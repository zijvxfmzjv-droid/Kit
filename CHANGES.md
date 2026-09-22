# Changelog — Luraph VM deobfuscation, source-shaping pass

Everything below was produced by working through §6 of `HANDOFF.md` in order.
`python3 assemble.py` + `./luau deobf_full.lua` were re-run after every change;
both pass (see "Verification").

Output: `deobf_full.lua`, 5,838 → **5,226 lines**, all **56 protos** still emitted.

---

## 1. Fixed: 9 protos were emitted as orphan `do -- standalone: T<n>` stubs

`structurer.structure()` sweeps reachable-but-unparsed IR in a loop that was
capped at **256 iterations**. T8 alone needs ~370 chunks, so the sweep stopped
early and the 9 closure-creation sites that live past the cap
(T283/303/452/473/498/508/599/609/619) were never emitted in place. They fell
through to the "standalone" backstop, which is also why their upvalues could not
be resolved.

* `structurer.py`: the cap is now only a runaway guard (1,000,000).
* Result: **0 standalone stubs**; every proto is emitted at its creation site.

## 2. Fixed: upvalue descriptors were never resolved (`UP0`, `UP1`, …)

Two independent bugs:

* `tables.pkl` serialises shared sub-tables as `{"__ref": <id>}`. `r9()` in
  `assemble.py` skipped any descriptor that was a `__ref`, so **every** proto
  lost its upvalue table and fell back to `UP<n>`. Added an `__id -> node`
  index + `deref()` so refs resolve.
* The descriptor keys are **1-based**, IR upvalue slots are **0-based** — the
  bindings were off by one.

Also added `capture_owner()` (follows mode-2 "copy parent upvalue" chains up to
the owning proto).

## 3. Fixed: registers are now real locals, so captures actually bind

Previously every register was a bare assignment (i.e. a *global*), which meant a
nested proto reading its parent's register could never work in source form.

* Each proto now emits one `local …` line for all of its non-parameter
  registers, directly after its header.
* Closures are emitted as plain assignments (`a6 = function(...) … end`) instead
  of `local function a6(...)`, because the parent already declared the name —
  `local function` would have shadowed it (six of T508's closures share register 6).
* **Scope-safe naming** (`assemble.py`): a register of a parent that is captured
  by a descendant must not be given the same name as one of that descendant's
  own registers. Colliding names are renamed to `<letter><n>`, with one letter
  reserved per proto so renamed names can never clash again. 50 collisions were
  resolved this way (verified by a checker: no capture is shadowed anywhere).
* `params_str()` now uses the same naming table (a renamed capture used to leave
  the parameter list saying `a1` while the body said `w1`).
* Registers that are only ever *written* are now included in the declaration
  list (`_own_regs` used to collect reads only).

## 4. Fixed: argument spreads rendered as string concatenation

`expr_str` rendered a multi-register argument range as `f(a126..a129)` — that is
string concat in Lua, not an argument list. All 163 sites now expand to
`f(a126, a127, a128, a129)`.

Open-ended spreads (`f(Rn..top)`) are folded into the multi-return call that
filled them: `R136 = g(…)` followed by `f(R134..top)` is emitted as the single
statement `R132 = f(R133, g(…))`, with the original statement dropped
(`_merge_multret_args`). 16 of 17 sites folded; the remaining one (a junk op in
T2) renders as `f(...)--[[registers … to top of stack]]`.

## 5. Constant pool: now parsed and inlined

`parse_pool()` never matched anything, so `POOL_RAW` was **empty** — the pool
block had no runtime annotations at all and no constant could be inlined.

* Rewrote the dump parser for the real `===NUP <n> … n={1=…,0={<pool>}}` format.
  It is brace- and quote-aware, and tolerates the truncated dump lines (the
  serialiser cuts each line at ~5.4k chars, so the pool stops at key ~170).
  166 of ~180 slots recovered.
* `pool_value_str()` rewritten for the actual value syntax (`"str"`,
  `boolean:x`, `number:x`, `{__dummyname="X"}`, `FN:function: ADDR`).
* Anonymous library tables are fingerprinted by their key set, so
  `pool[4]` → `string`, `pool[17]` → `math`, `pool[110]` → `utf8`, …
* T8's first parameter is the pool (it is never written to, and every child
  proto reaches the same table through upvalue 0), so `pool[k]` reads are
  inlined at the use site: `w121 = w1[147]` → `w121 = "GetChildren"`.
  `w1[5]` (205 sites) is the one slot the dump did not capture and stays.
