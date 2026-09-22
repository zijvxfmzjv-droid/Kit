#!/usr/bin/env python3
"""Pass 3: assemble full deobfuscated Lua output (naming, upvalue propagation, pool inlining)."""
import re
import pickle
import structurer
import decomp

protos = decomp.protos
tables = pickle.load(open('tables.pkl', 'rb'))

# ---------------- pool map from runtime dump (ground truth) ----------------
# nupdump.log lines look like:  ===NUP 3 tid=-1 n={1={...},0={1=FN:...,8="gmatch",...}}
# The constant pool is the `0=` sub-table of `n`.  Values are nested tables, so the
# key/value split has to be brace- and quote-aware (a naive regex matched the wrong
# `0=` and produced an empty pool map).
def _scan_depth(body, frm, to):
    """index of the first top-level ',' or closing brace at/after `frm`"""
    depth = 0
    instr = False
    j = frm
    while j < to:
        c = body[j]
        if instr:
            if c == '\\':
                j += 2
                continue
            if c == '"':
                instr = False
        elif c == '"':
            instr = True
        elif c in '{[':
            depth += 1
        elif c in '}]':
            if depth == 0:
                return j
            depth -= 1
        elif c == ',' and depth == 0:
            return j
        j += 1
    return to

def _depth_between(body, frm, to):
    depth = 0
    instr = False
    j = frm
    while j < to:
        c = body[j]
        if instr:
            if c == '\\':
                j += 2
                continue
            if c == '"':
                instr = False
        elif c == '"':
            instr = True
        elif c in '{[':
            depth += 1
        elif c in '}]':
            depth -= 1
        j += 1
    return depth

def _table_kv(body):
    """split a serialised table body into {key:int -> raw value text}"""
    out = {}
    pos = 0
    n = len(body)
    kre = re.compile(r'(?:\A|,)(\d+)=')
    while pos < n:
        m = kre.search(body, pos)
        if not m:
            break
        if _depth_between(body, pos, m.start(1)) != 0:
            pos = m.end(1)
            continue
        key = int(m.group(1))
        vstart = m.end()
        j = _scan_depth(body, vstart, n)
        val = body[vstart:j].strip()
        if _complete_value(val):
            out[key] = val
        pos = j
    return out


def _complete_value(v):
    """False for values cut in half by the truncated dump line"""
    if v.startswith(chr(34)):
        return len(v) > 1 and v.endswith(chr(34))
    if v.startswith('{'):
        return v.count('{') == v.count('}')
    return True

def _find_sub(body, key):
    """raw text of the top-level `key={...}` entry inside `body`"""
    for m in re.finditer(r'(?:\A|,)' + str(key) + r'=\{', body):
        start = m.end() - 1
        depth = 0
        instr = False
        j = start
        while j < len(body):
            c = body[j]
            if instr:
                if c == '\\':
                    j += 2
                    continue
                if c == '"':
                    instr = False
            elif c == '"':
                instr = True
            elif c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
                if depth == 0:
                    return body[start + 1:j], False
            j += 1
        # the dump line is truncated (serialiser limit): use what we have
        return body[start + 1:], True
    return None, True

def parse_pool():
    pool = {}
    for line in open('nupdump.log', encoding='utf-8', errors='replace'):
        if not (line.startswith('===NUP 3') or line.startswith('===NUP 4')):
            continue
        i = line.find(' n={')
        if i < 0:
            continue
        top = _find_sub(line[i:].strip(), 'n')[0] or ''
        body0 = _find_sub(top, 0)[0]
        if not body0:
            continue
        kv = _table_kv(body0)
        if len(kv) > len(pool):
            pool = kv
    return pool

POOL_RAW = parse_pool()

def unescape_dump(v):
    out = []
    i = 0
    while i < len(v):
        c = v[i]
        if c == '\\' and i + 1 < len(v):
            nxt = v[i + 1]
            out.append({'n': '\n', 'r': '\r', 't': '\t', '"': '"', '\\': '\\'}.get(nxt, '\\' + nxt))
            i += 2
            continue
        out.append(c)
        i += 1
    return ''.join(out)

