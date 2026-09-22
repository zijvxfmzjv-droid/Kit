#!/usr/bin/env python3
"""Pass 3: assemble full deobfuscated Lua output (naming, upvalue propagation, pool inlining)."""
import re
import pickle
import structurer
import decomp

protos = decomp.protos
tables = pickle.load(open('tables.pkl', 'rb'))

# ---------------- pool map from runtime dump (ground truth) ----------------
def parse_pool():
    pool = {}
    for line in open('nupdump.log', encoding='utf-8', errors='replace'):
        if line.startswith('===NUP 3') or line.startswith('===NUP 4'):
            m = re.search(r'0=\{(.*?)\},1=\{false', line)
            if not m:
                continue
            body = m.group(1)
            for kv in re.finditer(r'(?:^|,)(\d+)=', body):
                k = int(kv.group(1))
                start = kv.end()
                nxt = re.search(r',\d+=', body[start:])
                end = start + (nxt.start() if nxt else len(body[start:]))
                pool[k] = body[start:end].strip()
            break
    return pool

POOL_RAW = parse_pool()

def pool_value_str(k):
    v = POOL_RAW.get(k, '')
    if v.startswith('s') and ':' in v:
        ln, _, rest = v[1:].partition(':')
        return decomp.expr_str(('const', rest[:int(ln)]))
    if v.startswith('boolean:'):
        return v.split(':', 1)[1]
    if v.startswith('{__dummyname='):
        name = v.split('"')[1]
        return name  # global reference
    if v in ('F', '') or v.startswith('FN:') or v.startswith('t') or v.startswith('{'):
        return None  # unknown function/table -> keep __pool[k]
    if re.match(r'^-?[\d.]+$', v):
        return decomp.expr_str(('const', float(v)))
    return None

# ---------------- upvalue info ----------------
def r9(tid):
    t = tables[tid]
    s9 = t['kv'].get(9.0) or t['kv'].get(9)
    out = {}
    if s9 and isinstance(s9, dict) and 'kv' in s9:
        for k, v in s9['kv'].items():
            if isinstance(v, dict) and 'kv' in v:
                mode = v['kv'].get(1.0)
                w = v['kv'].get(3.0)
                out[int(k)] = (int(mode) if mode is not None else 0, int(w) if w is not None else 0)
    return out

# creators: child -> (parent, closure_op_instr, dst_reg)
creators = {}
for tid, p in protos.items():
    for P, V in enumerate(p['A']):
        if V in (188, 208):
            y = p['y'][P]
            child = y[1] if isinstance(y, tuple) else None
            if child is not None and child not in creators:
                creators[child] = (tid, P, p['e'][P])

def upval_bindings(tid):
    """child proto -> list of (slot, parent_kind, parent_idx) ; kind 'reg' or 'upv'"""
    if tid not in creators:
        return {}
    parent, P, dst = creators[tid]
    binds = {}
    for j, (mode, w) in r9(tid).items():
        if mode in (0, 1):
            binds[j] = ('reg', parent, w)
        else:
            binds[j] = ('upv', parent, w)
    return binds

def upval_name(tid, slot, _depth=0):
    if _depth > 40 or tid not in creators:
        return f"UP{slot}"
    binds = upval_bindings(tid)
    if slot not in binds:
        return f"UP{slot}"
    kind, parent, w = binds[slot]
    if kind == 'reg':
        return reg_name(parent, w)
    return upval_name(parent, w, _depth + 1)

def num_params(tid):
    p = protos[tid]
    np_ = p['numparams']
    va = p.get('vararg', 0)
    return np_, va

MAIN_TID = 2

def reg_name(tid, i):
    if tid == MAIN_TID:
        return f"L{i}"
    np_, va = num_params(tid)
    if 1 <= i <= np_:
        return f"a{i}"
    return f"L{i}"

# ---------------- rendering with naming context ----------------
CTX = {'tid': None}

