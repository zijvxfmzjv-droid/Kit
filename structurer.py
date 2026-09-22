#!/usr/bin/env python3
"""Pass 2: structure IR into nested control flow (if/else, numeric for, loops)."""
import re
import decomp

protos = decomp.protos

class S:
    """structured statement"""
    def __init__(self, kind, **kw):
        self.kind = kind
        self.kw = kw

def build_ir(tid):
    p = protos[tid]
    ir = decomp.decode_proto(tid)
    n = p['nops']
    p2ir = {}
    for e in ir:
        for pp in range(e.p0, n):
            p2ir[pp] = e.idx
        e.target_ir = None
        e.junk = False
    for e in ir:
        t = e.kw.get('target')
        if t is None:
            continue
        if t >= n:
            e.junk = True  # never-taken opaque predicate
        else:
            e.target_ir = p2ir[t]
    # drop junk tests -> nop statements
    for e in ir:
        if e.junk:
            e.kind = 'nop'
    return ir, p2ir, n

def reachable(ir, n):
    seen = set()
    stack = [0] if ir else []
    while stack:
        i = stack.pop()
        if i in seen or i >= len(ir):
            continue
        seen.add(i)
        e = ir[i]
        k = e.kind
        if k == 'jmp':
            if e.target_ir is not None:
                stack.append(e.target_ir)
        elif k == 'test':
            stack.append(i + 1)
            if e.target_ir is not None:
                stack.append(e.target_ir)
        elif k == 'forprep':
            if e.target_ir is not None:
                stack.append(e.target_ir)
        elif k == 'forloop':
            stack.append(i + 1)
            if e.target_ir is not None:
                stack.append(e.target_ir)
        elif k == 'coresume':
            stack.append(i + 1)
            if e.target_ir is not None:
                stack.append(e.target_ir)
        elif k == 'coroutine_wrap':
            stack.append(i + 1)  # body handled separately
            if e.target_ir is not None:
                stack.append(e.target_ir)
        elif k in ('ret', 'tailcall'):
            pass
        else:
            stack.append(i + 1)
    return seen

def find_numeric_for(ir, i, limit):
    """ir[i] is forprep with forward target T. Find matching forloop with target==T."""
    T = ir[i].target_ir
    if T is None or not (i < T < limit):
        return None
    for fl in range(T, limit):
        e = ir[fl]
        if e.kind == 'forloop':
            if e.target_ir == T:
                return (T, fl)
            return None  # first forloop must close this loop
        if e.kind in ('ret', 'tailcall'):
            return None
    return None

