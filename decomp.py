#!/usr/bin/env python3
"""Luraph VM decompiler — Pass 1 v2: symbolic IR builder (final semantics)."""
import pickle, re

protos = pickle.load(open('instrs.pkl', 'rb'))

def reg(i): return ('reg', i)
def const(v): return ('const', v)

def const_str(v):
    if isinstance(v, tuple):
        kind, val = v[0], v[1]
        if kind == 'str':
            s = val.replace('\\', '\\\\').replace("'", "\\'").replace('\n', '\\n').replace('\r', '\\r')
            return "'" + s + "'"
        if kind == 'bool': return 'true' if val else 'false'
        if kind == 'nil': return 'nil'
        f = float(val)
        return str(int(f)) if f == int(f) and abs(f) < 1e15 else repr(f)
    if v is True: return 'true'
    if v is False: return 'false'
    if isinstance(v, str):
        s = v.replace('\\', '\\\\').replace("'", "\\'").replace('\n', '\\n')
        return "'" + s + "'"
    return str(v)

def glname(v):
    s = v[1] if isinstance(v, tuple) and v[0] == 'str' else v
    return s if isinstance(s, str) and re.match(r'^[A-Za-z_]\w*$', s) else const_str(s)
def fld(obj, key): return ('fld', obj, key)
def binop(op, l, r): return ('bin', op, l, r)
def unop(op, e): return ('un', op, e)

def expr_str(e):
    t = e[0]
    if t == 'reg':
        return f"R{e[1]}"
    if t == 'const':
        v = e[1]
        if v is None: return 'nil'
        if isinstance(v, bool): return 'true' if v else 'false'
        if isinstance(v, str):
            return '"%s"' % v.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r')
        if isinstance(v, float) and v == int(v) and abs(v) < 2**53:
            return str(int(v))
        return repr(v)
    if t == 'fld' and e[1] == ('E',):
        if e[2][0] == 'reg':
            return expr_str(e[2])
        return 'nil'   # register-file slot whose index the junk ops rewrite at runtime
    if t == 'fld':
        obj, key = e[1], e[2]
        os_ = expr_str(obj)
        if key[0] == 'const' and isinstance(key[1], str) and re.match(r'^[A-Za-z_][A-Za-z0-9_]*$', key[1]):
            return f"{os_}.{key[1]}"
        return f"{os_}[{expr_str(key)}]"
    if t == 'bin':
        l, r = expr_str(e[2]), expr_str(e[3])
        op = e[1]
        fn = {'&': 'bit32.band', '|': 'bit32.bor', '~': 'bit32.bxor', '<<': 'bit32.lshift', '>>': 'bit32.rshift'}.get(op)
        if fn:
            return f"{fn}({l}, {r})"
        return f"({l} {op} {r})"
    if t == 'un':
        return f"({e[1]}{expr_str(e[2])})"
    if t == 'call':
        args = ', '.join(expr_str(a) for a in e[2])
        return f"{expr_str(e[1])}({args})"
    if t == 'newtable':
        return '{}'
    if t == 'closure':
        return f"T{e[1]}"
    if t == 'call0':
        return f"{expr_str(e[1])}()"
    if t == 'upv':
        return f"UPV{e[1]}"
    if t == 'pool':
        return f"POOL[{e[1]}]"
    if t == 'poolref':
        return f"UPV[{e[1]}][{e[2]}]"
    if t == 'E':
        return 'E'
    if t == 'x':
        return 'x'
    if t == 'ENV':
        return 'ENV'
    if t == 'UPVALS':
        return 'UPVALS'
    if t == 'const':
        return const_str(e[1])
    if t == 'spread':
        a, b = e[1], e[2]
        if b == 'top':
            # open-ended "registers R<a>..top of stack" argument list
            return f"...--[[registers {RN(a)}..top of stack]]"
        lo, hi = int(a), int(b)
        if hi < lo:
            return ''
        return ', '.join(RN(i) for i in range(lo, hi + 1))
    if t == 'spread_after':
        # R<lo>..R<d-1> followed by every result of the inlined multret call
        lo, d, cx = int(e[1]), int(e[2]), e[3]
        pre = [RN(i) for i in range(lo, d)]
        return ', '.join(pre + [expr_str(cx)])
    if t == 'callx':
        return f"{expr_str(e[1])}({', '.join(expr_str(a) for a in e[2])})"
    if t == 'varg':
        return '...'
    if t == 'raw':
        return e[1]
    return f"<?{t}>"

