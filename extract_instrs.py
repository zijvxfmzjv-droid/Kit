#!/usr/bin/env python3
"""Extract instruction streams for all protos from tables.pkl. v2 robust."""
import pickle

tabs = pickle.load(open('tables.pkl', 'rb'))

def stream_val(v):
    if isinstance(v, dict):
        if 'kv' in v and '__id' in v:
            return v['kv'], v.get('__id')
        if '__ref' in v:
            return tabs[v['__ref']]['kv'], v['__ref']
        return v, None
    return None, None

def num(v, default=0.0):
    if v is None: return default
    if isinstance(v, bool): return float(v)
    if isinstance(v, (int, float)): return float(v)
    if isinstance(v, bytes):
        try: return float(v.decode('latin1'))
        except Exception: return default
    return default

def extract_proto(tid):
    kv = tabs[tid]['kv']
    def S(k):
        return stream_val(kv.get(float(k)))
    A, _ = S(2)
    if not isinstance(A, dict):
        return None
    ns = [int(k) for k in A.keys() if isinstance(k, (int, float))]
    n = max(ns) if ns else 0
    def arr(slot, default=0.0):
        t, _ = S(slot)
        return [num(t.get(float(i)) if t else None, default) for i in range(1, n + 1)]
    z = arr(1)
    A_ = arr(2)
    u = arr(3)
    e = arr(6)
    D = arr(10)
    Tt, _ = S(4)
    T = []
    for i in range(1, n + 1):
        v = Tt.get(float(i)) if Tt else None
        if isinstance(v, bytes): T.append(('str', v.decode('latin1')))
        elif v is None: T.append(('nil', None))
        elif isinstance(v, bool): T.append(('bool', v))
        else: T.append(('num', float(v)))
    yt, _ = S(5)
    yd = []
    for i in range(1, n + 1):
        v = yt.get(float(i)) if yt else None
        if isinstance(v, dict):
            yd.append(('proto', v.get('__id', v.get('__ref'))))
        elif isinstance(v, bytes):
            yd.append(('str', v.decode('latin1')))
        elif isinstance(v, bool):
            yd.append(('bool', v))
        elif v is None:
            yd.append(('nil', None))
        else:
            yd.append(('num', float(v)))
    return {
        'tid': tid,
        'nops': n,
        'numparams': int(num(kv.get(float(8)))),
        'vararg': int(num(kv.get(float(11)))),
        'A': [int(a) for a in A_],
        'z': [int(v) for v in z],
        'u': [int(v) for v in u],
        'e': [int(v) for v in e],
        'T': T,
        'y': yd,
        'D': D,
    }

def find_protos():
    protos = {}
    for tid, t in tabs.items():
        kv = t.get('kv', {})
        if not all(float(i) in kv for i in (1, 2, 3, 8)):
            continue
        r2t, _ = stream_val(kv[float(2)])
        if isinstance(r2t, dict) and any(isinstance(k, float) for k in r2t.keys()):
            try:
                p = extract_proto(tid)
                if p and p['nops'] > 0:
                    protos[tid] = p
            except Exception as ex:
                print("skip", tid, ex)
    return protos

if __name__ == '__main__':
    protos = find_protos()
    print("protos:", len(protos))
    pickle.dump(protos, open('instrs.pkl', 'wb'))
    from collections import Counter
    c = Counter()
    for tid, p in protos.items():
        c.update(p['A'])
    print("total instrs:", sum(c.values()))
    known = [2,8,14,30,44,56,67,78,94,104,114,126,132,154,164,170,191,202,212,218,228,246,258,264,283,293,303,313,329,340,352,364,376,382,388,398,408,420,432,452,463,473,487,498,508,514,524,534,544,554,564,574,584,599,609,619]
    missing = [t for t in known if t not in protos]
    print("missing:", missing)
