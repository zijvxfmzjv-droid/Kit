-- ============================================================================
-- Deobfuscated source, recovered from Luraph VM bytecode ("NewOne (3).txt")
-- Structure:
--   * Top-level block = VM proto T2: builds the constant pool (L14), then
--     defines/calls the payload proto T8 with the original arguments.
--   * Nested `local function aN(...) -- F<tid>` blocks are the child protos.
-- Naming conventions:
--   ENV          = the global environment table (== getfenv() inside the loader)
--   L14 / L15    = T2's constant pool / scratch register
--   L<n>, a<n>   = VM registers of T2 and of nested protos respectively
--   a1..aN, ...  = prototype parameters (the VM passes all args as varargs)
--   '-- loader-installed helper' = value the Luraph loader stores at a numeric
--     index of a stock table (e.g. utf8[0]); absent in a clean environment.
--   A few operand streams are self-modified by junk ops at runtime; those spots
--   are marked with comments and rendered to the closest static interpretation.
-- ============================================================================

-- Deobfuscated source (recovered from Luraph VM bytecode)
-- Main chunk = proto T2; payload = T8 (called with the original arguments)

do -- standalone: T283 (closure created at T8 instr 2495; site not recovered into the nesting)
    local function aS283(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, ...) -- F283
    a3 = UP0[5]
    a4 = UP0[5]
    a5 = 118
    a6 = 180
    a7 = 62
    do -- for-in loop
    end
    do -- chunk @ir1
        a3 = a5
        a3 = (not a3)
        a5 = a3
        -- close upvalues
        do return a5 end
    end
    do -- chunk @ir6
        a3 = UP1
    end
    do -- chunk @ir9
        while true do
            a5 = a3
            a6 = a4
            a7 = a2
            a5 = a5(a6, a7)
        end
        L419 = L217[0]
    end
    do -- chunk @ir24
        a4 = a1
    end
    end
end
do -- standalone: T303 (closure created at T8 instr 3003; site not recovered into the nesting)
    local function aS303(a1, a2, a3, a4, a5, a6, ...) -- F303
    a2 = UP0
    a3 = UP1
    a4 = UP2
    a5 = (a1 % 256)
    a2(a3..a6)  -- multret
    a2 = UP2
    a2 = (a2 + 1)
    UP2 = a2
    -- close upvalues
    do return  end
    end
end
do -- standalone: T452 (closure created at T8 instr 4075; site not recovered into the nesting)
    local function aS452(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, ...) -- F452
    a3 = UP0[5]
    a4 = nil
    a5 = 66
    a6 = 294
    a7 = 57
    do -- chunk @ir1
        if (a11 >= 242) then
        end
        a9 = UP0[5]
        a10 = 37
        a3 = (a4 == a9)
    end
    do -- chunk @ir3
        a4 = a1
        a7 = UP0[25]
        a6 = 80
        a6 = 111
        a3[a4] = a5
        a3[a4] = a5
    end
    do -- chunk @ir5
        if not ((a11 >= 343)) then
            if not ((141 >= a11)) then
                a5 = UP0[5]
            end
        end
    end
    do -- chunk @ir7
        a4 = a2
        a10 = UP0[5]
        a3 = (a4 == a10)
        a9 = 83
        -- folded: if not ((66 >= a9)) then
            if not ((68 >= a9)) then
                a10 = 103
                if not ((a10 == 26)) then
                    a10 = 26
                    a3 = UP0[26]
                end
                a11 = a3
                -- close upvalues
                do return a11 end
            end
        a9 = 68
        a4 = a2
    end
    do -- chunk @ir13
        a3 = a7
    end
    do -- chunk @ir19
        a3 = UP2
        a6 = 2
        a4 = a2
        a3 = a3[a4]
        a10 = a3
        a11 = a4
        a10 = a10(a11)
    end
    do -- chunk @ir21
    end
    do -- chunk @ir27
        while true do -- repeat
            if not ((a8 >= 180)) then break end
        end
        a4 = a1
        a9 = a3
        a10 = a4
        a9 = a9(a10)
        a3 = a9
        a9 = 57
        a3 = UP1
    end
    do -- chunk @ir28
        a3 = UPVALS[a2]
        a3 = UP2
    end
    do -- chunk @ir29
        -- folded: if (22 >= a6) then
            a6 = 125
            a5 = UP0[26]
            if (a8 >= 237) then
                a3 = UP1
                a4 = a1
            else
            end
    end
    do -- chunk @ir32
        a5 = UP0[5]
        a6 = 22
        a9 = 66
    end
    do -- chunk @ir47
        while true do
        end
    end
    do -- chunk @ir47
        a3 = a10
    end
    do -- chunk @ir74
        a8 = a3
        -- close upvalues
        do return a8 end
    end
    do -- chunk @ir81
        a3 = UP0[25]
        a10 = a3
        -- close upvalues
        do return a10 end
    end
    do -- chunk @ir89
        if not ((a10 >= 64)) then
            a4 = a1
            a9 = UP0[5]
            a10 = 64
        end
    end
    end
end
do -- standalone: T473 (closure created at T8 instr 4332; site not recovered into the nesting)
    local function aS473(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, ...) -- F473
    a1 = UP0
    a2 = a77
    a3 = UP2
    a1, a2, a3 = a1(a2..a4)
    a3 = UPVALS[a3]
    a4 = 8
    a3 = a3(a4)
    a4 = a34
    a5 = a3
    a6 = 0
    a7 = a1
    a4(a5..a8)  -- multret
    a4 = 104
    while true do
        a5 = a34
        a6 = a3
        a7 = 4
        a8 = a2
        a5(a6..a9)  -- multret
        a4 = 39
        do continue end -- luau
    end
    do -- chunk @ir2
        while true do
            -- table.move range
            -- close upvalues
            do return a5 end
        end
    end
    do -- chunk @ir2
        a6(a7..a10)  -- multret
    end
    do -- chunk @ir19
        -- folded: if (104 > a4) then
            a5 = {}
            a6 = UPVALS[a5]
            a7 = UP6
            a8 = a3
            a7 = a7(a8)
            a8 = 1
            a9 = -1
    end
    end
end
do -- standalone: T498 (closure created at T8 instr 4688; site not recovered into the nesting)
    local function aS498(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, ...) -- F498
    a2 = UP0[5]
    a3 = UP0[5]
    a4 = 102
    a3 = a1
    do -- chunk @ir2
        -- close upvalues
        do return  end
    end
    do -- chunk @ir4
        while true do
            a5 = 103
            a6 = 257
            a7 = 69
            if not ((103 >= a8)) then
                if not ((a8 ~= 172)) then
                    a2 = (not a2)
                end
                a9 = a2
                -- close upvalues
                do return a9 end
            end
        end
    end
    do -- chunk @ir4
        a3 = (not a3)
    end
    do -- chunk @ir20
    end
    do -- chunk @ir29
        a2 = UP1
        a4 = 13
    end
    do -- chunk @ir35
        a2 = a2[a3]
    end
    end
end
do -- standalone: T508 (closure created at T8 instr 4709; site not recovered into the nesting)
    local function aS508(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...) -- F508
    a1 = {}
    a2 = 46
    a3 = 62
    a4 = 8
    do -- for-in loop
    end
    do -- chunk @ir2
        a2 = 7
    end
    do -- chunk @ir3
        if not ((a2 ~= 58)) then
            a2 = 81
        local function a3(a1, a2, a3, a4, a5, a6, a7, ...) -- F514
        a4 = UP0[176]
        a5 = UP1[44]
        a6 = UP1[93]
        a4 = a4(a5, a6)
        a5 = UP1[89]
        a4 = (a4 < a5)
        if not ((not a4)) then
            a4 = UP1[46]
        end
        do -- chunk @ir3
            a4 = UP1[31]
            while true do -- repeat
                if not (a4) then break end
            end
        end
        do -- chunk @ir5
            -- close upvalues
            do return a4 end
        end
        end
            a1[8] = L91
        end
        a2 = 58
        local a3 -- F574
        a3 = function(a1, a2, a3, a4, a5, a6, a7, ...)
        do -- chunk @ir1
            a3 = (-4294903594 + a3)
            -- close upvalues
            do return a3 end
        end
        do -- chunk @ir5
            while true do
                a3 = UP0[177]
                a4 = UP1[1]
                a5 = UP1[34]
                a4 = (a4 - a5)
                a5 = UP1[86]
                a3 = a3(a4, a5)
            end
        end
        do -- chunk @ir5
        end
        end
        a1[7] = L38
        L511 = (L456 < L411)
    end
    do -- chunk @ir8
        local a6 -- F524
        a6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...)
        a5 = UP0[16]
        a6 = UP0[1]
        a5 = (a5 - a6)
        a6 = UP0[43]
        a5 = (a5 - a6)
        a5 = (135 + a5)
        -- close upvalues
        do return a5 end
        end
        a1[3] = L14
    end
    do -- chunk @ir11
        local function a6(a1, a2, a3, a4, a5, a6, ...) -- F534
        a3 = UP0[74]
        a4 = UP0[12]
        a3 = (a3 + a4)
        a4 = UP0[10]
        a3 = (a3 == a4)
        a3 = UP0[22]
        a3 = (31 + a3)
        -- close upvalues
        do return a3 end
        do -- chunk @ir19
            a3 = UP0[3]
        end
        end
        a1[4] = a6
        local a6 -- F544
        a6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...)
        a5 = UP0[74]
        a6 = UP0[78]
        a5 = (a5 - a6)
        do -- chunk @ir2
            while true do
                a5 = (a5 - a6)
                a5 = (465 + a5)
                -- close upvalues
                do return a5 end
            end
        end
        do -- chunk @ir2
            a6 = UP0[12]
        end
        end
        a1[5] = a3
    end
    do -- chunk @ir22
        while true do
            -- close upvalues
            do return a3 end
        end
    end
    do -- chunk @ir22
        a3 = a1
    end
    do -- chunk @ir25
        local a6 -- F554
        a6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...)
        a5 = UP0[12]
        a6 = UP0[80]
        a5 = (a5 + a6)
        a6 = UP0[10]
        a5 = (a5 < a6)
        a5 = UP0[31]
        if not (a5) then
            a5 = UP0[37]
        end
        a5 = (-137 + a5)
        -- close upvalues
        do return a5 end
        end
        a1[2] = a6
    end
    do -- chunk @ir28
        a2 = 39
        a3 = 113
        a4 = 74
        while true do
            if not ((a5 ~= 54)) then
        local a6 -- F564
        a6 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...)
        a5 = UP0[168]
        a6 = UP0[175]
        a7 = UP1[74]
        a8 = UP1[91]
        a6 = a6(a7, a8)
        a5 = a5(a6)
        a5 = (169 + a5)
        -- close upvalues
        do return a5 end
        end
                a1[6] = L73
            end
        end
    end
    do -- chunk @ir32
    end
    do -- chunk @ir52
        local function a6(a1, a2, a3, a4, a5, a6, ...) -- F584
        a3 = UP0[89]
        a4 = UP0[55]
        a3 = (a3 - a4)
        a4 = UP0[75]
        a3 = (a3 <= a4)
        if not ((not a3)) then
            a3 = UP0[71]
        end
        if a3 then
            a3 = (-86 + a3)
            -- close upvalues
            do return a3 end
        end
        a3 = UP0[80]
        end
        a1[1] = L16
    end
    end
end
do -- standalone: T599 (closure created at T8 instr 4781; site not recovered into the nesting)
    local function aS599(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, ...) -- F599
    a3 = UP0[5]
    a4 = UP0[5]
    a5 = 65
    while true do
        a6 = a3
        a7 = a4
        a6 = a6(a7)
        do continue end -- luau
        a10 = 0
        a11 = UP4
        a4 = UP5
        a12 = 89
        a13 = 350
        a14 = 69
        while true do
        end
    end
    a3 = (a3 + a4)
    UP4 = a3
    -- close upvalues
    do return  end
    do -- chunk @ir1
        a3 = UPVALS[a2]
        a5 = 44
    end
    do -- chunk @ir3
        if (a15 >= 158) then
        end
        a4 = 1
        a3 = a2
    end
    do -- chunk @ir11
        if not ((a15 >= 227)) then
            a3 = UP4
        end
        if not ((a15 >= 296)) then
        end
    end
    do -- chunk @ir13
        if (not a3) then
        end
        a16(a17..a20)  -- multret
    end
    do -- chunk @ir19
        if not ((89 >= a15)) then
            a3 = UP1
            a6 = 74
            -- folded: if not ((a6 ~= 74)) then
                a7 = a3
                a7()  -- multret
                a6 = 22
                a7 = 136
                a8 = 14
        end
    end
    do -- chunk @ir25
        a6 = 87
    end
    do -- chunk @ir46
        a16 = a3
        a17 = a4
        a18 = a11
        a19 = a10
    end
    do -- chunk @ir52
        a3 = UP3
    end
    do -- chunk @ir54
        -- folded: if (a14 ~= 109) then
    end
    do -- chunk @ir61
        a3 = a6
    end
    do -- chunk @ir65
        a10 = UP0[5]
        a11 = 40
        a12 = 142
        a13 = 69
    end
    do -- chunk @ir109
        a5 = 27
        a4 = a1
    end
    end