class IR:
    __slots__ = ('idx', 'kind', 'kw', 'p0', 'target_ir', 'junk')
    def __init__(self, idx, kind, **kw):
        self.idx = idx; self.kind = kind; self.kw = kw; self.p0 = 0
    def __repr__(self):
        return f"[{self.idx}] {self.kind} {self.kw}"

def decode_proto(tid):
    p = protos[tid]
    n = p['nops']
    A, z, u, e, T, y, D = p['A'], p['z'], p['u'], p['e'], p['T'], p['y'], p['D']
    ir = []
    m = J = C = K = a = x = c62 = None
    pend = [None]
    P_ = 0

    def emit(kind, **kw):
        e = IR(len(ir), kind, **kw)
        e.p0 = pend[0] if pend[0] is not None else P_
        pend[0] = None
        ir.append(e)

    if n == 1 and A[0] > 224:
        emit('ret', exprs=[])
        return ir
    for P in range(n):
        P_ = P
        V = A[P]
        if pend[0] is None:
            pend[0] = P
        zp, up, ep = z[P], u[P], e[P]
        tp, yp, Dp = T[P], y[P], D[P]
        tpv = tp[1] if isinstance(tp, tuple) else tp
        yv = yp[1] if isinstance(yp, tuple) else yp
        ykind = yp[0] if isinstance(yp, tuple) else 'num'
        R = reg
        # ============ returns / tailcalls ============
        if V == 6:
            emit('close'); emit('ret', exprs=[R(up)]); continue
        if V == 173:
            emit('close'); emit('ret', exprs=[]); continue
        if V == 138:
            emit('close'); emit('ret', exprs=[('varg', ep)]); continue
        if V == 195:
            emit('close'); emit('ret', exprs=[]); continue
        if V == 164:
            emit('setupval', upv=zp, val=R(ep)); continue
        if V == 14:
            emit('close'); emit('tailcall', f=R(ep), args=[('spread', ep+1, 'top')]); continue
        if V == 38:
            emit('close'); emit('tailcall', f=R(up), args=[R(up+1)]); continue
        if V == 80:
            emit('close'); emit('tailcall', f=R(ep), args=[('spread', ep+1, ep+up-1)]); continue
        # ============ tests ============
        if V == 100:
            emit('test', cond=R(zp), target=ep); continue
        if V == 101:
            emit('test', cond=unop('not ', R(zp)), target=ep); continue
        if V == 28:
            emit('test', cond=binop('~=', R(ep), const(tpv)), target=zp); continue
        if V == 149:
            emit('test', cond=binop('==', R(ep), const(tpv)), target=zp); continue
        if V == 75:
            emit('setglobal', name=Dp, val=const(yv)); continue
        if V == 45:
            emit('test', cond=binop('<=', R(ep), const(yv)), target=up); continue
        if V == 33:
            emit('test', cond=binop('>=', const(Dp), R(up)), target=zp); continue
        if V == 86:
            emit('test', cond=binop('>', R(zp), const(tpv)), target=ep); continue
        if V == 88:
            emit('test', cond=binop('>=', R(ep), R(zp)), target=up); continue
        if V == 120:
            emit('test', cond=binop('<', R(zp), const(tpv)), target=ep); continue
        if V == 128:
            emit('test', cond=binop('>=', R(ep), const(yv)), target=up); continue
        if V == 132:
            emit('test', cond=binop('~=', R(up), R(ep)), target=zp); continue
        if V == 133:
            emit('test', cond=binop('>', const(yv), R(up)), target=ep); continue
        if V == 151:
            emit('test', cond=binop('>', R(up), R(ep)), target=zp); continue
        if V == 162:
            emit('test', cond=binop('==', R(up), R(ep)), target=zp); continue
        # ============ loops ============
        if V == 204:
            m = None
            emit('forprep', reg0=up, target=zp); continue
        if V == 17:
            emit('forloop', reg0=ep, target=zp); continue
        if V == 198:
            emit('forrestore'); continue
        if V == 190:
            emit('close'); continue
        if V == 62:
            c62 = zp; continue
        if V == 55:
            if c62 is not None:
                emit('call', dst=None, f=R(c62), args=[], nret=0)
            c62 = None; continue
        if V == 121:
            emit('jmp', target=ep); continue
        # ============ calls ============
        if V == 11:
            emit('call', dst=zp, f=R(zp), args=[R(zp+1)], nret=1); continue
        if V == 18:
            emit('call', dst=up, f=R(up), args=[R(up+1), R(up+2)], nret=1); continue
        if V == 1:
            emit('call', dst=None, f=R(zp), args=[], nret=0); continue
        if V == 21:
            emit('call', dst=None, f=R(up), args=[R(up+1)], nret=0); continue
        if V == 26:
            emit('call', dst=ep, f=R(ep), args=[], nret=1); continue
        if V == 40:
            args = [R(ep+1+i) for i in range(max(up-1, 0))]
            emit('call', dst=ep, f=R(ep), args=args, nret=1); continue
        if V == 184:
            emit('call', dst=ep, f=R(ep), args=[('spread', ep+1, 'top')], nret=1); continue
        if V == 58:
            emit('call', dst=None, f=R(up), args=[('spread', up+1, 'top')], nret=0); continue
        if V == 167:
            emit('call', dst=None, f=R(ep), args=[R(ep+1), R(ep+2)], nret=0); continue
        if V == 207:
            emit('call', dst=None, f=R(up), args=[('spread', up+1, up+zp)], nret=0); continue
        if V == 156:
            args = [('spread', zp+1, zp+ep)] if ep > 0 else []
            emit('call', dst=zp, f=R(zp), args=args, nret=up); continue
        if V == 172:
            emit('coroutine_wrap', reg0=up, target=ep); continue
        if V == 46:
            emit('coresume', dst=ep, target=up); continue
        # ============ closures ============
        if V == 188:
            emit('closure', dst=ep, child=yv, upvals=True); continue
        if V == 208:
            emit('closure', dst=ep, child=yv, upvals=False); continue
        # ============ varargs ============
        if V == 9:
            emit('varargs', dst=zp); continue
        if V == 44 or V == 216:
            emit('varargs_fixed', count=zp); continue
        if V == 144:
            emit('varargs_count', dst=up, count=zp); continue
        # ============ moves / loads ============
        if V == 4:
            emit('assign', dst=ep, expr=const(yv)); continue
        if V == 201:
            emit('assign', dst=ep, expr=R(up)); continue
        if V == 124:
            emit('newtable', dst=ep); continue
        if V == 175:
            emit('newtable_n', dst=ep, size=up); continue
        if V == 168:
            emit('assign', dst=ep, expr=const(None)); continue
        if V == 140:
            emit('assign', dst=ep, expr=const(None)); continue
        if V == 69:
            emit('nilrange', lo=up, hi=zp); continue
        if V == 92:
            emit('getglobal', dst=zp, name=tp); continue
        if V == 215:
            emit('setglobal', name=tp, val=R(zp)); continue
        if V == 82:
            emit('assign', dst=ep, expr=const(61004)); continue
        if V == 64:
            x = ep
            continue
        if V == 0:
            x = ('m',)
            continue
        # ============ table ops ============
        if V == 93:
            emit('assign', dst=ep, expr=fld(R(up), R(zp))); continue
        if V == 179:
            emit('assign', dst=up, expr=fld(R(zp), const(Dp))); continue
        if V == 145:
            emit('settable', obj=R(ep), key=R(up), val=R(zp)); continue
        if V == 220:
            emit('settable', obj=R(up), key=const(yv), val=R(zp)); continue
        if V == 217:
            emit('settable', obj=R(up), key=R(zp), val=const(Dp)); continue
        if V == 30:
            emit('settable', obj=R(zp), key=const(Dp), val=const(tpv)); continue
        if V == 143:
            emit('settable', obj=R(ep), key=R(up), val=R(zp)); continue
        if V == 118:
            emit('assign', dst=up, expr=unop('#', R(zp))); continue
        if V == 174:
            emit('assign', dst=zp, expr=unop('not ', R(ep))); continue
        if V == 181:
            emit('assign', dst=up, expr=unop('-', R(ep))); continue
        # ============ arithmetic ============
        if V == 42:
            emit('assign', dst=ep, expr=binop('%', R(zp), R(up))); continue
        if V == 155:
            emit('assign', dst=zp, expr=binop('%', R(ep), const(tpv))); continue
        if V == 98:
            emit('assign', dst=ep, expr=binop('*', R(zp), R(up))); continue
        if V == 182:
            emit('assign', dst=zp, expr=binop('*', R(up), const(Dp))); continue
        if V == 154:
            emit('assign', dst=zp, expr=binop('*', const(tpv), R(ep))); continue
        if V == 222:
            emit('assign', dst=ep, expr=binop('+', R(up), R(zp))); continue
        if V == 194:
            emit('assign', dst=up, expr=binop('+', R(ep), const(yv))); continue
        if V == 137:
            emit('assign', dst=up, expr=binop('+', const(yv), R(ep))); continue
        if V == 210:
            emit('assign', dst=up, expr=binop('-', R(ep), R(zp))); continue
        if V == 139:
            emit('assign', dst=up, expr=binop('-', R(ep), const(yv))); continue
        if V == 150:
            emit('assign', dst=up, expr=binop('-', const(Dp), R(zp))); continue
        if V == 122:
            emit('assign', dst=ep, expr=binop('/', R(zp), R(up))); continue
        if V == 87:
            emit('assign', dst=up, expr=binop('/', R(ep), const(yv))); continue
        if V == 66:
            emit('assign', dst=up, expr=binop('/', const(yv), R(ep))); continue
        if V == 104:
            emit('assign', dst=up, expr=binop('//', R(ep), R(zp))); continue
        if V == 31:
            emit('assign', dst=zp, expr=binop('//', R(up), const(Dp))); continue
        if V == 81:
            emit('assign', dst=ep, expr=binop('^', const(yv), const(tpv))); continue
        if V == 141:
            emit('assign', dst=zp, expr=binop('^', const(Dp), R(up))); continue
        if V == 68:
            emit('assign', dst=ep, expr=binop('>>', R(up), const(yv))); continue
        if V == 119:
            emit('assign', dst=up, expr=binop('~', R(ep), const(yv))); continue
        if V == 219:
            emit('assign', dst=zp, expr=binop('~', R(ep), R(up))); continue
        if V == 107:
            emit('assign', dst=zp, expr=binop('&', R(up), const(Dp))); continue
        # ============ comparisons (bool results) ============
        if V == 103:
            emit('assign', dst=up, expr=binop('==', R(zp), R(ep))); continue
        if V == 67:
            emit('assign', dst=ep, expr=binop('~=', R(up), R(zp))); continue
        if V == 50:
            emit('assign', dst=ep, expr=binop('==', R(up), const(yv))); continue
        if V == 8:
            emit('assign', dst=up, expr=binop('~=', R(zp), const(Dp))); continue
        if V == 29:
            emit('assign', dst=up, expr=binop('>=', R(ep), const(yv))); continue
        if V == 78:
            emit('assign', dst=ep, expr=binop('>=', R(zp), R(up))); continue
        if V == 129:
            emit('assign', dst=zp, expr=binop('<=', R(up), R(ep))); continue
        if V == 166:
            emit('assign', dst=zp, expr=binop('<', R(ep), R(up))); continue
        if V == 191:
            emit('assign', dst=up, expr=binop('>', R(zp), const(Dp))); continue
        # ============ concat ============
        if V == 24:
            emit('assign', dst=ep, expr=binop('..', const(tpv), R(zp))); continue
        if V == 178:
            emit('assign', dst=ep, expr=binop('..', R(zp), const(tpv))); continue
        if V == 159:
            emit('assign', dst=ep, expr=binop('..', R(up), R(zp))); continue
        if V == 221:
            emit('assign', dst=zp, expr=binop('..', const(tpv), const(Dp))); continue
        if V == 213:
            emit('assign', dst=zp, expr=binop('/', const(Dp), const(tpv))); continue
        # ============ upvalues / env ============
        if V == 60:
            if ykind == 'num':
                emit('assign', dst=up, expr=('poolref', ep, int(yv)))
            else:
                emit('assign', dst=up, expr=fld(('upv', ep), const(yv)))
            continue
        if V == 157:
            emit('getupval', dst=ep, upv=up); continue
        if V == 114:
            emit('getupval', dst=ep, upv=up); continue
        if V == 108:
            emit('assign', dst=zp, expr=fld(('upv', ep), const(tpv))); continue
        if V == 65:
            emit('assign', dst=ep, expr=fld(('upv', zp), R(up))); continue
        if V == 36:
            emit('assign', dst=up, expr=fld(('upv', zp), R(ep))); continue
        if V == 147:
            emit('setupval_field', upv=ep, key=const(yv), val=R(up)); continue
        if V == 16:
            emit('setupval_field', upv=zp, key=R(up), val=R(ep)); continue
        if V == 61:
            emit('setupval_field', upv=zp, key=R(ep), val=const(tpv)); continue
        if V == 89:
            emit('setupval_field', upv=zp, key=const(Dp), val=const(tpv)); continue
        if V == 22:
            emit('setupval_field', upv=ep, key=const(yv), val=const(tpv)); continue
        if V == 15:
            emit('setupval_field', upv=up, key=const(yv), val=R(ep)); continue
        if V == 170:
            emit('setupval', upv=zp, val=const(Dp)); continue
        if V == 148:
            emit('self', dst=ep, obj=R(up), key=const(yv)); continue
        # ============ SELF ============
        if V == 149:
            emit('self', dst=ep, obj=R(up), key=const(yv)); continue
        # ============ accumulator chains ============
        if V in (12, 97, 197):
            m = ('E',); continue
        if V in (3, 27):
            m = ('E',); J = R(zp); continue
        if V in (5, 153):
            m = ('E',); J = R(ep); continue
        if V == 214:
            m = ('E',); J = R(ep); C = ('E',); continue
        if V == 70:
            m = ('E',); J = R(up); continue
        if V in (109, 2):
            m = fld(('E',), R(up)); continue
        if V == 115:
            C = ('E',); K = R(up); continue
        if V == 35:
            C = fld(('E',), R(zp)); continue
        if V in (102, 91):
            C = ('E',); continue
        if V == 83:
            C = fld(('E',), R(up)); continue
        if V == 23:
            C = ('ENV',); continue
        if V == 99:
            J = R(zp); C = ('ENV',); continue
        if V == 106:
            C = const(tpv); continue
        if V == 37:
            C = const(yv); continue
        if V == 95:
            base = m if m is not None else ('E',)
            emit('settable', obj=base, key=J if J is not None else const('?'), val=const(yv))
            m = J = None; continue
        if V == 48:
            C = fld(C if C is not None else ('ENV',), const(tpv)); continue
        if V == 211:
            K = R(zp); C = fld(C if C is not None else ('E',), K); continue
        if V in (203, 205):
            C = fld(C if C is not None else ('E',), K if K is not None else const('?')); continue
        if V == 59:
            C = fld(C if C is not None else ('E',), K if K is not None else const('?'))
            K = const(Dp); continue
        if V == 187:
            K = R(up); C = fld(C if C is not None else ('E',), K); continue
        if V in (177, 218):
            C = fld(C if C is not None else ('E',), K if K is not None else const('?'))
            K = const(yv) if V == 177 else const(Dp); continue
        if V == 193:
            C = ('UPVALS',); continue
        if V == 85:
            J = fld(J if J is not None else ('E',), R(up))
            C = ('E',); continue
        if V == 158:
            K = ('x',) if K is None else K
            C = fld(C if C is not None else ('E',), K)
            C = ('cres', C); continue
        if V == 39:
            m = ('E',); J = R(up); C = ('E',); continue
        if V == 94:
            m = ('E',); J = R(zp); C = const(Dp); continue
        if V == 110:
            K = R(up); continue
        if V == 192:
            K = const(Dp); continue
        if V == 189:
            K = const(tpv); continue
        if V == 56:
            K = const(yv); continue
        if V == 169:
            K = R(ep); continue
        if V == 57:
            J = const(Dp); continue
        if V == 32:
            J = R(ep); continue
        if V == 113:
            J = R(up); continue
        if V == 160:
            J = R(ep); continue
        if V == 51:
            J = ('x',); continue
        if V == 90:
            m = ('E',); J = ('x',); continue
        if V == 52:
            m = fld(m if m is not None else ('E',), ('x',)); continue
        if V == 77:
            m = fld(m if m is not None else ('E',), J if J is not None else const('?')); continue
        if V == 135:
            m = ('E',); J = R(up); continue
        if V in (10, 34, 180):
            if isinstance(C, tuple) and C[0] == 'cres':
                if m == ('E',) and isinstance(J, tuple) and J[0] == 'reg':
                    emit('assign', dst=J[1], expr=('call0', C[1]))
                else:
                    emit('settable', obj=m or ('E',), key=J or const('?'), expr_call=C[1])
            else:
                emit('settable', obj=m if m is not None else ('E',), key=J if J is not None else const('?'), val=C if C is not None else const('?'))
            m = J = C = None; continue
        if V == 73:
            C = fld(C if C is not None else ('E',), K if K is not None else const('?'))
            emit('settable', obj=m if m is not None else ('E',), key=J if J is not None else const('?'), val=C)
            m = J = C = None; continue
        if V == 63:
            K = fld(K if K is not None else ('E',), a if a is not None else const('?'))
            C = binop('+', C if C is not None else const(0), K)
            emit('settable', obj=m if m is not None else ('E',), key=J if J is not None else const('?'), val=C)
            m = J = C = K = None; continue
        if V == 76:
            C = binop('-', C if C is not None else const(0), K if K is not None else const(0))
            emit('settable', obj=m if m is not None else ('E',), key=J if J is not None else const('?'), val=C)
            m = J = C = K = None; continue
        if V == 212:
            C = binop('/', C if C is not None else const(0), K if K is not None else const(1))
            emit('settable', obj=m if m is not None else ('E',), key=J if J is not None else const('?'), val=C)
            m = J = C = K = None; continue
        if V == 202:
            C = binop('*', C if C is not None else const(0), K if K is not None else const(1)); continue
        if V == 96:
            K = fld(K if K is not None else ('E',), a if a is not None else const('?'))
            C = binop('^', C if C is not None else const(0), K); continue
        if V == 19:
            K = fld(K if K is not None else ('E',), a if a is not None else const('?'))
            C = binop('..', C if C is not None else const(''), K); continue
        if V == 41:
            C = const(tpv); K = ('E',); a = R(zp); continue
        if V in (71, 123, 224):
            K = ('E',); a = R(up) if V in (71,) else R(zp); continue
        if V == 84:
            J = R(zp); m = fld(m if m is not None else ('E',), J); continue
        if V == 186:
            J = const(Dp); C = const(tpv); continue
        if V == 196:
            J = R(ep); C = ('E',); K = R(up); continue
        if V == 157+0:
            pass
        if V == 223 or 225 <= V <= 234:
            J = const(yv); C = ('E',); K = R(ep); continue
        if V == 185:
            emit('nop', op=185); continue
        if V == 53 or V == 43:
            emit('moverange'); continue
        if V == 105:
            x = m; m = ('E',); continue
        if V == 199:
            m = ('ENV',); J = const(tpv); continue
        if V == 116:
            J = R(ep); C = ('UPVALS',); continue
        if V == 54:
            emit('settable', obj=m if m is not None else ('E',), key=J if J is not None else const('?'), val=('newtable',))
            m = J = None; continue
        if V == 142:
            C = fld(C if C is not None else ('E',), K if K is not None else const('?'))
            K = const(yv); continue
        if V == 163:
            m = fld(m if m is not None else ('E',), J if J is not None else const('?'))
            J = ('E',); continue
        if V == 209:
            x = ep; continue
        if V in (20, 74, 112, 49, 206, 117, 72, 130, 47, 200, 126, 183):
            emit('nop', op=V); continue
        if V in (79, 125):
            emit('opaque', op=V, P=P); continue
        if V == 111:
            emit('opaque', op=V, P=P); continue
        emit('opaque', op=V, P=P)
    _simplify_regfile(ir)
    _pair_coroutines(ir)
    _merge_multret_args(ir)
    return ir