* The pool block itself now shows the runtime value, keeping the static decode
  as a comment when the two disagree.

## 6. Removed VM artefacts

* `-- close upvalues` (56), `-- folded: …` and `-- for-loop state restore` lines.
* `E[Rk] = v` / `v = E[Rk]` are plain register moves now (`E` is the VM register
  file, not a table); stores whose index the junk ops rewrite at runtime are
  rendered as comments instead of bogus `E[x] = E[x]()` lines.
* The one closure op whose child proto id the junk ops rewrite (`TNone()`) is
  now a comment instead of a call to a nil global.
* `coroutine.resume` desugar: the resume is emitted as a real statement
  (`Rd, Rd+1, Rd+2 = coroutine.resume(Rc, Rc+1, Rc+2)`) and the branch tests the
  ok flag register instead of a synthetic `__okN` global.

## 7. Structure / readability

* The ~684 `do -- chunk @irN` wrappers are flattened (they only added
  indentation once every register was a proper local). Blocks that terminate
  control flow (`do return … end`) are kept and relabelled.
* `repeat … until not (cond)` instead of `while true do … if not (cond) then
  break end end` (27 sites).
* Nested functions are emitted at their creation site's indent (they used to be
  emitted one level off, which the chunk wrappers masked).
* `-- multret` suffixes dropped: with real argument lists these calls are plain
  statement calls.
* `local ENV = (getfenv and getfenv()) or _G` prelude — the VM resolves globals
  through the loader's fenv (`Q[13]()`); without it every `ENV.<name>` was a nil
  index.
* New file header documenting the layout, the naming scheme and the artefacts
  that are intentionally left visible.

## Verification

```
python3 assemble.py          # -> wrote deobf_full.lua (5226 lines)
./luau deobf_full.lua        # -> ./deobf_full.lua:58: attempt to index nil with 'new'
```

The error is the expected success signal: the file compiles and runs until the
first Roblox global (`L14[20] = Path2DControlPoint.new`). Previously it died at
`ENV.utf8` without ever reaching the payload.

Static checks run alongside:

* **0** captures are shadowed by a nested proto's own register (checks every
  `(owner, register)` reference along the full ancestor path).
* **0** duplicate names inside a proto, **0** locals shadowing a parameter,
  **0** protos using the reserved pool/scratch names.
* **0** undeclared identifiers other than the intended Roblox globals
  (`game`, `task`, `Instance`, `CFrame`, `Vector3`, `UDim2`, `Enum`, `buffer`,
  `Path2DControlPoint`, `identifyexecutor`, …) and the three documented
  artefacts below.

## Known remaining artefacts (documented, not silently "fixed")

| artefact | count | why |
|---|---|---|
| `w1[5]` | 205 | the only pool slot missing from the runtime dump (function) |
| `UPVALS[i]` | 16 | upvalue read with a runtime-computed index |
| `UP120`, `UP324` | 2 | upvalue slot ids above the descriptor count — junk-op artifacts |
| `while true do … end` with no break | ~40 | dispatcher loops whose exit edge is a junk-op jump target |

## Not done (§6.2 – §6.4)

* Differential verification against the real loader run (needs a stubbed Roblox
  environment; the harness markers in `nupdump.luau` are still there).
* op75 census / op76 sub-store decode (T212/T398).
* `nupdump.luau` line-269 boolean serialiser bug + re-dump.