def structure(tid):
    ir, p2ir, n = build_ir(tid)
    reach = reachable(ir, n)
    N = len(ir)
    # fall-through entry: control flows into t from t-1 linearly
    def ft_entered(t):
        if t == 0:
            return True
        pv = ir[t - 1]
        if pv.kind in ('ret', 'tailcall'):
            return False
        if pv.kind in ('jmp',):
            return pv.target_ir == t
        return True
    # loop heads: backward jump targets that are fall-through entered
    back_jump_end = {}
    for j, e in enumerate(ir):
        if j not in reach or e.target_ir is None:
            continue
        t = e.target_ir
        if t <= j:
            back_jump_end[t] = max(back_jump_end.get(t, 0), j)
    loop_heads = set()
    for t, bj in back_jump_end.items():
        if ft_entered(t):
            loop_heads.add(t)
    # continues: forward jumps into loop heads
    conts = set()
    for j, e in enumerate(ir):
        if j not in reach or e.target_ir is None:
            continue
        t = e.target_ir
        if t in loop_heads and t < j:
            conts.add(j)
    covered_loops = set()
    processed = set()

    def _loop_body_end(head, hi):
        bj = back_jump_end.get(head)
        return bj

    def parse(lo, hi, out, depth=0, loop_depth=0):
        i = lo
        guard = 0
        while i < hi:
            guard += 1
            if guard > 200000:
                out.append(S('raw', txt='-- ?? guard'))
                return
            if i in processed:
                return  # merged flow
            e = ir[i]
            k = e.kind
            # ---- numeric for / for-in ----
            if k == 'forprep' and not e.junk:
                nf = find_numeric_for(ir, i, hi)
                if nf:
                    T, fl = nf
                    body = []
                    parse(T, fl, body, depth + 1, loop_depth + 1)
                    out.append(S('fornum', var=e.kw['reg0'], body=body))
                    i = fl + 1
                    continue
                T = e.target_ir
                if T is not None and i < T < hi:
                    body = []
                    bend = _loop_body_end(T, hi)
                    endx = (bend + 1) if (bend is not None and T in loop_heads) else hi
                    parse(T, endx, body, depth + 1)
                    out.append(S('do', body=body, comment='-- for-in loop'))
                    i = endx
                    continue
                i += 1
                continue
            if k == 'coroutine_wrap':
                T = e.target_ir
                body = []
                if T is not None and T < hi:
                    bend = _loop_body_end(T, hi)
                    endx = (bend + 1) if (bend is not None and T in loop_heads) else hi
                    parse(T, endx, body, depth + 1)
                out.append(S('forin', reg0=e.kw['reg0'], target=T, body=body))
                i += 1
                continue
            # ---- loop head ----
            if i in loop_heads and i not in covered_loops:
                covered_loops.add(i)
                bj = _loop_body_end(i, hi)
                if bj is None or bj < i:
                    i += 1
                    continue
                if ir[bj].kind == 'test' and ir[bj].target_ir == i:
                    body = []
                    processed.add(i)
                    parse(i, bj, body, depth + 1)
                    processed.discard(bj)
                    out.append(S('repeat', cond=ir[bj].kw['cond'], body=body))
                    i = bj + 1
                    continue
                if e.kind == 'test' and e.target_ir is not None and e.target_ir > bj:
                    body = []
                    processed.add(i)
                    parse(i + 1, bj + 1, body, depth + 1, loop_depth + 1)
                    out.append(S('while', cond=e.kw['cond'], body=body))
                    i = bj + 1
                    continue
                body = []
                parse(i + 1, bj + 1, body, depth + 1, loop_depth + 1)
                out.append(S('whiletrue', body=body))
                i = bj + 1
                continue
            processed.add(i)
            # ---- continue ----
            if i in conts and k == 'jmp' and loop_depth > 0:
                out.append(S('continue'))
                i += 1
                continue
            # ---- return ----
            if k in ('ret', 'tailcall'):
                out.append(S('emit', e=e))
                return
            # ---- test (if/else) ----
            if k == 'test':
                T = e.target_ir
                if T is None or T == i + 1:
                    i += 1
                    continue
                if T <= i:
                    if i == back_jump_end.get(T) and T in loop_heads:
                        return  # closes enclosing loop
                    i += 1
                    continue
                prev = ir[T - 1] if T - 1 > i else None
                if prev is not None and prev.kind == 'jmp' and prev.target_ir is not None and prev.target_ir > T:
                    T2 = prev.target_ir
                    then_body = []
                    parse(T, T2, then_body, depth + 1)
                    else_body = []
                    if i + 1 < T - 1:
                        parse(i + 1, T - 1, else_body, depth + 1)
                    out.append(S('ifelse', cond=e.kw['cond'], then=then_body, els=else_body))
                    i = max(T2, T)
                    continue
                body = []
                parse(i + 1, T, body, depth + 1)
                out.append(S('ifnot', cond=e.kw['cond'], body=body))
                i = T
                continue
            # ---- plain jump ----
            if k == 'jmp':
                t = e.target_ir
                if t == i + 1 or t is None:
                    i += 1
                    continue
                if t > i:
                    if t >= hi:
                        return
                    i = t  # follow layout link
                    continue
                # backward
                if i == back_jump_end.get(t) and t in loop_heads:
                    return  # closes enclosing loop
                if t not in processed:
                    i = t  # layout link backward into unprocessed code
                    continue
                i += 1
                continue
            # ---- forloop reaching here = loop exit point ----
            if k == 'forloop':
                return
            if k == 'coresume':
                T = e.target_ir
                then_body = []
                else_body = []
                # the resume itself is a statement; the branch tests its ok flag
                out.append(S('emit', e=e))
                if T is not None and T > i:
                    parse(T, hi, then_body, depth + 1)
                if i + 1 < hi:
                    parse(i + 1, hi, else_body, depth + 1)
                out.append(S('ifelse', cond=('reg', e.kw['dst']), then=then_body, els=else_body))
                return
            if k == 'forrestore' or k == 'nop':
                i += 1
                continue
            out.append(S('emit', e=e))
            i += 1

    stmts_out = []
    if ir:
        parse(0, N, stmts_out)
    # coverage sweep: reachable-but-unprocessed regions (scrambled chunks)
    # NOTE: the try cap used to be 256, which silently truncated the sweep and
    # dropped 9 closure-creation sites (T283/303/452/473/498/508/599/609/619) --
    # those protos then had to be emitted as top-level "standalone" stubs with
    # unresolved UP<n> upvalues.  Every reachable IR must be emitted, so the cap
    # is now only a runaway guard.
    tries = 0
    while tries < 1000000:
        tries += 1
        nxt = None
        for i in range(N):
            if i in reach and i not in processed:
                nxt = i
                break
        if nxt is None:
            break
        before = len(processed)
        blk = []
        parse(nxt, N, blk, 1)
        if len(processed) == before:
            processed.add(nxt)  # force progress
            continue
        if blk:
            stmts_out.append(S('do', body=blk, comment=f'-- chunk @ir{nxt}'))
    return stmts_out, ir, reach, p2ir, n

# ---------------- rendering ----------------

KW_TEXTOPS = None

def render_expr(x):
    return decomp.expr_str(x)