def _simplify_regfile(ir):
    """`E` is the VM register file, so `E[Rk] = v` / `v = E[Rk]` are plain moves.

    Stores whose index was never decoded (dead code produced by the self-modifying
    junk ops) become comments instead of a bogus `E[x] = ...` table store."""
    for e in ir:
        if e.kind == 'settable' and e.kw.get('obj') == ('E',):
            k = e.kw.get('key')
            if isinstance(k, tuple) and k[0] == 'reg' and 'expr_call' not in e.kw:
                e.kind = 'assign'
                e.kw = {'dst': k[1], 'expr': e.kw.get('val', const(None))}
            else:
                e.kind = 'raw'
                e.kw = {'txt': '-- (junk op: register-file store with a decoded-at-runtime index)'}

def _pair_coroutines(ir):
    """pair each coroutine-resume with the wrap that built its iterator triple"""
    wraps = {}
    for i, e in enumerate(ir):
        if e.kind == 'coroutine_wrap':
            wraps.setdefault(int(e.kw['reg0']), []).append(i)
    for e in ir:
        if e.kind == 'coresume':
            d = int(e.kw['dst'])
            cand = wraps.get(d)
            if cand:
                e.kw['co_reg0'] = int(ir[cand[0]].kw['reg0'])

def _merge_multret_args(ir):
    """Fold "call f(Ra..top)" after a multret call into one Lua argument list.

    The VM materialises the results of a multi-return call into registers
    Rd..top and then spreads them into the *next* call.  In source that is just
    `f(fixed..., g(...))` -- a multi-return call used as the last argument.  We
    inline the previous call expression at the use site and drop the original
    statement (it is marked 'consumed' and renders to nothing).
    """
    for i, e in enumerate(ir):
        if e.kind != 'call':
            continue
        args = e.kw.get('args') or []
        if len(args) != 1 or args[0][0] != 'spread' or args[0][2] != 'top':
            continue
        lo = args[0][1]
        j = i - 1
        while j >= 0 and ir[j].kind in ('close', 'nop', 'forrestore'):
            j -= 1
        if j < 0:
            continue
        pv = ir[j]
        if pv.kind != 'call' or pv.kw.get('nret') != 0 or pv.kw.get('dst') is None:
            continue
        d = int(pv.kw['dst'])
        if d < lo:
            continue
        e.kw['args'] = [('spread_after', lo, d, ('callx', pv.kw['f'], pv.kw['args']))]
        pv.kind = 'consumed'
        pv.kw = {'dst': d}

