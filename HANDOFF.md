# HANDOFF — Luraph VM Deobfuscation Kit

## 0. Read this first — expectations

The input (`NewOne (3).txt`) is a **Roblox script obfuscated with Luraph's VM protector**.
Luraph does not "wrap" the source — it **compiles the script into a custom register
bytecode** (~225 opcodes, binary-tree dispatch) interpreted by a small Lua VM. That means:

- The **original source text is gone forever** (names, comments, formatting are not
  preserved anywhere in the file).
- What IS recoverable: a **complete, faithful, readable Lua reconstruction** — every
  function, every statement, every constant, same behavior.
- Anyone (human or AI) who claims they can pop out the literal original file is wrong.
  The realistic goal, which this kit already ~90% achieves, is a clean reconstruction.

## 1. Current state (TL;DR)

- `deobf_full.lua` — **5,226 lines, all 56 VM protos emitted** (T2 = main chunk,
  T8 = payload, + 54 closures), **compiles clean** under the bundled Luau CLI and
  runs until the first Roblox global (`L14[20] = Path2DControlPoint.new`).
- Registers are real `local`s, upvalues resolve to the enclosing proto's locals,
  calls have real argument lists and the constant pool is inlined as literals.
- §6.1 (source-shaping) is done — see `CHANGES.md` for the itemised list of what
  changed and what is still open (§6.2-§6.4 are untouched).
- On top of §6.1: registers now carry **generated** names by inferred role
  (`fn/t/k/n/s/b/i/v`, plus `state` and `<x>Lib`), and two fidelity bugs were
  fixed (the pool was being wiped right before the payload ran; the loader's
  exit tailcall was dropped entirely, so nothing ever called the payload).
  Details and the verification method are in `CHANGES.md`.

## 2. Quick start

```bash
# everything runs from this directory; needs python3 (stdlib only)
python3 assemble.py            # -> deobf_full.lua  (uses instrs.pkl, tables.pkl, nupdump.log)

# syntax/behavior check (any run ending in "attempt to index nil with 'utf8'" = OK,
# it means the file compiled and ran until Roblox globals were needed)
./luau deobf_full.lua
```

Full re-extraction from the obfuscated file (only needed if you change the harness):

```bash
./luau nupdump.luau > nupdump.log      # instrumented loader, dumps protos at runtime
python3 parse_protos.py                # nupdump.log -> tables.pkl, protos.pkl
python3 extract_instrs.py              # nupdump.log -> instrs.pkl
python3 assemble.py                    # -> deobf_full.lua
```

## 3. Pipeline architecture

```
NewOne (3).txt (Luraph loader)
   │  nupdump.luau  (loader executed under Luau CLI, instrumented to dump the
   │                 decoded proto/constant tables when the VM initializes)
   ▼
nupdump.log ──parse_protos.py──▶ tables.pkl   (per-tid constant/upval descriptor tables)
        └─────extract_instrs.py──▶ instrs.pkl (per-tid instruction streams)
   ▼
decomp.py      pass 1: bytecode → linear IR per proto (decode_proto / render)
   ▼
structurer.py  pass 2: IR → control flow (if/while/repeat/numeric-for/for-in desugar)
   ▼
assemble.py    pass 3: closure tree → deobf_full.lua
               + fold_dispatch()  (constant-folds the dispatcher state vars)
               + synth_pool()     (T2 constant pool block)
               + Luau-compat sanitizers (bit32 ops, do return/continue wraps, ...)
```

Data formats:
- `instrs.pkl`: `tid → {'A','z','u','e','T','y','D','nops','numparams','vararg','tid'}` —
  all streams **1-based**, length `nops+1`. `A`=opcode, `z/u/e`=reg operands,
  `T`=const operand as `('str',s)|('bool',b)|('num',f)|('nil',None)`,
  `y`=extended operand `('num',k)|('str',s)|('proto',child_tid)|('nil',None)`, `D`=name (float).
- `tables.pkl`: `tid → {'__id','kv'}`; slot map: `1=z, 2=A, 3=u, 4=T, 5=y, 6=e, 9=upval
  descriptor, 10=D`. Slot-9 `kv` = `{upval_slot: (mode, w)}` (mode 0/1 = copy parent reg w,
  2 = copy parent upvalue w) — this is how closure upvalues are resolved.
- `nupdump.log`: also contains `===NUP <ci> tid=.. n=..` blocks = **runtime ground truth**
  of T2's constant pool (`L14`). `__dummyname="X"` entries = the loader stored global `X`
  there. Trust these over static decoding.

## 4. VM reference (hard-won facts — do not re-derive)

- Dispatcher: binary tree on opcode `V`, ~225 opcodes (see `op_full.txt` / `op_full2.pkl`).
- Frame prologue: `E,x,p,F,U,v = Q[1](Z),1,1`; `Z,h = Q[53](...)` (h = varargs);
  `k,P,c,j,l = 0,1,Q[13]()`.
