#!/usr/bin/env python3
"""AST-based per-opcode handler extraction."""
import re, pickle
from parse_dispatch2 import parse_chain, parse_if

txt = open('dispatch.txt').read()
items, i = parse_chain(txt, 0)
assert i == len(txt)

def solve(conds):
    lo, hi = 0, 10**9
    eqs, neqs = set(), set()
    for c in conds:
        c = c.strip()
        m = re.match(r'not\(V([<>=~]+)(-?[\d.]+)\)$', c)
        if m:
            op, num = m.group(1), float(m.group(2))
            c = {'>=': f'V<{num}', '<': f'V>={num}', '<=': f'V>{num}', '>': f'V<={num}', '==': f'V~={num}', '~=': f'V=={num}'}[op]
        m = re.match(r'V\s*([<>=~]+)\s*(-?[\d.]+)$', c)
        if not m: return None
        op, num = m.group(1), float(m.group(2))
        if op == '<': hi = min(hi, num - 1)
        elif op == '<=': hi = min(hi, num)
        elif op == '>=': lo = max(lo, num)
        elif op == '>': lo = max(lo, num + 1)
        elif op == '==': eqs.add(num)
        elif op == '~=': neqs.add(num)
    cand = set(range(int(lo), int(hi) + 1)) if hi < 10**9 else None
    if eqs:
        cand = (cand & eqs) if cand else set(eqs)
    if neqs and cand:
        cand -= neqs
    if cand is None: return None
    if len(cand) == 1: return [int(list(cand)[0])]
    if 0 < len(cand) < 400: return sorted(int(x) for x in cand)
    return None

results = {}
unknown = []

def render_items(items, conds):
    for nd in items:
        if nd[0] == 'raw':
            r = solve(conds)
            if r is None:
                unknown.append((list(conds), nd[1]))
            else:
                for op in r:
                    results.setdefault(op, []).append(nd[1])
        else:
            _, branches, eblock = nd
            for cond, block in branches:
                render_items(block, conds + [cond.strip()])
            if eblock is not None:
                negs = list(conds)
                for cond, _ in branches:
                    c = cond.strip()
                    m = re.match(r'not\(V([<>=~]+)(-?[\d.]+)\)$', c)
                    if m:
                        op, num = m.group(1), m.group(2)
                        negs.append({'>=': f'V<{num}', '<': f'V>={num}', '<=': f'V>{num}', '>': f'V<={num}', '==': f'V~={num}', '~=': f'V=={num}'}[op])
                    else:
                        m = re.match(r'V([<>=~]+)(-?[\d.]+)$', c)
                        if m:
                            op, num = m.group(1), m.group(2)
                            negs.append({'<': f'V>={num}', '<=': f'V>{num}', '>=': f'V<{num}', '>': f'V<={num}', '==': f'V~={num}', '~=': f'V=={num}'}[op])
                        else:
                            negs.append('NOT(' + c + ')')
                render_items(eblock, negs)

render_items(items, [])

with open('op_handlers.txt', 'w') as f:
    for op in sorted(results):
        f.write(f"=== OP {op} ===\n")
        for s in results[op]:
            f.write(f"    {s}\n")
    f.write(f"\nUNKNOWN: {len(unknown)}\n")
    for conds, s in unknown[:60]:
        f.write(f"  CONDS={conds}\n    :: {s}\n")
print("ops mapped:", len(results))
print("unknown:", len(unknown))
pickle.dump(results, open('op_handlers.pkl','wb'))