def RN(i):
    return expr_str(('reg', i))

LINEFMT = {
    'assign':   lambda k: f"{expr_str(('reg',k['dst']))} = {expr_str(k['expr'])}",
    'settable': lambda k: (f"{expr_str(k['obj'])}[{expr_str(k['key'])}] = {expr_str(k['expr_call'])}()"
                           if 'expr_call' in k else
                           f"{expr_str(k['obj'])}[{expr_str(k['key'])}] = {expr_str(k['val'])}"),
    'getglobal':lambda k: f"{RN(k['dst'])} = ENV.{glname(k['name'])}",
    'setglobal':lambda k: f"ENV.{glname(k['name'])} = {expr_str(k['val'])}",
    'newtable': lambda k: f"{RN(k['dst'])} = {{}}",
    'newtable_n':lambda k: f"{RN(k['dst'])} = {{}} -- size {k['size']}",
    'test':     lambda k: f"if {expr_str(k['cond'])} then PC -> {k['target']}",
    'jmp':      lambda k: f"goto {k['target']}",
    'ret':      lambda k: "return " + ', '.join(expr_str(x) for x in k['exprs']),
    'tailcall': lambda k: f"return {expr_str(k['f'])}({', '.join(expr_str(a) for a in k['args'])})",
    'close':    lambda k: "-- close upvalues",
    'call':     lambda k: _call_str(k),
    'self':     lambda k: f"{RN(k['dst']+1)} = {expr_str(k['obj'])}; {RN(k['dst'])} = {expr_str(k['obj'])}[{expr_str(k['key'])}]",
    'closure':  lambda k: f"{RN(k['dst'])} = closure T{k['child']}" + (" (with upvals)" if k['upvals'] else ""),
    'varargs':  lambda k: (f"{RN(k['dst'])} = ...  -- vararg fill: also writes "
                           f"R{k['dst']+1}, R{k['dst']+2}, ... (count is runtime dependent)"),
    'varargs_fixed': lambda k: f"__init_params({k['count']}) -- E[R1..R{k['count']}] = first varargs",
    'varargs_count': lambda k: f"{RN(k['dst'])} = x - {RN(k['dst'])} + 1  -- vararg count, max {k['count']}",
    'nilrange': lambda k: ', '.join(RN(k['lo'] + i) for i in range(max(0, int(k['hi']) - k['lo'] + 1))) + " = nil",
    'getupval': lambda k: f"{RN(k['dst'])} = {upval_ref(k['upv'])}",
    'setupval': lambda k: f"{upval_ref(k['upv'])} = {expr_str(k['val'])}",
    'setupval_field': lambda k: f"{upval_ref(k['upv'])}[{expr_str(k['key'])}] = {expr_str(k['val'])}",
    'forprep':  lambda k: f"for {RN(k['reg0'])},{RN(k['reg0']+1)},{RN(k['reg0']+2)} prep -> body at {k['target']}",
    'forloop':  lambda k: f"for {RN(k['reg0'])} loop-back -> {k['target']}",
    'forrestore': lambda k: "-- for-loop state restore",
    'coresume': lambda k: (f"{RN(k['dst'])}, {RN(k['dst']+1)}, {RN(k['dst']+2)} = "
                           f"coroutine.resume({RN(k['co_reg0'])}, {RN(k['co_reg0']+1)}, {RN(k['co_reg0']+2)})"
                           if 'co_reg0' in k else
                           f"{RN(k['dst'])}, {RN(k['dst']+1)}, {RN(k['dst']+2)} = coroutine.resume(coroutine-{k['target']})"),
    'coroutine_wrap': lambda k: f"-- coroutine for-in: wrapped fn in {RN(k['reg0'])}..{RN(k['reg0']+2)}; body resumes at instr {k['target']} (loop vars picked up there)",
    'opaque':   lambda k: f"-- opaque op {k['op']} (instr {k['P']})",
    'moverange':lambda k: "-- table.move range",
}