def expr2(x):
    t = x[0]
    if t == 'reg':
        return reg_name(CTX['tid'], x[1])
    if t == 'poolref':
        # UPV[e][key] where UPV e might be the pool table
        e = x[1]
        key = x[2]
        name = upval_name(CTX['tid'], e)
        if name in ('__pool',):
            lit = pool_value_str(key)
            if lit is not None:
                return lit
            return f"__pool[{key}]"
        return f"{name}[{key}]"
    if t == 'upv':
        return upval_name(CTX['tid'], x[1])
    return decomp.expr_str(x)

# monkey-patch decomp.expr_str to route through expr2 for reg/pool/upv
_orig_expr_str = decomp.expr_str
def expr_patched(x):
    if isinstance(x, tuple) and x[0] in ('reg', 'poolref', 'upv'):
        return expr2(x)
    return _orig_expr_str(x)
decomp.expr_str = expr_patched
# rebind inside decomp module's own references (LINEFMT closures call decomp-internal expr_str)
for _name in list(vars(decomp)):
    pass
# LINEFMT lambdas reference global expr_str in decomp module -> patch done above since same module dict

def render_body(tid, ind, self_name=None):
    stmts, ir, reach, p2ir, n = structurer.structure(tid)
    CTX['tid'] = tid
    upv_used = set()
    closures = []
    lines = structurer.render_stmts(stmts, ind, upv_used, closures)
    CTX['tid'] = None
    return lines, upv_used, closures

def params_str(tid):
    np_, va = num_params(tid)
    ps = [f"a{i}" for i in range(1, np_ + 1)]
    ps.append('...')   # VM protos are always vararg (op9 reads ...)
    return ', '.join(ps)

def emit_function(tid, out, ind, force_prenest=False):
    pad = '    ' * ind
    body, upv_used, closures = render_body(tid, ind + 1)
    # detect self reference: body text contains dst-reg name
    name_ctx = None
    if tid in creators:
        parent, P, dst = creators[tid]
        name_ctx = reg_name(parent, dst)
    txt = '\n'.join(body)
    if name_ctx and re.search(r'\b' + re.escape(name_ctx) + r'\b', txt):
        form = 'predecl'
    else:
        form = 'localfun'
    header = f"{pad}local function F{tid}({params_str(tid)})"
    if form == 'predecl' and name_ctx:
        out.append(f"{pad}local {name_ctx} -- F{tid}")
        out.append(f"{pad}{name_ctx} = function({params_str(tid)})")
    else:
        out.append(header)
    out.extend(body)
    out.append(f"{pad}end")

# ---------------- main assembly ----------------
def synth_pool(lines):
    """collect T2 pool stores + env temps -> clean block"""
    env15 = None
    env_regs = {}   # L<n> -> value expr
    pool = {}
    keep = []
    def note(n, v):
        env_regs['L' + str(n)] = v
    for L in lines:
        s = L.strip()
        m = re.match(r'^L(\d+) = ENV\.(\w+)$', s) or re.match(r'^L(\d+) = ENV\[.+\]$', s)
        if m:
            val = s.split(' = ', 1)[1]
            note(m.group(1), val)
            if m.group(1) == '15': env15 = val
            continue
        m = re.match(r'^L(\d+) = L(\d+)\[(\d+)\]$', s)
        if m:
            base = env_regs.get('L' + m.group(2), 'L' + m.group(2))
            val = f"{base}[{m.group(3)}]"
            note(m.group(1), val)
            if m.group(1) == '15': env15 = val
            continue
        m = re.match(r"""^L(\d+) = ('[^']*'|"[^"]*"|nil|true|false|-?\d+(?:\.\d+)?)$""", s)
        if m:
            note(m.group(1), m.group(2))
            continue
        m = re.match(r'^L(\d+) = (\w+)$', s)
        if m and not s.startswith('L14'):
            note(m.group(1), m.group(2))
            if m.group(1) == '15': env15 = m.group(2)
            continue
        m = re.match(r'^L14\[(\d+)\] = L(\d+)$', s)
        if m:
            pool[int(m.group(1))] = env_regs.get('L' + m.group(2), 'L' + m.group(2))
            continue
        m = re.match(r'^L14\[(\d+)\] = (.+)$', s)
        if m and (m.group(2)[:1] in (chr(39), chr(34)) or m.group(2).startswith('ENV')):
            pool[int(m.group(1))] = m.group(2)
            continue
        if s == 'L15 = L14; L14 = L14[0]':
            keep.append('-- (junk op: loader self-modifies operand stream here; real behavior = no-op)')
            continue
        keep.append(L)
    blk = ["local L14 = {}  -- Luraph environment pool (keys = constant indices)", "local L15"]
    for k in sorted(pool):
        v = pool[k]
        m0 = re.match(r'^(?:ENV\.)?(\w+)\[(\d+)\]$', v)
        if m0:
            vv = POOL_RAW.get(k, '')
            dm = re.search(r'__dummyname="([^"]+)"', vv)
            if dm:
                v = f"{dm.group(1)} -- via loader slot {m0.group(1)}[{m0.group(2)}]"
            else:
                v = f"{v} -- loader-installed helper"
        blk.append(f"L14[{k}] = {v}")
    return blk + keep