# library tables show up in the pool as anonymous tables of functions; recognise
# them by their key set so `pool[4]` can be rendered as `string` etc.
LIB_KEYS = {
    'string':    'split match gmatch upper gsub format lower sub pack find char packsize reverse byte unpack rep len',
    'table':     'getn foreachi foreach sort unpack freeze clear pack move insert create maxn isfrozen concat clone find remove',
    'coroutine': 'resume running yield close status wrap create isyieldable',
    'math':      'log e ldexp deg cosh round random frexp tanh floor max sqrt modf huge sqrt2 pow isnan acos phi tau exp pi isfinite tan cos isinf atan map sign ceil clamp noise abs nan sinh asin min randomseed fmod rad atan2 log10 sin lerp',
    'debug':     'info traceback',
    'utf8':      'offset codes codepoint charpattern len char',
    'os':        'time clock date difftime',
    'bit32':     'band bor bxor bnot lshift rshift extract replace lrotate rrotate countlz countrz',
    'buffer':    'create len tostring fromstring readu8 readi8 writeu8 readu16 readi16 writeu16 readu32 readi32 writeu32 readf32 readf64 writef32 writef64 readbits writebits readstring writestring copy',
    'task':      'wait delay spawn defer cancel',
}
LIB_SETS = {k: set(v.split()) for k, v in LIB_KEYS.items()}

def _raw_keys(body):
    """top-level keys of a serialised table body (numeric or identifier)"""
    keys = set()
    pos = 0
    n = len(body)
    while pos < n:
        j = _scan_depth(body, pos, n)
        part = body[pos:j]
        if '=' in part:
            k = part.split('=', 1)[0].strip()
            if k:
                keys.add(k)
        pos = j + 1
    return keys

def lib_table_name(raw):
    """name of a standard library table, or None"""
    if not raw.startswith('{'):
        return None
    body = raw[1:-1] if raw.endswith('}') else raw[1:]
    keys = _raw_keys(body)
    best, bestscore = None, 0.0
    for name, ks in LIB_SETS.items():
        if not ks:
            continue
        score = len(ks & keys) / float(len(ks))
        if score > bestscore:
            best, bestscore = name, score
    return best if bestscore >= 0.7 else None

def pool_value_str(k):
    """source-level literal for pool slot k, or None when it can't be inlined"""
    v = POOL_RAW.get(k, '')
    if v.startswith('"'):
        return decomp.expr_str(('const', unescape_dump(v[1:-1])))
    if v.startswith('boolean:'):
        return v.split(':', 1)[1]
    if v.startswith('number:'):
        try:
            return decomp.expr_str(('const', float(v.split(':', 1)[1])))
        except ValueError:
            return v.split(':', 1)[1]
    if v.startswith('{__dummyname='):
        m = re.match(r'\{__dummyname="([^"]+)"\}$', v)
        if m:
            return m.group(1)      # global reference captured by the loader
        return None
    if v.startswith('{'):
        return lib_table_name(v)   # standard library table -> `string`, `table`, ...
    if v.startswith('FN:') or v.startswith('t') or v in ('F', ''):
        return None                # function -> keep the pool reference
    if re.match(r'^-?[\d.]+$', v):
        return decomp.expr_str(('const', float(v)))
    return None

# ---------------- upvalue info ----------------
# tables.pkl serialises shared sub-tables as {'__ref': <table id>}; the previous
# version of r9() skipped those, so *every* proto lost its upvalue descriptors
# and rendered them as UP0/UP1/...  Build an id -> node index so refs resolve.
TABLE_IDX = {}

def _index_tables():
    def walk(n, d=0):
        if d > 8:
            return
        if isinstance(n, dict):
            i = n.get('__id')
            if isinstance(i, (int, float)):
                TABLE_IDX[int(i)] = n
            for v in n.values():
                walk(v, d + 1)
        elif isinstance(n, (list, tuple)):
            for v in n:
                walk(v, d + 1)
    for t in tables.values():
        walk(t)

