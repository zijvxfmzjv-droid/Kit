import json, pickle

dump = open('/home/user/deobf/protos_dump.txt','rb').read().decode('latin1')

class P:
    def __init__(s, t): s.t = t; s.i = 0
    def parse(s):
        c = s.t; i = s.i; ch = c[i]
        if ch == 'T':
            j = i+1
            while c[j].isdigit(): j += 1
            tid = int(c[i+1:j]); s.i = j
            tbl = {'__id': tid, '__kv': {}}
            if c[s.i] == '\x03':
                s.i += 1
                return tbl
            while True:
                assert c[s.i] == '\x01', repr(c[s.i:s.i+40])
                s.i += 1
                k = s.parse()
                assert c[s.i] == '\x02', repr(c[s.i:s.i+40])
                s.i += 1
                v = s.parse()
                if c[s.i] == '\x03':
                    s.i += 1
                    break
            return tbl
        elif ch == 't':
            j = i+1
            while c[j].isdigit(): j += 1
            tid = int(c[i+1:j]); s.i = j
            return {'__ref': tid}
        elif ch == 's':
            j = i+1
            while c[j].isdigit(): j += 1
            ln = int(c[i+1:j]); s.i = j+1
            v = c[s.i:s.i+ln]; s.i += ln
            v = v.replace('\\x01','\x01').replace('\\x02','\x02').replace('\\x03','\x03').replace('\\r','\r').replace('\\n','\n').replace('\\\\','\\')
            return v.encode('latin1', 'surrogateescape')
        elif ch == 'F':
            s.i += 1; return {'__func': True}
        elif c.startswith('NINF', i): s.i += 4; return float('-inf')
        elif c.startswith('NAN', i): s.i += 3; return float('nan')
        elif c.startswith('INF', i): s.i += 3; return float('inf')
        elif c.startswith('DEEP', i): s.i += 4; return {'__deep': True}
        elif ch == 'b':
            s.i += 2; return c[i+1] == '1'
        elif ch == '?':
            j = i+1
            while j < len(c) and (c[j].isalnum() or c[j]=='_'): j += 1
            v = c[i+1:j]; s.i = j; return {'__other': v}
        else:
            j = i
            while j < len(c) and (c[j].isdigit() or c[j] in '.-eE+'): j += 1
            v = c[i:j]; s.i = j
            return float(v)

p = P(dump)
root = p.parse()
assert p.i == len(dump), (p.i, len(dump), repr(dump[p.i:p.i+30]))
print("parsed ok")

seen = {}
def resolve(t):
    if isinstance(t, dict) and '__ref' in t:
        return seen.get(t['__ref'], t)
    if isinstance(t, dict) and '__kv' in t:
        seen[t['__id']] = t
        for k in list(t['__kv'].keys()):
            t['__kv'][k] = resolve(t['__kv'][k])
    return t
root = resolve(root)
protos = root['__kv'][1.0]['__kv']
print("num protos:", len(protos))
p1 = protos[1.0]
print("proto1 (main) keys:")
for k, v in sorted(p1['__kv'].items(), key=lambda x: str(x[0])):
    if isinstance(v, dict) and '__kv' in v:
        print(f"  {k}: TABLE nkeys={len(v['__kv'])}")
    elif isinstance(v, dict):
        print(f"  {k}: {v}")
    elif isinstance(v, bytes):
        print(f"  {k}: str len={len(v)} {v[:40]!r}")
    else:
        print(f"  {k}: {v}")
pickle.dump(root, open('/home/user/deobf/protos.pkl','wb'))