# ---------------- dispatcher const-folding ----------------
NUMRE = r'-?\d+(?:\.\d+)?'

def _num(s):
    try:
        f = float(s)
        return int(f) if f == int(f) else f
    except ValueError:
        return None

def fold_dispatch(lines):
    """evaluate tests on known-constant vars; drop dead ifs, unwrap true ifs"""
    out = []
    consts = {}
    i = 0
    N = len(lines)
    def inv_line(s):
        m = re.match(r'^(\w+) = ', s)
        if m and not re.match(r'^\w+ = (-?\d+(?:\.\d+)?|"[^"]*"|nil|true|false)$', s):
            consts.pop(m.group(1), None)
        m2 = re.match(r'^(\w+) = (-?\d+(?:\.\d+)?|"[^"]*"|nil|true|false)$', s)
        if m2:
            consts[m2.group(1)] = m2.group(2)
    def ev(cmp_):
        m = re.match(r'^\((\w+) (==|~=|>=|<=|>|<) (' + NUMRE + r'|"[^"]*")\)$', cmp_)
        if not m:
            m = re.match(r'^\((' + NUMRE + r'|"[^"]*") (==|~=|>=|<=|>|<) (\w+)\)$', cmp_)
            if not m:
                return None
            a, op, b = m.group(1), m.group(2), m.group(3)
            a_is_var = False
        else:
            a, op, b = m.group(1), m.group(2), m.group(3)
            a_is_var = True
        if a_is_var:
            if a not in consts: return None
            av = consts[a]; bv = b
        else:
            if b not in consts: return None
            av, bv = consts[b], a   # swap operand order
            op = {'<':'>', '>':'<', '<=':'>=', '>=':'<=', '==':'==', '~=':'~='}[op]
        an, bn = _num(av), _num(bv)
        if an is not None and bn is not None:
            a2, b2 = an, bn
        else:
            a2 = str(av).strip('"'); b2 = str(bv).strip('"')
        if op == '==': r = a2 == b2
        elif op == '~=': r = a2 != b2
        elif op == '>=': r = a2 >= b2
        elif op == '<=': r = a2 <= b2
        elif op == '>': r = a2 > b2
        else: r = a2 < b2
        return r
    while i < N:
        L = lines[i]
        s = L.strip()
        ind = len(L) - len(L.lstrip())
        code = re.split(r'\s--', s, 1)[0].strip()
        def _open(c):
            if c.startswith('elseif'): return False
            return c.endswith('then') or c.endswith('do') or re.match(r'(local\s+)?function\b', c) or c.startswith('function') or c.startswith('repeat') or re.search(r'=\s*function\s*\(', c)
        def _close(c):
            return re.match(r'end\b', c) or c.startswith('until')
        mif = re.match(r'^if (.+) then$', code)
        if mif:
            cond = mif.group(1)
            neg = False
            if cond.startswith('not (') and cond.endswith(')'):
                neg = True; cond = cond[5:-1]
            r = ev(cond)
            if r is not None:
                taken = (not r) if neg else r
                # find matching end
                j = i + 1; depth = 1
                while j < N and depth:
                    sj = lines[j].strip()
                    if sj.startswith('--'):
                        j += 1; continue
                    cj = re.split(r'\s--', sj, 1)[0].strip()
                    if cj.startswith('elseif'):
                        j += 1; continue
                    if _open(cj):
                        depth += 1
                    if _close(cj):
                        depth -= 1
                    j += 1
                endj = j - 1
                # does this if have an else/elseif at the same indent?
                has_else = False
                d2 = 1
                for q in range(i + 1, endj):
                    sq = lines[q].strip()
                    if sq.startswith('--'): continue
                    cq = re.split(r'\s--', sq, 1)[0].strip()
                    if _open(cq):
                        d2 += 1
                    elif _close(cq):
                        d2 -= 1
                    elif d2 == 1 and cq == 'else':
                        has_else = True
                        break
                # never fold away a block that creates closures (junk ops may rewrite operands)
                span = '\n'.join(lines[i+1:endj])
                if '-- closure' in span or re.search(r'= closure T\d+', span) or re.search(r'-- F\d+\b', span):
                    out.append(L)
                    i += 1
                    continue
                if not taken:
                    i = j  # drop block (incl. else)
                    continue
                if has_else:
                    out.append(L)  # keep if/else/end intact; can't unwrap an else
                    i += 1
                    continue
                # safety: the span must not cut through a nested block
                dchk = 0
                ok_span = True
                for q in range(i + 1, endj):
                    sq = lines[q].strip()
                    if sq.startswith('--'): continue
                    cq = re.split(r'\s--', sq, 1)[0].strip()
                    if _open(cq): dchk += 1
                    elif _close(cq): dchk -= 1
                    if dchk < 0:
                        ok_span = False
                        break
                if not ok_span or dchk != 0:
                    out.append(L)
                    i += 1
                    continue
                out.append(' ' * ind + '-- folded: ' + s)
                out.extend(lines[i+1:endj])    # no else: drop the end too
                i = endj + 1
                continue
        inv_line(s)
        out.append(L)
        i += 1
    return out