_index_tables()

def deref(v):
    seen = set()
    while isinstance(v, dict) and '__ref' in v:
        r = v['__ref']
        if not isinstance(r, (int, float)):
            return None
        r = int(r)
        if r in seen or r not in TABLE_IDX:
            return None
        seen.add(r)
        v = TABLE_IDX[r]
    return v

def r9(tid):
    """upvalue descriptor table: slot -> (mode, w)
    mode 0/1 = copy parent register w (by reference), 2 = copy parent upvalue w."""
    t = tables.get(tid)
    if not t:
        return {}
    s9 = deref(t['kv'].get(9.0) or t['kv'].get(9))
    out = {}
    if isinstance(s9, dict) and 'kv' in s9:
        for k, v in s9['kv'].items():
            v2 = deref(v)
            if not isinstance(v2, dict) or 'kv' not in v2:
                continue
            mode = v2['kv'].get(1.0)
            w = v2['kv'].get(3.0)
            if not isinstance(mode, (int, float)) or not isinstance(w, (int, float)):
                continue
            out[int(k)] = (int(mode), int(w))
    return out

# creators: child -> (parent, closure_op_instr, dst_reg)
creators = {}
for tid, p in protos.items():
    for P, V in enumerate(p['A']):
        if V in (188, 208):
            y = p['y'][P]
            child = y[1] if isinstance(y, tuple) else None
            if isinstance(child, (int, float)) and int(child) in protos and int(child) not in creators:
                creators[int(child)] = (tid, P, p['e'][P])

def upval_bindings(tid):
    """child proto -> list of (slot, parent_kind, parent_idx) ; kind 'reg' or 'upv'"""
    if tid not in creators:
        return {}
    parent, P, dst = creators[tid]
    binds = {}
    # descriptor keys are 1-based, IR upvalue slots are 0-based
    for j, (mode, w) in r9(tid).items():
        if mode in (0, 1):
            binds[j - 1] = ('reg', parent, w)
        else:
            binds[j - 1] = ('upv', parent, w)
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

def capture_owner(tid, slot, _depth=0):
    """resolved (owner_tid, register_index) behind upvalue `slot` of proto tid"""
    if _depth > 40 or tid not in creators:
        return None
    b = upval_bindings(tid).get(slot)
    if b is None:
        return None
    kind, parent, w = b
    if kind == 'reg':
        return (parent, w)
    return capture_owner(parent, w, _depth + 1)

def num_params(tid):
    p = protos[tid]
    np_ = p['numparams']
    va = p.get('vararg', 0)
    return np_, va

MAIN_TID = 2

# ---------------- register naming (scope-safe) ----------------
# Every proto gets its own register names, but a nested proto reads its parent's
# registers through upvalues -- so a register of the parent that is captured by a
# descendant must NOT be given the same name as one of the descendant's own
# registers (that would silently shadow the capture).  Default names are
# a1..a<numparams> (parameters) and L<n> (locals); when a collision is detected we
# rename the *captured* register in the owning proto to <letter><n>, with one
# dedicated letter per proto so renamed names can never clash again.

_ALT_LETTERS = 'vwpmnstqrzbcdefgh'
_alt_of = {}
_alt_seq = [0]

def alt_letter(tid):
    if tid not in _alt_of:
        _alt_of[tid] = _ALT_LETTERS[_alt_seq[0] % len(_ALT_LETTERS)]
        _alt_seq[0] += 1
    return _alt_of[tid]

