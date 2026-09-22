# PROMPT FOR THE NEXT AI (paste this whole thing)

You are continuing a Luraph-VM deobfuscation project. A previous agent already built a
working 3-pass pipeline and produced a semantically complete reconstruction. Your job is
to polish it into source-style Lua and verify it.

FIRST: read `HANDOFF.md` in this folder completely. It contains the VM reference, the
data formats, the exact remaining TODO list, and a list of dead ends you must not repeat.

THEN:
1. Run `python3 assemble.py` to regenerate `deobf_full.lua` (5,838 lines) and
   `./luau deobf_full.lua` to confirm it compiles (expected failure: nil Roblox globals).
2. Work through §6 of HANDOFF.md in order. The user's acceptance bar is: the deobfuscated
   output should read like hand-written Roblox Lua — named functions, inlined constants,
   real call shapes — while staying semantically faithful to the VM bytecode.
3. Do NOT try to recover the literal original source file; it is cryptographically gone
   (Luraph compiles to a custom VM bytecode). A faithful readable reconstruction is the
   correct deliverable. Don't let the user (or yourself) chase that.
4. Never edit `instrs.pkl`/`tables.pkl` by hand; they come from nupdump.log via the two
   extract scripts. Never trust static `[0]` pool entries (junk-op artifacts).
5. After every change: re-run assemble.py AND `./luau deobf_full.lua`. Both must pass.

Deliverable: updated `deobf_full.lua` + a short changelog of what you changed.