def pool_identity(lines):
    """resolve X[0] loader-slot reads to runtime-verified identities where known"""
    res = []
    for L in lines:
        def sub(m):
            base = m.group(1); k = int(m.group(2))
            v = POOL_RAW.get(k, '')
            dm = re.search(r'__dummyname="([^"]+)"', v)
            if dm and dm.group(1).startswith(base + '.'):
                return dm.group(1) + ' -- loader slot'
            return f"{base}[{k}] -- loader slot"
        L2 = re.sub(r'(\w+)\[(\d+)\] -- LOADER0', sub, L)
        res.append(L2)
    return res

def assemble():
    out = []
    out.append("-- Deobfuscated source (recovered from Luraph VM bytecode)")
    out.append("-- Main chunk = proto T2; payload = T8 (called with the original arguments)")
    out.append("")
    # emit nested closure tree depth-first starting at T2
    EMITTED = set()
    def emit_proto(tid, ind):
        EMITTED.add(tid)
        body, upv_used, closures = render_body(tid, ind)
        pad = '    ' * ind
        # replace closure-marker lines with nested bodies
        newlines = []
        for L in body:
            m = re.match(r'^(\s*)(?:L|a)(\d+) = (?:T(\d+)\(\) -- closure( \(with upvals\))?|closure T(\d+)(?: \(with upvals\))?)$', L)
            m2 = None
            mm = m or m2
            if mm:
                child = int(mm.group(3) or mm.group(5))
                if child in protos:
                    emit_proto_into(newlines, child, ind + 1, reg_name(tid, int(mm.group(2))))
                    continue
            newlines.append(L)
        return newlines, upv_used

    def emit_proto_into(out, tid, ind, dstname):
        pad = '    ' * ind
        body, upv_used = emit_proto(tid, ind)
        body = [x for x in body if '__init_params' not in x and '-- vararg count' not in x]
        body = fold_dispatch(body)
        body_txt = '\n'.join(body)
        if re.search(r'\b' + re.escape(dstname) + r'\b', body_txt):
            out.append(f"{pad}local {dstname} -- F{tid}")
            out.append(f"{pad}{dstname} = function({params_str(tid)})")
        else:
            out.append(f"{pad}local function {dstname}({params_str(tid)}) -- F{tid}")
        out.extend(body)
        out.append(f"{pad}end")

    # T2 = main chunk: run at top level
    body, upv_used = emit_proto(2, 0)
    # backstop: emit any referenced child whose creation site could not be nested
    for c in sorted(creators):
        if c not in EMITTED:
            par, pc_, dst_ = creators[c]
            out.append(f"do -- standalone: T{c} (closure created at T{par} instr {pc_}; site not recovered into the nesting)")
            emit_proto_into(out, c, 1, f"aS{c}")
            out.append("end")
    # drop leftover 'continue -- luau' at top level and empty do-blocks
    body = [L for L in body if L.strip() != 'continue -- luau']
    cleaned = []
    i = 0
    while i < len(body):
        if body[i].strip() == 'do' and i + 1 < len(body) and body[i+1].strip() == 'end':
            i += 2; continue
        cleaned.append(body[i]); i += 1
    body = synth_pool(cleaned)
    body = [x for x in body if '__init_params' not in x and '-- vararg count' not in x]
    body = fold_dispatch(body)
    out.extend(body)
    return out