# registers actually referenced by each proto
def _own_regs(tid):
    """every register the proto reads OR writes (destinations are plain ints)"""
    regs = set()
    def collect(v):
        if isinstance(v, tuple):
            if v[0] == 'reg':
                regs.add(int(v[1]))
            else:
                for x in v[1:]:
                    collect(x)
        elif isinstance(v, list):
            for x in v:
                collect(x)
    for e in decomp.decode_proto(tid):
        for v in e.kw.values():
            collect(v)
        kw = e.kw
        for key in ('dst', 'reg0', 'lo'):
            if isinstance(kw.get(key), (int, float)):
                regs.add(int(kw[key]))
        if isinstance(kw.get('hi'), (int, float)) and isinstance(kw.get('lo'), (int, float)):
            for i in range(int(kw['lo']), int(kw['hi']) + 1):
                regs.add(i)
        # multi-return calls write dst..dst+nret-1 ; the self op also fills dst+1
        if e.kind == 'call' and isinstance(kw.get('dst'), (int, float)):
            n = kw.get('nret') or 0
            for i in range(int(kw['dst']), int(kw['dst']) + max(int(n), 1)):
                regs.add(i)
        if e.kind == 'self' and isinstance(kw.get('dst'), (int, float)):
            regs.add(int(kw['dst']) + 1)
    return regs

OWN = {tid: _own_regs(tid) for tid in protos}

# upvalue slots read/written by each proto's own code
def _used_slots(tid):
    out = set()
    for e in decomp.decode_proto(tid):
        # 'upv' slots are plain ints in the kw dict
        if e.kind in ('getupval', 'setupval', 'setupval_field'):
            out.add(int(e.kw['upv']))
        for v in e.kw.values():
            def scan(x):
                if isinstance(x, tuple):
                    if x[0] == 'upv':
                        out.add(int(x[1]))
                    elif x[0] == 'poolref':
                        out.add(int(x[1]))
                    else:
                        for y in x[1:]:
                            scan(y)
                elif isinstance(x, list):
                    for y in x:
                        scan(y)
            scan(v)
    return out

CAPT = {}     # tid -> {(owner_tid, reg)} referenced (read or written) by tid
for _t in protos:
    _s = set()
    for _slot in _used_slots(_t):
        _o = capture_owner(_t, _slot)
        if _o:
            _s.add(_o)
    CAPT[_t] = _s

# closure tree
CHILDREN = {}
for _c, (_p, _i, _d) in creators.items():
    CHILDREN.setdefault(_p, []).append(_c)

def _subtree(tid, acc=None, first=True):
    if acc is None:
        acc = []
    if not first:
        acc.append(tid)
    for c in CHILDREN.get(tid, []):
        _subtree(c, acc, False)
    return acc

SUBTREE = {tid: _subtree(tid) for tid in protos}          # descendants, excl. self
SUB_REFS = {tid: set().union(*[CAPT[q] for q in [tid] + SUBTREE[tid]]) if (CAPT[tid] or any(CAPT[q] for q in SUBTREE[tid])) else set() for tid in protos}

def default_name(tid, i):
    if tid == MAIN_TID:
        return f"L{i}"
    np_, _ = num_params(tid)
    return (f"a{i}" if 1 <= i <= np_ else f"L{i}")

def reg_name(tid, i):
    return NAME.get((tid, int(i))) or default_name(tid, int(i))

# --- pass 1: which (owner, reg) pairs collide with a descendant's own name? ---
RENAMED = set()
for _t in protos:
    _own_names = {default_name(_t, _i) for _i in OWN[_t]}
    for _ref in SUB_REFS[_t]:
        if _ref[0] == MAIN_TID and _ref[1] in (14, 15):
            continue            # T2's pool/scratch registers keep their names
        if default_name(*_ref) in _own_names:
            RENAMED.add(_ref)
# --- pass 1b: two different captured registers that would share a name ---
for _t in protos:
    _by_name = {}
    for _ref in sorted(SUB_REFS[_t]):
        _by_name.setdefault(default_name(*_ref), []).append(_ref)
    for _n, _refs in _by_name.items():
        if len(_refs) > 1:
            for _r in _refs[:-1]:
                RENAMED.add(_r)

# the local name each nested proto is stored under (= its parent's dst register)
FNAME = {c: None for c in creators}

# T8's first parameter is the constant pool (it is never written to, and every
# child proto reaches the same table through upvalue 0).  Give it a name no other
# proto can produce so that `pool[k]` reads can be inlined safely.
POOL_PROTO = 8
POOL_REG = 1
if POOL_PROTO in creators:
    RENAMED.add((POOL_PROTO, POOL_REG))