def render_stmts(stmts, ind, upvals_used, closures_used):
    lines = []
    pad = '    ' * ind
    for st in stmts:
        k = st.kind
        if k == 'emit':
            e = st.kw['e']
            lines.extend(render_ir(e, ind, upvals_used, closures_used))
        elif k == 'ifelse':
            cond = st.kw['cond']
            if isinstance(cond, tuple) and cond[0] == 'res':
                cond_txt = f"__ok{cond[1]}"
            else:
                cond_txt = render_expr(cond)
            lines.append(f"{pad}if {cond_txt} then")
            lines.extend(render_stmts(st.kw['then'], ind + 1, upvals_used, closures_used))
            els = st.kw['els']
            if els:
                lines.append(f"{pad}else")
                lines.extend(render_stmts(els, ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}end")
        elif k == 'ifnot':
            if not st.kw['body']:
                continue
            lines.append(f"{pad}if not ({render_expr(st.kw['cond'])}) then")
            lines.extend(render_stmts(st.kw['body'], ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}end")
        elif k == 'while':
            lines.append(f"{pad}while not ({render_expr(st.kw['cond'])}) do -- while-exit-cond")
            lines.extend(render_stmts(st.kw['body'], ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}end")
        elif k == 'whiletrue':
            lines.append(f"{pad}while true do")
            lines.extend(render_stmts(st.kw['body'], ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}end")
        elif k == 'repeat':
            # the loop-back test jumps back while it holds, so `repeat body until
            # not cond` is the source-level shape
            lines.append(f"{pad}repeat")
            lines.extend(render_stmts(st.kw['body'], ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}until not ({render_expr(st.kw['cond'])})")
        elif k == 'fornum':
            v = st.kw['var']
            lines.append(f"{pad}for __v{v}, __l{v}, __s{v} in __foriter do -- numeric for (regs R{v}..R{v+2})")
            lines.extend(render_stmts(st.kw['body'], ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}end")
        elif k == 'forin':
            lines.append(f"{pad}-- generic-for iterator (coroutine desugar) reg R{st.kw['reg0']}")
            lines.append(f"{pad}do")
            lines.extend(render_stmts(st.kw['body'], ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}end")
        elif k == 'do':
            c = st.kw.get('comment') or ''
            lines.append(f"{pad}do {c}".rstrip())
            lines.extend(render_stmts(st.kw['body'], ind + 1, upvals_used, closures_used))
            lines.append(f"{pad}end")
        elif k == 'continue':
            lines.append(f"{pad}continue -- luau")
        elif k == 'raw':
            lines.append(f"{pad}{st.kw['txt']}")
    return lines

def render_ir(e, ind, upvals_used, closures_used):
    pad = '    ' * ind
    f = decomp.LINEFMT.get(e.kind)
    if e.kind == 'closure':
        closures_used.append(e.kw)
        child = e.kw['child']
        if not isinstance(child, (int, float)) or int(child) not in decomp.protos:
            # junk op: the operand stream is rewritten at runtime, so the child
            # proto id was never statically decoded.  The assignment cannot be
            # reproduced -- keep it as a comment instead of a call to a nil global.
            return [f"{pad}-- (junk closure op at instr {e.p0}: child proto not statically decoded)"]
        return [f"{pad}{decomp.expr_str(('reg', e.kw['dst']))} = T{int(child)}() -- closure"]
    if e.kind == 'getupval':
        upvals_used.add(e.kw['upv'])
        return [f"{pad}{decomp.RN(e.kw['dst'])} = {render_expr(('upv', e.kw['upv']))}"]
    if e.kind == 'setupval':
        upvals_used.add(e.kw['upv'])
        return [f"{pad}{render_expr(('upv', e.kw['upv']))} = {render_expr(e.kw['val'])}"]
    if e.kind == 'setupval_field':
        upvals_used.add(e.kw['upv'])
        return [f"{pad}{render_expr(('upv', e.kw['upv']))}[{render_expr(e.kw['key'])}] = {render_expr(e.kw['val'])}"]
    if e.kind == 'raw':
        return [f"{pad}{e.kw['txt']}"]
    if e.kind in ('nop', 'consumed'):
        return []
    if f is None:
        return [f"{pad}<?{e.kind}>"]
    return [f"{pad}{f(e.kw)}"]

def upval_name(idx):
    return f"U{idx}"

if __name__ == '__main__':
    import sys
    tids = [int(a) for a in sys.argv[1:]] if len(sys.argv) > 1 else sorted(protos)
    for tid in tids:
        stmts, ir, reach, p2ir, n = structure(tid)
        dead = sum(1 for i in range(len(ir)) if i not in reach)
        upv, cls = set(), []
        lines = render_stmts(stmts, 0, upv, cls)
        print(f"===== T{tid} params={protos[tid]['numparams']} upvals={sorted(upv)} closures={[c['child'] for c in cls]} dead={dead}/{len(ir)}")
        for L in lines:
            print(L)