def upval_ref(idx):
    e = expr_str(('upv', idx)) if callable(globals().get('expr_str')) else f"UPV[{idx}]"
    return e

def _call_str(k):
    args = ', '.join(expr_str(a) for a in k['args'])
    call = f"{expr_str(k['f'])}({args})"
    if k['nret'] == 0:
        return call                 # results discarded -> plain statement call
    if k['nret'] == 1:
        return f"{RN(k['dst'])} = {call}"
    if k['nret'] > 1:
        names = ', '.join(RN(k['dst'] + i) for i in range(k['nret']))
        return f"{names} = {call}"
    return f"{call}  -- multret"

def render(tid):
    p = protos[tid]
    ir = decode_proto(tid)
    lines = []
    for ins in ir:
        f = LINEFMT.get(ins.kind)
        txt = f(ins.kw) if f else f"<?{ins.kind}>"
        lines.append((ins.idx, txt))
    return lines

if __name__ == '__main__':
    import sys
    tids = [int(a) for a in sys.argv[1:]] if len(sys.argv) > 1 else sorted(protos)
    for tid in tids:
        p = protos[tid]
        print(f"===== proto T{tid}  nops={p['nops']} params={p['numparams']}")
        for idx, txt in render(tid):
            print(f"  {idx:4d}: {txt}")