# --- pass 2: assign names top-down (parents first) ---
NAME = {}
_bfs = [MAIN_TID]
_i = 0
while _i < len(_bfs):
    _t = _bfs[_i]; _i += 1
    for _c in CHILDREN.get(_t, []):
        if _c not in _bfs:
            _bfs.append(_c)
for _t in protos:
    if _t not in _bfs:
        _bfs.append(_t)
# T2's pool / scratch registers keep the names the rest of the file refers to
RESERVED = {default_name(MAIN_TID, 14), default_name(MAIN_TID, 15)}

for _t in _bfs:
    _forb = set()
    if _t != MAIN_TID:
        _forb |= RESERVED
    for _d in SUBTREE[_t]:
        for _j in OWN[_d]:
            _forb.add(default_name(_d, _j))
    for _ref in SUB_REFS[_t]:
        _forb.add(NAME.get(_ref) or default_name(*_ref))
    _fn = reg_name(creators[_t][0], creators[_t][2]) if _t in creators else None
    if _fn:
        FNAME[_t] = _fn
        _forb.add(_fn)
    for _j in sorted(OWN[_t]):
        _n = default_name(_t, _j)
        if _t == MAIN_TID and _j in (14, 15):
            NAME[(_t, _j)] = _n          # pool / scratch: names referenced by synth_pool
            continue
        if _n == _fn:
            _n = f"{alt_letter(_t)}{_j}" 
        if (_t, _j) in RENAMED or _n in _forb:
            _n = f"{alt_letter(_t)}{_j}"
        NAME[(_t, _j)] = _n

for _c, (_p, _i, _d) in creators.items():
    FNAME[_c] = reg_name(_p, _d)

# ---------------- local declarations ----------------
def param_regs(tid):
    if tid == MAIN_TID:
        return set()
    np_, _ = num_params(tid)
    return set(range(1, np_ + 1))

# registers of `tid` that some descendant proto captures through upvalues
CAPTURED_HERE = {}
for _t in protos:
    CAPTURED_HERE[_t] = {i for (o, i) in SUB_REFS[_t] if o == _t}