end
do -- standalone: T609 (closure created at T8 instr 4917; site not recovered into the nesting)
    local function aS609(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, ...) -- F609
    a2 = UP0[5]
    a3 = nil
    a4 = 21
    a5 = 184
    a6 = 37
    a27 = (a19 * 403)
    a28 = (a18 * a21)
    a22 = (a27 + a28)
    a23 = (a22 * 65536)
    a23 = (a23 + a20)
    a2 = (a23 % 4294967296)
    do -- chunk @ir1
        a4 = bit32.bxor(a2, 320281964)
        -- close upvalues
        do return a4 end
    end
    do -- chunk @ir5
        a8 = 1
        a9 = (#a3)
        a10 = 1
        do -- for-in loop
        end
    end
    do -- chunk @ir25
        if (a26 ~= 53) then
        end
    end
    do -- chunk @ir27
        a17 = (a2 * 16777619)
        a2 = (a17 % 4294967296)
    end
    do -- chunk @ir41
        a9(a10..a13)  -- multret
        -- table.move range
        a3 = a8
        a10 = a1
        a11 = 1
        a12 = -1
        a22 = UP0[5]
        a23 = 7
        a24 = 174
        a25 = 46
        a18 = (a2 % 65536)
    end
    do -- chunk @ir45
        a2 = 2166136261
        a8 = {}
        a9 = UP1
    end
    do -- chunk @ir48
        while true do -- repeat
            if not ((a16 > 94)) then break end
        end
        a12 = a3[a11]
    end
    do -- chunk @ir49
        a2 = bit32.bxor(a2, a12)
    end
    do -- chunk @ir51
        a18 = UP0[5]
        a19 = UP0[5]
        a20 = UP0[5]
        a21 = UP0[5]
    end
    do -- chunk @ir59
        a12 = UP0[5]
        a13 = 94
        a14 = 266
        a15 = 55
    end
    do -- chunk @ir74
        a27 = (a2 - a18)
        a19 = (a27 / 65536)
        a20 = (a18 * 403)
        a21 = 256
    end
    end
end
do -- standalone: T619 (closure created at T8 instr 5134; site not recovered into the nesting)
    local function aS619(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, ...) -- F619
    a2 = a1[1]
    a3 = a1[2]
    if (a3 ~= "boolean") then
        if not ((a3 ~= "string")) then
            a4 = UP0
            a5 = a2
            a6 = 1
            a7 = 1
            a4 = a4(a5, a6, a7)
            a4 = (a4 ~= 0)
            a5 = UP0
            a6 = a2
            a7 = 2
            a8 = 2
            a5 = a5(a6, a7, a8)
            a6 = UP1
            a6 = (a6 * a5)
            a7 = a124
            a6 = (a6 + a7)
            a5 = (a6 % 256)
        end
        a2 = (-a2)
        a4 = 3
        a5 = (#a1)
        a6 = 3
        do -- for-in loop
        end
    end
    if not ((a10 > a11)) then
        a12 = a7[a10]
        a13 = (a10 + 1)
        a13 = a7[a13]
    end
    a12 = a7[a10]
    a7[a9] = a12
    a9 = (a9 + 1)
    a8 = (a9 - 1)
    do -- chunk @ir2
        a8 = (#a7)
    end
    do -- chunk @ir4
        a2 = a7[1]
    end
    do -- chunk @ir9
        a8 = a1[a7]
        a9 = (a7 + 1)
        a9 = a1[a9]
        a10 = (a7 + 2)
        a10 = a1[a10]
        a11 = a8[a10]
        a11[a9] = a2
        a11 = UP5[a10]
        a11 = a8[a11]
        a11[a9] = L0
    end
    do -- chunk @ir15
        a7 = {}
        a8 = 3
        a9 = (#a2)
        a10 = 1
        while true do
            a10 = 1
            a11 = (a8 - 1)
        end
        -- close upvalues
        do return  end
    end
    do -- chunk @ir35
        a12 = UP0
        a13 = a2
        a14 = a11
        a12 = a12(a13, a14)
        a12 = bit32.bxor(a12, a5)
        a12 = a92[a12]
        a7 = (a7 .. a12)
        a12 = UP1
        a12 = (a12 * a5)
        a13 = a124
        a12 = (a12 + a13)
        a5 = (a12 % 256)
    end
    do -- chunk @ir43
        a2 = a7
    end
    do -- chunk @ir49
        a5 = a100
        a6 = a2
        a7 = 2
        a5 = a5(a6, a7)
        a2 = a5
    end
    do -- chunk @ir60
        while true do
            a7[a9] = a12
            a9 = (a9 + 1)
            a10 = (a10 + 2)
        end
        a12 = (a11 - 2)
        a13 = UP0
        a14 = a2
        a15 = a11
        a13 = a13(a14, a15)
        a13 = bit32.bxor(a13, a5)
        a13 = a92[a13]
        a7[a12] = a13
        a12 = UP1
        a12 = (a12 * a5)
        a13 = a124
        a12 = (a12 + a13)
        a5 = (a12 % 256)
    end
    do -- chunk @ir60
        a12 = (a12 .. a13)
    end
    do -- chunk @ir71
        a9 = 1
    end
    do -- chunk @ir125
        a6 = (#a2)
        if not ((600 > a6)) then
            a2 = (not a2)
        end
        a7 = ""
        a8 = 3
        a9 = a6
        a10 = 1
    end
    end
end
local L14 = {}  -- Luraph environment pool (keys = constant indices)
local L15
L14[0] = ENV.utf8[0] -- loader-installed helper
L14[1] = L16
L14[2] = L24
L14[3] = ENV.task
L14[4] = L107
L14[5] = L3
L14[6] = L73
L14[7] = L38
L14[8] = "gmatch"
L14[9] = "format"
L14[10] = "char"
L14[11] = L9
L14[12] = "match"
L14[13] = L45
L14[14] = "find"
L14[15] = "byte"
L14[16] = "gsub"
L14[17] = L18
L14[18] = "running"
L14[19] = "sub"
L14[20] = L29
L14[21] = L49
L14[22] = "isyieldable"
L14[23] = L99
L14[24] = "rep"
L14[27] = L76
L14[28] = "concat"
L14[29] = "cancel"
L14[30] = "unpack"
L14[31] = "create"
L14[32] = "resume"
L14[33] = "yield"
L14[34] = L186
L14[35] = "status"
L14[36] = L605
L14[37] = L74
L14[38] = "close"
L14[39] = L59
L14[40] = "spawn"
L14[41] = "defer"
L14[42] = L110
L14[43] = L8
L14[44] = "readu8"
L14[45] = L58
L14[46] = "The debug library is required on Luau platforms. Please open a support ticket."
L14[47] = L21
L14[48] = "info"
L14[49] = "traceback"
L14[50] = "wrap"
L14[51] = "readu32"
L14[52] = L128
L14[53] = "pack"
L14[54] = L53
L14[55] = "writeu16"
L14[56] = "tostring"
L14[57] = "writeu8"
L14[58] = L61
L14[59] = L84
L14[60] = L117
L14[61] = L46
L14[62] = L113
L14[63] = L57
L14[64] = "insert"
L14[65] = L85
L14[66] = L55
L14[67] = L103
L14[68] = "table"
L14[69] = "lastlinedefined"
L14[70] = "linedefined"
L14[71] = "nparams"
L14[72] = "short_src"
L14[73] = "[C]"
L14[74] = "source"
L14[75] = "=[C]"
L14[76] = "what"
L14[77] = "C"
L14[78] = "currentline"
L14[79] = "namewhat"
L14[80] = ""
L14[81] = "isvararg"
L14[82] = "new"
L14[83] = L104
L14[84] = "function"
L14[85] = "'setfenv' cannot change environment of given object"
L14[86] = "slnaf"
L14[87] = "getmetatable"
L14[88] = L460
L14[89] = "setmetatable"
L14[90] = "tonumber"
L14[91] = "select"
L14[92] = "rawget"
L14[93] = "getinfo"
L14[94] = "xpcall"
L14[95] = "assert"
L14[96] = "error"
L14[97] = "pcall"
L14[98] = "type"
L14[99] = "next"
L14[100] = "typeof"
L14[101] = "getfenv"
L14[102] = "setfenv"
L14[103] = L214
L14[104] = "abs"
L14[105] = "wait"
L14[106] = "delay"
L14[107] = L88
L14[108] = "copy"
L14[109] = L629
L14[110] = L529
L14[111] = L67
L14[112] = "áá¢áµáá­á¹áá¥áªáá±á³iÌÌááµá»"
L14[113] = L468
L14[114] = "ì³ë¶ì®ëê¶·ëì¤"
L14[115] = "ScreenGui"
L14[116] = "Frame"
L14[117] = "Size"
L14[118] = "Parent"
L14[119] = "Path2D"
L14[120] = "Scale"
L14[121] = "X"
L14[122] = "Y"
L14[123] = "Workspace"
L14[124] = "Folder"
L14[125] = "WaitForChild"
L14[126] = "Name"
L14[127] = "userdata"
L14[128] = "Instance"
L14[129] = "ClassName"
L14[130] = "string"
L14[131] = "AncestryChanged"
L14[132] = "Connect"
L14[133] = "Destroying"
L14[134] = "Disconnect"
L14[135] = "Connected"
L14[136] = "The metatable is locked"
L14[137] = "DataModel"
L14[138] = "HttpService"
L14[139] = "GetAsync"
L14[140] = "PostAsync"
L14[141] = "RequestAsync"
L14[142] = "RunService"
L14[143] = "IsStudio"
L14[144] = "IsClient"
L14[145] = "IsServer"
L14[146] = "StarterPlayer"
L14[147] = "GetChildren"
L14[148] = L658
L14[149] = "Enums"
L14[150] = "EnumItem"
L14[151] = "EnumType"
L14[152] = "OuterBox"
L14[153] = "HumanoidCollisionType"
L14[154] = "IsA"
L14[155] = "Value"
L14[156] = "Enum"
L14[157] = "FromValue"
L14[158] = "FromName"
L14[159] = "number"
L14[160] = "Random"
L14[161] = "NextUnitVector"
L14[162] = "NextInteger"
L14[163] = "NextNumber"
L14[164] = "Clone"
L14[165] = "Shuffle"
L14[166] = L176
L14[167] = L623
L14[168] = L164
L14[169] = L666
L14[170] = ":(%d+)[:\r\n]"
L14[171] = "__index"
L14[172] = "Your Lua environment does not support load or loadstring, therefore you are unable to use Luraph's 'LPH_NO_UPVALUES' macro."
L14[173] = "dCWeI"
L14[174] = "Luraph"
L14[175] = L680
L14[176] = L684
L14[177] = ENV.bit32[0] -- loader-installed helper
L14 = {}
L14[25] = true
do -- chunk @ir1
-- (junk op: loader self-modifies operand stream here; real behavior = no-op)
end
do -- chunk @ir9
    local function L15(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32, a33, a34, a35, a36, a37, a38, a39, a40, a41, a42, a43, a44, a45, a46, a47, a48, a49, a50, a51, a52, a53, a54, a55, a56, a57, a58, a59, a60, a61, a62, a63, a64, a65, a66, a67, a68, a69, a70, a71, a72, a73, a74, a75, a76, a77, a78, a79, a80, a81, a82, a83, a84, a85, a86, a87, a88, a89, a90, a91, a92, a93, a94, a95, a96, a97, a98, a99, a100, a101, a102, a103, a104, a105, a106, a107, a108, a109, a110, a111, a112, a113, a114, a115, a116, a117, a118, a119, a120, a121, a122, a123, a124, a125, a126, a127, a128, a129, a130, a131, a132, a133, a134, a135, a136, a137, a138, a139, a140, a141, a142, a143, ...) -- F8
    a2 = a1[1]
    a3 = a1[2]
    a4 = a1[3]
    a5 = a1[4]
    a6 = a1[5]
    a7 = a1[5]
    a8 = a1[5]
    a9 = a1[5]
    a10 = 102
    a9 = a1[6]
    a11 = a1[9]
    a11 = a5[a11]
    a12 = a1[5]
    a13 = a1[5]
    a14 = a1[5]
    a15 = a1[5]
    a16 = nil
    a10 = 49
    a17 = a1[10]
    a16 = a5[a17]
    a17 = a1[15]
    a17 = a5[a17]
    a18 = a1[16]
    a18 = a5[a18]
    a19 = a1[17]
    a20 = a1[5]
    a21 = a1[5]
    a22 = a1[5]
    a23 = a1[5]
    a24 = a1[5]
    a25 = a1[5]
    a10 = 102
    a26 = a1[19]
    a21 = a5[a26]
    a10 = 8
    do -- chunk @ir1
        local function a86(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, ...) -- F14
        a4 = nil
        a5 = UP0[5]
        a6 = nil
        a7 = 87
        do -- chunk @ir1
            a9 = a80
            a6 = 1
            a4 = (a4 == a6)
            if (not a4) then
                a10 = 65
                a11 = 354
                a12 = 96
                do -- for-in loop
                end
            else
                a10 = 18
                while true do
                    a4 = a1
                    a10 = 73
                end
            end
            a80 = a4
        end
        do -- chunk @ir6
            a6 = a58
            a11 = a4
            a12 = a6
            a13 = a9
            a14 = a10
            a11(a12..a15)  -- multret
            a4 = a80
            a11 = 18
            a12 = 119
            a13 = 93
            while true do -- repeat
                if not ((a7 > 12)) then break end
            end
            a8 = a5
            a9 = a4
            a10 = a6
            a8 = a8(a9, a10)
            a5 = a8
            a7 = 123
            a5 = a4
            a10 = UP0[5]
            a8 = 84
            -- folded: if not ((38 >= a8)) then
                a4 = a66
                a8 = 35
        end
        do -- chunk @ir8
            a5 = a55
            a7 = 33
        end
        do -- chunk @ir18
            a8 = 106
            a5 = 0
            a8 = 65
        end
        do -- chunk @ir20
            a6 = 2
        end
        do -- chunk @ir22
            a7 = 30
        end
        do -- chunk @ir24
            a6 = 1
            a4 = (a4 + a6)
        end
        do -- chunk @ir27
        end
        do -- chunk @ir30
            while true do
                a7 = 74
                a4 = a1
            end
        end
        do -- chunk @ir30
            do return  end
        end
        do -- chunk @ir43
            a6 = a2
            a7 = 12
        end
        do -- chunk @ir60
            while not ((18 >= a14)) do -- while-exit-cond
            end
        end
        do -- chunk @ir114
            a5 = a3
        end
        do -- chunk @ir119
            a4 = a3
        end
        do -- chunk @ir125
            a5 = a1
            a8 = a5
            a8()  -- multret
        end
        end
        a10 = 78
        if not ((60 >= a10)) then
            if not ((a10 >= 79)) then
        local function a87(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F67
        a4 = UP0[5]
        a5 = UP0[5]
        a6 = UP0[5]
        a7 = 38
        a5 = a1
        a6 = a2
        a8 = a4
        a9 = a5
        a10 = a6
        a8 = a8(a9, a10)
        a4 = a8
        a4 = (not a4)
        a7 = 70
        a8 = 117
        a9 = 190
        a10 = 73
        while true do -- repeat
            if not ((a11 == 117)) then break end
        end
        a12 = a4
        a12()  -- multret
        do -- chunk @ir1
            a5 = (a5 == a6)
            if not ((not a5)) then
                a5 = a2
                a4 = a5
            end
            a5 = a82
            a8 = UP0[5]
            a9 = UP0[5]
            a10 = 11
            a11 = 159
            a12 = 8
            do -- for-in loop
            end
        end
        do -- chunk @ir4
            a14(a15..a18)  -- multret
            a10 = 85
            a10 = 79
            a6 = 1
            a5 = (a5 + a6)
            a6 = 2
            a4 = a5
        end
        do -- chunk @ir8
            a6 = UP3
        end
        do -- chunk @ir10
            a5 = a3
        end
        do -- chunk @ir12
            -- folded: if not ((a11 >= 214)) then
        end
        do -- chunk @ir14
            -- folded: if not ((27 >= a13)) then
                a14 = a5
                a15 = a6
                a16 = a9
                a17 = a8
            a9 = UP4
        end
        do -- chunk @ir17
            while true do -- repeat
                if not ((31 >= a8)) then break end
            end
        end
        do -- chunk @ir18
            a8 = 114
            a5 = a1
        end
        do -- chunk @ir22
            while true do
            end
        end
        do -- chunk @ir22
            a8 = 31
        end
        do -- chunk @ir27
            a7 = 109
        end
        do -- chunk @ir50
            a5 = (a5 == a6)
        end
        do -- chunk @ir53
            a8 = 66
        end
        do -- chunk @ir55
            a6 = 1
        end
        do -- chunk @ir66
            do return  end
        end
        do -- chunk @ir74
            a8 = 86
            a9 = 214
            a10 = 64
        end
        do -- chunk @ir80
            a4 = 1
            a8 = 57
            a5 = a3
        end
        do -- chunk @ir87
            a4 = a3
        end
        do -- chunk @ir100
            a10 = 48
            a5 = UP4
        end
        do -- chunk @ir138
            a7 = 77
            a4 = UP1
        end
        end
                a10 = 85
                a125 = a83
                a126 = a13
                a127 = a120
                a126 = a126(a127)
                a127 = a1[127]
                a128 = a1[26]
                a125(a126..a129)  -- multret
            end
        end
        if not ((85 >= a10)) then
            a102 = a97
            a103 = a52
            a104 = a1[100]
            a102(a103, a104)  -- multret
            a102 = a1[82]
            a102 = a69[a102]
            a103 = a97
            a104 = a7
            a105 = a1[8]
            a103(a104, a105)  -- multret
            a103 = a97
            a104 = a11
            a105 = a1[9]
            a103(a104, a105)  -- multret
            a10 = 115
            if (a10 > 54) then
            else
                a103 = a97
                a104 = a14
                a105 = a1[14]
                a103(a104, a105)  -- multret
                a10 = 29
            end
            a120[3699368772] = 452242525
            a120[1831891793] = 1560434486
            a118(a119, a120)  -- multret
            a118 = a1[5]
            a10 = 82
            if (a10 ~= 84) then
                if (a10 ~= 82) then
                    a119 = a118
                    a120 = a113
                    a121 = a1[137]
                    a119(a120, a121)  -- multret
                    a10 = 84
                    a121 = a119[60]
                    a101[28] = a97
                    a121 = a83
                    a122 = UP0
                    a122 = a122()
                    a123 = a119[60]
                    a124 = 1
                    a121(a122..a125)  -- multret
                    a121 = 90
                    a122 = 153
                    a123 = 33
                    do -- for-in loop
                    end
                else
        local function a118(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, ...) -- F126
        a3 = UP0
        a4 = a83[127]
        a5 = UP2
        a6 = a1
        a5 = a5(a6)
        a3(a4, a5)  -- multret
        a3 = UP3
        a4 = UP4
        a5 = a1
        a4 = a4(a5)
        a5 = a83[128]
        a3(a4, a5)  -- multret
        a3 = a83[5]
        a4 = a83[5]
        a5 = 61
        a3 = a1[0]
        a6 = a83[118]
        a4 = a1[a6]
        a5 = 120
        a10 = 92
        -- folded: if not ((11 >= a10)) then
            -- folded: if not ((a10 >= 110)) then
                a10 = 11
                a7 = a83[131]
        a9 = a1[a7]
        a10 = 117
        do -- chunk @ir2
            while true do
                a7 = a1[a10]
                a9 = 78
            end
            a3 = 31
            a4 = 119
            a5 = 44
            do -- for-in loop
            end
        end
        do -- chunk @ir2
            a10 = a83[126]
        end
        do -- chunk @ir6
            a7 = UP0
            a8 = a2
            a9 = a83[129]
            a9 = a1[a9]
            a7(a8, a9)  -- multret
        end
        do -- chunk @ir10
            if not ((a10 >= 92)) then
                a10 = 110
                a8 = a1[a7]
            end
            if (110 >= a10) then
            else
                a11 = a37
                a12 = a8
                a13 = a9
                a11(a12, a13)  -- multret
                a11 = a86
                a12 = (a8 == a9)
                a11(a12)  -- multret
                a11 = a83[132]
            end
            a10 = UP0
            a11 = (#a7)
            a12 = (#a8)
            a10(a11, a12)  -- multret
            a10 = UPVALS[L0]
            a11 = a33
            a12 = a1
            a11 = a11(a12)
            a12 = a7
            a10(a11, a12)  -- multret
            a17 = a83[25]
            a18 = a83[133]
            a18 = a1[a18]
            a19 = a18; a18 = a18["Connect"]
            local function a20(a1, a2, a3, a4, ...) -- F132
            a1 = a17[26]
            UP0 = a1
            -- close upvalues
            do return  end
            end
            a18 = a18(a19, a20)
            a19 = 60
            a20 = 204
            a21 = 72
            do -- for-in loop
            end
        end
        do -- chunk @ir12
            if not ((a9 ~= 85)) then
                a10 = UP0
                a11 = a83[130]
                a12 = UP2
                a13 = a7
                a12 = a12(a13)
                a10(a11, a12)  -- multret
                a10 = UP3
                a11 = a7
                a12 = a8
                a10(a11, a12)  -- multret
            end
            a10 = a83[126]
            a8 = a1[a10]
            a9 = 85
            a17 = UP11
            a18 = a12
            a19 = a83[132]
            a17(a18, a19)  -- multret
            a17 = a37
            a18 = a11
            a19 = a12
            a17(a18, a19)  -- multret
        end
        do -- chunk @ir19
            if not ((a22 > 60)) then
                a23 = UP9
                a24 = a17
                a23(a24)  -- multret
            end
            a23 = a83[5]
            a24 = 19
            a25 = 238
            a26 = 73
            do -- for-in loop
            end
        end
        do -- chunk @ir21
            a28 = UP10
            a29 = a23
            a30 = a83[5]
            a28(a29, a30)  -- multret
        end
        do -- chunk @ir28
            while true do -- repeat
                if not ((a6 ~= 31)) then break end
            end
            a7 = a83[5]
            a8 = a83[5]
            a9 = 107
        end
        do -- chunk @ir29
            a7 = a83[5]
            a8 = a83[5]
            a9 = a83[5]
        end
        do -- chunk @ir33
            a17 = UP11
            a18 = a11
            a19 = a83[132]
            a17(a18, a19)  -- multret
            a24 = a86
            a25 = a83[135]
            a25 = a18[a25]
            a25 = (not a25)
            a24(a25)  -- multret
        end
        do -- chunk @ir37
            if not ((a6 ~= 75)) then
            end
        end
        do -- chunk @ir57
            a28(a29, a30)  -- multret
        end
        do -- chunk @ir71
            -- close upvalues
            a7 = UP0
            a8 = a83[136]
            a9 = a97
            a10 = a1
            a9(a10..a11)  -- multret
            a7(a8..top)  -- multret
        end
        do -- chunk @ir78
            -- close upvalues
            do return  end
        end
        do -- chunk @ir92
            if (a27 ~= 19) then
                a28 = UP11
                a29 = a23
                a30 = a83[134]
            else
                a28 = a83[134]
                a23 = a18[a28]
            end
        end
        do -- chunk @ir137
        end
        do -- chunk @ir143
            a11 = a8[a11]
            a12 = a83[132]
            a12 = a8[a12]
            a13 = 118
            a14 = 264
            a15 = 10
        end
        do -- chunk @ir175
        end
        do -- chunk @ir178
            a23 = a86
            a24 = a83[135]
            a24 = a18[a24]
            a23(a24)  -- multret
        end
        do -- chunk @ir250
            a28 = a23
            a29 = a18
            a28(a29)  -- multret
        end
        end
                    a10 = 9
                    a125 = a119[59]
                    a101[72] = L348
                end
            else
                a119 = a118
                a120 = a106
                a121 = a1[123]
                a119(a120, a121)  -- multret
                a119 = a83
                a120 = a113
                a121 = a1[118]
                a121 = a106[a121]
                a122 = a1[26]
                a119(a120..a123)  -- multret
                a119 = nil
                a120 = 104
                a121 = 330
                a122 = 113
                do -- for-in loop
                end
            end
            a104(a105, a106)  -- multret
            a104 = a97
            a105 = a26
            a106 = a1[24]
            a104(a105, a106)  -- multret
            a10 = 93
            -- folded: if not ((23 >= a10)) then
            a104 = a97
            a105 = a72
            a106 = a1[64]
            a104(a105, a106)  -- multret
            a10 = 10
            a131[4286544108] = L330
            a131[4113771706] = L477
            a131[4054428537] = L645
            a131[1373830112] = L199
            a131[1485835597] = L543
            a131[3571856872] = L146
            a126 = a131
        end
        a85 = a1[67]
        a10 = 107
        a126 = a1[26]
        a123(a124..a127)  -- multret
        -- folded: if (a122 ~= 20) then
    end
    do -- chunk @ir4
        a99 = a1[88]
        a10 = 58
        a100 = a97
        a101 = a36
        a102 = a1[89]
        a100(a101, a102)  -- multret
        a100 = a97
        a101 = a70
        a102 = a1[90]
        a100(a101, a102)  -- multret
        a100 = a1[5]
        a10 = 12
        a125 = a119[22]
        a101[77] = a23
    end
    do -- chunk @ir7
        if not ((not a121)) then
            a126 = a55
            a126()  -- multret
        end
        a126 = a55
        a126()  -- multret
        a126 = a1[5]
        a127 = a1[5]
        a128 = a1[5]
        a129 = 87
        a130 = 163
        a131 = 19
        do -- for-in loop
        end
    end
    do -- chunk @ir9
        a127 = a97
        a128 = a1[165]
        a128 = a121[a128]
        a129 = a1[165]
        a127(a128, a129)  -- multret
    end
    do -- chunk @ir13
        a118 = a97
        a119 = a102
        a120 = a1[82]
        a118(a119, a120)  -- multret
        a118 = a97
        a119 = a98
        a120 = a1[82]
        a118(a119, a120)  -- multret
        a10 = 14
    end
    do -- chunk @ir15
        a121 = a119[29]
        a101[43] = a121
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[29]
        a124 = 2
        a121(a122..a125)  -- multret
        a120 = 115
        a120 = 54
        a121 = a119[12]
        a101[44] = a13
        a121 = a84
        a122 = UP0
        a122 = a122()
        a123 = a119[12]
        a124 = 1
        a121(a122..a125)  -- multret
        a120 = a84
        a121 = a52
        a122 = a119
        a121 = a121(a122)
        a122 = a1[149]
        a123 = a1[26]
        a120(a121..a124)  -- multret
    end
    do -- chunk @ir16
        a121 = a119[a119]
        a101[51] = a98
        a121 = a84
        a122 = a119[5]
        a123 = UP0
        a123 = a123()
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a119[20]
        a101[52] = a128
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[20]
        a124 = 1
        a121(a122..a125)  -- multret
        a120 = 117
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[23]
        a124 = 1
        a121(a122..a125)  -- multret
        a120 = 111
        a125 = a84
        a126 = a52
        a127 = a120
        a126 = a126(a127)
        a127 = a1[150]
        a128 = a1[26]
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir20
        a139 = a1[26]
        a137(a138, a139)  -- multret
        a133 = a1[a1]
        a133 = a132[a133]
        a133 = (a133 * 100)
        a133 = (a133 // 1)
        a101[98] = a36
        a122 = 46
        if (46 >= a122) then
            a133 = a119
            a134 = a1[122]
            a134 = a132[a134]
            a135 = a1[26]
            a133(a134, a135)  -- multret
            a122 = 53
            a125 = a119[7]
            a101[37] = a74
        else
            a134 = a120; a133 = a120["Destroy"]
            a133(a134)  -- multret
            -- close upvalues
            a10 = 66
        end
        a49 = a1[a1]
        a46 = a20[a49]
        a47 = a4[0]
        a10 = 51
        -- folded: if not ((25 >= a10)) then
        a45 = a1[42]
        a10 = 36
        a125 = a84
        a126 = a13
        a127 = a123
        a126 = a126(a127)
        a127 = a1[127]
        a128 = true
        a125(a126..a129)  -- multret
        a124 = 11
        a128 = 263
        a124 = a124(a125, a126, a127, a128)
        a121[a123] = a124
        a123 = a1[5]
        a124 = 40
        a125 = 386
        a126 = 114
        do -- for-in loop
        end
    end
    do -- chunk @ir23
        a125 = a119[4]
        a101[36] = L605
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[4]
        a128 = 1
        a125(a126..a129)  -- multret
        a123 = a84
        a124 = a1[127]
        a125 = a13
        a126 = a121
        a125 = a125(a126)
        a126 = a1[a1]
        a123(a124..a127)  -- multret
        a122 = 46
    end
    do -- chunk @ir25
        -- folded: if (72 >= a10) then
            -- folded: if not ((a10 >= 77)) then
                if not ((58 >= a10)) then
                    a112 = a1[5]
                    a113 = a1[a1]
                    a114 = 36
                    a115 = 244
                    a116 = 76
                    a77 = a1[5]
                    a78 = a1[5]
                    a79 = a1[5]
                    a10 = 101
                end
    end
    do -- chunk @ir26
        a121 = a84
        a122 = a119[25]
        a123 = UP0
        a123 = a123()
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = 50
        a122 = 89
        a123 = 39
        do -- for-in loop
        end
    end
    do -- chunk @ir28
        a114(a115)  -- multret
        a114 = a112
        a115 = a68
        a114(a115)  -- multret
        a114 = a112
        a115 = a2
        a114(a115)  -- multret
        a10 = 58
        a114 = a112
        a115 = a7
        a114(a115)  -- multret
        a10 = 117
        a114 = a112
        a115 = a14
        a114(a115)  -- multret
        a114 = a1[5]
        a115 = a1[a1]
        a10 = 89
        if (100 >= a10) then
        else
            a115 = a1[5]
            a10 = 67
        end
        a26 = a1[22]
        a22 = a6[a26]
        a10 = 71
    end
    do -- chunk @ir35
        a101[93] = L410
        a131 = a1[5]
        a122 = 119
        while true do
            a122 = 106
            a132 = a119
            a133 = a1[121]
            a133 = a130[a133]
            a134 = a1[120]
            a133 = a133[a134]
            a134 = a1[26]
            a132(a133, a134)  -- multret
        end
        a123 = a84
        a124 = 0.36546066092082763
        a126 = a121; a125 = a121["NextNumber"]
        a125 = a125(a126)
        a126 = a1[26]
        a123(a124..a127)  -- multret
        a123 = a84
        a125 = a121; a124 = a121["NextNumber"]
        a124 = a124(a125)
        a125 = 0.9399625980565814
        a126 = true
        a123(a124..a127)  -- multret
        a123 = 42
        a124 = 60
        a125 = 4
    end
    do -- chunk @ir40
        a119 = a79
        a120 = a45
        a121 = a1[147]
        a121 = a113[a121]
        a120 = a120(a121)
        a121 = a1[26]
        a119(a120, a121)  -- multret
        a119 = a1[5]
        a120 = 50
        a121 = 228
        a122 = 104
        do -- for-in loop
        end
    end
    do -- chunk @ir42
        a129 = 22
        do -- for-in loop
        end
    end
    do -- chunk @ir44
        while true do
            a121 = a118[8]
            a101[18] = a43
        end
    end
    do -- chunk @ir44
        a120 = 122
    end
    do -- chunk @ir50
        a126 = a126()
        a127 = a119[24]
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir57
        a114 = a112
        a115 = a11
        a114(a115)  -- multret
        a10 = 80
    end
    do -- chunk @ir65
    end
    do -- chunk @ir67
        -- folded: if not ((30 >= a10)) then
            a102 = {}
            a101 = a102
            a10 = 0
        a102 = a97
        a103 = a13
        a104 = a1[98]
        a102(a103, a104)  -- multret
        a102 = a97
        a103 = a40
        a104 = a1[99]
        a102(a103, a104)  -- multret
        a10 = 119
    end
    do -- chunk @ir73
        a125 = a1[126]
        a121[a125] = a124
        a125 = a83
        a126 = a121
        a127 = a123
        a128 = a120
        a129 = a124
        a127 = a127(a128, a129)
        a128 = a1[26]
        a125(a126..a129)  -- multret
        a126 = a120; a125 = a120["Destroy"]
        a125(a126)  -- multret
        a126 = a121; a125 = a121["Destroy"]
        a125(a126)  -- multret
        a125 = a79
        a126 = a1[118]
        a126 = a121[a126]
        a127 = true
        a125(a126, a127)  -- multret
        a125 = a78
        a126 = a45
        local function a127(a1, a2, a3, a4, ...) -- F44
        a1 = a121
        UP0["Parent"] = a1
        -- close upvalues
        do return  end
        end
        a126 = a126(a127)
        a126 = (not a126)
        a127 = a1[26]
        a125(a126, a127)  -- multret
        -- close upvalues
        a119 = a1[5]
        a120 = 32
        a121 = 137
        a122 = 105
    end
    do -- chunk @ir74
        local function a112(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...) -- F258
        a3 = UP0
        a4 = a1
        a3 = a3(a4)
        if not ((not a3)) then
            local a3 -- F264
            a3 = function(a1, a2, a3, a4, a5, a6, ...)
            a2 = UP0
            a3 = UP1
            do -- chunk @ir1
                a5 = 3
                a4(a5..a6)  -- multret
                a2(a3..top)  -- multret
                a2 = UPVALS[a3]
                a3 = a3
                a4 = UP1
                a5 = 4
                a4(a5..a6)  -- multret
                a2(a3..top)  -- multret
                a2 = UP3
                a3 = UP1
                a4 = 5
                a3 = a3(a4)
                a4 = UP6
                a2(a3, a4)  -- multret
                a2 = UP3
                a3 = UP1
                a4 = 7
                a3 = a3(a4)
                a4 = UP2
                a2(a3, a4)  -- multret
                a2 = UP3
                a3 = UP1
                a4 = 8
                a3 = a3(a4)
                a4 = UP5
                a2(a3, a4)  -- multret
                a2 = ...  -- varargs fill (multret)
                -- close upvalues
                do return ... end
            end
            do -- chunk @ir22
                while true do
                    a3 = a3(a4)
                    a4 = UP2
                    a2(a3, a4)  -- multret
                end
            end
            do -- chunk @ir22
                a4 = 2
            end
            do -- chunk @ir41
                a2 = UP3
                a3 = UP4
                a4 = UP1
            end
            end
            a4 = UP5
            a5 = a1
            a6 = a3
            a7 = ...  -- varargs fill (multret)
            a4, a5, a6 = a4()
            a6 = UP7
            a7 = a4
            a6(a7)  -- multret
            a6 = UP8
            a7 = a5
            a8 = "error in error handling"
            a6(a7, a8)  -- multret
            -- close upvalues
        end
        do return  end
        end
        a10 = 6
        a125 = a118[3]
        a101[6] = a73
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a118[3]
        a128 = 1
        a125(a126..a129)  -- multret
        local function a91(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F352
        a3 = UP0[5]
        a4 = UP0[5]
        a5 = 18
        a3 = UP1
        a5 = 73
        a12 = a10
        a13 = a11
        a14 = a12
        a13 = a13(a14)
        a11 = a13
        a13 = UP0[5]
        a14 = 30
        a13 = a2
        a14 = 101
        a8 = nil
        a5 = 68
        -- folded: if not ((56 >= a5)) then
            a5 = 83
            a9 = a6
            a10 = a7
            a11 = a8
            -- generic-for iterator (coroutine desugar) reg R9
            while true do -- repeat
                if not ((155 > a16)) then break end
            end
        do -- chunk @ir1
            a11 = nil
            a12 = 82
            a13 = 195
            a14 = 62
            do -- for-in loop
                while true do -- repeat
                    if not ((82 >= a15)) then break end
                end
            end
            a16 = a11
            a16()  -- multret
            if __ok9 then
            else
                -- close upvalues
                do return  end
            end
        end
        do -- chunk @ir17
            a14 = 0
            a12 = UP0[5]
        end
        do -- chunk @ir28
            a6, a7, a8 = nil
            a6 = a3
            a7 = a4
        end
        do -- chunk @ir38
            a4 = a2
            a5 = 125
        end
        do -- chunk @ir48
            a6 = a3
            a7 = a4
            a8 = nil
            a5 = 56
        end
        do -- chunk @ir66
            -- generic-for iterator (coroutine desugar) reg R9
            do
                if __ok9 then
                else
                    a11 = UP0[5]
                    a12 = UP0[5]
                    a13 = 100
                    a14 = 275
                    a15 = 55
                    while true do -- repeat
                        if not ((a5 > 22)) then break end
                    end
                end
            end
        end
        do -- chunk @ir78
            a10 = a7
            a11 = a8
            -- generic-for iterator (coroutine desugar) reg R9
        end
        do -- chunk @ir94
            -- folded: if not ((a15 >= 144)) then
                a11 = a90
        end
        do -- chunk @ir99
            a4 = a1
        end
        end
        a10 = 9
        a92 = 77
        a94 = a89
        a95 = a25
        a94(a95)  -- multret
        a94 = a89
        a95 = a69
        a94(a95)  -- multret
        a93 = 13521840
        a94 = a89
        a95 = a73
        a94(a95)  -- multret
        a94 = a89
        a95 = a62
        a94(a95)  -- multret
        a94 = a1[5]
        a95 = a1[5]
        a96 = a1[5]
        a97, a98 = nil
        a10 = 44
        if (44 >= a10) then
            a99 = a89
            a100 = a81
            a99(a100)  -- multret
            a10 = 27
            a132 = a1[122]
            a132 = a130[a132]
            a133 = a1[120]
            a132 = a132[a133]
            a132 = (a132 * 100)
            a132 = (a132 // 1)
            a101[94] = a28
            a122 = 65
            a132 = a119
            a133 = a1[122]
            a133 = a130[a133]
            a134 = a1[120]
            a133 = a133[a134]
            a134 = a1[26]
            a132(a133, a134)  -- multret
            if (78 >= a10) then
        local function a89(a1, a2, a3, a4, a5, a6, a7, ...) -- F78
        a2 = UP0
        a3 = (not a1)
        a2(a3)  -- multret
        a2 = UPVALS[a1]
        a3 = a84[68]
        a4 = UP3
        a5 = a1
        a4 = a4(a5)
        a2(a3, a4)  -- multret
        a2 = 116
        -- folded: if not ((67 >= a2)) then
            a2 = 67
            a3 = a79
            a4 = a84[5]
            a5 = a13
            a6 = a1
            a5 = a5(a6)
            a3(a4, a5)  -- multret
        a3 = a48
        a4 = a45
        a5 = a1
        a6 = a84[5]
        a3(a4..a7)  -- multret
        -- close upvalues
        do return  end
        end
                a10 = 79
            end
            a120 = 100
            a121 = a84
            a122 = a119[30]
            a123 = UP0
            a123 = a123()
            a124 = 1
            a121(a122..a125)  -- multret
            a121 = a119[25]
            a101[23] = a99
        else
            a99 = {}
            a95 = a99
            a99 = {}
            a100 = a1[69]
            a99[a100] = -1
            a100 = a1[70]
            a99[a100] = -1
            a100 = a1[71]
            a99[a100] = 0
            a100 = a1[72]
            a101 = a1[73]
            a99[a100] = a101
            a100 = a1[74]
            a101 = a1[75]
            a99[a100] = a101
            a100 = a1[76]
            a101 = a1[77]
            a99[a100] = a101
            a100 = a1[78]
            a99[a100] = -1
            a100 = a1[79]
            a101 = a1[80]
        end
        a59 = nil
        a10 = 28
    end
    do -- chunk @ir79
        a128 = a1[26]
        a125(a126..a129)  -- multret
        a10 = 71
        a119 = a1[5]
        a120 = 67
        -- folded: if not ((a120 >= 70)) then
            a120 = 70
            a121 = a1[82]
            a119 = a81[a121]
        a121 = a97
        a122 = a119
        a123 = a1[82]
        a121(a122, a123)  -- multret
        a121 = a112
        a122 = a119
        a123 = {}
        a121(a122, a123)  -- multret
        a120 = 0
        -- folded: if not ((a120 > 0)) then
            a121 = a1[5]
            a122 = 28
        a121 = a1[5]
        a122 = 20
    end
    do -- chunk @ir83
        a122 = 323
        a123 = 106
        do -- for-in loop
        end
    end
    do -- chunk @ir86
        while true do
            a133 = (a133 * 100)
            a133 = (a133 // 1)
        end
    end
    do -- chunk @ir86
        a133 = a127[0]
    end
    do -- chunk @ir90
        a128 = a113; a127 = a113["GetService"]
        a129 = a1[146]
        a127 = a127(a128, a129)
        a121 = a127
        a114 = a112
        a115 = a48
        a114(a115)  -- multret
        a10 = 85
    end
    do -- chunk @ir95
        if not ((a132 ~= 87)) then
        local function a126(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F164
        a2 = UP0
        a3 = a1
        a4 = a12[170]
        a2 = a2(a3, a4)
        a3 = UP2
        a4 = a1
        a5 = a12[170]
        a3 = a3(a4, a5)
        a3 = a3()
        a4 = a12[5]
        a5 = a12[5]
        a6 = 83
        a7 = 199
        a8 = 25
        do -- for-in loop
        end
        do -- chunk @ir1
            a9 = 106
            a15 = a21
            a16 = a12
            a17 = a10
            a15(a16, a17)  -- multret
        end
        do -- chunk @ir6
            a9 = 119
            a15 = a21
            a16 = a11
            a17 = a12
            a15(a16, a17)  -- multret
            while not ((a9 ~= 61)) do -- while-exit-cond
                a9 = 120
                a15 = a21
                a16 = a8
                a17 = a7
                a15(a16, a17)  -- multret
                a11 = UP3
                a11()  -- multret
            end
            a10 = UP3
            a10()  -- multret
            if not (a3) then
                a10 = UP3
                a10()  -- multret
            end
        end
        do -- chunk @ir12
            if not (a4) then
                a10 = UP3
                a10()  -- multret
            end
        end
        do -- chunk @ir14
        end
        do -- chunk @ir17
            a9 = 103
            a14 = (a8 + 0)
            a15 = a21
            a16 = a3
            a17 = a6
            a15(a16, a17)  -- multret
            a15 = UP10
            a16 = a6
            a17 = a8
            a15(a16, a17)  -- multret
            a9 = 61
        end
        do -- chunk @ir20
            a14 = a12[5]
            a9 = 3
        end
        do -- chunk @ir23
            a15 = a21
            a16 = a10
            a17 = a14
            a15(a16, a17)  -- multret
            a15 = UP10
            a16 = a14
            a17 = a13
            a15(a16, a17)  -- multret
            a15 = a11
            -- close upvalues
            do return a15 end
        end
        do -- chunk @ir32
            a6 = UP3
            a6()  -- multret
            while true do -- repeat
                if not (a5) then break end
            end
        end
        do -- chunk @ir35
            a7 = a12[5]
            a8 = a12[5]
            a9 = 45
            a10 = a14
            a11 = UPVALS[a6]
            a12 = a1
            a13 = (a4 + 1)
            a14 = (a5 - 1)
            a11(a12..a15)  -- multret
            a10 = a10(a11..top)
            a8 = a10
            a10 = a17
            a11 = a1
            a12 = a12[170]
            local function a13(a1, a2, a3, ...) -- F170
            UP0 = a1
            -- close upvalues
            do return  end
            end
            a10(a11..a14)  -- multret
        end
        do -- chunk @ir39
            a9 = 40
            a13 = (a7 + 0)
        end
        do -- chunk @ir42
            a7 = L0
            a9 = 103
        end
        do -- chunk @ir56
            a11 = UP3
            a11()  -- multret
            a11 = a12[5]
            a12 = a12[5]
            a13 = a12[5]
            a10 = UP4
            a11 = a1
            a12 = a12[170]
            a10, a11, a12 = a10(a11..a13)
            a4 = a10
            a5 = a11
        end
        do -- chunk @ir62
        end
        do -- chunk @ir103
            a9 = 6
            a11 = (a2 + 0)
        end
        do -- chunk @ir113
            L278 = (nil / L430)
            while true do -- repeat
                if not (a6) then break end
            end
            a10 = UP3
            a10()  -- multret
        end
        do -- chunk @ir117
            a9 = 105
        end
        do -- chunk @ir144
            a9 = 26
            a15 = a21
            a16 = a2
            a17 = a3
            a15(a16, a17)  -- multret
            a9 = 52
            a10 = (a6 + 0)
        end
        do -- chunk @ir167
            a9 = 40
            a10 = a18
            a11 = a1
            a12 = (a4 + 1)
            a13 = (a5 - 1)
            a10 = a10(a11, a12, a13)
            a6 = a10
        end
        do -- chunk @ir180
            a12 = (a3 + 0)
            a9 = 45
        end
        end
            a133 = a126
            a134 = a120
            a133 = a133(a134)
            a127 = a133
        end
    end
    do -- chunk @ir101
        -- folded: if not ((a123 >= 154)) then
            a119 = a1[a1]
        a124 = a83
        a125 = a13
        a126 = a119
        a125 = a125(a126)
        a126 = a1[127]
        a127 = a1[26]
        a124(a125..a128)  -- multret
    end
    do -- chunk @ir103
        if (a126 == 106) then
            a127 = a118
            a128 = a121
            a129 = a1[146]
            a127(a128, a129)  -- multret
        end
        a128 = a1[118]
        a123[a128] = a121
        a129 = a123; a128 = a123["SetControlPoints"]
        a130 = {} -- size 4
        a131 = a24
        a132 = a114
        a133 = 0.0625
        a134 = -2
        a135 = 0
        a136 = 2
        a132 = a132(a133, a134, a135, a136)
        a133 = a114
        a134 = 0.125
        a135 = -1
        a136 = 0
        a137 = -3
        a133 = a133(a134, a135, a136, a137)
        a134 = a114
        a135 = 0
        a136 = 0
        a137 = 0
        a138 = 0
        a134(a135..a139)  -- multret
        a131 = a131(a132..top)
        a132 = a24
        a133 = a114
        a134 = 0.375
        a135 = 7
        a136 = 0.125
        a137 = -2
        a133 = a133(a134, a135, a136, a137)
        a134 = a114
        a135 = 0
        a136 = 2
        a137 = 0
        a138 = -6
        a134 = a134(a135, a136, a137, a138)
        a135 = a114
        a136 = 0
        a137 = 0
        a138 = 0
        a139 = 0
        a135(a136..a140)  -- multret
        a132 = a132(a133..top)
        a133 = a24
        a134 = a114
        a135 = 0.5
        a136 = -4
        a137 = 0.375
        a138 = -7
        a134 = a134(a135, a136, a137, a138)
        a135 = a114
        a136 = 0
        a137 = -6
        a138 = 0.125
        a139 = 7
        a135 = a135(a136, a137, a138, a139)
        a136 = a114
        a137 = 0
        a138 = 1
        a139 = 0
        a140 = -4
        a136(a137..a141)  -- multret
        a133 = a133(a134..top)
        a134 = a24
        a135 = a114
        a136 = 0
        a137 = -1
        a138 = 0
        a139 = -4
        a135 = a135(a136, a137, a138, a139)
        a136 = a114
        a137 = 0
    end
    do -- chunk @ir105
        a123 = a118[14]
        a124 = 2
        a121(a122..a125)  -- multret
        a120 = 13
    end
    do -- chunk @ir109
        a24 = a1[20]
        a10 = 17
    end
    do -- chunk @ir112
        a121 = a84
        a122 = a118[18]
        a123 = UP0
        a123 = a123()
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a118[12]
        a101[2] = a24
        a121 = 124
        a122 = 176
        a123 = 26
        do -- for-in loop
        end
    end
    do -- chunk @ir114
        a121 = a119[46]
        a101[38] = a4
        a121 = a84
        a122 = a119[46]
        a123 = UP0
        a123 = a123()
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a119[41]
        a101[39] = a59
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[41]
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[40]
        a101[40] = a92
        a121 = 118
        a122 = 171
        a123 = 33
        while true do -- repeat
            if not ((a10 ~= 8)) then break end
        end
    end
    do -- chunk @ir115
        if not ((a10 >= 53)) then
            a127 = {}
            a128 = a1[171]
        local function a129(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, ...) -- F364
        a3 = UP0[5]
        a4 = 28
        a5 = 50
        a6 = 22
        do -- chunk @ir1
            if not ((17 >= a12)) then
                a13 = a107
                a14 = a8
                a13(a14)  -- multret
            end
        end
        do -- chunk @ir3
            while true do -- repeat
                if not ((a7 ~= 50)) then break end
            end
            UP324[nil] = nil
            a8 = UP1[a3]
            a9 = 17
            a10 = 224
            a11 = 71
            a4 = a125
            a4()  -- multret
            -- close upvalues
            do return  end
        end
        do -- chunk @ir9
            if (a12 >= 88) then
                if not ((88 >= a12)) then
                    a13 = a1[a2]
                    -- close upvalues
                    do return a13 end
                end
            end
            a13 = UP0[5]
            UP1[a3] = a13
        end
        do -- chunk @ir13
            a8 = a1[0]
            a3 = a8[a2]
        end
        do -- chunk @ir18
        end
        end
            a127[a128] = a129
            a126 = a127
            a10 = 53
        end
        a127 = a1[5]
        a128 = a1[5]
        a129 = 65
        if not ((a129 >= 65)) then
            if not ((not a127)) then
            end
        local function a128(a1, a2, a3, ...) -- F293
        a1 = UP0
        a2 = UP1[172]
        a1(a2)  -- multret
        end
        end
        a130 = a45
        a131 = a99
        a132 = a11
        a133 = " --[[%s]] return setfenv(function(...) return %s(...) end, setmetatable({ [\"%s\"] = ... }, { __index = getfenv((...)) })) "
        a134 = "\n				 .@%(/*,.......      ...,,*/(#%&@@.\n			 (*   ,/(#%%&&@@@@&%((////(((##%###((/**,,.     ,//(&.\n		   /* .%@@@@@@@@%,  .(&@@@&&&&&&@@@@@@&#(*,........*%@@@(.  ,#.\n		 */ .&@@@@@@@*  (%,   *(&&@@@@@&%(*,.             .,*(#%(*@@&*  *,\n		#, /@@@@@@* *&( ,&&/.,/#%&&@@@&(&@@@@@@@@@@@@#*,.....,/&@@@@@@@@( .%\n	   #  #@@@@@*/@% .#%./(,.,/*,//*,.,/(*@@@@@@@@@@@@%@@@@@@@@@#.#@@@@@@&. %\n	  /  &@@@@@@@@(%@# *&&*&@@@@#/&@@@@/%%.,%@@@@@@@%/@@&(,  ,,,...  *%@@@# *\n	#  .&@@@@@@@@@@@,((%@@@@@#.    ,&@@#@@&* .&@@@@@&,.#@@@@/&@@%(@@@&(/,(&, /,\n (/   (@&&&%&@@@&/, ,@#(@@@@,        #@@/,&@& /@@@@@,%#%@@@@@(     *@@@@@&,%%. .\n/  #/,#@@@&#(//#@@@/ %@@@&@@@(.    ,&@@(.*/*  %@@*   %@@@@@@%       (@@&(*...%&.\n ///@@&,  (&@@#,   /@/ ,*&@@@@#&@@%#%((%@&* /@@@@@@&. #@@@#&@@@&%%@@@@@@&,/(*@/#\n%%.&@# .&@@@# /@@@@%&@@@&/.   ,/((/*,  ./&@@@@@@@@@@,*&(./%@@#*&@@@(#(....,&#*@/\n@%.&& .&@@@&*    /&@@@@@@@@@@@@@@@@&@@#/(%@@@@@@@@@@&,  (@@@@@@@@@@@@/,@@@@@#.&*\n&&,%% .&*    /@@@(.  ,(@@@@@&/(////#( /&@@@@@@@@@@@@@@@(  ,&@@@@@@@@&, (@@&*/@(/\n.%*#@( /@@@@( *@@@@@@/     *%@@@@@@@&.,@& ,#, .&@@@@@@# .#*%&/,#@@@@*   *@@&/*&*\n .&/.#@@@@@@@,   *&@@%.,&@@&(,    ,(%@%&@@@@@@@@@(.*,  /@@@@@@@@@&,      %@@@@..\n@* .%@@@@@@@@(       .   (@@@@@@@@(       .*(%&@@@@@@@@@@@@&(,  ./.*@%   /@@% ./\n  @* .&@@@@@@&.             ./&@@@*.&@@@@@@@&, ,**,.    .,*(&(.%@@# %@*  ,@@% ,#\n	&, /@@@@@@*                    .#@@@@@@@@*.%@@@@@(,@@@@@@& ,%(.      .&@% ,#\n	  / *@@@@@#                                                           %@&.,#\n	  (( .&@@@@*                                                          #@&.,#\n	   .&. ,&@@@,                                                         (@&.,#\n		  #. .%@@* /@@/                                                   /@&.,(\n			./  #@%. %@&,,#,                                              /@@,./\n			  *(  #@%. . (@@@@@%/,                                        /@@,.*\n				//  %@&, *@@@@@@@@( (@%/.                                 #@@, (\n				  #* .&@@#. (@@@@&.*@@@@@@@@%. */.                  *..%*.&@@, /\n					@* .%@@@%, ,/ .@@@@@@@@@@,.%@@@@@% .&@@@* #@&..&@*,* %@@&. *\n					   /  *&@@@@%,   *(&@@@@&. #@@@@@* #@@@% (@@* ,.   /@@@@* (\n						 @#. .#@@@@@@&(,.                      .,*(%&@@@@@&..(\n							 &(.   ./%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(. ((\n								  ,#/*.       ..,,,,,,,,....          ,/#\n\n"
        a135 = a1[173]
        a136 = a1[173]
        a132 = a132(a133, a134, a135, a136)
        a133 = a1[174]
        a134 = a1[5]
        a130, a131, a132 = a130(a131..a135)
        a127 = a130
        a128 = a131
        a129 = 44
        -- folded: if not ((16 >= a10)) then
    end
    do -- chunk @ir117
        a101 = a97
        a102 = a68
        a103 = a1[92]
        a101(a102, a103)  -- multret
        a10 = 101
        a125 = a125[a126]
        a126 = a1[151]
        a125 = a125[a126]
        a126 = a125; a125 = a125["FromValue"]
        a127 = 1
        a125 = a125(a126, a127)
        a125 = a125[0]
        a126 = a125; a125 = a125["FromValue"]
        a127 = 1
        a125 = a125(a126, a127)
        a126 = a1[151]
        a125 = a125[a126]
        a126 = a125; a125 = a125["FromValue"]
        a127 = 1
        a125 = a125(a126, a127)
        a126 = a1[151]
        a125 = a125[a126]
        a126 = a125; a125 = a125["FromName"]
        a127 = a1[152]
        a125 = a125(a126, a127)
        a120 = a125
    end
    do -- chunk @ir119
        -- folded: if (97 >= a124) then
        a41 = a1[5]
        a42 = a1[5]
        a43 = a1[5]
        a44 = a1[5]
        a45 = a1[5]
        a46 = a1[5]
        a47 = nil
        a48 = a1[5]
        a10 = 34
        a119 = 1
        a120 = 9
        a121 = 1
        a122 = 120
        a128 = a1[121]
        a128 = a126[a128]
        a128 = a128[0]
        a128 = (a128 * 100)
        a128 = (a128 // 1)
        a101[85] = a89
        a128 = a119
        a129 = a1[121]
        a129 = a126[a129]
        a130 = a1[120]
        a129 = a129[a130]
        a130 = a1[26]
        a128(a129, a130)  -- multret
    end
    do -- chunk @ir121
        a137 = a119
        a138 = a1[122]
        a138 = a131[a138]
        a139 = a1[26]
        a137(a138, a139)  -- multret
    end
    do -- chunk @ir127
        a103(a104, a105)  -- multret
        a103 = a1[103]
        a104 = a97
        a105 = a18
        a106 = a1[16]
        a104(a105, a106)  -- multret
        a104 = a97
        a105 = a21
        a106 = a1[19]
    end
    do -- chunk @ir130
        local function a77(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, ...) -- F340
        a3 = UP0[5]
        a4 = UP0[5]
        a5 = UP0[5]
        a6 = UP0[5]
        a7 = 50
        a8 = 325
        a9 = 85
        while true do
            a14 = 21
            a15 = (a6 + 4)
            a16 = UP0[5]
            a17 = 0
            -- folded: if (0 >= a17) then
                a18 = UP1
                a19 = a1
                a20 = a6
                a18 = a18(a19, a20)
                a16 = a18
                a18 = bit32.band(a16, 255)
                a11 = bit32.bxor(a9, a18)
                a12 = (a11 * 435)
                a17 = 95
                a9 = (a12 % a5)
            -- folded: if not ((a10 >= 220)) then
                a5 = 4294967296
                while true do
                    a9 = nil
                    a10 = UP0[5]
                    a11 = UP0[5]
                    a12 = UP0[5]
                    a13 = UP0[5]
                    a14 = 124
                end
            a3 = 2216829733
            a4 = 3421674724
            -- folded: if not ((a14 >= 112)) then
                a14 = 14
                a11 = UP0[5]
                a12 = nil
        end
        do -- chunk @ir5
            a18 = (a11 * 256)
            a18 = (a13 + a18)
            a19 = (a10 * 435)
            a18 = (a18 + a19)
            a10 = (a18 % a5)
            a18 = bit32.rshift(a16, 24)
            a11 = bit32.bxor(a9, a18)
            a12 = (a11 * 435)
            a9 = (a12 % a5)
            a18 = 15
            a19 = 168
            a20 = 30
            a18 = bit32.rshift(a16, 16)
            a18 = bit32.band(a18, 255)
            a11 = bit32.bxor(a9, a18)
            a12 = (a11 * 435)
            a9 = (a12 % a5)
            a17 = 98
            a17 = 89
            a18 = (a12 - a9)
            a13 = (a18 / a5)
        end
        do -- chunk @ir18
            a17 = 4
            a18 = (a11 * 256)
            a18 = (a13 + a18)
            a19 = (a10 * 435)
            a18 = (a18 + a19)
            a10 = (a18 % a5)
            if (4 >= a17) then
            else
            end
        end
        do -- chunk @ir25
            a15 = a9
            a16 = a10
            -- close upvalues
            do return  end
        end
        do -- chunk @ir29
            a16 = (a11 * 256)
            a16 = (a13 + a16)
            a17 = (a10 * 435)
            a16 = (a16 + a17)
            a10 = (a16 % a5)
            a15 = 19
            a6 = (a6 + 1)
            if not ((a6 >= a2)) then
                a15 = 101
                a12 = (a11 * 435)
                a9 = (a12 % a5)
                a16 = (a12 - a9)
                a13 = (a16 / a5)
                a15 = 4
            end
            a14 = 112
        end
        do -- chunk @ir43
        end
        do -- chunk @ir47
        end
        do -- chunk @ir57
            a22 = (a12 - a9)
            a13 = (a22 / a5)
            a22 = (a11 * 256)
            a22 = (a13 + a22)
            a23 = (a10 * 435)
            a22 = (a22 + a23)
            a10 = (a22 % a5)
        end
        do -- chunk @ir72
        end
        do -- chunk @ir86
            a6 = 0
        end
        do -- chunk @ir101
            a16 = a16(a17, a18)
            a11 = bit32.bxor(a9, a16)
            a15 = 0
            a18 = (a12 - a9)
            a13 = (a18 / a5)
            a18 = (a11 * 256)
            a18 = (a13 + a18)
            a19 = (a10 * 435)
            a18 = (a18 + a19)
            a10 = (a18 % a5)
            a18 = bit32.rshift(a16, 8)
            a18 = bit32.band(a18, 255)
            a11 = bit32.bxor(a9, a18)
            a12 = (a11 * 435)
            a9 = (a12 % a5)
            a18 = (a12 - a9)
            a13 = (a18 / a5)
            a17 = 121
            L382 = (L228 * L506)
            a6 = (a6 + 4)
        end
        do -- chunk @ir144
            a16 = a54
            a17 = a1
            a18 = a6
        end
        do -- chunk @ir198
            a13 = nil
        end
        end
        a10 = 95
        a123(a124..a127)  -- multret
    end
    do -- chunk @ir132
        a125 = a1[151]
        a123 = a120[a125]
        a124 = 26
    end
    do -- chunk @ir135
        a127 = a127()
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir139
        a122 = UP0
        a122 = a122()
        a123 = a119[47]
        a124 = 2
        a121(a122..a125)  -- multret
        a106(a107, a108)  -- multret
        a106 = a97
        a107 = a35
        a108 = a1[32]
        a106(a107, a108)  -- multret
        a106 = ENV.workspace
        a107 = a97
        a108 = a56
        a109 = a1[50]
        a107(a108, a109)  -- multret
        a10 = 109
        if (a10 ~= 104) then
        else
            a107 = a97
            a108 = a43
            a109 = a1[40]
            a107(a108, a109)  -- multret
            a107 = a97
            a108 = a44
            a109 = a1[41]
            a107(a108, a109)  -- multret
            a107 = a97
            a108 = a47
            a109 = a1[106]
            a107(a108, a109)  -- multret
            a107 = a97
            a108 = a105
            a109 = "wait"
            a107(a108, a109)  -- multret
            a107 = a1[5]
            a10 = 66
            while true do
                a107 = L0
                a108 = a97
                a109 = a53
                a110 = a1[49]
                a108(a109, a110)  -- multret
                a108 = a1[5]
                a109 = a1[5]
                a10 = 41
                if (a10 >= 116) then
        local function a110(a1, ...) -- F202
        do return  end
        end
                    a109 = a110
        local a110 -- F212
        a110 = function(a1, a2, a3, a4, a5, a6, ...)
        a2 = UP0
        a2 = a8
        a2()  -- multret
        a2 = a108
        a2 = (892841 * a2)
        a2 = (a2 + 297308)
        a2 = (a2 % 16777216)
        a108 = a2
        a2 = a108
        a2 = (888359 * a2)
        a2 = (a2 + 5530975)
        a2 = (a2 % 16777216)
        a108 = a2
        a2 = a108
        a2 = (517693 * a2)
        a2 = (a2 + 10063901)
        a2 = (a2 % 16777216)
        a108 = a2
        a2 = a108
        a2 = (34723 * a2)
        a2 = (a2 + 6399898)
        a2 = (a2 % 16777216)
        a108 = a2
        a2 = a108
        do -- chunk @ir2
            while true do
                a2 = (a2 + 11944249)
                a2 = (a2 % 16777216)
            end
            -- close upvalues
            while true do
                a2 = a108
                a2 = (619511 * a2)
                a2 = (a2 + 13158945)
                a2 = (a2 % 16777216)
                a108 = a2
                a2 = a108
            end
            a3 = a108
            a3 = (211673 * a3)
            a3 = (a3 + 16505416)
            a3 = (a3 % 16777216)
            a108 = a3
            -- close upvalues
            do return  end
        end
        do -- chunk @ir2
            a2 = (884145 * a2)
        end
        do -- chunk @ir6
            a2 = (a2 + 8368439)
            a2 = (a2 % 16777216)
            a108 = a2
            a2 = a108
            a2 = (892893 * a2)
            a2 = (a2 + 1892924)
            a2 = (a2 % 16777216)
            a108 = a2
            -- close upvalues
            do return  end
        end
        do -- chunk @ir17
            a2 = UP3
            a3 = (a1 + 1)
            a2(a3)  -- multret
            a2 = UP0
            a2 = (a2 - 1)
        end
        do -- chunk @ir46
            do return a2 end
        end
        do -- chunk @ir64
            a2 = a2(a3, a4)
            if not (a2) then
                a108 = a2
                a2 = a108
                a2 = (77149 * a2)
            end
            local function a3(a1, a2, a3, a4, ...) -- F228
            a1 = UP0
            a1 = (488551 * a1)
            a1 = (a1 + 11463257)
            a1 = (a1 % 16777216)
            UP0 = a1
            a1 = UP0
            a1 = (218691 * a1)
            a1 = (a1 + 2359832)
            a1 = (a1 % 16777216)
            UP0 = a1
            a1 = UP0
            a1 = (21605 * a1)
            a1 = (a1 + 1243276)
            a1 = (a1 % 16777216)
            UP0 = a1
            a1 = UP0
            a1 = (339477 * a1)
            a1 = (a1 + 7553257)
            a1 = (a1 % 16777216)
            UP0 = a1
            a1 = UP0
            a1 = (636249 * a1)
            a1 = (a1 + 9752435)
            a1 = (a1 % 16777216)
            UP0 = a1
            a1 = UP0
            a1 = (891329 * a1)
            a1 = (a1 + 16497462)
            a1 = (a1 % 16777216)
            UP0 = a1
            a1 = UP0
            a1 = (753455 * a1)
            a1 = (a1 + 3820704)
            a1 = (a1 % 16777216)
            UP0 = a1
            end
            a4 = a3
            a4()  -- multret
        end
        do -- chunk @ir75
            a2 = a110
            a3 = a8
            local function a4(a1, a2, a3, a4, ...) -- F218
            a1 = UP0
            a1 = (43789 * a1)
            a1 = (a1 + 6517415)
            a1 = (a1 % 16777216)
            UP0 = a1
            a1 = UP0
            a1 = (327245 * a1)
            a1 = (a1 + 8953997)
            a1 = (a1 % 16777216)
            UP0 = a1
            -- close upvalues
            do return  end
            end
        end
        end
                    a10 = 111
                else
                    a110 = a97
                    a111 = a99
                    a112 = a1[5]
                    a113 = a1[26]
                    a110(a111..a114)  -- multret
        local function a110(a1, ...) -- F191
        do return  end
        end
                    a108 = a110
                    a10 = 116
                    a123 = a97
                    a124 = a24
                    a125 = "new"
                    a123(a124, a125)  -- multret
                    a122 = 37
                end
            end
        end
        a125 = a112
        a126 = a1[143]
        a126 = a119[a126]
        a125(a126)  -- multret
    end
    do -- chunk @ir143
        a129 = a123; a128 = a123["GetTangentOnCurve"]
        a130 = 0.375
        a128 = a128(a129, a130)
        a127 = a128
        a128 = a1[121]
        a128 = a127[a128]
        a128 = (a128 * 100)
        a128 = (a128 // 1)
        a101[87] = a70
        a128 = a1[5]
        a129 = 20
        a130 = 176
        a131 = 46
        do -- for-in loop
        end
    end
    do -- chunk @ir149
        a119 = a1[5]
        a120 = a1[5]
        a121 = a1[5]
        a122 = a1[5]
        a123 = a1[5]
        a124 = a1[5]
        a125 = 7
        a125 = 58
        a126 = a45
        a127 = L12
        a126, a127, a128 = a126(a127..a128)
        a119 = a126
        a120 = a127
        a126 = a45
        a127 = UP8
        a126, a127, a128 = a126(a127..a128)
        a121 = a126
        a122 = a127
    end
    do -- chunk @ir153
        -- folded: if (a10 >= 100) then
        a123 = a1[130]
        if not ((a122 == a123)) then
            a122 = a55
            a122()  -- multret
        end
        a10 = 92
        a125 = a113; a124 = a113["GetService"]
        a126 = a1[138]
        a124 = a124(a125, a126)
        a119 = a124
        a124 = a118
        a125 = a119
        a126 = a1[138]
        a124(a125, a126)  -- multret
    end
    do -- chunk @ir160
        if (a122 ~= 123) then
        end
        a118 = a1[82]
        a117 = a25[a118]
        a118 = a112
        a119 = a35
        a118(a119)  -- multret
        a10 = 40
    end
    do -- chunk @ir163
        a130 = a123; a129 = a123["GetPositionOnCurveArcLength"]
        a131 = 0.6666666865348816
        a129 = a129(a130, a131)
        a122 = 12
        a121 = a119[57]
        a101[55] = a65
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[57]
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[56]
        a101[56] = a68
        a121 = a84
        a122 = a119[56]
        a123 = UP0
        a123 = a123()
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[43]
        a101[57] = a79
        a120 = 70
        -- folded: if not ((39 >= a120)) then
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[45]
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[28]
        a101[60] = a117
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[28]
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a119[63]
        a101[61] = a46
        a121 = a84
        a122 = a119[63]
        a123 = UP0
        a123 = a123()
        a124 = 2
        a121(a122..a125)  -- multret
        a120 = 56
        a121 = a119[6]
        a101[62] = a113
        a120 = 55
    end
    do -- chunk @ir167
        a125 = a84
        a126 = UP0
        a126 = a126()
        a127 = a119[22]
        a128 = 1
        a125(a126..a129)  -- multret
        a124 = 117
        a125 = a84
        a126 = a1[136]
        a127 = a48
        a128 = a123
        a127 = a127(a128)
        a128 = true
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir169
        a125(a126..a129)  -- multret
        a125 = a119[35]
        a101[80] = a78
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[35]
        a128 = 1
        a125(a126..a129)  -- multret
        a121 = a1[5]
        a128 = a133
        a129 = a126
        a130 = a124
        a129 = a129(a130)
        a130 = a83
        a131 = a127
        a132 = a128
        a133 = a1[26]
        a130(a131..a134)  -- multret
        a130 = a84
        a131 = a128
    end
    do -- chunk @ir184
        a127 = a127()
        a128 = 1
        a125(a126..a129)  -- multret
        a125 = a118[2]
        a101[9] = a125
        a107 = a97
        a108 = a30
        a109 = a1[29]
        a107(a108, a109)  -- multret
        a10 = 104
    end
    do -- chunk @ir188
        a10 = 13
    end
    do -- chunk @ir190
    end
    do -- chunk @ir192
        a133 = a131[a133]
        a134 = true
        a132(a133, a134)  -- multret
    end
    do -- chunk @ir196
        a122 = a122()
        a123 = a119[9]
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[8]
        a101[71] = a71
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[8]
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = 125
        a122 = 224
        a123 = 33
        do -- for-in loop
        end
    end
    do -- chunk @ir205
        -- folded: if (16 >= a124) then
        a121 = 72
        a122 = 173
        a123 = 25
        while true do
            a128 = a1[164]
            a128 = a121[a128]
            a129 = a1[164]
            a127(a128, a129)  -- multret
        end
        a116 = a112
        a117 = a67
        a116(a117)  -- multret
        a116 = a112
        a117 = a29
        a116(a117)  -- multret
        a116 = {}
        a116[4] = 3
        a116[5] = 1
        a116[10] = 6
        a10 = 72
        a117 = a112
        a118 = a38
        a117(a118)  -- multret
        a117 = a112
        a118 = a41
        a117(a118)  -- multret
        a117 = nil
        a10 = 45
    end
    do -- chunk @ir207
        a120 = 102
        a121 = a119[58]
        a101[50] = a77
        a120 = 99
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[3]
        a124 = 2
        a121(a122..a125)  -- multret
    end
    do -- chunk @ir214
        while true do
            a128 = a1[26]
            a126(a127, a128)  -- multret
            a122 = 49
        end
        a122 = a45
        a123 = a2
        a124 = a1[25]
        a122, a123, a124 = a122(a123..a125)
        a119 = a122
        a120 = a123
        a121 = 61
        -- folded: if not ((a121 >= 86)) then
            if a119 then
            end
    end
    do -- chunk @ir214
        a127 = a127[a128]
    end
    do -- chunk @ir219
        a111 = a41
        a112 = a47
        a113 = 299
        a114 = a55
        a112 = a112(a113, a114)
        a111(a112)  -- multret
        a111 = a1[5]
        a112 = nil
        a10 = 52
        a104 = a97
        a105 = a31
        a106 = a1[30]
        a104(a105, a106)  -- multret
        a10 = 24
    end
    do -- chunk @ir227
        -- close upvalues
        a10 = 58
        a126 = a126(a127, a128)
        a127 = a1[5]
        a122 = 61
    end
    do -- chunk @ir235
        a118 = a112
        a119 = a44
        a118(a119)  -- multret
        a118 = a112
        a119 = a47
        a118(a119)  -- multret
        a10 = 108
        a118 = a112
        a119 = a43
        a118(a119)  -- multret
        a10 = 1
    end
    do -- chunk @ir240
        a57 = a1[51]
        a54 = a20[a57]
        a10 = 117
        local function a55(a1, a2, a3, a4, ...) -- F376
        a1 = UP6[5]
        a3 = nil
        UP0 = a1
        UP0 = a3
        UP2 = a3
        UP3 = a3
        UP4 = a3
        UP5 = a3
            local a1 -- F382
            a1 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, ...)
            a1 = ENV.string
            a1 = a1[0]
            a2 = ENV.string
            a2 = a2[0]
            a4 = a2
            a5 = " "
            a6 = 8
            a4 = a4(a5, a6)
                local a5 -- F388
                a5 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...)
                a3 = 1
                a4 = 0
                if (a1 >= a2) then
                    a5 = (a1 % 2)
                    a4 = (a4 + a3)
                    a6 = (a1 - a5)
                    a1 = (a6 / 2)
                    a3 = (a3 * 2)
                end
                a1 = a2
                a7 = (a1 - a5)
                a1 = (E["?"] / 2)
                a7 = (a2 - a6)
                a2 = (a7 / 2)
                a3 = (a3 * 2)
                do -- chunk @ir11
                    a5 = a4
                    -- close upvalues
                    do return a5 end
                end
                do -- chunk @ir20
                    a4 = (a4 + a3)
                end
                do -- chunk @ir37
                    a5 = (a1 % 2)
                    a6 = (a2 % 2)
                end
                end
                local a6 -- F398
                a6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...)
                if (not a3) then
                    a4 = (a2 - 1)
                    a4 = (2 ^ a4)
                    a5 = (a4 + a4)
                    a5 = (a1 % a5)
                    a5 = (a5 >= a4)
                    if not ((not a5)) then
                        a5 = 1
                    end
                end
                a4 = (a2 - 1)
                a4 = (2 ^ a4)
                a4 = (a1 / a4)
                a5 = (a3 - 1)
                a6 = (a2 - 1)
                a5 = (a5 - a6)
                a5 = (a5 + 1)
                a5 = (2 ^ a5)
                a4 = (a4 % a5)
                a5 = (a4 % 1)
                a5 = (a4 - a5)
                do return a5 end
                do -- chunk @ir1
                    a5 = 0
                    -- close upvalues
                    while true do -- repeat
                        if not (a5) then break end
                    end
                end
                end
                local a7 -- F408
                a7 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...)
                a1 = UP0
                a2 = UPVALS[a1]
                a3 = 1
                a4 = 4
                a1, a2, a3, a4, a5 = a1(a2..a5)
                a5 = a4
                a6 = a4
                a7 = 64
                a5 = a5(a6, a7)
                a5 = (a5 * 16777216)
                a6 = a4
                a7 = a3
                a8 = 32
                a6 = a6(a7, a8)
                a6 = (a6 * 65536)
                a5 = (a5 + a6)
                a6 = a4
                a7 = a2
                a8 = 16
                a6 = a6(a7, a8)
                a6 = (a6 * 256)
                a5 = (a5 + a6)
                a6 = a4
                a7 = a1
                a8 = 8
                a6 = a6(a7, a8)
                a5 = (a5 + a6)
                -- close upvalues
                do return a5 end
                end
                local a8 -- F420
                a8 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, ...)
                a1 = UP0
                E[x] = E[x]()
                a2 = UP0
                a2 = a2()
                a3 = 1
                a4 = UPVALS[a1]
                a5 = a2
                a6 = 1
                a7 = 20
                a4 = a4(a5, a6, a7)
                a4 = (a4 * 4294967296)
                a4 = (a4 + a1)
                a5 = a7
                a6 = a2
                a7 = 21
                a8 = 31
                a5 = a5(a6, a7, a8)
                a6 = a7
                a7 = a2
                a8 = 32
                a6 = a6(a7, a8)
                a6 = (1 ^ a6)
                a6 = (-a6)
                do -- chunk @ir7
                    while true do -- repeat
                        if not (a7) then break end
                    end
                    a7 = (a6 * 0)
                    a7 = (a7 / 0)
                    a7 = (a5 - 1023)
                    a7 = (2 ^ a7)
                    a7 = (a6 * a7)
                    a8 = (a4 / 4503599627370496)
                    a8 = (a3 + a8)
                    a7 = (a7 * a8)
                    -- close upvalues
                    do return a7 end
                end
                do -- chunk @ir14
                end
                do -- chunk @ir16
                    if not ((a4 ~= 0)) then
                        a7 = (a6 * 0)
                        -- close upvalues
                        do return a7 end
                    end
                    a5 = 1
                    a3 = 0
                end
                do -- chunk @ir54
                    a7 = (a4 == 0)
                    a7 = (a6 * 1)
                    a7 = (a7 / 0)
                end
                end
                local function a9(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F432
                a1 = 1
                a2 = UP0
                a2 = a2()
                a3 = 1
                do -- for-in loop
                end
                do -- chunk @ir1
                    a15 = UP2
                    E[x] = E[x]()
                    a15 = a5[a15]
                    a15 = UP1
                    a16 = UP2
                    a16 = a16()
                    a17 = UP2
                    a17(a18..a18)  -- multret
                    a15 = a15(a16..top)
                    a5[a14] = a15
                    a14 = UP0
                    a14 = a14()
                    a15 = UP2
                    a15 = a15()
                    if (not a15) then
                        a5[a14] = a15
                        a14 = a8
                        a15 = UP2
                        a15 = a15()
                        a16 = UP0
                        a16(a17..a17)  -- multret
                        a14 = a14(a15..top)
                        a15 = {} -- size 1
                        a16 = UP2
                        a16 = a16()
                        a17 = UP0
                        a17(a18..a18)  -- multret
                        -- table.move range
                        a5[a14] = a15
                    end
                    a15 = UPVALS[a2]
                    a15 = a15()
                end
                do -- chunk @ir9
                    a1 = UP1
                    a2 = UP2
                    a2 = a2()
                    a3 = UP0
                    a3(a4..a4)  -- multret
                    -- close upvalues
                    do return a1(a2..top) end
                end
                do -- chunk @ir21
                    a10 = 0
                    a11 = 255
                    a12 = 1
                    do -- for-in loop
                    end
                end
                do -- chunk @ir26
                    while true do
                        a5 = {}
                        a6 = 0
                        a7 = 255
                        a8 = 1
                    end
                end
                do -- chunk @ir29
                    while true do
                        a11 = a11(a12..top)
                        a5[a10] = a11
                        a10 = UP1
                        a11 = UP0
                        a11 = a11()
                        a12 = UP0
                        a12(a13..a13)  -- multret
                        a10 = a10(a11..top)
                        a11 = UPVALS[a1]
                        a12 = UP0
                        a12 = a12()
                        a13 = UP0
                        a13(a14..a14)  -- multret
                        a11 = a11(a12..top)
                        a5[a10] = a11
                    end
                end
                do -- chunk @ir29
                    a13(a14..a14)  -- multret
                end
                do -- chunk @ir37
                    a6 = 1
                    a7 = UP0
                    a7 = a7()
                    a8 = 1
                end
                do -- chunk @ir69
                    a10 = UP1
                    a11 = UP0
                    a11 = a11()
                    a12 = UP0
                    a12(a13..a13)  -- multret
                    a10 = a10(a11..top)
                    a11 = UP1
                end
                do -- chunk @ir73
                    a14 = UP0
                    a14 = a14()
                    a14 = UP2
                    a14 = a14()
                end
                do -- chunk @ir97
                    while true do
                        a12 = a12()
                        a13 = UP0
                    end
                end
                do -- chunk @ir97
                    a12 = UP0
                end
                end
            a10 = a9
            a10 = a10()
            if not ((not a10)) then
                a10 = a9
                a10()  -- multret
            end
            do return  end
            end
        a1()  -- multret
        L0, a1, a2, a3, a4 = nil
        -- opaque op 125 (instr 10)
        a1 = 2
        L0 = L0[a1]
        a1 = {}
        a2 = 1
        a3 = (#L0)
        a4 = 1
        do -- for-in loop
        end
        do -- chunk @ir26
            while true do
            end
            L0[L5] = a1
        end
        end
        a10 = 80
        a121 = a84
        a122 = UP0
        a122 = a122()
        a123 = a119[14]
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[9]
        a101[70] = a127
        a121 = a84
        a122 = UP0
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir242
        a121 = a1[5]
        a122 = a1[5]
        a123 = a1[5]
        a124 = 71
    end
    do -- chunk @ir249
        if not ((a117 >= 188)) then
            if not ((36 >= a117)) then
                a118 = a56
        local function a119(a1, a2, a3, ...) -- F114
        a1 = UP0
        a2 = 1468268675
        a1(a2)  -- multret
        a1 = UP0
        a2 = a39
        a1(a2)  -- multret
        -- close upvalues
        do return  end
        end
                a118 = a118(a119)
                a113 = a118
            end
        end
        a118 = a83
        a119 = a113
        a119 = a119()
        a120 = 1468268675
        a121 = a1[26]
        a118(a119..a122)  -- multret
        a118 = a83
        a119 = a113
        a119 = a119()
        a120 = a112
        a121 = a1[26]
        a118(a119..a122)  -- multret
        -- close upvalues
        a10 = 7
        a68 = a34
        a69 = 2048
        a68 = a68(a69)
        a66 = a68
        a10 = 31
    end
    do -- chunk @ir251
        -- folded: if (41 >= a10) then
            if (114 >= a10) then
                -- folded: if not ((a10 >= 41)) then
                    a36 = a1[37]
                    a10 = 114
            else
                a40 = a1[36]
            end
    end
    do -- chunk @ir253
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[37]
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir257
        a118 = a91
        a119 = a19
        a120 = {}
        a120[2728713478] = 1541303681
        a120[901450932] = 1153969210
        a120[889552922] = 784453481
        a118(a119, a120)  -- multret
        a10 = 57
        a118 = a91
        a119 = a49
        a120 = {}
        a120[410403160] = 452019009
        a120[749373828] = 168960940
        a120[2260094527] = 595074863
        a120[1939539207] = 1070924627
        a120[2267345195] = 659079966
        a118(a119, a120)  -- multret
        a118 = a91
        a119 = a4
        a120 = {}
    end
    do -- chunk @ir263
        -- folded: if not ((a10 >= 119)) then
            a102 = a97
            a103 = a60
            a104 = a1[102]
            a102(a103, a104)  -- multret
            a10 = 65
    end
    do -- chunk @ir268
        a120 = 13
        a121 = a84
        a122 = a119[58]
        a123 = UP0
        a123 = a123()
        a124 = 2
        a121(a122..a125)  -- multret
    end
    do -- chunk @ir272
        if (31 >= a120) then
            a120 = 114
            a121 = a84
            a122 = UP0
            a122 = a122()
            a123 = a119[11]
            a124 = 1
            a121(a122..a125)  -- multret
        else
            a120 = 116
            a121 = a84
            a122 = UP0
            a122 = a122()
            a123 = a119[34]
            a124 = 2
            a121(a122..a125)  -- multret
        end
    end
    do -- chunk @ir277
        while true do
        end
        -- folded: if (a120 > 47) then
            a121 = a119[48]
            a101[48] = a22
            a120 = 57
        local function a88(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, ...) -- F463
        a4 = a2
        a5 = UP0
        a6 = UP1[5]
        a7 = 93
        -- folded: if not ((93 > a7)) then
            a6 = UP1[5]
            a7 = 24
            a9 = 24
            a10 = 237
            a11 = 108
            do -- for-in loop
                while true do
                    a9 = a4
                    a6 = UP3
                end
            end
        a8 = a5
        a9 = a4
        a10 = ...  -- varargs fill (multret)
        a8, a9, a10 = a8()
        a5 = a8
        a4 = a9
        a6 = UP2
        a8 = UP1[5]
        a8 = a5
        do -- chunk @ir8
            do -- for-in loop
            end
            L449 = UP120[nil]
            a8 = a1
            a10 = a6
            a11 = a8
            a12 = a9
            a10(a11, a12)  -- multret
        end
        do -- chunk @ir11
            a13 = a6
            a14 = a8
            a13(a14)  -- multret
        end
        do -- chunk @ir20
            while true do
            end
        end
        do -- chunk @ir20
            do return  end
        end
        end
        a10 = 48
        a129 = a1[121]
        a129 = a128[a129]
        a129 = (a129 * 100)
        a129 = (a129 // 1)
        a101[89] = a105
        a129 = a119
        a130 = a1[121]
        a130 = a128[a130]
        a131 = a1[26]
        a129(a130, a131)  -- multret
        a129 = 6
        a130 = 231
        a131 = 117
        a10 = 54
        a125 = a84
        a126 = UP0
        a126 = a126()
        a127 = a119[18]
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir277
        a126 = a1[122]
        a126 = a125[a126]
        a126 = a126[0]
        a126 = (a126 * 100)
        a126 = (a126 // 1)
        a101[84] = a126
        a126 = a119
        a127 = a1[122]
        a127 = a125[a127]
        a128 = a1[120]
        a127 = a127[a128]
        a128 = a1[26]
        a126(a127, a128)  -- multret
        a127 = a123; a126 = a123["GetPositionOnCurve"]
        a128 = 0.2857142984867096
        a125 = a119[49]
        a101[78] = a5
        a125 = a83
    end
    do -- chunk @ir281
        if (a120 ~= 99) then
        else
            a118 = {}
        local function a119(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, ...) -- F30
        a3 = UP0[5]
        a4 = 4
        a3 = UP1
        a4 = 19
        a10 = UP0[5]
        a11 = 40
        a12 = 246
        a13 = 107
        do -- for-in loop
            while true do -- repeat
                if not ((a14 >= 147)) then break end
            end
        end
        a6 = UP2
        do -- chunk @ir1
            a6 = UP4
        end
        do -- chunk @ir3
            a5 = (a5 + a6)
            a8 = 100
        end
        do -- chunk @ir7
            -- close upvalues
            do return  end
        end
        do -- chunk @ir9
            a8 = a8[a9]
            a10 = a6
            a11 = a8
            a10(a11)  -- multret
            a6 = UPVALS[a5]
            a10 = 2
            a11 = 30
            a12 = 7
            do -- for-in loop
            end
        end
        do -- chunk @ir10
            a8 = a7
        end
        do -- chunk @ir12
            a9 = UP0[26]
            while true do
                a6[a8] = a9
                a10 = 51
                a11 = 245
                a12 = 97
            end
            a8 = a3
            a4 = 100
            -- folded: if not ((98 >= a4)) then
                a9 = UP0[26]
        end
        do -- chunk @ir14
            a8 = UP5
        end
        do -- chunk @ir33
            if (a13 ~= 9) then
                a8 = a3
            else
                a9 = L0
                a6[a8] = a9
            end
        end
        do -- chunk @ir35
            a6 = (a6 // a8)
            a10 = 68
            a11 = 83
            a12 = 15
            do -- for-in loop
            end
        end
        do -- chunk @ir41
            while true do
                a6 = UPVALS[a5]
                a4 = 89
                a7 = (a7 - a5)
            end
        end
        do -- chunk @ir41
            a5 = a3
            a8 = UP0[5]
            a9 = UP0[5]
            a10 = 112
            a11 = 463
            a12 = 71
            a6 = 1
        end
        do -- chunk @ir43
            a13 = 70
            a14 = 21
            do -- for-in loop
            end
        end
        do -- chunk @ir46
            while true do -- repeat
                if not ((a15 ~= 28)) then break end
            end
        end
        do -- chunk @ir47
            a8 = 2
            a8 = 61
            a9 = 175
            a10 = 57
            do -- for-in loop
            end
        end
        do -- chunk @ir48
            a8 = a5
        end
        do -- chunk @ir50
        end
        do -- chunk @ir52
            a8 = 1
            a1 = a6
        end
        do -- chunk @ir58
            a6 = a2
        end
        do -- chunk @ir60
            a9 = UP0[5]
            while true do
                a8 = a63
                a11 = UP0[5]
                a12 = 7
                a19 = a10
                a16(a17..a20)  -- multret
            end
        end
        do -- chunk @ir78
            a6 = UP5
            a4 = 48
            a6 = (a6 + a8)
        end
        do -- chunk @ir84
        end
        do -- chunk @ir90
            a6 = (a6 * a8)
            a11 = 231
            a12 = 71
            while true do -- repeat
                if not ((a13 ~= 254)) then break end
            end
            a9 = true
        end
        do -- chunk @ir92
            -- folded: if (a13 ~= 69) then
                a6[a8] = a9
        end
        do -- chunk @ir103
            a11 = UP4
            a16 = a6
            a17 = a8
            a18 = a11
        end
        do -- chunk @ir116
            a9 = a1
            a11 = 213
            a12 = 91
            while true do
            end
        end
        do -- chunk @ir130
            a6 = a118
        end
        do -- chunk @ir138
            a6 = UP5
        end
        do -- chunk @ir145
        end
        do -- chunk @ir147
            a9 = UP0[5]
            a6[a8] = a9
        end
        do -- chunk @ir163
            a4 = 98
            a6[a8] = a9
        end
        do -- chunk @ir182
            a6 = a1
        end
        do -- chunk @ir199
            a6 = UP5
            a8 = a5
            a10 = 69
            a5 = 1
            a6 = UP0[5]
            a7 = UP0[5]
        end
        do -- chunk @ir220
            UP4 = a6
        end
        do -- chunk @ir262
            a6[a8] = a9
            a6 = UP5
            a10 = 17
        end
        end
            a120 = a1[5]
            a121 = a1[5]
            a122 = 94
        end
        a123 = a123()
        a124 = 2
        a121(a122..a125)  -- multret
    end
    do -- chunk @ir291
        a116 = a112
        a117 = a17
        a116(a117)  -- multret
        a116 = a112
        a117 = a18
        a116(a117)  -- multret
        a10 = 115
    end
    do -- chunk @ir301
        a121(a122..a125)  -- multret
        a121 = a118[10]
        a101[13] = a121
        a121 = a84
        a122 = UP0
        a122 = a122()
        a123 = a118[10]
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a118[4]
        a101[14] = a40
        a121 = a84
        a122 = a118[4]
        a123 = UP0
        a123 = a123()
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a118[7]
        a101[15] = a30
        a120 = 95
    end
    do -- chunk @ir303
        a129 = 613
        a130 = a1[26]
        a127(a128..a131)  -- multret
    end
    do -- chunk @ir307
        a121 = a119[45]
        a101[59] = a84
        a120 = 90
    end
    do -- chunk @ir321
        a101(a102, a103)  -- multret
        a101 = a1[5]
        a10 = 30
    end
    do -- chunk @ir327
        if (a120 >= 21) then
        else
            a74 = a1[65]
            a75 = {}
            a76 = a1[5]
        end
    end
    do -- chunk @ir333
        a127 = 813
        a124 = a124(a125, a126, a127)
        a125 = 807
        a126 = true
        a123(a124..a127)  -- multret
        a122 = 102
        a132 = a129[4]
        a133 = 95
    end
    do -- chunk @ir343
        -- folded: if (36 >= a10) then
        a68 = a1[59]
        a10 = 29
    end
    do -- chunk @ir345
        a124 = a1[161]
        a124 = a121[a124]
        a125 = a1[161]
        a123(a124, a125)  -- multret
        a123 = a97
        a124 = a1[162]
        a124 = a121[a124]
        a125 = "NextInteger"
        a123(a124, a125)  -- multret
        a123 = a97
        a124 = a1[163]
        a124 = a121[a124]
        a125 = a1[163]
        a123(a124, a125)  -- multret
        a123 = 23
        a124 = 66
        a125 = 43
        do -- for-in loop
        end
    end
    do -- chunk @ir356
        a121 = a84
        a122 = UP0
        a122 = a122()
        a123 = a119[a119]
        a124 = 2
        a121(a122..a125)  -- multret
        a120 = 79
    end
    do -- chunk @ir360
        a89 = a1[5]
        a90 = a1[5]
        a10 = 60
    end
    do -- chunk @ir364
        a81 = a1[66]
        a10 = 11
        a127 = a119[31]
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir368
        a120 = 92
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a118[1]
        a124 = 1
        a121 = 87
        a122 = 281
        a123 = 97
        do -- for-in loop
        end
    end
    do -- chunk @ir374
        while true do
            a128 = a1[122]
            a128 = a126[a128]
            a129 = a1[120]
            a128 = a128[a129]
        end
        a124 = 2
        a121(a122..a125)  -- multret
        a120 = 78
        a121 = a84
        a122 = a119[51]
        a123 = UP0
        a123 = a123()
    end
    do -- chunk @ir374
        a122 = 119
    end
    do -- chunk @ir380
        a125 = a97
        a126 = a1[139]
        a126 = a119[a126]
        a127 = a1[139]
        a125(a126, a127)  -- multret
        a124 = 114
        a125 = a97
        a126 = a1[140]
        a126 = a119[a126]
        a127 = "PostAsync"
        a125(a126, a127)  -- multret
        a125 = a97
        a126 = a1[141]
        a126 = a119[a126]
        a127 = "RequestAsync"
        a125(a126, a127)  -- multret
        a122 = 15
        a123 = a118
        a124 = a121
        a125 = a1[124]
        a123(a124, a125)  -- multret
        a123 = a84
        a124 = a1[118]
        a124 = a121[a124]
        a125 = a120
        a126 = a1[26]
        a123(a124..a127)  -- multret
        a123 = a1[125]
        a123 = a120[a123]
        a124 = a84
        a125 = a1[118]
        a125 = a121[a125]
        a126 = a1[118]
        a126 = a121[a126]
        a127 = true
        a124(a125..a128)  -- multret
        a124 = a97
        a125 = a123
        a126 = a1[125]
        a124(a125, a126)  -- multret
        a124 = a1[5]
        a125 = 116
        a126 = 133
        a127 = 17
        do -- for-in loop
        end
    end
    do -- chunk @ir388
        if (not a119) then
        else
            a126 = a55
            a126()  -- multret
        end
    end
    do -- chunk @ir395
        a127 = a118[12]
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir399
        a126 = UP0
        a126 = a126()
        a127 = a119[38]
        a128 = 2
        a125(a126..a129)  -- multret
        a121 = 6
        a122 = 334
        a123 = 82
        a126 = a45
        a127 = UP9
        a126, a127, a128 = a126(a127..a128)
        a123 = a126
        a124 = a127
        a125 = 81
    end
    do -- chunk @ir404
        a120 = 55
        a120 = 42
        a121 = a119[26]
        a101[81] = L635
    end
    do -- chunk @ir406
        a119 = a30
        a118(a119)  -- multret
        a10 = 42
    end
    do -- chunk @ir410
        a125 = a119[36]
        a101[67] = a103
    end
    do -- chunk @ir421
        -- folded: if (a122 >= 106) then
    end
    do -- chunk @ir423
        a125 = a119[1]
        a101[31] = a125
    end
    do -- chunk @ir426
        a10 = 10
    end
    do -- chunk @ir431
        a122 = a1[169]
        a123 = L3[4]
        a122 = a122(a123)
        a121 = a121(a122)
        a122 = L3[6]
        a121 = (a121 + a122)
        a122 = L3[1]
        a121 = (a121 - a122)
        a122 = L3[7]
        a121 = (a121 + a122)
        a121 = (-7254156035 + a121)
        a122 = 1
    end
    do -- chunk @ir437
    end
    do -- chunk @ir446
        a121 = a118[9]
        a101[17] = a18
        a120 = 8
    end
    do -- chunk @ir455
        a71 = a1[63]
        a10 = 74
    end
    do -- chunk @ir458
        if not ((a124 == 252)) then
            a125 = a119[51]
            a101[33] = a27
        end
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[32]
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir462
        a120 = 66
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[17]
        a124 = 1
        a121(a122..a125)  -- multret
    end
    do -- chunk @ir470
        a132 = a1[121]
        a132 = a131[a132]
        a132 = (a132 * 100)
        a132 = (a132 // 1)
        a101[95] = a126
        a122 = 27
    end
    do -- chunk @ir474
        a133 = a133(a134, a135)
        a133 = (#a132)
        a133 = a90
        a134 = a132
        a133 = a133(a134)
        a133 = a126[a133]
        if a133 then
            a120 = (a120 + a133)
            a125 = (a125 + 1)
            if (50 >= a125) then
                if __ok131 then
                    a133 = a80
                    a134 = a1[130]
                    a135 = a13
                    a136 = a132
                    a135 = a135(a136)
                else
                    a125 = a1[153]
                    a125 = a119[a125]
                    a126 = a1[152]
                    a125 = a83
                    a126 = UP0
                    a126 = a126()
                    a127 = a118[13]
                    a128 = 2
                    a125(a126..a129)  -- multret
                    a125 = a118[6]
                end
            end
        end
    end
    do -- chunk @ir483
    end
    do -- chunk @ir485
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir488
        local function a97(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, ...) -- F313
        a4 = UP0
        a5 = a1
        a4 = a4(a5)
        a4 = UP1
        a5 = UP2
        a6 = a1
        a5 = a5(a6)
        a6 = UP3[84]
        a4(a5, a6)  -- multret
        a4 = UP4
        a5 = UP3[85]
        a6 = a88
        a7 = a1
        a8 = a60
        a4(a5..a9)  -- multret
        a4 = a95
        a5 = a1
        a6 = UP3[86]
        a4, a5, a6, a7, a8, a9, a10 = a4(a5..a7)
        a10 = UP8
        a11 = UP3[73]
        a12 = a4
        a10(a11, a12)  -- multret
        a10 = 66
        a11 = 430
        a12 = 60
        do -- for-in loop
        end
        do -- chunk @ir16
            a4 = a74
            a4()  -- multret
            -- close upvalues
            while true do -- repeat
                if not (a3) then break end
            end
            a14 = UP1
            a15 = a6
            a16 = a2
            a14(a15, a16)  -- multret
        end
        do -- chunk @ir22
            a14 = UP1
            a15 = 0
            a16 = a7
            a14(a15, a16)  -- multret
            a14 = UP1
            a15 = UP3[26]
            a16 = a8
            a14(a15, a16)  -- multret
        end
        do -- chunk @ir27
        end
        do -- chunk @ir29
            a14 = UPVALS[a1]
            a15 = a1
            a16 = a9
            a14(a15, a16)  -- multret
        end
        do -- chunk @ir34
            while true do
                a14 = 65
            end
            a14 = UP9
        end
        do -- chunk @ir34
            a15(a16, a17)  -- multret
        end
        do -- chunk @ir55
        end
        do -- chunk @ir57
            a15 = UP1
            a16 = a85
            a17 = a1
            a16 = a16(a17)
            a17 = UP3[26]
        end
        do -- chunk @ir66
            a15 = UP1
            a16 = UP3[25]
            a17 = a71
            a18 = a1
            a17(a18..a19)  -- multret
            a15(a16..top)  -- multret
        end
        do -- chunk @ir105
            a14 = 106
        end
        end
        a99 = a97
        a100 = a48
        a101 = a1[87]
        a99(a100, a101)  -- multret
        a10 = 32
    end
    do -- chunk @ir490
        a128 = a117
        a129 = a1[119]
        a128 = a128(a129)
        a123 = a128
    end
    do -- chunk @ir494
        a113 = a112
        a114 = a57
        a115 = -19393
        a113(a114, a115)  -- multret
        a113 = a1[5]
        a10 = 107
        a118 = a112
        a119 = a94
        a118(a119)  -- multret
        a118 = a112
        a119 = a51
        a118(a119)  -- multret
        a118 = a112
        a119 = a99
        a118(a119)  -- multret
        a118 = a97
        a119 = a117
        a120 = a1[82]
        a118(a119, a120)  -- multret
        a118 = a112
        a119 = a117
        a120 = a1[5]
        a118(a119, a120)  -- multret
        a10 = 43
    end
    do -- chunk @ir498
        a123 = UP2
        a123 = a123()
        a120 = bit32.bxor(a123, 1180920661)
        a10 = 68
    end
    do -- chunk @ir504
        a121 = a83
        a122 = UP0
        a122 = a122()
        -- folded: if (a10 >= 46) then
            -- folded: if not ((a10 >= 75)) then
                if not ((46 >= a10)) then
                    a127 = a59
                    a128, a129 = nil
                    -- generic-for iterator (coroutine desugar) reg R127
                    a125 = a119[24]
                    a101[24] = a52
                    a125 = a84
                    a126 = UP0
                end
        a121 = a121(a122)
        a121 = (-26 + a121)
        a122 = 1
        do -- for-in loop
        end
    end
    do -- chunk @ir510
    end
    do -- chunk @ir517
        a121(a122..a125)  -- multret
        a121 = a119[10]
        a101[65] = a85
    end
    do -- chunk @ir527
    end
    do -- chunk @ir529
        if not ((a120 ~= 78)) then
            a121 = a119[42]
            a101[34] = L186
            a121 = a83
            a122 = UP0
            a122 = a122()
            a123 = a119[42]
            a124 = 1
            a121(a122..a125)  -- multret
            a121 = a119[53]
            a101[35] = L551
            a121 = a83
            a122 = UP0
            a122 = a122()
            a123 = a119[53]
            a124 = 1
            a121(a122..a125)  -- multret
            a121 = 111
            a125 = a119[31]
            a101[29] = a106
            a125 = a83
            a126 = UP0
            a126 = a126()
        end
    end
    do -- chunk @ir544
        while true do
            a134 = a1[122]
            a134 = a128[a134]
            a135 = a1[26]
            a133(a134, a135)  -- multret
        end
    end
    do -- chunk @ir544
        a133 = a119
    end
    do -- chunk @ir552
        a101 = a97
        a102 = a2
        a103 = a1[95]
        a101(a102, a103)  -- multret
        a101 = a97
        a102 = a3
        a103 = a1[96]
        local function a78(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, ...) -- F329
        a3 = UP0
        a4 = a50[5]
        a5 = 38
        do -- chunk @ir1
            if not ((a8 ~= 9)) then
                a3 = UP5
                a4 = 1
                a3 = (a3 + a4)
                UP5 = a3
                while true do -- repeat
                    if not ((not a3)) then break end
                end
                a6 = a50[5]
                a7 = 88
                a8 = 139
                a9 = 51
                a6 = a3
                a7 = a4
                a6 = a6(a7)
                a3 = a6
                if (not a3) then
                    a3 = a2
                end
            end
            a9 = a3
            a10 = a4
            a11 = a7
            a12 = a6
            a9(a10..a13)  -- multret
            a8 = 9
        end
        do -- chunk @ir11
            a5 = 77
            a4 = a1
            while true do
            end
            a3 = UP3
        end
        do -- chunk @ir14
        end
        do -- chunk @ir16
            a3 = UP2
        end
        do -- chunk @ir19
            a4 = UP4
            a7 = UP5
            a8 = 82
        end
        do -- chunk @ir38
            a10 = a3
            a10()  -- multret
            do -- for-in loop
            end
        end
        do -- chunk @ir41
            a6 = 1
        end
        do -- chunk @ir74
            a6 = 61
            a7 = 254
            a8 = 92
        end
        end
        a10 = 50
        a133 = a126
        a134 = a122
        a133 = a133(a134)
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir562
        a123 = a123()
        a124 = 2
        a121(a122..a125)  -- multret
    end
    do -- chunk @ir574
        a125 = a119[39]
        a101[68] = a64
    end
    do -- chunk @ir577
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[39]
        a128 = 1
        a125(a126..a129)  -- multret
        a125 = a119[14]
        a101[69] = a42
        a111 = a1[5]
        a116 = a43
        local function a117(a1, a2, a3, ...) -- F246
        do -- chunk @ir2
            while true do
                E[x] = E[x]()
                UP0 = a1
                do return  end
            end
        end
        do -- chunk @ir2
            a1 = a111
        end
        end
        a116(a117)  -- multret
    end
    do -- chunk @ir581
        a104 = a97
        a105 = a22
        a106 = a1[22]
        a104(a105, a106)  -- multret
        a10 = 97
        a123 = a83
        a124 = a1[68]
        a125 = a13
        a126 = L3
        a125 = a125(a126)
        a126 = a1[26]
        a123(a124..a127)  -- multret
    end
    do -- chunk @ir585
    end
    do -- chunk @ir594
        a28 = a1[25]
        a29 = a1[26]
        a27[a28] = a29
        a28 = a1[26]
        a29 = a1[25]
        a27[a28] = a29
        a28 = a1[27]
        a29 = a1[28]
        a29 = a9[a29]
        a30 = a1[5]
        a31 = a1[5]
        a32 = a1[5]
        a10 = 91
        a33 = a1[31]
        a32 = a6[a33]
        local function a33(a1, a2, a3, a4, a5, a6, a7, ...) -- F487
        a2 = UP0[5]
        a3 = UP0[5]
        a4 = 96
        do -- chunk @ir1
            a4 = 63
            a2 = a1
            while true do
                a3 = UPVALS[a1]
                a2 = (not a2)
                a3 = a3[a2]
                a5 = a3
                -- close upvalues
                do return a5 end
            end
        end
        do -- chunk @ir4
        end
        end
        a34 = a1[31]
        a34 = a20[a34]
    end
    do -- chunk @ir599
        a119 = a1[5]
        a120 = a1[5]
        a121 = 86
    end
    do -- chunk @ir616
        a130 = (a130 * 100)
        a130 = (a130 // 1)
        a101[92] = a6
    end
    do -- chunk @ir627
    end
    do -- chunk @ir630
        a135 = 0.20000000298023224
        a133 = a133(a134, a135)
        a128 = a133
    end
    do -- chunk @ir634
        a124 = a89
        a125 = a119
        a124(a125)  -- multret
    end
    do -- chunk @ir638
        a111 = a41
        a112 = a43
        local function a113(a1, a2, ...) -- F154
        a1 = UP0
        a1()  -- multret
        -- close upvalues
        do return  end
        end
        a112 = a112(a113)
        a111(a112)  -- multret
        a10 = 81
    end
    do -- chunk @ir639
    end
    do -- chunk @ir650
        a114 = a112
        a115 = a60
        a116 = -31710
        a114(a115, a116)  -- multret
        a10 = 78
    end
    do -- chunk @ir656
        a132 = a1[122]
        a132 = a131[a132]
        a132 = (a132 * 100)
        a132 = (a132 // 1)
        a101[96] = L609
        a132 = a1[5]
        a133 = 69
        a134 = 491
        a135 = 125
        while true do
            a126 = 0
            a127 = 0
            a123 = a123(a124, a125, a126, a127)
            a121["Position"] = L212
            a123 = a1[117]
            a124 = a114
            a125 = 0
            a126 = 144
            a127 = 0
        end
        a112 = 1188220356
        a125 = a118[15]
        a101[3] = a14
    end
    do -- chunk @ir665
        a121 = L3[4]
        a121 = L3[2]
        a121 = (-2535928120 + a121)
        a122 = 1
        do -- for-in loop
        end
    end
    do -- chunk @ir669
        a122 = a122(a123)
        a123 = a1[26]
        a120(a121..a124)  -- multret
        a120 = a1[5]
        a121 = 67
        a122 = 99
        a123 = 16
        do -- for-in loop
        end
    end
    do -- chunk @ir671
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[7]
        a128 = 2
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir682
        a55 = nil
        a56 = a1[5]
        a10 = 110
    end
    do -- chunk @ir686
        a139 = 0
        a140 = 0
        a141 = 0
        a137 = a137(a138, a139, a140, a141)
        a138 = a114
        a139 = 0
        a140 = -7
        a141 = 0
        a142 = 2
        a138(a139..a143)  -- multret
        a135()  -- multret
        -- table.move range
        a128(a129, a130)  -- multret
        a125 = a123; a124 = a123["GetLength"]
        a124 = a124(a125)
        a125 = (a124 * 100)
        a125 = (a125 // 1)
        a101[82] = a111
        a125 = a1[5]
        a122 = 80
    end
    do -- chunk @ir694
        a125 = a119[38]
        a101[30] = a50
        a125 = a84
    end
    do -- chunk @ir723
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[40]
        a128 = 1
        a125(a126..a129)  -- multret
    end
    do -- chunk @ir730
        a121 = a83
        a122 = UP0
        a122 = a122()
        a123 = a119[27]
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[50]
        a101[42] = a110
        a120 = 7
    end
    do -- chunk @ir731
        a73 = a1[60]
    end
    do -- chunk @ir737
        a101[22] = a69
        a120 = 89
    end
    do -- chunk @ir749
        while true do
            a131 = a127
            a132 = a129
            a133 = a1[26]
            a130(a131..a134)  -- multret
            a125 = 1
        end
    end
    do -- chunk @ir749
        a130 = a84
    end
    do -- chunk @ir757
        a121 = a119; a120 = a119["Destroy"]
        a120(a121)  -- multret
        a120 = a1[a1]
        a121 = a1[5]
        a122 = 14
    end
    do -- chunk @ir758
        a125 = a119[15]
        a101[76] = a124
    end
    do -- chunk @ir796
    end
    do -- chunk @ir802
        if (a122 ~= 63) then
            a124 = 1
            a125 = a123
            a126 = 1
            do -- for-in loop
            end
        else
            a122 = 18
            a125 = a121; a124 = a121["NextInteger"]
            a126 = 181
            a127 = 605
            a124 = a124(a125, a126, a127)
            a123 = (a124 % 24)
        end
        a125 = a83
        a126 = UP0
        a126 = a126()
        a127 = a119[59]
        a128 = 1
        a125(a126..a129)  -- multret
        a125 = a119[18]
        a101[73] = a96
    end
    do -- chunk @ir805
        a125 = 0
        a126 = a1[5]
        a127 = 54
        a128 = 98
        if __ok127 then
            a122 = (a122 + 1)
            a99 = a1[5]
            a10 = 7
        end
    end
    do -- chunk @ir813
        a121 = a119[47]
        a101[45] = a58
        a120 = 29
        a121 = a83
    end
    do -- chunk @ir819
        a121 = a119[62]
        a101[54] = a53
        a121 = a84
        a122 = a119[62]
        a123 = UP0
        a123 = a123()
        a124 = 1
        a121(a122..a125)  -- multret
    end
    do -- chunk @ir835
        a125 = a119[11]
        a101[25] = a102
    end
    do -- chunk @ir842
        a17 = a1[12]
        a12 = a5[a17]
        a13 = a1[13]
        a17 = a1[14]
        a14 = a5[a17]
        a10 = 92
    end
    do -- chunk @ir868
    end
    do -- chunk @ir874
        -- folded: if not ((8 >= a10)) then
            -- folded: if not ((a10 >= 102)) then
                a8 = 6666
                a10 = 8
                a125 = a84
                a126 = UP0
                a126 = a126()
                a127 = a118[5]
                a128 = 2
                a125(a126..a129)  -- multret
                a120 = a119
                a122 = 21
                a115 = a127
                a119 = a1[5]
                a120 = 14
                a121 = 79
                a122 = 2
                a99[a100] = a101
                a100 = a1[81]
                a101 = a1[26]
                a99[a100] = a101
                a96 = a99
                a10 = 5
        a6 = a1[7]
        a11 = a1[8]
        a7 = a5[a11]
        do -- for-in loop
        end
    end
    do -- chunk @ir876
        a124 = UP2
        a124()  -- multret
    end
    do -- chunk @ir883
        a131 = a123; a130 = a123["GetPositionOnCurveArcLength"]
        a132 = 0.4000000059604645
        a130 = a130(a131, a132)
        a131 = a130[0]
        a132 = a1[120]
        a131 = a131[a132]
        a131 = (a131 * 100)
        a131 = (a131 // 1)
    end
    do -- chunk @ir890
        a125 = 0.9787031188959563
        a126 = a1[26]
        a123(a124..a127)  -- multret
        a123 = a83
        a125 = a121; a124 = a121["NextNumber"]
        a124 = a124(a125)
        a125 = 0.5760869541013449
        a126 = a1[26]
        a123(a124..a127)  -- multret
        a123 = a1[5]
        a122 = 63
    end
    do -- chunk @ir894
        a125 = a84
        a126 = a123[a121]
        a127 = a120
        a128 = a1[26]
        a125(a126..a129)  -- multret
        a124 = 92
        a121 = a118
        a122 = a119
        a123 = a1[142]
        a121(a122, a123)  -- multret
        a120 = 61
        a121 = a83
        a122 = a113
        a123 = a1[118]
        a123 = a119[a123]
        a124 = a1[26]
        a121(a122..a125)  -- multret
        a121 = a97
        a122 = a1[a1]
        a122 = a119[a122]
        a123 = a1[143]
        a121(a122, a123)  -- multret
        a121 = a97
        a122 = a1[144]
        a122 = a119[a122]
        a123 = a1[144]
        a121(a122, a123)  -- multret
        a121 = 31
        a122 = 39
        a123 = 8
    end
    do -- chunk @ir918
        a102 = a97
        a103 = a57
        a104 = a1[101]
        a102(a103, a104)  -- multret
        a10 = 106
    end
    do -- chunk @ir920
        a104 = a97
        a105 = a23
        a106 = a1[18]
        a104(a105, a106)  -- multret
        a104 = a97
        a105 = a32
        a106 = a1[31]
        a104(a105, a106)  -- multret
        a104 = a1[5]
        a105 = a1[5]
        a10 = 76
    end
    do -- chunk @ir932
    end
    do -- chunk @ir936
        a122 = 0
    end
    do -- chunk @ir950
        a111 = a76
        a112 = (a93 % 256)
        a112 = (a93 - a112)
        a112 = (a112 / 256)
        a111(a112)  -- multret
        a10 = 77
    end
    do -- chunk @ir955
        a121 = (a121 - a122)
        a122 = L3[1]
        a121 = (a121 - a122)
        a122 = L3[7]
        a121 = (a121 ~= a122)
        if (not a121) then
        end
        a101[11] = a9
        a41 = a1[33]
        a39 = a6[a41]
        a10 = 116
    end
    do -- chunk @ir959
        a125 = a119[32]
        a101[32] = a26
    end
    do -- chunk @ir968
        a125 = a84
        a127 = a123; a126 = a123["FromValue"]
        a128 = a122
        a126 = a126(a127, a128)
        a127 = a120
    end
    do -- chunk @ir971
        a126(a127, a128)  -- multret
    end
    do -- chunk @ir973
        if not ((a119 >= 78)) then
            a119 = 107
            a120 = 1
            a121 = a1[169]
        end
        a120 = 1
        a121 = L3[6]
        a122 = L3[1]
        a121 = (a121 - a122)
        a122 = L3[7]
        a121 = (a121 + a122)
        a122 = L3[2]
    end
    do -- chunk @ir979
        a119 = a1[5]
        a120 = 19
    end
    do -- chunk @ir987
        a106 = a1[104]
        a104 = a19[a106]
        a10 = 94
        a116 = a112
        a117 = a18
        a116(a117)  -- multret
        a10 = 70
    end
    do -- chunk @ir1001
        if (a10 ~= 40) then
        else
            a118 = a112
            a119 = a56
            a118(a119)  -- multret
            a118 = a112
        end
    end
    do -- chunk @ir1018
        if not ((33 >= a115)) then
            a116 = a50
            a117 = a45
            a118 = a41
            a119 = a111
        end
    end
    do -- chunk @ir1032
        a132 = 43
        a133 = bit32.bxor(a127, 64)
        a134 = a16
        a135 = a127
        a134 = a134(a135)
        a100[a133] = a134
        a133 = 47
        a134 = a36
        a135 = a131
        a136 = a126
        a134(a135, a136)  -- multret
        a101 = a97
        a102 = a37
        a103 = a1[56]
        a101(a102, a103)  -- multret
        a10 = 123
    end
    do -- chunk @ir1034
        if not ((111 >= a124)) then
            a125 = a84
            a126 = a119[15]
            a127 = UP0
            a127 = a127()
            a128 = 1
            a125(a126..a129)  -- multret
            a121 = 67
            a122 = 172
            a123 = 35
            while true do
                a128 = 2
                a125(a126..a129)  -- multret
            end
        end
        a125 = a84
        a126 = a119[44]
        a127 = UP0
        a125 = a97
        a126 = a1[157]
        a126 = a123[a126]
        a127 = "FromValue"
        a125(a126, a127)  -- multret
        a125 = a112
        a126 = a123[0]
        a125(a126)  -- multret
        a125 = a112
        a126 = a1[157]
        a126 = a123[a126]
        a125(a126)  -- multret
        a124 = 50
    end
    do -- chunk @ir1036
        a121 = a118[14]
        a101[16] = a66
        a120 = 105
    end
    do -- chunk @ir1045
        a124 = a83
        a125 = a113
        a126 = a1[118]
        a126 = a119[a126]
        a127 = a1[26]
        a124(a125..a128)  -- multret
        a124 = 31
    end
    do -- chunk @ir1050
        a131[328532366] = L602
        a131[1929211092] = L260
        a131[440669232] = L638
        a131[1011881004] = L273
        a131[2267675775] = L394
        a131[1132109174] = L447
        a131[2571219683] = L495
        a131[236808915] = L618
    end
    do -- chunk @ir1063
        a125 = a119[27]
        a101[41] = a81
    end
    do -- chunk @ir1066
        a125 = a83
        a126 = a52
        a127 = a123
        a126 = a126(a127)
        a127 = a1[156]
        a128 = a1[26]
        a125(a126..a129)  -- multret
        a124 = 110
        a120 = 86
        a122 = a113; a121 = a113["GetService"]
        a123 = a1[142]
    end
    do -- chunk @ir1073
        a140 = -9
        a136 = a136(a137, a138, a139, a140)
        a137 = a114
        a138 = 0
    end
    do -- chunk @ir1080
        while true do -- repeat
            if not ((a122 >= 120)) then break end
        end
        a122 = 106
        a128 = a119
        a129 = a1[122]
        a129 = a126[a129]
        a130 = a1[120]
        a129 = a129[a130]
        a130 = a1[26]
        a128(a129, a130)  -- multret
    end
    do -- chunk @ir1081
        a114 = a112
        a115 = a13
        a114(a115)  -- multret
        a114 = a112
        a115 = a40
        a114(a115)  -- multret
        a10 = 81
    end
    do -- chunk @ir1084
        a121 = a119[34]
        a101[26] = a112
        a120 = 41
    end
    do -- chunk @ir1101
        a121 = a84
        a122 = a119[6]
        a123 = UP0
        a123 = a123()
        a124 = 2
        a121(a122..a125)  -- multret
        a121 = a119[33]
        a101[63] = a121
        a121 = a84
        a122 = UP0
        a122 = a122()
        a123 = a119[33]
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a119[19]
        a101[64] = a120
        a121 = a84
        a122 = UP0
        a122 = a122()
        a123 = a119[19]
        a124 = 2
        a132 = a137
    end
    do -- chunk @ir1105
        a121 = 53
        a122 = 233
        a123 = 29
        do -- for-in loop
        end
    end
    do -- chunk @ir1110
        while true do
            a126 = (a126 // 1)
            a101[83] = a104
        end
    end
    do -- chunk @ir1110
        a126 = (a126 * 100)
    end
    do -- chunk @ir1114
    end
    do -- chunk @ir1137
        while not ((43 >= a122)) do -- while-exit-cond
            a119 = 4
            a120 = 0
            a122 = 43
            a123 = 0
            a124 = (a120 - 1)
            a125 = 1
        end
        a119 = 60
        a120 = 1
        a121 = a1[166]
        a122 = a1[167]
        a123 = a1[168]
        a124 = L3[2]
        a125 = L3[2]
        a124 = (a124 + a125)
        a125 = L3[1]
        a124 = (a124 + a125)
        a123 = a123(a124)
        a122 = a122(a123)
    end
    do -- chunk @ir1150
        a123 = a118[7]
        a124 = 2
        a121(a122..a125)  -- multret
        a120 = 50
    end
    do -- chunk @ir1158
        a129 = a112
        a130 = a123
        a131 = a1[5]
        a129(a130, a131)  -- multret
    end
    do -- chunk @ir1176
    end
    do -- chunk @ir1178
    end
    do -- chunk @ir1200
        a122 = a13
        a123 = a120
        a122 = a122(a123)
    end
    do -- chunk @ir1212
    end
    do -- chunk @ir1238
        a126 = a1[121]
        a126 = a125[a126]
        a127 = a1[120]
        a126 = a126[a127]
    end
    do -- chunk @ir1243
        a131 = a131[a132]
        a132 = a1[26]
        a130(a131, a132)  -- multret
    end
    do -- chunk @ir1247
        local function a111(a1, a2, a3, a4, a5, a6, ...) -- F56
        a2 = (a1 + 3)
        a3 = UP0
        a4 = a2
        a5 = "f"
        a3 = a3(a4, a5)
        -- close upvalues
        do return a3 end
        end
        a10 = 3
    end
    do -- chunk @ir1252
        a133 = a1[122]
        a133 = a128[a133]
        a133 = (a133 * 100)
        a133 = (a133 // 1)
        a101[90] = L466
    end
    do -- chunk @ir1271
        a123 = a84
        a124 = a13
        a125 = L3[a122]
        a124 = a124(a125)
        a125 = a1[159]
        a123(a124, a125)  -- multret
    end
    do -- chunk @ir1284
        a120 = 47
        a121 = a119[17]
        a101[47] = a21
    end
    do -- chunk @ir1298
        while true do
        end
        a122 = 59
        a123 = a83
        a125 = a121; a124 = a121["NextNumber"]
        a124 = a124(a125)
    end
    do -- chunk @ir1301
        a120 = 107
    end
    do -- chunk @ir1323
        local function a83(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, ...) -- F94
        a4 = UP0
        a5 = a1
        a6 = UP1[5]
        a7 = 26
        a8 = 107
        a9 = 27
        do -- chunk @ir1
            if (4 >= a11) then
                if not ((a11 >= 121)) then
                    if not ((2 >= a11)) then
                        a5 = (a5 == a6)
                        a5 = a1
                        a4 = a5
                        a5 = UP2
                        a12 = UP1[5]
                        a13 = UP1[5]
                        a11 = 51
                        -- folded: if (51 >= a11) then
                    end
                end
            end
        end
        do -- chunk @ir4
            a4 = 1
            a11 = 2
            a12 = 82
            a13 = 106
            a14 = 24
            do -- for-in loop
            end
        end
        do -- chunk @ir7
            a5 = a3
        end
        do -- chunk @ir11
            while not ((not a4)) do -- while-exit-cond
            end
            a4 = a5
        end
        do -- chunk @ir18
            a5 = (a5 == a6)
            if not ((not a5)) then
                a12 = 107
                a13 = 288
                a14 = 125
            end
        end
        do -- chunk @ir23
            a14 = a5
            a15 = a6
            a16 = a12
            a17 = a13
            a14(a15..a18)  -- multret
            a14 = 112
            a15 = 116
            a16 = 2
            while true do
            end
            a5 = UP3
        end
        do -- chunk @ir34
            a5 = a2
        end
        do -- chunk @ir37
            -- close upvalues
            do return  end
        end
        do -- chunk @ir41
            a11 = 4
            a6 = 1
        end
        do -- chunk @ir51
            while true do
                a11 = a11(a12, a13)
                a4 = a11
            end
        end
        do -- chunk @ir51
            a13 = a6
        end
        do -- chunk @ir62
            a4 = a3
        end
        do -- chunk @ir67
        end
        do -- chunk @ir78
            a6 = 2
        end
        do -- chunk @ir80
            if (a17 >= 116) then
            end
        end
        do -- chunk @ir84
            a4 = UP5
            a11 = a4
            a11()  -- multret
        end
        do -- chunk @ir104
            a6 = a2
            a11 = a4
            a12 = a5
        end
        do -- chunk @ir105
            a6 = 1
            a5 = (a5 + a6)
        end
        do -- chunk @ir117
            a13 = a4
        end
        do -- chunk @ir137
            UP3 = a5
            a5 = a3
            a11 = 121
        end
        end
        local function a84(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F104
        a4 = UP0[5]
        a5 = UP0[5]
        a6 = UP0[5]
        a7 = 17
        a8 = 68
        a9 = 3
        a6 = a2
        a11 = a4
        a12 = a5
        a13 = a6
        a11 = a11(a12, a13)
        a4 = a11
        do -- chunk @ir1
            a9 = 76
        end
        do -- chunk @ir4
            a5 = UP3
            a8 = a4
        end
        do -- chunk @ir7
            a5 = a1
            a4 = (not a4)
            if (not a4) then
                a4 = a3
            else
                a4 = UP2
                a7 = a4
                a7()  -- multret
            end
        end
        do -- chunk @ir9
            a5 = UP4
            a9 = 37
        end
        do -- chunk @ir14
            a5 = (a5 == a6)
            a13 = 0
            a14 = 92
            a15 = 46
            do -- for-in loop
            end
        end
        do -- chunk @ir18
            a5 = (a5 == a6)
        end
        do -- chunk @ir27
            while true do -- repeat
                if not ((59 >= a9)) then break end
            end
            a6 = UP5
            a9 = 59
        end
        do -- chunk @ir28
            a9 = 64
            a6 = 1
            a5 = (a5 + a6)
            L287 = TNone() -- closure
            UP4 = a5
            while true do -- repeat
                if not ((not a4)) then break end
            end
            a7 = 111
            a8 = 197
            a9 = 86
            do -- for-in loop
            end
        end
        do -- chunk @ir29
            a5 = a2
            a4 = a5
            a7 = UP4
            -- close upvalues
        end
        do -- chunk @ir57
            -- folded: if not ((a10 >= 197)) then
                a4 = 0
                a5 = a3
        end
        do -- chunk @ir59
        end
        do -- chunk @ir68
            a9 = 94
            a10 = a5
            a11 = a6
            a12 = a7
            a13 = a8
            a10(a11..a14)  -- multret
        end
        do -- chunk @ir89
            a6 = 2
        end
        do -- chunk @ir96
            a5 = a1
            a4 = a5
        end
        do -- chunk @ir102
            a7 = nil
            a8 = UP0[5]
            a9 = 115
            a10 = 219
            a11 = 52
        end
        do -- chunk @ir103
            a6 = 1
        end
        end
        a85 = a1[5]
        a86 = a1[5]
        a87 = a1[5]
        a88 = a1[5]
    end
    do -- chunk @ir1361
        -- folded: if not ((64 >= a10)) then
            a62 = a1[58]
            a10 = 59
    end
    do -- chunk @ir1397
        a127 = "IsServer"
        a125(a126, a127)  -- multret
    end
    do -- chunk @ir1411
        a10 = 2
    end
    do -- chunk @ir1425
        if not ((a123 ~= 16)) then
        end
        a124 = a36
        a125 = a119
        a126 = a1[5]
        a124(a125, a126)  -- multret
        a10 = 11
    end
    do -- chunk @ir1434
        while true do -- repeat
            if not ((a10 > 59)) then break end
        end
        a106 = a97
        a107 = a39
        a108 = a1[33]
        a106(a107, a108)  -- multret
        a106 = a97
        a107 = a41
        a108 = a1[38]
    end
    do -- chunk @ir1435
        a106 = a1[105]
        a105 = a4[a106]
        a10 = 37
    end
    do -- chunk @ir1451
        a121 = a84
        a122 = a119[48]
        a123 = UP0
        a123 = a123()
        a124 = 1
        a121(a122..a125)  -- multret
        a121 = a119[3]
        a101[49] = a51
        a120 = 20
        a125 = a119[61]
        a101[74] = a115
        a125 = a84
        a126 = UP0
        a126 = a126()
        a127 = a119[61]
    end
    do -- chunk @ir1463
        a122 = 62
        a132 = a119
        a133 = a1[121]
    end
    do -- chunk @ir1473
        a10 = 112
    end
    do -- chunk @ir1486
        a37 = a1[5]
        a38 = a1[5]
        a39 = a1[5]
        a40 = a1[5]
        a10 = 31
    end
    end
    L14[26] = true
end
do -- chunk @ir44
    while true do
    end
end
do -- chunk @ir44
end
do -- chunk @ir74
end
do -- chunk @ir130
end