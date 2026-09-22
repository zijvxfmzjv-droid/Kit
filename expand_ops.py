#!/usr/bin/env python3
"""Evaluate dispatch AST per concrete opcode value."""
import re, pickle
from parse_dispatch2 import parse_chain

txt = open('dispatch.txt').read()
items, i = parse_chain(txt, 0)
assert i == len(txt)

def cond_true(cond, V):
    cond = cond.strip()
    m = re.match(r'not\((.*)\)$', cond)
    if m:
        return not cond_true(m.group(1), V)
    m = re.match(r'V\s*([<>=~]+)\s*(-?[\d.]+)$', cond)
    if not m:
        raise ValueError(cond)
    op, num = m.group(1), float(m.group(2))
    if op == '<': return V < num
    if op == '<=': return V <= num
    if op == '>=': return V >= num
    if op == '>': return V > num
    if op == '==': return V == num
    if op == '~=': return V != num
    raise ValueError(cond)

def render_items(items, V, out):
    for nd in items:
        if nd[0] == 'raw':
            out.append(nd[1])
        else:
            _, branches, eblock = nd
            done = False
            for cond, block in branches:
                if cond_true(cond, V):
                    render_items(block, V, out)
                    done = True
                    break
            if not done and eblock is not None:
                render_items(eblock, V, out)

per_op = {}
for V in range(0, 235):
    out = []
    try:
        render_items(items, V, out)
        per_op[V] = ' '.join(out)
    except Exception as e:
        per_op[V] = f"<eval error {e}>"

with open('op_full.txt', 'w') as f:
    for V in sorted(per_op):
        f.write(f"=== OP {V} ===\n    {per_op[V]}\n\n")
pickle.dump(per_op, open('op_full.pkl', 'wb'))
print("done")
for V in [1, 11, 18, 156, 174, 188, 205, 222]:
    print(f"--- {V}: {per_op[V][:200]}")