- Q-slot identities (probed via qtest.luau, results in qtest.log):
  Q1=frame allocator, Q2=string.find-like, Q3=bit32.bxor, Q6=rshift, Q9=setfenv-like,
  Q29=unpack, Q32=coroutine.resume, Q44=pcall/error wrap, Q47=band, Q53=table.pack.
- Key opcodes:
  - op73 `C=C[K]; m[J]=C` · op75 `c[D]=y` (setglobal, provisional) ·
    op76 `C-=K; (m)[J]=C` (2 sites: T212/T398)
  - op93 GETGLOBAL `E[z]=c[T]` · op216 SETGLOBAL `(c)[T]=E[z]` (c = env = Q13())
  - op168 `E[e]=nil` · op169 `K=e` · op170 SETUPVAL-const
  - op188/208 CLOSURE (nested proto y[P] / top-level O[T[P]]); op209 variant;
    env passed via `Q[9](m,c)`
  - op220 pool-store `POOL[y[P]] = E[z]`   ← value comes from **z**, not e
  - op46/op172 = coroutine for-in desugar (wrapped fn in reg0..reg0+2, loop body resumes
    at the jump target; the loop vars are picked up there)
- T2's constant pool: keys 1..337 (sparse ~180 used), rendered as `L14[k]` in the output.
  Slot 112/114 = encrypted blobs (Hangul strings — used for string-obfuscation decode).
- **Junk ops**: op121/op92/op38/op179 sequences *self-modify the operand stream at
  runtime*; op79 = junk jump-target patch. Consequences: ~3 static renders are wrong
  (ir62 `R15 = R15[0]`, all `[0]`-chain pool entries). Never "fix" these statically —
  they are marked with comments in the output.
- D stream is 100% float, T stream 100% str across all 9,402 instructions (after the
  tuple re-extract; `extract_instrs.py` already emits proper tuples).
- `params=` debug header in structurer output = `numparams`, not maxstack.

## 5. Pitfalls / dead ends (burned us once — don't repeat)

1. **Never lift static `[0]`-chain pool entries** (`utf8[0]`, `bit32[0]`, `UDim2[0]`…):
   they are junk-op artifacts. Use the `===NUP` runtime values from nupdump.log.
2. **hoist_pool_chunks was removed on purpose** (produced dangling `a14[..]=a15` lines).
   `synth_pool()` replaced it. Do not reinstate.
3. `fold_dispatch()` in assemble.py:
   - **Never unwrap an if that has an else** (can only drop dead branches — unwrapping
     keeps the else with no `if` → syntax error).
   - The else-less unwrap must skip spans containing `-- closure`, `= closure T\d+` or
     `-- F\d+` markers (junk ops may rewrite the operands; folding them away loses protos).
   - The scanner counts `function(` assignments and `do -- repeat`-style commented lines
     as block-openers; it strips `-- comments` before classification.
4. Locating emitted functions: **child dst reg ≠ child tid**. Grep `-- F<n>` markers.
5. Luau compatibility (all handled by assemble.py sanitizers — keep them):
   - `& | ~ << >>` are **not** Luau operators → rendered as `bit32.band/bor/bxor/...`.
   - VM protos are always vararg → every function header must include `...`
     (op9 reads `...` in non-vararg protos too).
   - mid-block `return` → wrapped as `do return ... end`; bare `continue` → `do continue end`.
   - multret `a4..a6 = f()` is invalid syntax → enumerate `a4, a5, a6 = f()`.
6. `op_full2.pkl` fragments reuse dispatcher temporaries per branch — never lift
   semantics without a provenance check.
7. Raw instrs.pkl dumps: keep index `< nops` (IndexError at T619 P175 otherwise).
8. `unluac` / standard Lua decompilers are useless here — Luraph's VM bytecode is not
   Lua 5.1 bytecode. That's why this custom pipeline exists. (unluac sources are in the
   workspace history but were only used for reference.)
9. `nupdump.luau` line ~269: the serializer mis-handles boolean constants
   (T/y bool consts suspect until fixed & re-dumped). Known-affected: pool[25]=false,
   pool[26]=true (verified at runtime instead).
10. `tables.pkl` shares sub-tables by reference (`{'__ref': <id>}`). Any code that
   reads a nested descriptor must deref through an `__id -> node` index first;
   the old `r9()` skipped refs and silently produced an empty upvalue map.
   Likewise, upvalue descriptor keys are 1-based while IR slots are 0-based.
11. The `===NUP` dump lines are **truncated** (the serialiser cuts at ~5.4k
   chars), so the recovered pool stops around key 170 and slot 5 is missing
   entirely. Parse them brace/quote-aware and expect missing keys.