if __name__ == '__main__':
    lines = assemble()
    txt = '\n'.join(lines)
    # pool inlining for string constants
    def _sub(m):
        k = int(m.group(1))
        lit = pool_value_str(k)
        return lit if lit is not None else m.group(0)
    txt = re.sub(r'__pool\[(\d+)\]', _sub, txt)
    txt = re.sub(r'\bUPV\[(\d+)\]\[(\d+)\]', lambda m: f"__pool[{m.group(2)}]", txt)
    txt = re.sub(r'E\[(?:L|a)\d+\]', lambda m: m.group(0)[2:-1], txt)
    HEADER = '''-- ============================================================================
-- Deobfuscated source, recovered from Luraph VM bytecode ("NewOne (3).txt")
-- Structure:
--   * Top-level block = VM proto T2: builds the constant pool (L14), then
--     defines/calls the payload proto T8 with the original arguments.
--   * Nested `local function aN(...) -- F<tid>` blocks are the child protos.
-- Naming conventions:
--   ENV          = the global environment table (== getfenv() inside the loader)
--   L14 / L15    = T2's constant pool / scratch register
--   L<n>, a<n>   = VM registers of T2 and of nested protos respectively
--   a1..aN, ...  = prototype parameters (the VM passes all args as varargs)
--   '-- loader-installed helper' = value the Luraph loader stores at a numeric
--     index of a stock table (e.g. utf8[0]); absent in a clean environment.
--   A few operand streams are self-modified by junk ops at runtime; those spots
--   are marked with comments and rendered to the closest static interpretation.
-- ============================================================================

'''
    txt = HEADER + txt
    txt = re.sub(r'(?m)^(\s*)return\b(.*)$', lambda m: f"{m.group(1)}do return{m.group(2)} end", txt)
    txt = re.sub(r'(?m)^(\s*)continue\b(?! end)(.*)$', lambda m: f"{m.group(1)}do continue end{m.group(2)}", txt)
    open('deobf_full.lua', 'w').write(txt)
    print(f"wrote deobf_full.lua ({len(txt.splitlines())} lines)")