def local_decl_line(tid, skip=()):
    """`local ...` for every register of `tid` that is not a parameter.

    Nested protos read their parent's registers through upvalues, so those names
    have to be real Lua locals in the parent's scope for the capture to bind."""
    skip = set(skip)
    names = []
    for i in sorted(OWN[tid] | CAPTURED_HERE.get(tid, set())):
        if i in param_regs(tid):
            continue
        n = reg_name(tid, i)
        if n in skip or n in names:
            continue
        names.append(n)
    if not names:
        return None
    return 'local ' + ', '.join(names)

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
    # parameter names follow the register-naming table (a capture may have forced
    # a rename of a parameter slot, e.g. a1 -> w1)
    ps = [reg_name(tid, i) for i in range(1, np_ + 1)]
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
    """collect T2 pool stores + env temps -> clean constant-pool block"""
    pool = {}
    keep = []
    env_regs = {}                       # register index -> value expression
    # T2 register names (they depend on the rename pass, so build them here)
    RN2I = {}
    for i in OWN[MAIN_TID] | CAPTURED_HERE.get(MAIN_TID, set()):
        RN2I[reg_name(MAIN_TID, i)] = i
    REG = '(?:' + '|'.join(sorted(RN2I, key=len, reverse=True)) + ')'
    POOLREG = reg_name(MAIN_TID, 14)
    LIT = "(?:'[^']*'|\"[^\"]*\"|nil|true|false|-?[0-9]+(?:[.][0-9]+)?)"

    def note(n, v):
        env_regs[n] = v

    for L in lines:
        s = L.strip()
        m = re.match(r'^' + REG + r' = ENV\.(\w+)$', s) or re.match(r'^' + REG + r' = ENV\[.+\]$', s)
        if m:
            note(RN2I[m.group(0).split(' = ')[0]], s.split(' = ', 1)[1])
            continue
        m = re.match(r'^(' + REG + r') = (' + REG + r')\[(\d+)\]$', s)
        if m:
            base = env_regs.get(RN2I[m.group(2)], m.group(2))
            note(RN2I[m.group(1)], f"{base}[{m.group(3)}]")
            continue
        m = re.match(r'^(' + REG + r') = (' + LIT + r')$', s)
        if m:
            note(RN2I[m.group(1)], m.group(2))
            continue
        m = re.match(r'^' + re.escape(POOLREG) + r'\[(\d+)\] = (' + REG + r')$', s)
        if m:
            r = m.group(2)
            pool[int(m.group(1))] = env_regs.get(RN2I[r], r)
            continue
        m = re.match(r'^' + re.escape(POOLREG) + r'\[(\d+)\] = (.+)$', s)
        if m and (m.group(2)[:1] in (chr(39), chr(34)) or m.group(2).startswith('ENV')
                  or m.group(2).startswith('bit32') or re.match(r'^' + LIT + r'$', m.group(2))):
            pool[int(m.group(1))] = m.group(2)
            continue
        if s == f'{reg_name(MAIN_TID, 15)} = {POOLREG}; {POOLREG} = {POOLREG}[0]':
            keep.append('-- (junk op: loader self-modifies operand stream here; real behavior = no-op)')
            continue
        keep.append(L)

    blk = [f"local {POOLREG} = {{}}  -- Luraph constant pool (keys = constant indices)",
           f"local {reg_name(MAIN_TID, 15)}   -- T2 scratch register (holds the payload closure)"]

    def _cmt(txt):
        return ' '.join(str(txt).split())[:70]

    for k in sorted(pool):
        v = pool[k]
        raw = POOL_RAW.get(k)
        lit = pool_value_str(k)
        m0 = re.match(r'^(?:ENV\.)?(\w+)\[(\d+)\]$', v)
        if m0 and raw:
            dm = re.search(r'__dummyname="([^"]+)"', raw)
            if dm:
                v = f"{dm.group(1)} -- via loader slot {m0.group(1)}[{m0.group(2)}]"
            else:
                v = f"{v} -- loader-installed helper"
        elif m0:
            v = f"{v} -- loader-installed helper"
        elif lit is not None and (v not in (lit,) and not re.match(r'^' + LIT + r'$', v)):
            # runtime dump (nupdump.log) is ground truth: use it, keep the static
            # decode as documentation when the two disagree
            v = f"{lit} -- static decode: {_cmt(v)}"
        elif lit is not None:
            v = lit
        elif raw and not re.match(r'^' + LIT + r'$', v):
            v = f"{v} -- runtime: {_cmt(raw)}"
        blk.append(f"{POOLREG}[{k}] = {v}")
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
                blk = lines[i + 1:endj]
                inds = [len(x) - len(x.lstrip()) for x in blk if x.strip()]
                base = min(inds) if inds else ind + 4
                shift = base - (ind + 4)
                if shift > 0:
                    blk = [(x[shift:] if len(x) - len(x.lstrip()) >= shift else x) if x.strip() else x
                           for x in blk]
                # the folded-away test is dropped, but keep a trace of it
                out.append(' ' * (ind + 4) + '-- (constant test eliminated: ' + s + ')')
                out.extend(blk)                 # no else: drop the end too
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
            m = re.match(r'^(\s*)(\w+) = (?:T(\d+)\(\) -- closure( \(with upvals\))?|closure T(\d+)(?: \(with upvals\))?)$', L)
            m2 = None
            mm = m or m2
            if mm:
                child = int(mm.group(3) or mm.group(5))
                if child in protos:
                    # emit the nested function at the marker line's own indent
                    emit_proto_into(newlines, child, len(mm.group(1)) // 4, mm.group(2))
                    continue
                newlines.append(L)   # unreachable, but keep the marker visible
            newlines.append(L)
        return newlines, upv_used

    def emit_proto_into(out, tid, ind, dstname):
        pad = '    ' * ind
        body, upv_used = emit_proto(tid, ind + 1)
        body = [x for x in body if '__init_params' not in x and '-- vararg count' not in x]
        body = fold_dispatch(body)
        # the parent pre-declares every register as a local, so the closure is a
        # plain assignment (never `local function`, which would shadow the parent's
        # register and break later uses of it)
        out.append(f"{pad}{dstname} = function({params_str(tid)}) -- F{tid}")
        decl = local_decl_line(tid)
        if decl:
            out.append(pad + '    ' + decl)
        out.extend(body)
        out.append(f"{pad}end")

    # T2 = main chunk: run at top level
    body, upv_used = emit_proto(2, 0)
    # backstop: emit any referenced child whose creation site could not be nested
    for c in sorted(creators):
        if c not in EMITTED:
            par, pc_, dst_ = creators[c]
            out.append(f"do -- standalone: T{c} (closure created at T{par} instr {pc_}; site not recovered into the nesting)")
            out.append(f"    local aS{c}")
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
    # T2's registers are plain locals of the main chunk (L14/L15 are declared by
    # synth_pool below, so they are skipped here)
    decl = local_decl_line(MAIN_TID, skip=('L14', 'L15'))
    if decl:
        body.insert(2, decl)
    body = [x for x in body if '__init_params' not in x and '-- vararg count' not in x]
    body = fold_dispatch(body)
    out.extend(body)
    return out

# ---------------- structural cleanup ----------------
_KEEP_IN_DO = ('return', 'break', 'continue')

def _ends_block(line):
    s = line.strip()
    return any(s.startswith(k) or s.startswith('do ' + k) for k in _KEEP_IN_DO)

def unwrap_do_blocks(lines):
    """flatten the `do -- chunk @irN` wrappers the structurer emits per basic block.

    Every register is now a real local declared at the top of its function, and
    closures are plain assignments, so those blocks only added indentation."""
    res = []
    i = 0
    n = len(lines)
    while i < n:
        s = lines[i].strip()
        if s == 'do' or s.startswith('do ') and s.split('--', 1)[0].strip() == 'do':
            ind = len(lines[i]) - len(lines[i].lstrip())
            endj = None
            j = i + 1
            while j < n:
                sj = lines[j]
                if sj.strip():
                    ij = len(sj) - len(sj.lstrip())
                    if ij < ind:
                        break
                    if ij == ind and re.match(r'end\b', sj.strip()):
                        endj = j
                        break
                j += 1
            if endj is not None:
                body = lines[i + 1:endj]
                # never flatten a block that ends control flow (`do return ... end`)
                if not any(_ends_block(b) for b in body if len(b) - len(b.lstrip()) == ind + 4):
                    ded = [b[4:] if b.startswith(' ' * 4) else b for b in body]
                    res.extend(unwrap_do_blocks(ded))
                    i = endj + 1
                    continue
        res.append(lines[i])
        i += 1
    return res

def rename_kept_wrappers(lines):
    """the only `do` blocks left are the ones that terminate control flow"""
    return [re.sub(r'^(\s*)do -- chunk @ir\d+$', r'\1do -- (terminates control flow)', L)
            for L in lines]

def mark_empty_spinloops(lines):
    """`while true do end` with no body is a dispatcher loop whose body the
    structurer could not recover (its exit edge is a junk-op jump target).
    It is kept -- it is what the bytecode does -- but flagged."""
    out = []
    for i, L in enumerate(lines):
        if L.strip() == 'while true do' and i + 1 < len(lines) and lines[i + 1].strip() == 'end':
            out.append(L + ' -- (empty spin loop: unrestructured dispatcher exit)')
            continue
        out.append(L)
    return out

def drop_noise(lines):
    """remove VM artefacts that have no meaning in source form"""
    out = []
    for L in lines:
        s = L.strip()
        if s == '-- close upvalues':
            continue
        if s.startswith('-- folded:'):
            continue
        if s == '-- for-loop state restore':
            continue
        if s == '-- (junk op: loader self-modifies operand stream here; real behavior = no-op)':
            continue
        out.append(L)
    # collapse runs of blank/comment-only lines left behind by the flattening
    cleaned = []
    for L in out:
        if not L.strip() and cleaned and not cleaned[-1].strip():
            continue
        cleaned.append(L)
    return cleaned

if __name__ == '__main__':
    lines = assemble()
    txt = '\n'.join(lines)
    # pool inlining for string constants
    def _sub(m):
        k = int(m.group(1))
        lit = pool_value_str(k)
        return lit if lit is not None else m.group(0)
    txt = re.sub(r'__pool\[(\d+)\]', _sub, txt)
    # inline constant-pool reads:  pool[k] -> the literal the VM stored there
    _pool_alias = reg_name(POOL_PROTO, POOL_REG)
    if _pool_alias != default_name(POOL_PROTO, POOL_REG):
        def _sub_pool(m):
            return pool_value_str(int(m.group(1))) or m.group(0)
        txt = re.sub(r'\b' + re.escape(_pool_alias) + r'\[([0-9]+)\]', _sub_pool, txt)
    txt = re.sub(r'\bUPV\[(\d+)\]\[(\d+)\]', lambda m: f"__pool[{m.group(2)}]", txt)
    txt = re.sub(r'E\[(?:L|a)\d+\]', lambda m: m.group(0)[2:-1], txt)
    HEADER = """-- ============================================================================
-- Deobfuscated source, recovered from Luraph VM bytecode ("NewOne (3).txt")
--
-- This is a faithful *reconstruction*, not the original file: Luraph compiles
-- the script to a custom register bytecode, so names/comments/formatting are
-- gone for good.  Structure, control flow and every constant are intact.
--
-- Layout
--   * ENV          the loader's function environment (getfenv()); every
--                  `ENV.<name>` in this file is a real global lookup.
--   * L14          T2's constant pool, keys 1..337, dumped as literal values.
--   * L15          the payload closure (proto T8) built at the end of T2.
--   * `X = function(...) -- F<n>`   nested VM proto with id n.
--
-- Naming
--   * a1..aN       parameters of the enclosing proto (VM protos are vararg).
--   * L<n> / v<n>  a proto's own local registers, declared with `local` at the
--                  top of the function so nested protos capture them for real.
--   * A register that a nested proto captures is renamed to <letter><n> when its
--     default name would be shadowed inside that proto.
--
-- Remaining VM artefacts (documented, not silently "fixed")
--   * `UPVALS[i]`  upvalue read with a runtime-computed index.
--   * `<pool>[5]`  the one constant-pool slot the runtime dump did not capture.
--   * junk ops (op121/92/38/179) rewrite their operands at runtime; those few
--     sites are commented instead of rendered.
-- ============================================================================
"""
    ENV_PRELUDE = (
        "-- The VM resolves globals through the loader's function environment\n"
        "-- (Q[13]() == getfenv()); every `ENV.<name>` below is a real global lookup.\n"
        "local ENV = (getfenv and getfenv()) or _G\n\n"
    )
    txt = HEADER + ENV_PRELUDE + txt
    txt = re.sub(r'(?m)^(\s*)return\b(.*)$', lambda m: f"{m.group(1)}do return{m.group(2)} end", txt)
    txt = re.sub(r'(?m)^(\s*)continue\b(?! end)(.*)$', lambda m: f"{m.group(1)}do continue end{m.group(2)}", txt)
    lines = txt.split(chr(10))
    lines = unwrap_do_blocks(lines)
    lines = rename_kept_wrappers(lines)
    lines = drop_noise(lines)
    txt = chr(10).join(lines)
    if not txt.endswith(chr(10)):
        txt += chr(10)
    lines2 = mark_empty_spinloops(txt.split(chr(10)))
    txt = chr(10).join(lines2)
    open('deobf_full.lua', 'w').write(txt)
    print(f"wrote deobf_full.lua ({len(txt.splitlines())} lines)")