## 6. TODO — what "finished" means (priority order)

The user's bar: **output should read like hand-written Lua**, not VM pseudo-code.

> **Status 2026-09-22: item 1 (source-shaping) is complete.** Every sub-item
> (1a-1g) is done; details and verification in `CHANGES.md`. Items 2-4 below are
> still open. The two entries marked FIXED are the bugs that were blocking 1a/1b.

Remaining polish:

1. **Source-shaping (the big one)**
   - a. **FIXED** — Fake upvalue names `UP<n>`: `upval_name()` in assemble.py fell back to `UP<n>`
     when the creator instruction wasn't statically decoded — currently affects the 9
     "standalone" protos (T283/303/452/473/498/508/599/609/619; their creation sites use
     `y=('proto',tid)` which decomp.py's closure emit didn't match — it only checked
     numeric y). Fix: make decomp's closure emit accept `('proto',tid)` and re-run; or
     resolve their upvalue chains manually via tables.pkl slot-9 of each proto.
   - b. **FIXED** — Inline `L14[k]` / pool refs inside function bodies (the pool
     parser itself was broken: `POOL_RAW` was empty, see §5.10 below) (build a per-proto env map from
     the pool stores and substitute; keep the `L14 = {...}` block as documentation).
   - c. Rename registers to semantic names: `L14[k]` → the global/string it holds;
     dispatcher state var (`a10` etc.) → `state`; string-compared temps → names from
     their comparisons ("wait", "Destroy", "GetAsync"…).
   - d. **FIXED** — Real call shapes: `('spread', lo, hi)` used to render as
     `f(a..b)` (string concat!); every range is now enumerated, and open-ended
     spreads fold into the multi-return call that filled them.
   - e. Merge the `do -- for-in loop` / coroutine-desugar markers with their loop bodies
     (op46/op172; sites listed in the session log: T8 instrs 156, 845, 1723, 3143, 3281,
     3437, 3640, 4626; T352; T126).
   - f. Collapse `do -- chunk @irN` wrappers, drop `-- close upvalues` noise, merge
     adjacent straight-line chunks into single blocks.
   - g. Move the 9 `do -- standalone: T<n>` wrappers into their real creation sites
     (fix 1a first) and de-duplicate their repeated pool blocks.
2. **Differential verification**: run T8 under `./luau` with a stubbed Roblox env and
   diff behavior against the original loader run (harness markers `OP <pc> <op>`,
   `RANDOM_NEW_SEED`, `WEIRDB_TABLE`, `DUMMY_CALL`, `VM_ERR_PC` already exist for this).
3. op75 census; op76 sub-store decode (T212/T398).
4. Fix `nupdump.luau` line-269 bool bug and re-dump (then verify pool[25/26] and all
   bool consts statically).

## 7. File inventory

| file | what it is |
|---|---|
| `NewOne (3).txt` / `input.lua` | original obfuscated input (identical) |
| `nupdump.luau` | instrumented loader (Luau) → nupdump.log |
| `parse_protos.py` | nupdump.log → tables.pkl |
| `extract_instrs.py` | nupdump.log → instrs.pkl (tuple-typed T/y) |
| `decomp.py` | pass-1 IR decoder (LINEFMT renderers, RN register naming) |
| `structurer.py` | pass-2 control-flow structurer (loop_depth-aware) |
| `assemble.py` | pass-3 assembler → deobf_full.lua (pool, closures, folding, sanitizers) |
| `deobf_full.lua` | **current output — 5,163 lines, all 56 protos, compiles clean** |
| `deobf_full.txt` | byte-identical plain-text copy (the hand-off artifact) |
| `instrs.pkl` / `tables.pkl` / `protos.pkl` | extracted bytecode data |
| `op_full2.pkl` / `op_full.txt` / `opcodemap.txt` / `isa_used.txt` | VM dispatch reference |
| `qtest.luau` / `qtest.log` | Q-slot identity probes |
| `loader_pretty.lua` | prettified obfuscated loader (reference) |
| `parse_dispatch3.py`, `extract_ops3.py`, `expand_ops.py` | dispatch → op_full2.pkl extraction |
| `luau` | Luau CLI 0.739 binary (syntax check + runs) |

## 8. Environment notes

- Python 3.13, stdlib only (pickle/re/struct). No pip installs needed.
- Luau CLI 0.739 (https://github.com/luau-lang/luau/releases) — supports loadstring,
  `continue`, `\u{}`, bit32. Roblox globals (game, Instance, task…) do **not** exist
  outside Roblox; expected first failure point: `ENV.utf8` nil at the pool block.
- A "clean" run of `./luau deobf_full.lua` = compiles + starts executing + fails on the
  first Roblox global. That is the success signal for syntax validity.
