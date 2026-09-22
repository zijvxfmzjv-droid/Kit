-- ============================================================================
-- Deobfuscated source, recovered from Luraph VM bytecode ("NewOne (3).txt")
--
-- This is a faithful *reconstruction*, not the original file: Luraph compiles
-- the script to a custom register bytecode, so names/comments/formatting are
-- gone for good.  Structure, control flow and every constant are intact.
--
-- Layout
--   * ENV          the loader's function environment (getfenv()); every
--                  `ENV.<name>` in this file is a real global lookup.
--   * L14          T2's constant pool, keys 1..337, dumped as literal values.
--   * L15          the payload closure (proto T8) built at the end of T2.
--   * `X = function(...) -- F<n>`   nested VM proto with id n.
--
-- Naming (all names below are GENERATED -- the original identifiers are not
--   recoverable, a Luraph build only ships bytecode)
--   * a<n>         parameter of the enclosing proto (VM protos are vararg).
--   * fn<n>        register used as a call target (a function value).
--   * t<n>         table / object that gets indexed.
--   * k<n>         key used to index a table.
--   * n<n>         number: arithmetic / comparison operand.
--   * s<n>         string: concat / string-library operand.
--   * b<n>         boolean.
--   * i<n>         numeric `for` counter.
--   * v<n>         value of mixed or unknown kind.
--   * state        the VM dispatcher's state register inside a proto.
--   * <x>Lib       a global library table (stringLib, mathLib, taskLib, ...).
--
--   The role letters are a readability hint inferred from how each register is
--   used, not a claim about its runtime value.  Registers are declared with
--   `local` at the top of their function so nested protos really capture them,
--   and every proto keeps its `-- F<n>` marker.
--
-- Remaining VM artefacts (documented, not silently "fixed")
--   * `UPVALS[i]`  upvalue read with a runtime-computed index.
--   * `<pool>[5]`  the one constant-pool slot the runtime dump did not capture.
--   * junk ops (op121/92/38/179) rewrite their operands at runtime; those few
--     sites are commented instead of rendered.
--   * Empty `while true do end` loops are dispatcher exits whose real outgoing
--     edge is a junk-op jump.  They are commented out (a bodyless loop cannot
--     terminate, so emitting them would hang this file before the payload runs).
--   * The last line is the loader's exit tailcall -- see the comment above it.
-- ============================================================================
-- The VM resolves globals through the loader's function environment
-- (Q[13]() == getfenv()); every `ENV.<name>` below is a real global lookup.
local ENV = (getfenv and getfenv()) or _G

-- Deobfuscated source (recovered from Luraph VM bytecode)
-- Main chunk = proto T2; payload = T8 (called with the original arguments)

local L14 = {}  -- Luraph constant pool (keys = constant indices)
local L15   -- T2 scratch register (holds the payload closure)
local v1, v3, L4, L5, L6, L7, v8, v9, L10, L11, L12, v5, v6, v7, v24, v29, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v84, v25, v26, v27, v28, v104, v30, v31, v32, v33, v34, v35, fn1, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48
L14[0] = ENV.utf8[0] -- loader-installed helper
L14[1] = v5 -- runtime: FN:function: ADDR
L14[2] = v24 -- runtime: FN:function: ADDR
L14[3] = task -- static decode: ENV.task
L14[4] = string -- static decode: v30
L14[5] = v3
L14[6] = table -- static decode: v21
L14[7] = coroutine -- static decode: v10
L14[8] = "gmatch"
L14[9] = "format"
L14[10] = "char"
L14[11] = v9 -- runtime: FN:function: ADDR
L14[12] = "match"
L14[13] = v11 -- runtime: FN:function: ADDR
L14[14] = "find"
L14[15] = "byte"
L14[16] = "gsub"
L14[17] = math -- static decode: v6
L14[18] = "running"
L14[19] = "sub"
L14[20] = Path2DControlPoint.new -- static decode: v29
L14[21] = Instance -- static decode: v13
L14[22] = "isyieldable"
L14[23] = buffer -- static decode: v27
L14[24] = "rep"
L14[25] = false
L14[26] = true
L14[27] = v23 -- runtime: FN:function: ADDR
L14[28] = "concat"
L14[29] = "cancel"
L14[30] = "unpack"
L14[31] = "create"
L14[32] = "resume"
L14[33] = "yield"
L14[34] = v37 -- runtime: FN:function: ADDR
L14[35] = "status"
L14[36] = v42 -- runtime: FN:function: ADDR
L14[37] = v22 -- runtime: FN:function: ADDR
L14[38] = "close"
L14[39] = v18 -- runtime: FN:function: ADDR
L14[40] = "spawn"
L14[41] = "defer"
L14[42] = v31 -- runtime: FN:function: ADDR
L14[43] = v8 -- runtime: FN:function: ADDR
L14[44] = "readu8"
L14[45] = debug -- static decode: v17
L14[46] = "The debug library is required on Luau platforms. Please open a support ticket."
L14[47] = v7 -- runtime: FN:function: ADDR
L14[48] = "info"
L14[49] = "traceback"
L14[50] = "wrap"
L14[51] = "readu32"
L14[52] = getfenv -- static decode: v34
L14[53] = "pack"
L14[54] = v14 -- runtime: FN:function: ADDR
L14[55] = "writeu16"
L14[56] = "tostring"
L14[57] = "writeu8"
L14[58] = CFrame -- static decode: v19
L14[59] = v84 -- runtime: FN:function: ADDR
L14[60] = Vector2 -- static decode: v33
L14[61] = Vector3 -- static decode: v12
L14[62] = v32 -- runtime: FN:function: ADDR
L14[63] = identifyexecutor -- static decode: v16
L14[64] = "insert"
L14[65] = v25 -- runtime: FN:function: ADDR
L14[66] = v15 -- runtime: {new=FN:function: ADDR}
L14[67] = v28 -- runtime: FN:function: ADDR
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
L14[83] = v104 -- runtime: FN:function: ADDR
L14[84] = "function"
L14[85] = "'setfenv' cannot change environment of given object"
L14[86] = "slnaf"
L14[87] = "getmetatable"
L14[88] = v39 -- runtime: FN:function: ADDR
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
L14[103] = UDim.new -- static decode: v38
L14[104] = "abs"
L14[105] = "wait"
L14[106] = "delay"
L14[107] = game -- static decode: v26
L14[108] = "copy"
L14[109] = UDim2.new -- static decode: v44
L14[110] = utf8 -- static decode: v41
L14[111] = v20
L14[112] = "챒욦떣귌ḯ핐"
L14[113] = v40
L14[114] = "앳띶쮕끍궷뇃쐤"
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
L14[148] = Enum -- static decode: v45
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
L14[166] = v36 -- runtime: FN:function: ADDR
L14[167] = v43 -- runtime: FN:function: ADDR
L14[168] = v35 -- runtime: FN:function: ADDR
L14[169] = v46 -- runtime: FN:function: ADDR
L14[170] = ":(%d+)[:\r\n]"
L14[171] = "__index"
L14[172] = "Your Lua environment does not support load or loadstring, therefore you are unable to use Luraph's 'LPH_NO_UPVALUES' macro."
L14[173] = "dCWeI"
L14[174] = "Luraph"
L14[175] = v47
L14[176] = v48
L14[177] = ENV.bit32[0] -- loader-installed helper
L15 = function(w1, v2, w3, taskLib, stringLib, t4, w7, w8, t5, state, v6, w12, w13, w14, w15, w16, w17, w18, mathLib, t7, w21, v14, w23, v16, v17, k2, w27, k3, v19, v20, v21, v22, w33, k5, v23, w36, w37, v26, w39, w40, v29, v30, v31, v32, w45, w46, v35, w48, v37, w50, w51, w52, k6, w54, w55, v43, v44, w58, v46, w60, w61, v49, w63, w64, w65, w66, v54, v55, v56, v57, w71, v59, v60, w74, w75, v62, w77, w78, w79, w80, v66, w82, w83, w84, w85, w86, v71, w88, v73, w90, v75, w92, w93, fn1, w95, v78, w97, v80, v81, w100, w101, fn2, fn3, fn4, v82, v83, w107, w108, v86, w110, w111, w112, v89, fn6, v90, w116, v91, w118, v92, w120, w121, v94, v95, w124, w125, b2, b3, b4, v97, b5, v98, v99, v100, b6, v101, v102, fn10, v103, v104, v105, v106, v107, a143, ...) -- F8
    local v1, v108, v109, v110, v111, v112, v113, v114, v115, v116, v117, v118, v119, v120, v121, v122, v123, v124, v125, v126, v127, v128, v129, v130, v131, v132, v133, fn11, v134, v135, v136, v137, v138, v139, v140, v141, v142, v143, v144, v145, v146, v147, v148, v149, v150, v151, v152, v153, v154, v155, v156, v157, v158, b7, v159, v160, v161, v162, v163, v164, v165, v166, v167, v168, v169, v170, v171, v172, v173, v174, v175, v176, v177, v178, v179, v180, v181, v182, v183, v184, v185, v186, v187, v188, v189, v190, v191, v192, v193, v194, v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209, v210, v211, v212, v213, v214, v215, v216, v217, v218, v219, v220, v221, v222, v223, v224, v225, v226, v227, v228, v229, v230, v231, v232, v233, v234, v235, v236, v237, v238, v239, v240, v241, v242, v243, v244, v245, v246, v247, v248, v249, v250, v251, v252, v253, v254, v255, v256, v257, v258, v259, v260, v261, v262, v263, v264, v265, v266, v267, v268, v269, v270, v271, v272, v273, v274, v275, v276, v277, v278, v279, v280, v281, v282, v283, v284, v285, v286, v287, v288, v289, v290, v291, v292, v293, v294, v295, v296, v297, v298, v299, v300, v301, v302, v303, v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314, v315, v316, v317, v318, v319, v320, v321, v322, v323, v324, v325, v326, v327, v328, v329, v330, v331, v332, v333, v334, v335, v336, v337, v338, v339, v340, v341, v342, v343, v344, v345, v346, v347, v348, v349, v350, v351, v352, v353, v354, v355, v356, v357, v358, v359, v360, v361, v362, v363, v364, v365, v366, v367, v368, v369, v370, v371, v372, v373, v374, v375, v376, v377, v378, v379, v380, v381, v382, v383, v384, v385, v386, v387, v388, v389, v390, v391, v392, v393, v394, v395, v396, v397, v398, v399, v400, v401, v402, v403, v404, v405, v406, v407, v408, v409, v410, v411, v412, v413, v414, v415, v416, v417, v418, v419, v420, v421, v422, v423, v424, v425, v426, v427, v428, v429, v430, v431, v432, v433, v434, v435, v436, v437, v438, v439, v440, v441, v442, v443, v444, v445, v446, v447, v448, v449, v450, v451, v452, v453, v454, v455, v456, v457, v458, v459, v460, v461, v462, v463, v464, v465, v466, v467, v468, v469, v470, v471, v472, v473, v474, v475, v476, v477, v478, v479, v480, v481, v482, v483, v484, v485, v486, v487, v488, v489, v490, v491, v492, v493, v494, v495, v496, v497, v498, v499, v500, v501, v502, v503, v504, v505, v506, v507, v508, v509, v510, v511, v512, v513, v514, v515, v516, v517, v518, v519, v520, v521, v522, v523, v524, v525, v526, v527, v528, v529, v530, v531, v532, v533, v534, v535, v536, v537, v538, v539, v540, v541, v542, v543, v544, v545, v546, v547
    v2 = w1[1]
    w3 = w1[2]
    taskLib = task
    stringLib = string
    t4 = w1[5]
    w7 = w1[5]
    w8 = w1[5]
    t5 = w1[5]
    state = 102
    t5 = table
    v6 = "format"
    v6 = stringLib[v6]
    w12 = w1[5]
    w13 = w1[5]
    w14 = w1[5]
    w15 = w1[5]
    w16 = nil
    state = 49
    w17 = "char"
    w16 = stringLib[w17]
    w17 = "byte"
    w17 = stringLib[w17]
    w18 = "gsub"
    w18 = stringLib[w18]
    mathLib = math
    t7 = w1[5]
    w21 = w1[5]
    v14 = w1[5]
    w23 = w1[5]
    v16 = w1[5]
    v17 = w1[5]
    state = 102
    k2 = "sub"
    w21 = stringLib[k2]
    state = 8
    w86 = function(k1, v1, v2, v3, v4, v5, n1, v6, v7, v8, i1, i2, n2, n3, a15, a16, ...) -- F14
        local v9, v10, v11
        v4 = w1[5]
        n1 = 87
        v7 = w58
        v3 = (v3 == v5)
        if (not v3) then
            i1 = 354
            i2 = 96
        else
            while true do
                v3 = k1
            end
        end
        w58 = v3
        v5 = w66
        i1 = v3
        i2 = v5
        n2 = v7
        n3 = v8
        i1(i2, n2, n3, a15)
        v3 = w58
        i1 = 18
        i2 = 119
        n2 = 93
        repeat
        until not ((n1 > 12))
        v6 = v4
        v7 = v3
        v8 = v5
        v6 = v6(v7, v8)
        v4 = v6
        n1 = 123
        v4 = v3
        v8 = w1[5]
            -- (constant test eliminated: if not ((38 >= v6)) then)
            v3 = w61
        v4 = w80
        n1 = 33
        v4 = 0
        n1 = 30
        v3 = (v3 + v5)
        while true do
            n1 = 74
            v3 = k1
        end
        do -- (terminates control flow)
            do return  end
        end
        v5 = v1
        n1 = 12
        while not ((18 >= n3)) do -- while-exit-cond
        end
        v4 = v2
        v3 = v2
        v4 = w55
        v6 = v4
        v6()
    end
    state = 78
    if not ((60 >= state)) then
        if not ((state >= 79)) then
            v71 = function(v1, v2, v3, b1, v4, n1, n2, v5, i1, i2, n3, fn1, n4, fn2, v6, v7, v8, a18, ...) -- F67
                local v9, v10
                b1 = w1[5]
                v4 = w1[5]
                n1 = w1[5]
                n2 = 38
                v4 = v1
                n1 = v2
                v5 = b1
                i1 = v4
                i2 = n1
                v5 = v5(i1, i2)
                b1 = v5
                b1 = (not b1)
                n2 = 70
                i1 = 190
                i2 = 73
                repeat
                until not ((n3 == 117))
                fn1 = b1
                fn1()
                v4 = (v4 == n1)
                if not ((not v4)) then
                    v4 = v2
                    b1 = v4
                end
                v4 = w61
                v5 = w1[5]
                i1 = w1[5]
                i2 = 11
                n3 = 159
                fn2(v6, v7, v8, a18)
                i2 = 85
                i2 = 79
                n1 = 1
                v4 = (v4 + n1)
                n1 = 2
                b1 = v4
                n1 = w66
                v4 = v3
                    -- (constant test eliminated: if not ((n3 >= 214)) then)
                if not ((n4 > 19)) then
                    if not ((19 > n4)) then
                            -- (constant test eliminated: if not ((i2 == 85)) then)
                            w58 = v4
                            -- (empty spin loop: dispatcher exit the structurer could not
                            --  recover; commented out -- it can never terminate on its own)
                            -- while true do
                            -- end
                    end
                    v5 = b1
                end
                if not ((27 >= n4)) then
                    fn2 = v4
                    v6 = n1
                    v7 = i1
                    v8 = v5
                end
                i1 = w58
                repeat
                until not ((31 >= v5))
                v4 = v1
                -- (empty spin loop: dispatcher exit the structurer could not
                --  recover; commented out -- it can never terminate on its own)
                -- while true do
                -- end
                n2 = 109
                v4 = (v4 == n1)
                n1 = 1
                do -- (terminates control flow)
                    do return  end
                end
                i1 = 214
                i2 = 64
                b1 = 1
                v4 = v3
                b1 = v3
                i2 = 48
                v4 = w58
                n2 = 77
                b1 = w82
            end
            state = 85
            w125 = w83
            b2 = w13
            b3 = w120
            b2 = b2(b3)
            b3 = "userdata"
            b4 = true
            w125(b2, b3, b4, v97)
        end
    end
    if not ((85 >= state)) then
        fn2 = w97
        fn3 = w52
        fn4 = "typeof"
        fn2(fn3, fn4)
        fn2 = "new"
        fn2 = v56[fn2]
        fn3 = w97
        fn4 = w7
        v82 = "gmatch"
        fn3(fn4, v82)
        fn3 = w97
        fn4 = v6
        v82 = "format"
        fn3(fn4, v82)
        state = 115
        if (state > 54) then
        else
            fn3 = w97
            fn4 = w14
            v82 = "find"
            fn3(fn4, v82)
            state = 29
        end
        w120[3699368772] = 452242525
        w120[1831891793] = 1560434486
        w118(v92, w120)
        w118 = w1[5]
        state = 82
        if (state ~= 84) then
            if (state ~= 82) then
                v92 = w118
                w120 = v89
                w121 = "DataModel"
                v92(w120, w121)
                state = 84
                w121 = v92[60]
                w101[28] = w97
                w121 = w83
                v94 = L7
                v94 = v94()
                v95 = v92[60]
                w124 = 1
                w121(v94, v95, w124, w125)
                w121 = 90
                v94 = 153
                v95 = 33
            else
                w118 = function(t1, v2, fn1, v3, v4, fn2, v5, v6, n1, fn3, fn4, v7, i1, i2, i3, n2, c17, v8, v9, i4, i5, n3, fn6, v10, i6, i7, n4, fn7, v11, v12, a31, ...) -- F126
                    local v1, v13
                    fn1 = w83
                    v3 = "userdata"
                    v4 = w13
                    fn2 = t1
                    v4 = v4(fn2)
                    fn1(v3, v4)
                    fn1 = w84
                    v3 = w52
                    v4 = t1
                    v3 = v3(v4)
                    v4 = "Instance"
                    fn1(v3, v4)
                    fn1 = w1[5]
                    v3 = w1[5]
                    v4 = 61
                    fn1 = t1[0]
                    fn2 = "Parent"
                    v3 = t1[fn2]
                    v4 = 120
                    fn3 = 92
                        -- (constant test eliminated: if not ((11 >= fn3)) then)
                            -- (constant test eliminated: if not ((fn3 >= 110)) then)
                            fn3 = 11
                            v5 = "AncestryChanged"
                    n1 = t1[v5]
                    fn3 = 117
                    while true do
                        v5 = t1[fn3]
                        n1 = 78
                    end
                    v4 = 44
                    fn3 = "Name"
                    v5 = w83
                    v6 = v2
                    n1 = "ClassName"
                    n1 = t1[n1]
                    v5(v6, n1)
                    if not ((fn3 >= 92)) then
                        fn3 = 110
                        v6 = t1[v5]
                    end
                    if (110 >= fn3) then
                    else
                        fn4 = w86
                        v7 = v6
                        i1 = n1
                        fn4(v7, i1)
                        fn4 = w78
                        v7 = (v6 == n1)
                        fn4(v7)
                        fn4 = "Connect"
                    end
                    fn3 = w83
                    fn4 = (#v5)
                    v7 = (#v6)
                    fn3(fn4, v7)
                    fn3 = UPVALS[v1]
                    fn4 = w37
                    v7 = t1
                    fn4 = fn4(v7)
                    v7 = v5
                    fn3(fn4, v7)
                    c17 = false
                    v8 = "Destroying"
                    v8 = t1[v8]
                    v9 = v8; v8 = v8["Connect"]
                    i4 = function(v1, a2, a3, a4, ...) -- F132
                        local v2
                        v1 = true
                        c17 = v1
                        do return  end
                    end
                    v8 = v8(v9, i4)
                    i4 = 204
                    i5 = 72
                    if not ((n1 ~= 85)) then
                        fn3 = w83
                        fn4 = "string"
                        v7 = w13
                        i1 = v5
                        v7 = v7(i1)
                        fn3(fn4, v7)
                        fn3 = w84
                        fn4 = v5
                        v7 = v6
                        fn3(fn4, v7)
                    end
                    fn3 = "Name"
                    v6 = t1[fn3]
                    n1 = 85
                    c17 = w97
                    v8 = v7
                    v9 = "Connect"
                    c17(v8, v9)
                    c17 = w86
                    v8 = fn4
                    v9 = v7
                    c17(v8, v9)
                    fn6 = w1[5]
                    i6 = 238
                    i7 = 73
                    fn7 = w112
                    v11 = fn6
                    v12 = w1[5]
                    fn7(v11, v12)
                    repeat
                    until not ((fn2 ~= 31))
                    v5 = w1[5]
                    v6 = w1[5]
                    n1 = 107
                    v5 = w1[5]
                    v6 = w1[5]
                    n1 = w1[5]
                    c17 = w97
                    v8 = fn4
                    v9 = "Connect"
                    c17(v8, v9)
                    v10 = w78
                    i6 = "Connected"
                    i6 = v8[i6]
                    i6 = (not i6)
                    v10(i6)
                    if not ((fn2 ~= 75)) then
                    end
                    fn7(v11, v12)
                    v5 = w83
                    v6 = "The metatable is locked"
                    n1 = w48
                    fn3 = t1
                    v5(v6, n1(fn3, fn4))
                    do -- (terminates control flow)
                        do return  end
                    end
                    if (n4 ~= 19) then
                        fn7 = w97
                        v11 = fn6
                        v12 = "Disconnect"
                    else
                        fn7 = "Disconnect"
                        fn6 = v8[fn7]
                    end
                    fn4 = v6[fn4]
                    v7 = "Connect"
                    v7 = v6[v7]
                    i1 = 118
                    i2 = 264
                    i3 = 10
                    fn6 = w78
                    v10 = "Connected"
                    v10 = v8[v10]
                    fn6(v10)
                    fn7 = fn6
                    v11 = v8
                    fn7(v11)
                end
                state = 9
                w125 = v92[59]
                w101[72] = v125
            end
        else
            v92 = w118
            w120 = v83
            w121 = "Workspace"
            v92(w120, w121)
            v92 = w83
            w120 = v89
            w121 = "Parent"
            w121 = v83[w121]
            v94 = true
            v92(w120, w121, v94, v95)
            v92 = nil
            w120 = 104
            w121 = 330
            v94 = 113
        end
        fn4(v82, v83)
        fn4 = w97
        v82 = k2
        v83 = "rep"
        fn4(v82, v83)
        state = 93
            -- (constant test eliminated: if not ((23 >= state)) then)
        fn4 = w97
        v82 = v59
        v83 = "insert"
        fn4(v82, v83)
        state = 10
        v98[4286544108] = v124
        v98[4113771706] = v169
        v98[4054428537] = v337
        v98[1373830112] = v112
        v98[1485835597] = v235
        v98[3571856872] = v108
        b2 = v98
    end
    w85 = w1[67]
    state = 107
    b2 = true
    v95(w124, w125, b2, b3)
        -- (constant test eliminated: if (v94 ~= 20) then)
    v81 = w1[88]
    state = 58
    w100 = w97
    w101 = w36
    fn2 = "setmetatable"
    w100(w101, fn2)
    w100 = w97
    w101 = v57
    fn2 = "tonumber"
    w100(w101, fn2)
    w100 = w1[5]
    state = 12
    w125 = v92[22]
    w101[77] = w23
    if not ((not w121)) then
        b2 = w55
        b2()
    end
    b2 = w55
    b2()
    b2 = w1[5]
    b3 = w1[5]
    b4 = w1[5]
    v97 = 87
    b5 = 163
    v98 = 19
    b3 = w97
    b4 = "Shuffle"
    b4 = w121[b4]
    v97 = "Shuffle"
    b3(b4, v97)
    w118 = w97
    v92 = fn2
    w120 = "new"
    w118(v92, w120)
    w118 = w97
    v92 = v80
    w120 = "new"
    w118(v92, w120)
    state = 14
    w121 = v92[29]
    w101[43] = w121
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[29]
    w124 = 2
    w121(v94, v95, w124, w125)
    w120 = 115
    w120 = 54
    w121 = v92[12]
    w101[44] = w13
    w121 = w84
    v94 = L7
    v94 = v94()
    v95 = v92[12]
    w124 = 1
    w121(v94, v95, w124, w125)
    w120 = w84
    w121 = w52
    v94 = v92
    w121 = w121(v94)
    v94 = "Enums"
    v95 = true
    w120(w121, v94, v95, w124)
    w121 = v92[v92]
    w101[51] = v80
    w121 = w84
    v94 = v92[5]
    v95 = L7
    v95 = v95()
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = v92[20]
    w101[52] = b4
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[20]
    w124 = 1
    w121(v94, v95, w124, w125)
    w120 = 117
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[23]
    w124 = 1
    w121(v94, v95, w124, w125)
    w120 = 111
    w125 = w84
    b2 = w52
    b3 = w120
    b2 = b2(b3)
    b3 = "EnumItem"
    b4 = true
    w125(b2, b3, b4, v97)
    v104 = true
    fn10(v103, v104)
    v100 = w1[w1]
    v100 = v99[v100]
    v100 = (v100 * 100)
    v100 = (v100 // 1)
    w101[98] = w36
    v94 = 46
    if (46 >= v94) then
        v100 = v92
        b6 = "Y"
        b6 = v99[b6]
        v101 = true
        v100(b6, v101)
        v94 = 53
        w125 = v92[7]
        w101[37] = w74
    else
        b6 = w120; v100 = w120["Destroy"]
        v100(b6)
        state = 66
    end
    v37 = w1[w1]
    w46 = t7[v37]
    v35 = taskLib[0]
    state = 51
        -- (constant test eliminated: if not ((25 >= state)) then)
    w45 = w1[42]
    state = 36
    w125 = w84
    b2 = w13
    b3 = v95
    b2 = b2(b3)
    b3 = "userdata"
    b4 = true
    w125(b2, b3, b4, v97)
    w124 = 11
    b4 = 263
    w124 = w124(w125, b2, b3, b4)
    w121[v95] = w124
    v95 = w1[5]
    w124 = 40
    w125 = 386
    b2 = 114
    w125 = v92[4]
    w101[36] = v297
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[4]
    b4 = 1
    w125(b2, b3, b4, v97)
    v95 = w84
    w124 = "userdata"
    w125 = w13
    b2 = w121
    w125 = w125(b2)
    b2 = w1[w1]
    v95(w124, w125, b2, b3)
    v94 = 46
        -- (constant test eliminated: if (72 >= state) then)
            -- (constant test eliminated: if not ((state >= 77)) then)
            if not ((58 >= state)) then
                w112 = w1[5]
                v89 = w1[w1]
                fn6 = 36
                v90 = 244
                w116 = 76
                w77 = w1[5]
                w78 = w1[5]
                w79 = w1[5]
                state = 101
            end
    w121 = w84
    v94 = v92[25]
    v95 = L7
    v95 = v95()
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = 50
    v94 = 89
    v95 = 39
    fn6(v90)
    fn6 = w112
    v90 = v55
    fn6(v90)
    fn6 = w112
    v90 = v2
    fn6(v90)
    state = 58
    fn6 = w112
    v90 = w7
    fn6(v90)
    state = 117
    fn6 = w112
    v90 = w14
    fn6(v90)
    fn6 = w1[5]
    v90 = w1[w1]
    state = 89
    if (100 >= state) then
    else
        v90 = w1[5]
        state = 67
    end
    k2 = "isyieldable"
    v14 = t4[k2]
    state = 71
    w101[93] = v130
    v98 = w1[5]
    v94 = 119
    while true do
        v94 = 106
        v99 = v92
        v100 = "X"
        v100 = b5[v100]
        b6 = "Scale"
        v100 = v100[b6]
        b6 = true
        v99(v100, b6)
    end
    v95 = w84
    w124 = 0.36546066092082763
    b2 = w121; w125 = w121["NextNumber"]
    w125 = w125(b2)
    b2 = true
    v95(w124, w125, b2, b3)
    v95 = w84
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w125 = 0.9399625980565814
    b2 = true
    v95(w124, w125, b2, b3)
    v95 = 42
    w124 = 60
    w125 = 4
    v92 = w79
    w120 = w45
    w121 = "GetChildren"
    w121 = v89[w121]
    w120 = w120(w121)
    w121 = true
    v92(w120, w121)
    v92 = w1[5]
    w120 = 50
    w121 = 228
    v94 = 104
    v97 = 22
    while true do
        w121 = w118[8]
        w101[18] = v31
    end
    w120 = 122
    b2 = b2()
    b3 = v92[24]
    b4 = 1
    w125(b2, b3, b4, v97)
    fn6 = w112
    v90 = v6
    fn6(v90)
    state = 80
        -- (constant test eliminated: if not ((30 >= state)) then)
        fn2 = {}
        w101 = fn2
        state = 0
    fn2 = w97
    fn3 = w13
    fn4 = "type"
    fn2(fn3, fn4)
    fn2 = w97
    fn3 = w40
    fn4 = "next"
    fn2(fn3, fn4)
    state = 119
    w125 = "Name"
    w121[w125] = w124
    w125 = w83
    b2 = w121
    b3 = v95
    b4 = w120
    v97 = w124
    b3 = b3(b4, v97)
    b4 = true
    w125(b2, b3, b4, v97)
    b2 = w120; w125 = w120["Destroy"]
    w125(b2)
    b2 = w121; w125 = w121["Destroy"]
    w125(b2)
    w125 = w79
    b2 = "Parent"
    b2 = w121[b2]
    b3 = true
    w125(b2, b3)
    w125 = w78
    b2 = w45
    b3 = function(v1, a2, a3, a4, ...) -- F44
        v1 = w120
        w121["Parent"] = v1
        do return  end
    end
    b2 = b2(b3)
    b2 = (not b2)
    b3 = true
    w125(b2, b3)
    v92 = w1[5]
    w120 = 32
    w121 = 137
    v94 = 105
    w112 = function(h1, a2, h3, fn2, v1, fn3, v2, v3, a9, ...) -- F258
        local v4
        h3 = w33
        fn2 = h1
        h3 = h3(fn2)
        if not ((not h3)) then
            h3 = function(a1, fn1, fn2, v1, v2, a6, ...) -- F264
                local v3
                fn1 = w83
                fn2 = w111
                do -- (terminates control flow)
                    v2 = 3
                    fn1(fn2, v1(v2, a6))
                    fn1 = UPVALS[fn2]
                    fn2 = h1
                    v1 = w111
                    v2 = 4
                    fn1(fn2, v1(v2, a6))
                    fn1 = w84
                    fn2 = w111
                    fn2 = fn2(v1)
                    v1 = w15
                    fn1(fn2, v1)
                    fn1 = w84
                    fn2 = w111
                    fn2 = fn2(v1)
                    v1 = w45
                    fn1(fn2, v1)
                    fn1 = w84
                    fn2 = w111
                    fn2 = fn2(v1)
                    v1 = w112
                    fn1(fn2, v1)
                    fn1 = ...  -- vararg fill: also writes R3, R4, ... (count is runtime dependent)
                    do return ... end
                end
                while true do
                    fn2 = fn2(v1)
                    v1 = w45
                    fn1(fn2, v1)
                end
                fn1 = w84
                fn2 = h3
                v1 = w111
            end
            fn2 = w15
            v1 = h1
            fn3 = h3
            v2 = ...  -- vararg fill: also writes R8, R9, ... (count is runtime dependent)
            fn2, v1, fn3 = fn2()
            fn3 = w79
            v2 = fn2
            fn3(v2)
            fn3 = w86
            v2 = v1
            fn3(v2, v3)
        end
        do return  end
    end
    state = 6
    w125 = w118[3]
    w101[6] = v60
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = w118[3]
    b4 = 1
    w125(b2, b3, b4, v97)
    v75 = function(v1, v2, k1, v3, n1, v4, k2, v5, v6, v7, v8, i1, i2, i3, i4, fn1, a17, a18, ...) -- F352
        local v9
        k1 = w1[5]
        v3 = w1[5]
        n1 = 18
        k1 = w40
        n1 = 73
        i1 = v7
        i2 = v8
        i3 = i1
        i2 = i2(i3)
        v8 = i2
        i2 = w1[5]
        i3 = 30
        i2 = v2
        i3 = 101
        n1 = 68
            -- (constant test eliminated: if not ((56 >= n1)) then)
            n1 = 83
            v6 = v4
            v7 = k2
            v8 = v5
            -- generic-for iterator (coroutine desugar) reg R9
            repeat
            until not ((155 > fn1))
        i1 = 82
        i2 = 195
        i3 = 62
        repeat
        until not ((82 >= i4))
        fn1 = v8
        fn1()
        v6, v7, v8 = coroutine.resume(v6, v7, v8)
        if v6 then
        else
            do return  end
        end
        i3 = 0
        i1 = w1[5]
        v4, k2, v5 = nil
        v4 = k1
        k2 = v3
        v3 = v2
        n1 = 125
        v4 = k1
        k2 = v3
        n1 = 56
        -- generic-for iterator (coroutine desugar) reg R9
        v6, v7, v8 = coroutine.resume(v6, v7, v8)
        if v6 then
        else
            v8 = w1[5]
            i1 = w1[5]
            i2 = 100
            i3 = 275
            i4 = 55
            repeat
            until not ((n1 > 22))
        end
        v7 = k2
        v8 = v5
        -- generic-for iterator (coroutine desugar) reg R9
            -- (constant test eliminated: if not ((i4 >= 144)) then)
            v8 = w55
        v3 = v1
    end
    state = 9
    w92 = 77
    fn1 = v73
    w95 = v17
    fn1(w95)
    fn1 = v73
    w95 = v56
    fn1(w95)
    w93 = 13521840
    fn1 = v73
    w95 = v60
    fn1(w95)
    fn1 = v73
    w95 = v49
    fn1(w95)
    fn1 = w1[5]
    w95 = w1[5]
    v78 = w1[5]
    w97, v80 = nil
    state = 44
    if (44 >= state) then
        v81 = v73
        w100 = v66
        v81(w100)
        state = 27
        v99 = "Y"
        v99 = b5[v99]
        v100 = "Scale"
        v99 = v99[v100]
        v99 = (v99 * 100)
        v99 = (v99 // 1)
        w101[94] = k3
        v94 = 65
        v99 = v92
        v100 = "Y"
        v100 = b5[v100]
        b6 = "Scale"
        v100 = v100[b6]
        b6 = true
        v99(v100, b6)
        if (78 >= state) then
            v73 = function(v1, fn1, fn2, fn3, fn4, v2, a7, ...) -- F78
                local v3, v4
                fn1 = w79
                fn2 = (not v1)
                fn1(fn2)
                fn1 = UPVALS[v1]
                fn2 = "table"
                fn3 = w13
                fn4 = v1
                fn3 = fn3(fn4)
                fn1(fn2, fn3)
                    -- (constant test eliminated: if not ((67 >= fn1)) then)
                    fn2 = w84
                    fn3 = w1[5]
                    fn4 = w48
                    v2 = v1
                    fn4 = fn4(v2)
                    fn2(fn3, fn4)
                fn2 = w45
                fn3 = w36
                fn4 = v1
                v2 = w1[5]
                fn2(fn3, fn4, v2, a7)
                do return  end
            end
            state = 79
        end
        w120 = 100
        w121 = w84
        v94 = v92[30]
        v95 = L7
        v95 = v95()
        w124 = 1
        w121(v94, v95, w124, w125)
        w121 = v92[25]
        w101[23] = v81
    else
        v81 = {}
        w95 = v81
        v81 = {}
        w100 = "lastlinedefined"
        v81[w100] = -1
        w100 = "linedefined"
        v81[w100] = -1
        w100 = "nparams"
        v81[w100] = 0
        w100 = "short_src"
        w101 = "[C]"
        v81[w100] = w101
        w100 = "source"
        w101 = "=[C]"
        v81[w100] = w101
        w100 = "what"
        w101 = "C"
        v81[w100] = w101
        w100 = "currentline"
        v81[w100] = -1
        w100 = "namewhat"
        w101 = ""
    end
    state = 28
    b4 = true
    w125(b2, b3, b4, v97)
    state = 71
    v92 = w1[5]
    w120 = 67
        -- (constant test eliminated: if not ((w120 >= 70)) then)
        w120 = 70
        w121 = "new"
        v92 = v66[w121]
    w121 = w97
    v94 = v92
    v95 = "new"
    w121(v94, v95)
    w121 = w112
    v94 = v92
    v95 = {}
    w121(v94, v95)
    w120 = 0
        -- (constant test eliminated: if not ((w120 > 0)) then)
        w121 = w1[5]
        v94 = 28
    w121 = w1[5]
    v94 = 20
    v94 = 323
    v95 = 106
    while true do
        v100 = (v100 * 100)
        v100 = (v100 // 1)
    end
    v100 = b3[0]
    b4 = v89; b3 = v89["GetService"]
    v97 = "StarterPlayer"
    b3 = b3(b4, v97)
    w121 = b3
    fn6 = w112
    v90 = w48
    fn6(v90)
    state = 85
    if not ((v99 ~= 87)) then
        b2 = function(v2, fn1, fn2, v3, n1, v4, e7, v5, state, fn3, fn4, v6, v7, v8, fn5, v9, v10, a18, ...) -- F164
            local v1, v11, v12
            fn1 = w12
            fn2 = v2
            v3 = w1[170]
            fn1 = fn1(fn2, v3)
            fn2 = w7
            v3 = v2
            n1 = w1[170]
            fn2 = fn2(v3, n1)
            fn2 = fn2()
            v3 = w1[5]
            n1 = w1[5]
            v4 = 83
            e7 = 199
            state = 106
            fn5 = w83
            v9 = v6
            v10 = fn3
            fn5(v9, v10)
            state = 119
            fn5 = w83
            v9 = fn4
            v10 = v6
            fn5(v9, v10)
            while not ((state ~= 61)) do -- while-exit-cond
                state = 120
                fn5 = w83
                v9 = v5
                v10 = e7
                fn5(v9, v10)
                fn4 = w55
                fn4()
            end
            fn3 = w55
            fn3()
            if not (fn2) then
                fn3 = w55
                fn3()
            end
            if not (v3) then
                fn3 = w55
                fn3()
            end
            state = 103
            v8 = (v5 + 0)
            fn5 = w83
            v9 = fn2
            v10 = v4
            fn5(v9, v10)
            fn5 = w84
            v9 = v4
            v10 = v5
            fn5(v9, v10)
            state = 61
            v8 = w1[5]
            state = 3
            do -- (terminates control flow)
                fn5 = w83
                v9 = fn3
                v10 = v8
                fn5(v9, v10)
                fn5 = w84
                v9 = v8
                v10 = v7
                fn5(v9, v10)
                fn5 = fn4
                do return fn5 end
            end
            v4 = w55
            v4()
            repeat
            until not (n1)
            e7 = w1[5]
            v5 = w1[5]
            state = 45
            fn3 = w16
            fn4 = UPVALS[v4]
            v6 = v2
            v7 = (v3 + 1)
            v8 = (n1 - 1)
            fn3 = fn3(fn4(v6, v7, v8, fn5))
            v5 = fn3
            fn3 = w18
            fn4 = v2
            v6 = w1[170]
            v7 = function(v1, a2, a3, ...) -- F170
                local v2
                e7 = v1
                do return  end
            end
            fn3(fn4, v6, v7, v8)
            state = 40
            v7 = (e7 + 0)
            e7 = v1
            state = 103
            fn4 = w55
            fn4()
            fn4 = w1[5]
            v6 = w1[5]
            v7 = w1[5]
            fn3 = w14
            fn4 = v2
            v6 = w1[170]
            fn3, fn4, v6 = fn3(fn4, v6, v7)
            v3 = fn3
            n1 = fn4
            state = 6
            fn4 = (fn1 + 0)
            v11 = (nil / v12)
            repeat
            until not (v4)
            fn3 = w55
            fn3()
            state = 105
            state = 26
            fn5 = w83
            v9 = fn1
            v10 = fn2
            fn5(v9, v10)
            state = 52
            fn3 = (v4 + 0)
            state = 40
            fn3 = w21
            fn4 = v2
            v6 = (v3 + 1)
            v7 = (n1 - 1)
            fn3 = fn3(fn4, v6, v7)
            v4 = fn3
            v6 = (fn2 + 0)
            state = 45
        end
        v100 = b2
        b6 = w120
        v100 = v100(b6)
        b3 = v100
    end
        -- (constant test eliminated: if not ((v95 >= 154)) then)
        v92 = w1[w1]
    w124 = w83
    w125 = w13
    b2 = v92
    w125 = w125(b2)
    b2 = "userdata"
    b3 = true
    w124(w125, b2, b3, b4)
    if (b2 == 106) then
        b3 = w118
        b4 = w121
        v97 = "StarterPlayer"
        b3(b4, v97)
    end
    b4 = "Parent"
    v95[b4] = w121
    v97 = v95; b4 = v95["SetControlPoints"]
    b5 = {} -- size 4
    v98 = v16
    v99 = fn6
    v100 = 0.0625
    b6 = -2
    v101 = 0
    v102 = 2
    v99 = v99(v100, b6, v101, v102)
    v100 = fn6
    b6 = 0.125
    v101 = -1
    v102 = 0
    fn10 = -3
    v100 = v100(b6, v101, v102, fn10)
    b6 = fn6
    v101 = 0
    v102 = 0
    fn10 = 0
    v103 = 0
    v98 = v98(v99, v100, b6(v101, v102, fn10, v103, v104))
    v99 = v16
    v100 = fn6
    b6 = 0.375
    v101 = 7
    v102 = 0.125
    fn10 = -2
    v100 = v100(b6, v101, v102, fn10)
    b6 = fn6
    v101 = 0
    v102 = 2
    fn10 = 0
    v103 = -6
    b6 = b6(v101, v102, fn10, v103)
    v101 = fn6
    v102 = 0
    fn10 = 0
    v103 = 0
    v99 = v99(v100, b6, v101(v102, fn10, v103, v104, v105))
    v100 = v16
    b6 = fn6
    v101 = 0.5
    v102 = -4
    fn10 = 0.375
    v103 = -7
    b6 = b6(v101, v102, fn10, v103)
    v101 = fn6
    v102 = 0
    fn10 = -6
    v103 = 0.125
    v101 = v101(v102, fn10, v103, v104)
    v102 = fn6
    fn10 = 0
    v103 = 1
    v105 = -4
    v100 = v100(b6, v101, v102(fn10, v103, v104, v105, v106))
    b6 = v16
    v101 = fn6
    v102 = 0
    fn10 = -1
    v103 = 0
    v101 = v101(v102, fn10, v103, v104)
    v102 = fn6
    fn10 = 0
    v95 = w118[14]
    w124 = 2
    w121(v94, v95, w124, w125)
    w120 = 13
    v16 = Path2DControlPoint.new
    state = 17
    w121 = w84
    v94 = w118[18]
    v95 = L7
    v95 = v95()
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = w118[12]
    w101[2] = v16
    w121 = 124
    v94 = 176
    v95 = 26
    w121 = v92[46]
    w101[38] = taskLib
    w121 = w84
    v94 = v92[46]
    v95 = L7
    v95 = v95()
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = v92[41]
    w101[39] = v46
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[41]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[40]
    w101[40] = w92
    w121 = 118
    v94 = 171
    v95 = 33
    repeat
    until not ((state ~= 8))
    if not ((state >= 53)) then
        b3 = {}
        b4 = w1[171]
        v97 = function(t1, k1, k2, fn1, i1, i2, n1, t2, i3, i4, i5, n2, fn2, v1, a15, a16, ...) -- F364
            k2 = w1[5]
            i1 = 50
            i2 = 22
                -- (constant test eliminated: if not ((17 >= n2)) then)
                fn2 = w125
                v1 = t2
                fn2(v1)
            do -- (terminates control flow)
                repeat
                until not ((n1 ~= 50))
                UP324[nil] = nil
                t2 = w107[k2]
                i3 = 17
                i4 = 224
                i5 = 71
                fn1 = w55
                fn1()
                do return  end
            end
            fn2 = w1[5]
            w107[k2] = fn2
            t2 = t1[0]
            k2 = t2[k1]
        end
        b3[b4] = v97
        b2 = b3
        state = 53
    end
    b3 = w1[5]
    b4 = w1[5]
    v97 = 65
    if not ((v97 >= 65)) then
        if not ((not b3)) then
        end
        b4 = function(fn1, v1, a3, ...) -- F293
            fn1 = w3
            v1 = w1[172]
            fn1(v1)
        end
    end
    b5 = w45
    v98 = v81
    v99 = v6
    v100 = " --[[%s]] return setfenv(function(...) return %s(...) end, setmetatable({ [\"%s\"] = ... }, { __index = getfenv((...)) })) "
    b6 = "\n				 .@%(/*,.......      ...,,*/(#%&@@.\n			 (*   ,/(#%%&&@@@@&%((////(((##%###((/**,,.     ,//(&.\n		   /* .%@@@@@@@@%,  .(&@@@&&&&&&@@@@@@&#(*,........*%@@@(.  ,#.\n		 */ .&@@@@@@@*  (%,   *(&&@@@@@&%(*,.             .,*(#%(*@@&*  *,\n		#, /@@@@@@* *&( ,&&/.,/#%&&@@@&(&@@@@@@@@@@@@#*,.....,/&@@@@@@@@( .%\n	   #  #@@@@@*/@% .#%./(,.,/*,//*,.,/(*@@@@@@@@@@@@%@@@@@@@@@#.#@@@@@@&. %\n	  /  &@@@@@@@@(%@# *&&*&@@@@#/&@@@@/%%.,%@@@@@@@%/@@&(,  ,,,...  *%@@@# *\n	#  .&@@@@@@@@@@@,((%@@@@@#.    ,&@@#@@&* .&@@@@@&,.#@@@@/&@@%(@@@&(/,(&, /,\n (/   (@&&&%&@@@&/, ,@#(@@@@,        #@@/,&@& /@@@@@,%#%@@@@@(     *@@@@@&,%%. .\n/  #/,#@@@&#(//#@@@/ %@@@&@@@(.    ,&@@(.*/*  %@@*   %@@@@@@%       (@@&(*...%&.\n ///@@&,  (&@@#,   /@/ ,*&@@@@#&@@%#%((%@&* /@@@@@@&. #@@@#&@@@&%%@@@@@@&,/(*@/#\n%%.&@# .&@@@# /@@@@%&@@@&/.   ,/((/*,  ./&@@@@@@@@@@,*&(./%@@#*&@@@(#(....,&#*@/\n@%.&& .&@@@&*    /&@@@@@@@@@@@@@@@@&@@#/(%@@@@@@@@@@&,  (@@@@@@@@@@@@/,@@@@@#.&*\n&&,%% .&*    /@@@(.  ,(@@@@@&/(////#( /&@@@@@@@@@@@@@@@(  ,&@@@@@@@@&, (@@&*/@(/\n.%*#@( /@@@@( *@@@@@@/     *%@@@@@@@&.,@& ,#, .&@@@@@@# .#*%&/,#@@@@*   *@@&/*&*\n .&/.#@@@@@@@,   *&@@%.,&@@&(,    ,(%@%&@@@@@@@@@(.*,  /@@@@@@@@@&,      %@@@@..\n@* .%@@@@@@@@(       .   (@@@@@@@@(       .*(%&@@@@@@@@@@@@&(,  ./.*@%   /@@% ./\n  @* .&@@@@@@&.             ./&@@@*.&@@@@@@@&, ,**,.    .,*(&(.%@@# %@*  ,@@% ,#\n	&, /@@@@@@*                    .#@@@@@@@@*.%@@@@@(,@@@@@@& ,%(.      .&@% ,#\n	  / *@@@@@#                                                           %@&.,#\n	  (( .&@@@@*                                                          #@&.,#\n	   .&. ,&@@@,                                                         (@&.,#\n		  #. .%@@* /@@/                                                   /@&.,(\n			./  #@%. %@&,,#,                                              /@@,./\n			  *(  #@%. . (@@@@@%/,                                        /@@,.*\n				//  %@&, *@@@@@@@@( (@%/.                                 #@@, (\n				  #* .&@@#. (@@@@&.*@@@@@@@@%. */.                  *..%*.&@@, /\n					@* .%@@@%, ,/ .@@@@@@@@@@,.%@@@@@% .&@@@* #@&..&@*,* %@@&. *\n					   /  *&@@@@%,   *(&@@@@&. #@@@@@* #@@@% (@@* ,.   /@@@@* (\n						 @#. .#@@@@@@&(,.                      .,*(%&@@@@@&..(\n							 &(.   ./%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(. ((\n								  ,#/*.       ..,,,,,,,,....          ,/#\n\n"
    v101 = w1[173]
    v102 = w1[173]
    v99 = v99(v100, b6, v101, v102)
    v100 = w1[174]
    b6 = w1[5]
    b5, v98, v99 = b5(v98, v99, v100, b6, v101)
    b3 = b5
    b4 = v98
    v97 = 44
        -- (constant test eliminated: if not ((16 >= state)) then)
    w101 = w97
    fn2 = v55
    fn3 = "rawget"
    w101(fn2, fn3)
    state = 101
    w125 = w125[b2]
    b2 = "EnumType"
    w125 = w125[b2]
    b2 = w125; w125 = w125["FromValue"]
    b3 = 1
    w125 = w125(b2, b3)
    w125 = w125[0]
    b2 = w125; w125 = w125["FromValue"]
    b3 = 1
    w125 = w125(b2, b3)
    b2 = "EnumType"
    w125 = w125[b2]
    b2 = w125; w125 = w125["FromValue"]
    b3 = 1
    w125 = w125(b2, b3)
    b2 = "EnumType"
    w125 = w125[b2]
    b2 = w125; w125 = w125["FromName"]
    b3 = "OuterBox"
    w125 = w125(b2, b3)
    w120 = w125
        -- (constant test eliminated: if (97 >= w124) then)
    v29 = w1[5]
    v30 = w1[5]
    v31 = w1[5]
    v32 = w1[5]
    w45 = w1[5]
    w46 = w1[5]
    w48 = w1[5]
    state = 34
    v92 = 1
    w120 = 9
    w121 = 1
    v94 = 120
    b4 = "X"
    b4 = b2[b4]
    b4 = b4[0]
    b4 = (b4 * 100)
    b4 = (b4 // 1)
    w101[85] = v73
    b4 = v92
    v97 = "X"
    v97 = b2[v97]
    b5 = "Scale"
    v97 = v97[b5]
    b5 = true
    b4(v97, b5)
    fn10 = v92
    v103 = "Y"
    v103 = v98[v103]
    v104 = true
    fn10(v103, v104)
    fn3(fn4, v82)
    fn3 = UDim.new
    fn4 = w97
    v82 = w18
    v83 = "gsub"
    fn4(v82, v83)
    fn4 = w97
    v82 = w21
    v83 = "sub"
    w77 = function(k1, n1, v1, v2, n2, n3, i1, i2, v3, n4, n5, v4, v5, state, n7, n8, n9, n10, v6, i3, v7, n11, v8, a24, a25, ...) -- F340
        local v9, v10, v11
        v1 = w1[5]
        v2 = w1[5]
        n2 = w1[5]
        n3 = w1[5]
        i1 = 50
        i2 = 325
        while true do
            state = 21
            n7 = (n3 + 4)
            n8 = w1[5]
            n9 = 0
                -- (constant test eliminated: if (0 >= n9) then)
                n10 = w54
                v6 = k1
                i3 = n3
                n10 = n10(v6, i3)
                n8 = n10
                n10 = bit32.band(n8, 255)
                n5 = bit32.bxor(v3, n10)
                v4 = (n5 * 435)
                n9 = 95
                v3 = (v4 % n2)
            if not ((n4 >= 220)) then
                n2 = 4294967296
                while true do
                    n4 = w1[5]
                    n5 = w1[5]
                    v4 = w1[5]
                    v5 = w1[5]
                    state = 124
                end
            end
            v2 = 3421674724
        end
        n10 = (n5 * 256)
        n10 = (v5 + n10)
        v6 = (n4 * 435)
        n10 = (n10 + v6)
        n4 = (n10 % n2)
        n10 = bit32.rshift(n8, 24)
        n5 = bit32.bxor(v3, n10)
        v4 = (n5 * 435)
        v3 = (v4 % n2)
        n10 = 15
        i3 = 30
        n10 = bit32.rshift(n8, 16)
        n10 = bit32.band(n10, 255)
        n5 = bit32.bxor(v3, n10)
        v4 = (n5 * 435)
        v3 = (v4 % n2)
        n9 = 98
        n9 = 89
        n10 = (v4 - v3)
        v5 = (n10 / n2)
        n9 = 4
        n10 = (n5 * 256)
        n10 = (v5 + n10)
        v6 = (n4 * 435)
        n10 = (n10 + v6)
        n4 = (n10 % n2)
        if (4 >= n9) then
        else
        end
        do -- (terminates control flow)
            n7 = v3
            n8 = n4
            do return  end
        end
        n8 = (n5 * 256)
        n8 = (v5 + n8)
        n9 = (n4 * 435)
        n8 = (n8 + n9)
        n4 = (n8 % n2)
        n7 = 19
        n3 = (n3 + 1)
        if not ((n3 >= n1)) then
            n7 = 101
            v4 = (n5 * 435)
            v3 = (v4 % n2)
            n8 = (v4 - v3)
            v5 = (n8 / n2)
            n7 = 4
        end
        state = 112
        n11 = (v4 - v3)
        v5 = (n11 / n2)
        n11 = (n5 * 256)
        n11 = (v5 + n11)
        v8 = (n4 * 435)
        n11 = (n11 + v8)
        n4 = (n11 % n2)
        n3 = 0
        n8 = n8(n9, n10)
        n5 = bit32.bxor(v3, n8)
        n7 = 0
        n10 = (v4 - v3)
        v5 = (n10 / n2)
        n10 = (n5 * 256)
        n10 = (v5 + n10)
        v6 = (n4 * 435)
        n10 = (n10 + v6)
        n4 = (n10 % n2)
        n10 = bit32.rshift(n8, 8)
        n10 = bit32.band(n10, 255)
        n5 = bit32.bxor(v3, n10)
        v4 = (n5 * 435)
        v3 = (v4 % n2)
        n10 = (v4 - v3)
        v5 = (n10 / n2)
        n9 = 121
        v10 = (v9 * v11)
        n3 = (n3 + 4)
        n8 = w46
        n9 = k1
        n10 = n3
    end
    state = 95
    v95(w124, w125, b2, b3)
    w125 = "EnumType"
    v95 = w120[w125]
    w124 = 26
    b3 = b3()
    b4 = 1
    w125(b2, b3, b4, v97)
    v94 = L7
    v94 = v94()
    v95 = v92[47]
    w124 = 2
    w121(v94, v95, w124, w125)
    v83(w107, w108)
    v83 = w97
    w107 = v23
    w108 = "resume"
    v83(w107, w108)
    v83 = ENV.workspace
    w107 = w97
    w108 = v43
    v86 = "wrap"
    w107(w108, v86)
    state = 109
    if (state ~= 104) then
    else
        w107 = w97
        w108 = v31
        v86 = "spawn"
        w107(w108, v86)
        w107 = w97
        w108 = v32
        v86 = "defer"
        w107(w108, v86)
        w107 = w97
        w108 = v35
        v86 = "delay"
        w107(w108, v86)
        w107 = w97
        w108 = v82
        v86 = "wait"
        w107(w108, v86)
        w107 = w1[5]
        state = 66
        while true do
            w107 = v1
            w108 = w97
            v86 = k6
            w110 = "traceback"
            w108(v86, w110)
            w108 = w1[5]
            v86 = w1[5]
            state = 41
            if (state >= 116) then
                w110 = function(a1, ...) -- F202
                    do return  end
                end
                v86 = w110
                w110 = function(n1, n2, v1, fn1, a5, a6, ...) -- F212
                    n2 = w8
                    n2 = w108
                    n2()
                    n2 = w93
                    n2 = (892841 * n2)
                    n2 = (n2 + 297308)
                    n2 = (n2 % 16777216)
                    w93 = n2
                    n2 = w93
                    n2 = (888359 * n2)
                    n2 = (n2 + 5530975)
                    n2 = (n2 % 16777216)
                    w93 = n2
                    n2 = w93
                    n2 = (517693 * n2)
                    n2 = (n2 + 10063901)
                    n2 = (n2 % 16777216)
                    w93 = n2
                    n2 = w93
                    n2 = (34723 * n2)
                    n2 = (n2 + 6399898)
                    n2 = (n2 % 16777216)
                    w93 = n2
                    n2 = w93
                    do -- (terminates control flow)
                        while true do
                            n2 = (n2 + 11944249)
                            n2 = (n2 % 16777216)
                        end
                        while true do
                            n2 = w93
                            n2 = (619511 * n2)
                            n2 = (n2 + 13158945)
                            n2 = (n2 % 16777216)
                            w93 = n2
                            n2 = w93
                        end
                        v1 = w93
                        v1 = (211673 * v1)
                        v1 = (v1 + 16505416)
                        v1 = (v1 % 16777216)
                        w93 = v1
                        do return  end
                    end
                    n2 = (884145 * n2)
                    do -- (terminates control flow)
                        n2 = (n2 + 8368439)
                        n2 = (n2 % 16777216)
                        w93 = n2
                        n2 = w93
                        n2 = (892893 * n2)
                        n2 = (n2 + 1892924)
                        n2 = (n2 % 16777216)
                        w93 = n2
                        do return  end
                    end
                    n2 = w110
                    v1 = (n1 + 1)
                    n2(v1)
                    n2 = w8
                    n2 = (n2 - 1)
                    do -- (terminates control flow)
                        do return n2 end
                    end
                    n2 = n2(v1, fn1)
                    if not (n2) then
                        w93 = n2
                        n2 = w93
                        n2 = (77149 * n2)
                    end
                    v1 = function(n1, a2, a3, a4, ...) -- F228
                        local n212, v2
                        n1 = w93
                        n1 = (488551 * n1)
                        n1 = (n1 + 11463257)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        n1 = w93
                        n1 = (218691 * n1)
                        n1 = (n1 + 2359832)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        n1 = w93
                        n1 = (21605 * n1)
                        n1 = (n1 + 1243276)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        n1 = w93
                        n1 = (339477 * n1)
                        n1 = (n1 + 7553257)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        n1 = w93
                        n1 = (636249 * n1)
                        n1 = (n1 + 9752435)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        n1 = w93
                        n1 = (891329 * n1)
                        n1 = (n1 + 16497462)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        n1 = w93
                        n1 = (753455 * n1)
                        n1 = (n1 + 3820704)
                        n1 = (n1 % 16777216)
                        w93 = n1
                    end
                    fn1 = v1
                    fn1()
                    n2 = w15
                    v1 = w108
                    fn1 = function(n1, a2, a3, a4, ...) -- F218
                        local v1, v2, v3
                        n1 = w93
                        n1 = (43789 * n1)
                        n1 = (n1 + 6517415)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        n1 = w93
                        n1 = (327245 * n1)
                        n1 = (n1 + 8953997)
                        n1 = (n1 % 16777216)
                        w93 = n1
                        do return  end
                    end
                end
                state = 111
            else
                w110 = w97
                w111 = v81
                w112 = w1[5]
                v89 = true
                w110(w111, w112, v89, fn6)
                w110 = function(a1, ...) -- F191
                    do return  end
                end
                w108 = w110
                state = 116
                v95 = w97
                w124 = v16
                w125 = "new"
                v95(w124, w125)
                v94 = 37
            end
        end
    end
    w125 = w112
    b2 = "IsStudio"
    b2 = v92[b2]
    w125(b2)
    v97 = v95; b4 = v95["GetTangentOnCurve"]
    b5 = 0.375
    b4 = b4(v97, b5)
    b3 = b4
    b4 = "X"
    b4 = b3[b4]
    b4 = (b4 * 100)
    b4 = (b4 // 1)
    w101[87] = v57
    b4 = w1[5]
    v97 = 20
    b5 = 176
    v98 = 46
    v92 = w1[5]
    w120 = w1[5]
    w121 = w1[5]
    v94 = w1[5]
    v95 = w1[5]
    w124 = w1[5]
    w125 = 7
    w125 = 58
    b2 = w45
    b3 = L4
    b2, b3, b4 = b2(b3, b4)
    v92 = b2
    w120 = b3
    b2 = w45
    b3 = L5
    b2, b3, b4 = b2(b3, b4)
    w121 = b2
    v94 = b3
        -- (constant test eliminated: if (state >= 100) then)
    v95 = "string"
    if not ((v94 == v95)) then
        v94 = w55
        v94()
    end
    state = 92
    w125 = v89; w124 = v89["GetService"]
    b2 = "HttpService"
    w124 = w124(w125, b2)
    v92 = w124
    w124 = w118
    w125 = v92
    b2 = "HttpService"
    w124(w125, b2)
    if (v94 ~= 123) then
    end
    w118 = "new"
    v91 = v17[w118]
    w118 = w112
    v92 = v23
    w118(v92)
    state = 40
    b5 = v95; v97 = v95["GetPositionOnCurveArcLength"]
    v98 = 0.6666666865348816
    v97 = v97(b5, v98)
    v94 = 12
    w121 = v92[57]
    w101[55] = w65
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[57]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[56]
    w101[56] = v55
    w121 = w84
    v94 = v92[56]
    v95 = L7
    v95 = v95()
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[43]
    w101[57] = w79
    w120 = 70
        -- (constant test eliminated: if not ((39 >= w120)) then)
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[45]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[28]
    w101[60] = v91
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[28]
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = v92[63]
    w101[61] = w46
    w121 = w84
    v94 = v92[63]
    v95 = L7
    v95 = v95()
    w124 = 2
    w121(v94, v95, w124, w125)
    w120 = 56
    w121 = v92[6]
    w101[62] = v89
    w120 = 55
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = v92[22]
    b4 = 1
    w125(b2, b3, b4, v97)
    w124 = 117
    w125 = w84
    b2 = "The metatable is locked"
    b3 = w48
    b4 = v95
    b3 = b3(b4)
    b4 = true
    w125(b2, b3, b4, v97)
    w125(b2, b3, b4, v97)
    w125 = v92[35]
    w101[80] = w78
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[35]
    b4 = 1
    w125(b2, b3, b4, v97)
    w121 = w1[5]
    b4 = v100
    v97 = b2
    b5 = w124
    v97 = v97(b5)
    b5 = w83
    v98 = b3
    v99 = b4
    v100 = true
    b5(v98, v99, v100, b6)
    b5 = w84
    v98 = b4
    b3 = b3()
    b4 = 1
    w125(b2, b3, b4, v97)
    w125 = w118[2]
    w101[9] = w125
    w107 = w97
    w108 = v20
    v86 = "cancel"
    w107(w108, v86)
    state = 104
    state = 13
    v100 = v98[v100]
    b6 = true
    v99(v100, b6)
    v94 = v94()
    v95 = v92[9]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[8]
    w101[71] = w71
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[8]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = 125
    v94 = 224
    v95 = 33
        -- (constant test eliminated: if (16 >= w124) then)
    w121 = 72
    v94 = 173
    v95 = 25
    while true do
        b4 = "Clone"
        b4 = w121[b4]
        v97 = "Clone"
        b3(b4, v97)
    end
    w116 = w112
    v91 = v54
    w116(v91)
    w116 = w112
    v91 = v19
    w116(v91)
    w116 = {}
    w116[4] = 3
    w116[5] = 1
    w116[10] = 6
    state = 72
    v91 = w112
    w118 = v26
    v91(w118)
    v91 = w112
    w118 = v29
    v91(w118)
    v91 = nil
    state = 45
    w120 = 102
    w121 = v92[58]
    w101[50] = w77
    w120 = 99
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[3]
    w124 = 2
    w121(v94, v95, w124, w125)
    while true do
        b4 = true
        b2(b3, b4)
        v94 = 49
    end
    v94 = w45
    v95 = v2
    w124 = false
    v94, v95, w124 = v94(v95, w124, w125)
    v92 = v94
    w120 = v95
    w121 = 61
        -- (constant test eliminated: if not ((w121 >= 86)) then)
        if v92 then
        end
    b3 = b3[b4]
    w111 = v29
    w112 = v35
    v89 = 299
    fn6 = w55
    w112 = w112(v89, fn6)
    w111(w112)
    w111 = w1[5]
    w112 = nil
    state = 52
    fn4 = w97
    v82 = v21
    v83 = "unpack"
    fn4(v82, v83)
    state = 24
    state = 58
    b2 = b2(b3, b4)
    b3 = w1[5]
    v94 = 61
    w118 = w112
    v92 = v32
    w118(v92)
    w118 = w112
    v92 = v35
    w118(v92)
    state = 108
    w118 = w112
    v92 = v31
    w118(v92)
    state = 1
    v44 = "readu32"
    w54 = t7[v44]
    state = 117
    w55 = function(fn1, i1, v1, i2, ...) -- F376
        local t1, v2
        fn1 = w1[5]
        L7 = fn1
        v8 = v1
        v9 = v1
        L10 = v1
        L11 = v1
        v3 = v1
        fn1 = function(t1, v2, a3, t4, t5, t6, t7, t8, k1, fn2, a11, ...) -- F382
            local v7
            t1 = ENV.string
            t1 = t1[0]
            v2 = ENV.string
            v2 = v2[0]
            t4 = v2
            t5 = " "
            t6 = 8
            t4 = t4(t5, t6)
            t5 = function(n1, n2, n3, v1, n4, n5, v2, a8, a9, ...) -- F388
                n3 = 1
                if (n1 >= n2) then
                    n4 = (n1 % 2)
                    v1 = (v1 + n3)
                    n5 = (n1 - n4)
                    n1 = (n5 / 2)
                    n3 = (n3 * 2)
                end
                n1 = n2
                v2 = (n1 - n4)
                n1 = (nil / 2)
                v2 = (n2 - n5)
                n2 = (v2 / 2)
                n3 = (n3 * 2)
                do -- (terminates control flow)
                    n4 = v1
                    do return n4 end
                end
                v1 = (v1 + n3)
                n4 = (n1 % 2)
                n5 = (n2 % 2)
            end
            t6 = function(n1, n2, n3, n4, n5, v1, a7, a8, ...) -- F398
                local v2
                if (not n3) then
                    n4 = (n2 - 1)
                    n4 = (2 ^ n4)
                    n5 = (n4 + n4)
                    n5 = (n1 % n5)
                    n5 = (n5 >= n4)
                    if not ((not n5)) then
                        n5 = 1
                    end
                end
                n4 = (n2 - 1)
                n4 = (2 ^ n4)
                n4 = (n1 / n4)
                n5 = (n3 - 1)
                v1 = (n2 - 1)
                n5 = (n5 - v1)
                n5 = (n5 + 1)
                n5 = (2 ^ n5)
                n4 = (n4 % n5)
                n5 = (n4 % 1)
                n5 = (n4 - n5)
                do return n5 end
                n5 = 0
                repeat
                until not (n5)
            end
            t7 = function(fn1, v1, v2, v3, v4, fn2, v5, v6, a9, ...) -- F408
                local fn3, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79, v80, v81, v82, v83, v84, v85, v86, v87, v88, v89, v90, v91, v92, v93, v94, v95, v96, v97, v98, v99, v100, v101, v102, v103, v104, v105, v106, v107, v108, v109, v110, v111, v112, v113, v114, v115, v116, v117, v118, v119, v120, v121, v122, v123, v124, v125, v126, v127, v128, v129, v130, v131, v132, v133, v134, v135, v136, v137, v138, v139, v140, v141, v142, v143, v144, v145, v146, v147, v148, v149, v150, v151, v152, v153, v154, v155, v156, v157, v158, v159, v160, v161, v162, v163, v164, v165, v166, v167, v168, v169, v170, v171, v172, v173, v174, v175, v176, v177, v178, v179, v180, v181, v182, v183, v184, v185, v186, v187, v188, v189, v190, v191, v192, v193, v194, v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209, v210, v211, v212, v213, v214, v215, v216, v217, v218, v219, v220, v221, v222, v223, v224, v225, v226, v227, v228, v229, v230, v231, v232, v233, v234, v235, v236, v237, v238, v239, v240, v241, v242, v243, v244, v245, v246, v247, v248, v249, v250, v251, v252, v253, v254, v255, v256, v257, v258, v259, v260, v261, v262, v263, v264, v265, v266, v267, v268, v269, v270, v271, v272, v273, v274, v275
                fn1 = t1
                v1 = UPVALS[fn1]
                v2 = 1
                fn1, v1, v2, v3, v4 = fn1(v1, v2, v3, v4)
                v4 = t5
                fn2 = v3
                v4 = v4(fn2, v5)
                v4 = (v4 * 16777216)
                fn2 = t5
                v5 = v2
                fn2 = fn2(v5, v6)
                fn2 = (fn2 * 65536)
                v4 = (v4 + fn2)
                fn2 = t5
                v5 = v1
                fn2 = fn2(v5, v6)
                fn2 = (fn2 * 256)
                v4 = (v4 + fn2)
                fn2 = t5
                v5 = fn1
                fn2 = fn2(v5, v6)
                v4 = (v4 + fn2)
                do return v4 end
            end
            t8 = function(k1, fn1, v1, n1, v2, v3, v4, n2, a9, a10, ...) -- F420
                local v5
                k1 = t7
                -- (junk op: register-file store with a decoded-at-runtime index)
                fn1 = t7
                fn1 = fn1()
                n1 = UPVALS[k1]
                v2 = fn1
                v4 = 20
                n1 = n1(v2, v3, v4)
                n1 = (n1 * 4294967296)
                n1 = (n1 + k1)
                v2 = t6
                v3 = fn1
                v4 = 21
                n2 = 31
                v2 = v2(v3, v4, n2)
                v3 = t6
                v4 = fn1
                n2 = 32
                v3 = v3(v4, n2)
                v3 = (1 ^ v3)
                v3 = (-v3)
                do -- (terminates control flow)
                    repeat
                    until not (v4)
                    v4 = (v3 * 0)
                    v4 = (v4 / 0)
                    v4 = (v2 - 1023)
                    v4 = (2 ^ v4)
                    v4 = (v3 * v4)
                    n2 = (n1 / 4503599627370496)
                    n2 = (v1 + n2)
                    v4 = (v4 * n2)
                    do return v4 end
                end
                if not ((n1 ~= 0)) then
                    v4 = (v3 * 0)
                    do return v4 end
                end
                v2 = 1
                v4 = (n1 == 0)
                v4 = (v3 * 1)
                v4 = (v4 / 0)
            end
            k1 = function(v1, fn1, fn2, a4, t1, i1, i2, i3, a9, fn3, fn4, fn5, fn6, fn7, fn8, fn9, fn10, a18, ...) -- F432
                fn1 = t7
                fn1 = fn1()
                fn2 = 1
                fn8 = t8
                -- (junk op: register-file store with a decoded-at-runtime index)
                fn8 = t1[fn8]
                fn8 = t5
                fn9 = t8
                fn9 = fn9()
                fn10 = t8
                fn8 = fn8(fn9, fn10(a18))
                t1[fn7] = fn8
                fn7 = t7
                fn7 = fn7()
                fn8 = t8
                fn8 = fn8()
                if (not fn8) then
                    t1[fn7] = fn8
                    fn7 = t6
                    fn8 = t8
                    fn8 = fn8()
                    fn9 = t7
                    fn7 = fn7(fn8, fn9(fn10))
                    fn8 = {} -- size 1
                    fn9 = t8
                    fn9 = fn9()
                    fn10 = t7
                    fn10(a18)
                    -- table.move range
                    t1[fn7] = fn8
                end
                fn8 = UPVALS[fn1]
                fn8 = fn8()
                do -- (terminates control flow)
                    v1 = t5
                    fn1 = t8
                    fn1 = fn1()
                    fn2 = t7
                    fn2(a4)
                    do return v1(...--[[registers fn1..top of stack]]) end
                end
                fn3 = 0
                fn4 = 255
                fn5 = 1
                while true do
                    t1 = {}
                    i1 = 0
                    i2 = 255
                    i3 = 1
                end
                while true do
                    fn4 = fn4(fn5, fn6(fn7))
                    t1[fn3] = fn4
                    fn3 = t5
                    fn4 = t7
                    fn4 = fn4()
                    fn5 = t7
                    fn3 = fn3(fn4, fn5(fn6))
                    fn4 = UPVALS[v1]
                    fn5 = t7
                    fn5 = fn5()
                    fn6 = t7
                    fn4 = fn4(fn5, fn6(fn7))
                    t1[fn3] = fn4
                end
                i1 = 1
                i2 = t7
                i2 = i2()
                i3 = 1
                fn3 = t5
                fn4 = t7
                fn4 = fn4()
                fn5 = t7
                fn3 = fn3(fn4, fn5(fn6))
                fn4 = t5
                fn7 = t7
                fn7 = fn7()
                fn7 = t8
                fn7 = fn7()
                while true do
                    fn5 = fn5()
                    fn6 = t7
                end
                fn5 = t7
            end
            fn2 = k1
            fn2 = fn2()
            if not ((not fn2)) then
                fn2 = k1
                fn2()
            end
            do return  end
        end
        fn1()
        t1, fn1, i1, v1, i2 = nil
        -- opaque op 125 (instr 10)
        t1 = t1[fn1]
        fn1 = {}
        i1 = 1
        v1 = (#t1)
        i2 = 1
        -- (empty spin loop: dispatcher exit the structurer could not
        --  recover; commented out -- it can never terminate on its own)
        -- while true do
        -- end
        t1[v2] = fn1
    end
    state = 80
    w121 = w84
    v94 = L7
    v94 = v94()
    v95 = v92[14]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[9]
    w101[70] = b3
    w121 = w84
    v94 = L7
    w125(b2, b3, b4, v97)
    w121 = w1[5]
    v94 = w1[5]
    v95 = w1[5]
    w124 = 71
    if not ((v91 >= 188)) then
        if not ((36 >= v91)) then
            w118 = v43
            v92 = function(fn1, v1, a3, ...) -- F114
                fn1 = w39
                fn1(v1)
                fn1 = w39
                v1 = w112
                fn1(v1)
                do return  end
            end
            w118 = w118(v92)
            v89 = w118
        end
    end
    w118 = w83
    v92 = v89
    v92 = v92()
    w120 = 1468268675
    w121 = true
    w118(v92, w120, w121, v94)
    w118 = w83
    v92 = v89
    v92 = v92()
    w120 = w112
    w121 = true
    w118(v92, w120, w121, v94)
    state = 7
    v55 = k5
    v56 = 2048
    v55 = v55(v56)
    w66 = v55
    state = 31
        -- (constant test eliminated: if (41 >= state) then)
        if (114 >= state) then
                -- (constant test eliminated: if not ((state >= 41)) then)
                w36 = w1[37]
                state = 114
        else
            w40 = w1[36]
        end
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[37]
    b4 = 1
    w125(b2, b3, b4, v97)
    w118 = v75
    v92 = mathLib
    w120 = {}
    w120[2728713478] = 1541303681
    w120[901450932] = 1153969210
    w120[889552922] = 784453481
    w118(v92, w120)
    state = 57
    w118 = v75
    v92 = v37
    w120 = {}
    w120[410403160] = 452019009
    w120[749373828] = 168960940
    w120[2260094527] = 595074863
    w120[1939539207] = 1070924627
    w120[2267345195] = 659079966
    w118(v92, w120)
    w118 = v75
    v92 = taskLib
    w120 = {}
        -- (constant test eliminated: if not ((state >= 119)) then)
        fn2 = w97
        fn3 = w60
        fn4 = "setfenv"
        fn2(fn3, fn4)
        state = 65
    w120 = 13
    w121 = w84
    v94 = v92[58]
    v95 = L7
    v95 = v95()
    w124 = 2
    w121(v94, v95, w124, w125)
    if (31 >= w120) then
        w120 = 114
        w121 = w84
        v94 = L7
        v94 = v94()
        v95 = v92[11]
        w124 = 1
        w121(v94, v95, w124, w125)
    else
        w120 = 116
        w121 = w84
        v94 = L7
        v94 = v94()
        v95 = v92[34]
        w124 = 2
        w121(v94, v95, w124, w125)
    end
    -- (empty spin loop: dispatcher exit the structurer could not
    --  recover; commented out -- it can never terminate on its own)
    -- while true do
    -- end
        -- (constant test eliminated: if (w120 > 47) then)
        w121 = v92[48]
        w101[48] = v14
        w120 = 57
    w88 = function(v1, v2, a3, k1, k2, k3, v3, fn1, i1, v4, i2, n1, fn2, v5, a15, ...) -- F463
        local v6
        k1 = v2
        k2 = w45
        k3 = w1[5]
            -- (constant test eliminated: if not ((93 > v3)) then)
            k3 = w1[5]
            i1 = 24
            v4 = 237
            i2 = 108
            while true do
                i1 = k1
                k3 = w83
            end
        fn1 = k2
        i1 = k1
        v4 = ...  -- vararg fill: also writes R11, R12, ... (count is runtime dependent)
        fn1, i1, v4 = fn1()
        k2 = fn1
        k1 = i1
        k3 = w79
        fn1 = w1[5]
        fn1 = k2
        v6 = UP120[nil]
        fn1 = v1
        v4 = k3
        i2 = fn1
        n1 = i1
        v4(i2, n1)
        fn2 = k3
        v5 = fn1
        fn2(v5)
        -- (empty spin loop: dispatcher exit the structurer could not
        --  recover; commented out -- it can never terminate on its own)
        -- while true do
        -- end
        do -- (terminates control flow)
            do return  end
        end
    end
    state = 48
    v97 = "X"
    v97 = b4[v97]
    v97 = (v97 * 100)
    v97 = (v97 // 1)
    w101[89] = v82
    v97 = v92
    b5 = "X"
    b5 = b4[b5]
    v98 = true
    v97(b5, v98)
    v97 = 6
    b5 = 231
    v98 = 117
    state = 54
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = v92[18]
    b4 = 1
    w125(b2, b3, b4, v97)
    b2 = "Y"
    b2 = w125[b2]
    b2 = b2[0]
    b2 = (b2 * 100)
    b2 = (b2 // 1)
    w101[84] = b2
    b2 = v92
    b3 = "Y"
    b3 = w125[b3]
    b4 = "Scale"
    b3 = b3[b4]
    b4 = true
    b2(b3, b4)
    b3 = v95; b2 = v95["GetPositionOnCurve"]
    b4 = 0.2857142984867096
    w125 = v92[49]
    w101[78] = stringLib
    w125 = w83
    if (w120 ~= 99) then
    else
        w118 = {}
        v92 = function(v2, v3, v4, n1, v5, v6, v7, v8, b1, i1, i2, i3, n2, i4, n3, fn1, m17, v10, v11, a20, ...) -- F30
            local v1, v12, v13
            v4 = w1[5]
            n1 = 4
            v4 = v9
            n1 = 19
            i1 = w1[5]
            i2 = 40
            i3 = 246
            n2 = 107
            repeat
            until not ((i4 >= 147))
            v6 = w63
            v6 = w58
            v5 = (v5 + v6)
            do -- (terminates control flow)
                do return  end
            end
            v8 = v8[b1]
            i1 = v6
            i2 = v8
            i1(i2)
            v6 = UPVALS[v5]
            i1 = 2
            i2 = 30
            i3 = 7
            v8 = v7
            b1 = true
            while true do
                v6[v8] = b1
                i1 = 51
                i2 = 245
                i3 = 97
            end
            v8 = v4
            n1 = 100
                -- (constant test eliminated: if not ((98 >= n1)) then)
                b1 = true
            v8 = w118
            if (n2 ~= 9) then
                v8 = v4
            else
                b1 = v1
                v6[v8] = b1
            end
            v6 = (v6 // v8)
            i1 = 68
            i2 = 83
            i3 = 15
            while true do
                v6 = UPVALS[v5]
                n1 = 89
                v7 = (v7 - v5)
            end
            v5 = v4
            v8 = w1[5]
            b1 = w1[5]
            i1 = 112
            i2 = 463
            i3 = 71
            n2 = 70
            i4 = 21
            repeat
            until not ((n3 ~= 28))
            b1 = 175
            i1 = 57
            v8 = v5
            v2 = v6
            v6 = v3
            b1 = w1[5]
            while true do
                v8 = w66
                i2 = w1[5]
                i3 = 7
                v11 = i1
                fn1(m17, v10, v11, a20)
            end
            v6 = w118
            n1 = 48
            v6 = (v6 + v8)
            v6 = (v6 * v8)
            i2 = 231
            i3 = 71
            repeat
            until not ((n2 ~= 254))
            b1 = true
                -- (constant test eliminated: if (n2 ~= 69) then)
                v6[v8] = b1
            i2 = w58
            fn1 = v6
            m17 = v8
            v10 = i2
            b1 = v2
            i2 = 213
            i3 = 91
            -- (empty spin loop: dispatcher exit the structurer could not
            --  recover; commented out -- it can never terminate on its own)
            -- while true do
            -- end
            v6 = w78
            v6 = w118
            b1 = w1[5]
            v6[v8] = b1
            n1 = 98
            v6[v8] = b1
            v6 = v2
            v6 = w118
            v8 = v5
            i1 = 69
            v6 = w1[5]
            v7 = w1[5]
            w58 = v6
            v6[v8] = b1
            v6 = w118
            i1 = 17
        end
        w120 = w1[5]
        w121 = w1[5]
        v94 = 94
    end
    v95 = v95()
    w124 = 2
    w121(v94, v95, w124, w125)
    w116 = w112
    v91 = w17
    w116(v91)
    w116 = w112
    v91 = w18
    w116(v91)
    state = 115
    w121(v94, v95, w124, w125)
    w121 = w118[10]
    w101[13] = w121
    w121 = w84
    v94 = L7
    v94 = v94()
    v95 = w118[10]
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = w118[4]
    w101[14] = w40
    w121 = w84
    v94 = w118[4]
    v95 = L7
    v95 = v95()
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = w118[7]
    w101[15] = v20
    w120 = 95
    v97 = 613
    b5 = true
    b3(b4, v97, b5, v98)
    w121 = v92[45]
    w101[59] = w84
    w120 = 90
    w101(fn2, fn3)
    w101 = w1[5]
    state = 30
    if (w120 >= 21) then
    else
        w74 = w1[65]
        w75 = {}
        v62 = w1[5]
    end
    b3 = 813
    w124 = w124(w125, b2, b3)
    w125 = 807
    b2 = true
    v95(w124, w125, b2, b3)
    v94 = 102
    v99 = v97[4]
    v100 = 95
        -- (constant test eliminated: if (36 >= state) then)
    v55 = w1[59]
    state = 29
    w124 = "NextUnitVector"
    w124 = w121[w124]
    w125 = "NextUnitVector"
    v95(w124, w125)
    v95 = w97
    w124 = "NextInteger"
    w124 = w121[w124]
    w125 = "NextInteger"
    v95(w124, w125)
    v95 = w97
    w124 = "NextNumber"
    w124 = w121[w124]
    w125 = "NextNumber"
    v95(w124, w125)
    v95 = 23
    w124 = 66
    w125 = 43
    w121 = w84
    v94 = L7
    v94 = v94()
    v95 = v92[v92]
    w124 = 2
    w121(v94, v95, w124, w125)
    w120 = 79
    v73 = w1[5]
    w90 = w1[5]
    state = 60
    v66 = w1[66]
    state = 11
    b3 = v92[31]
    b4 = 1
    w125(b2, b3, b4, v97)
    w120 = 92
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = w118[1]
    w124 = 1
    w121 = 87
    v94 = 281
    v95 = 97
    while true do
        b4 = "Y"
        b4 = b2[b4]
        v97 = "Scale"
        b4 = b4[v97]
    end
    w124 = 2
    w121(v94, v95, w124, w125)
    w120 = 78
    w121 = w84
    v94 = v92[51]
    v95 = L7
    v95 = v95()
    v94 = 119
    w125 = w97
    b2 = "GetAsync"
    b2 = v92[b2]
    b3 = "GetAsync"
    w125(b2, b3)
    w124 = 114
    w125 = w97
    b2 = "PostAsync"
    b2 = v92[b2]
    b3 = "PostAsync"
    w125(b2, b3)
    w125 = w97
    b2 = "RequestAsync"
    b2 = v92[b2]
    b3 = "RequestAsync"
    w125(b2, b3)
    v94 = 15
    v95 = w118
    w124 = w121
    w125 = "Folder"
    v95(w124, w125)
    v95 = w84
    w124 = "Parent"
    w124 = w121[w124]
    w125 = w120
    b2 = true
    v95(w124, w125, b2, b3)
    v95 = "WaitForChild"
    v95 = w120[v95]
    w124 = w84
    w125 = "Parent"
    w125 = w121[w125]
    b2 = "Parent"
    b2 = w121[b2]
    b3 = true
    w124(w125, b2, b3, b4)
    w124 = w97
    w125 = v95
    b2 = "WaitForChild"
    w124(w125, b2)
    w124 = w1[5]
    w125 = 116
    b2 = 133
    b3 = 17
    if (not v92) then
    else
        b2 = w55
        b2()
    end
    b3 = w118[12]
    b4 = 1
    w125(b2, b3, b4, v97)
    b2 = L7
    b2 = b2()
    b3 = v92[38]
    b4 = 2
    w125(b2, b3, b4, v97)
    w121 = 6
    v94 = 334
    v95 = 82
    b2 = w45
    b3 = L6
    b2, b3, b4 = b2(b3, b4)
    v95 = b2
    w124 = b3
    w125 = 81
    w120 = 55
    w120 = 42
    w121 = v92[26]
    w101[81] = v327
    v92 = v20
    w118(v92)
    state = 42
    w125 = v92[36]
    w101[67] = fn3
        -- (constant test eliminated: if (v94 >= 106) then)
    w125 = v92[1]
    w101[31] = w125
    state = 10
    v94 = w1[169]
    v95 = L12[4]
    v94 = v94(v95)
    w121 = w121(v94)
    v94 = L12[6]
    w121 = (w121 + v94)
    v94 = L12[1]
    w121 = (w121 - v94)
    v94 = L12[7]
    w121 = (w121 + v94)
    w121 = (-7254156035 + w121)
    v94 = 1
    w121 = w118[9]
    w101[17] = w18
    w120 = 8
    w71 = identifyexecutor
    state = 74
    if not ((w124 == 252)) then
        w125 = v92[51]
        w101[33] = w27
    end
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[32]
    b4 = 1
    w125(b2, b3, b4, v97)
    w120 = 66
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[17]
    w124 = 1
    w121(v94, v95, w124, w125)
    v99 = "X"
    v99 = v98[v99]
    v99 = (v99 * 100)
    v99 = (v99 // 1)
    w101[95] = b2
    v94 = 27
    v100 = v100(b6, v101)
    v100 = (#v99)
    v100 = w90
    b6 = v99
    v100 = v100(b6)
    v100 = b2[v100]
    if v100 then
        w120 = (w120 + v100)
        w125 = (w125 + 1)
        if (50 >= w125) then
            v98, v99, v100 = coroutine.resume(v98, v99, v100)
            if v98 then
                v100 = w80
                b6 = "string"
                v101 = w13
                v102 = v99
                v101 = v101(v102)
            else
                w125 = "HumanoidCollisionType"
                w125 = v92[w125]
                b2 = "OuterBox"
                w125 = w83
                b2 = L7
                b2 = b2()
                b3 = w118[13]
                b4 = 2
                w125(b2, b3, b4, v97)
                w125 = w118[6]
            end
        end
    end
    b4 = 1
    w125(b2, b3, b4, v97)
    w97 = function(v1, b1, v2, fn1, fn2, v3, v4, v5, v6, fn3, i1, i2, state, fn4, fn5, v7, v8, v9, a19, ...) -- F313
        local v10, v11
        fn1 = w33
        fn2 = v1
        fn1 = fn1(fn2)
        fn1 = w84
        fn2 = w13
        v3 = v1
        fn2 = fn2(v3)
        v3 = "function"
        fn1(fn2, v3)
        fn1 = w88
        fn2 = "'setfenv' cannot change environment of given object"
        v3 = w60
        v4 = v1
        v5 = w95
        fn1(fn2, v3, v4, v5, v6)
        fn1 = w51
        fn2 = v1
        v3 = "slnaf"
        fn1, fn2, v3, v4, v5, v6, fn3 = fn1(fn2, v3, v4)
        fn3 = w83
        i1 = "[C]"
        i2 = fn1
        fn3(i1, i2)
        fn3 = 66
        i1 = 430
        i2 = 60
        fn1 = w55
        fn1()
        repeat
        until not (v2)
        fn4 = w84
        fn5 = v3
        v7 = b1
        fn4(fn5, v7)
        fn4 = w84
        fn5 = 0
        v7 = v4
        fn4(fn5, v7)
        fn4 = w84
        fn5 = true
        v7 = v5
        fn4(fn5, v7)
        fn4 = UPVALS[v1]
        fn5 = v1
        v7 = v6
        fn4(fn5, v7)
        while true do
            fn4 = 65
        end
        fn4 = w71
        fn5(v7, v8)
        fn5 = w84
        v7 = w74
        v8 = v1
        v7 = v7(v8)
        v8 = true
        fn5 = w84
        v7 = false
        v8 = w85
        v9 = v1
        fn5(v7, v8(v9, a19))
        fn4 = 106
    end
    v81 = w97
    w100 = w48
    w101 = "getmetatable"
    v81(w100, w101)
    state = 32
    b4 = v91
    v97 = "Path2D"
    b4 = b4(v97)
    v95 = b4
    v89 = w112
    fn6 = v44
    v90 = -19393
    v89(fn6, v90)
    v89 = w1[5]
    state = 107
    w118 = w112
    v92 = fn1
    w118(v92)
    w118 = w112
    v92 = w51
    w118(v92)
    w118 = w112
    v92 = v81
    w118(v92)
    w118 = w97
    v92 = v91
    w120 = "new"
    w118(v92, w120)
    w118 = w112
    v92 = v91
    w120 = w1[5]
    w118(v92, w120)
    state = 43
    v95 = v9
    v95 = v95()
    w120 = bit32.bxor(v95, 1180920661)
    state = 68
    w121 = w83
    v94 = L7
    v94 = v94()
        -- (constant test eliminated: if (state >= 46) then)
            -- (constant test eliminated: if not ((state >= 75)) then)
            if not ((46 >= state)) then
                b3 = v46
                b4, v97 = nil
                -- generic-for iterator (coroutine desugar) reg R127
                w125 = v92[24]
                w101[24] = w52
                w125 = w84
                b2 = L7
            end
    w121 = w121(v94)
    w121 = (-26 + w121)
    v94 = 1
    w121(v94, v95, w124, w125)
    w121 = v92[10]
    w101[65] = w85
    if not ((w120 ~= 78)) then
        w121 = v92[42]
        w101[34] = v110
        w121 = w83
        v94 = L7
        v94 = v94()
        v95 = v92[42]
        w124 = 1
        w121(v94, v95, w124, w125)
        w121 = v92[53]
        w101[35] = v243
        w121 = w83
        v94 = L7
        v94 = v94()
        v95 = v92[53]
        w124 = 1
        w121(v94, v95, w124, w125)
        w121 = 111
        w125 = v92[31]
        w101[29] = v83
        w125 = w83
        b2 = L7
        b2 = b2()
    end
    while true do
        b6 = "Y"
        b6 = b4[b6]
        v101 = true
        v100(b6, v101)
    end
    v100 = v92
    w101 = w97
    fn2 = v2
    fn3 = "assert"
    w101(fn2, fn3)
    w101 = w97
    fn2 = w3
    fn3 = "error"
    w78 = function(v1, v2, v3, v4, n1, v5, i1, i2, v6, fn1, v7, v8, a13, ...) -- F329
        local v9
        v3 = w50
        v4 = w1[5]
        n1 = 38
        v6 = v3
        fn1 = v4
        v7 = i1
        v8 = v5
        v6(fn1, v7, v8, a13)
        i2 = 9
        n1 = 77
        v4 = v1
        -- (empty spin loop: dispatcher exit the structurer could not
        --  recover; commented out -- it can never terminate on its own)
        -- while true do
        -- end
        v3 = w61
        v3 = w55
        v4 = w66
        i1 = w58
        i2 = 82
        fn1 = v3
        fn1()
        i1 = 254
        i2 = 92
    end
    state = 50
    v100 = b2
    b6 = v94
    v100 = v100(b6)
    b4 = 1
    w125(b2, b3, b4, v97)
    v95 = v95()
    w124 = 2
    w121(v94, v95, w124, w125)
    w125 = v92[39]
    w101[68] = w64
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[39]
    b4 = 1
    w125(b2, b3, b4, v97)
    w125 = v92[14]
    w101[69] = v30
    w111 = w1[5]
    w116 = v31
    v91 = function(v1, a2, a3, ...) -- F246
        local v2, v3
        while true do
            -- (junk op: register-file store with a decoded-at-runtime index)
            w111 = v1
            do return  end
        end
        v1 = w23
    end
    w116(v91)
    fn4 = w97
    v82 = v14
    v83 = "isyieldable"
    fn4(v82, v83)
    state = 97
    v95 = w83
    w124 = "table"
    w125 = w13
    b2 = L12
    w125 = w125(b2)
    b2 = true
    v95(w124, w125, b2, b3)
    k3 = false
    v19 = true
    w27[k3] = v19
    k3 = true
    v19 = false
    w27[k3] = v19
    k3 = w1[27]
    v19 = "concat"
    v19 = t5[v19]
    v20 = w1[5]
    v21 = w1[5]
    v22 = w1[5]
    state = 91
    w33 = "create"
    v22 = t4[w33]
    w33 = function(k1, k2, t1, n1, v1, a6, a7, ...) -- F487
        local v2, v3, v4
        k2 = w1[5]
        t1 = w1[5]
        n1 = 96
        n1 = 63
        k2 = k1
        while true do
            t1 = UPVALS[k1]
            k2 = (not k2)
            t1 = t1[k2]
            v1 = t1
            do return v1 end
        end
    end
    k5 = "create"
    k5 = t7[k5]
    v92 = w1[5]
    w120 = w1[5]
    w121 = 86
    b5 = (b5 * 100)
    b5 = (b5 // 1)
    w101[92] = t4
    v101 = 0.20000000298023224
    v100 = v100(b6, v101)
    b4 = v100
    w124 = v73
    w125 = v92
    w124(w125)
    w111 = v29
    w112 = v31
    v89 = function(fn1, a2, ...) -- F154
        fn1 = w39
        fn1()
        do return  end
    end
    w112 = w112(v89)
    w111(w112)
    state = 81
    fn6 = w112
    v90 = w60
    w116 = -31710
    fn6(v90, w116)
    state = 78
    v99 = "Y"
    v99 = v98[v99]
    v99 = (v99 * 100)
    v99 = (v99 // 1)
    w101[96] = v301
    v99 = w1[5]
    v100 = 69
    b6 = 491
    v101 = 125
    while true do
        b2 = 0
        b3 = 0
        v95 = v95(w124, w125, b2, b3)
        w121["Position"] = v113
        v95 = "Size"
        w124 = fn6
        w125 = 0
        b2 = 144
        b3 = 0
    end
    w112 = 1188220356
    w125 = w118[15]
    w101[3] = w14
    w121 = L12[4]
    w121 = L12[2]
    w121 = (-2535928120 + w121)
    v94 = 1
    v94 = v94(v95)
    v95 = true
    w120(w121, v94, v95, w124)
    w120 = w1[5]
    w121 = 67
    v94 = 99
    v95 = 16
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[7]
    b4 = 2
    w125(b2, b3, b4, v97)
    w55 = nil
    v43 = w1[5]
    state = 110
    v105 = 0
    v106 = 0
    fn10 = fn10(v103, v104, v105, v106)
    v103 = fn6
    v105 = -7
    v106 = 0
    v107 = 2
    v103(v104, v105, v106, v107, a143)
    v101()
    -- table.move range
    b4(v97, b5)
    w125 = v95; w124 = v95["GetLength"]
    w124 = w124(w125)
    w125 = (w124 * 100)
    w125 = (w125 // 1)
    w101[82] = w111
    w125 = w1[5]
    v94 = 80
    w125 = v92[38]
    w101[30] = w50
    w125 = w84
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[40]
    b4 = 1
    w125(b2, b3, b4, v97)
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[27]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[50]
    w101[42] = w110
    w120 = 7
    v60 = Vector2
    w101[22] = v56
    w120 = 89
    while true do
        v98 = b3
        v99 = v97
        v100 = true
        b5(v98, v99, v100, b6)
        w125 = 1
    end
    b5 = w84
    w121 = v92; w120 = v92["Destroy"]
    w120(w121)
    w120 = w1[w1]
    w121 = w1[5]
    v94 = 14
    w125 = v92[15]
    w101[76] = w124
    if (v94 ~= 63) then
        w124 = 1
        w125 = v95
        b2 = 1
    else
        v94 = 18
        w125 = w121; w124 = w121["NextInteger"]
        b2 = 181
        b3 = 605
        w124 = w124(w125, b2, b3)
        v95 = (w124 % 24)
    end
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[59]
    b4 = 1
    w125(b2, b3, b4, v97)
    w125 = v92[18]
    w101[73] = v78
    w125 = 0
    b2 = w1[5]
    b3 = 54
    b4 = 98
    b3, b4, v97 = coroutine.resume(b3, b4, v97)
    if b3 then
        v94 = (v94 + 1)
        v81 = w1[5]
        state = 7
    end
    w121 = v92[47]
    w101[45] = w58
    w120 = 29
    w121 = w83
    w121 = v92[62]
    w101[54] = k6
    w121 = w84
    v94 = v92[62]
    v95 = L7
    v95 = v95()
    w124 = 1
    w121(v94, v95, w124, w125)
    w125 = v92[11]
    w101[25] = fn2
    w17 = "match"
    w12 = stringLib[w17]
    w13 = w1[13]
    w17 = "find"
    w14 = stringLib[w17]
    state = 92
        -- (constant test eliminated: if not ((8 >= state)) then)
            -- (constant test eliminated: if not ((state >= 102)) then)
            w8 = 6666
            state = 8
            w125 = w84
            b2 = L7
            b2 = b2()
            b3 = w118[5]
            b4 = 2
            w125(b2, b3, b4, v97)
            w120 = v92
            v94 = 21
            v90 = b3
            v92 = w1[5]
            w120 = 14
            w121 = 79
            v94 = 2
            v81[w100] = w101
            w100 = "isvararg"
            w101 = true
            v81[w100] = w101
            v78 = v81
            state = 5
    t4 = coroutine
    v6 = "gmatch"
    w7 = stringLib[v6]
    w124 = v9
    w124()
    v98 = v95; b5 = v95["GetPositionOnCurveArcLength"]
    v99 = 0.4000000059604645
    b5 = b5(v98, v99)
    v98 = b5[0]
    v99 = "Scale"
    v98 = v98[v99]
    v98 = (v98 * 100)
    v98 = (v98 // 1)
    w125 = 0.9787031188959563
    b2 = true
    v95(w124, w125, b2, b3)
    v95 = w83
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w125 = 0.5760869541013449
    b2 = true
    v95(w124, w125, b2, b3)
    v95 = w1[5]
    v94 = 63
    w125 = w84
    b2 = v95[w121]
    b3 = w120
    b4 = true
    w125(b2, b3, b4, v97)
    w124 = 92
    w121 = w118
    v94 = v92
    v95 = "RunService"
    w121(v94, v95)
    w120 = 61
    w121 = w83
    v94 = v89
    v95 = "Parent"
    v95 = v92[v95]
    w124 = true
    w121(v94, v95, w124, w125)
    w121 = w97
    v94 = w1[w1]
    v94 = v92[v94]
    v95 = "IsStudio"
    w121(v94, v95)
    w121 = w97
    v94 = "IsClient"
    v94 = v92[v94]
    v95 = "IsClient"
    w121(v94, v95)
    w121 = 31
    v94 = 39
    v95 = 8
    fn2 = w97
    fn3 = v44
    fn4 = "getfenv"
    fn2(fn3, fn4)
    state = 106
    fn4 = w97
    v82 = w23
    v83 = "running"
    fn4(v82, v83)
    fn4 = w97
    v82 = v22
    v83 = "create"
    fn4(v82, v83)
    fn4 = w1[5]
    v82 = w1[5]
    state = 76
    v94 = 0
    w111 = v62
    w112 = (w93 % 256)
    w112 = (w93 - w112)
    w112 = (w112 / 256)
    w111(w112)
    state = 77
    w121 = (w121 - v94)
    v94 = L12[1]
    w121 = (w121 - v94)
    v94 = L12[7]
    w121 = (w121 ~= v94)
    if (not w121) then
    end
    w101[11] = t5
    v29 = "yield"
    w39 = t4[v29]
    state = 116
    w125 = v92[32]
    w101[32] = k2
    w125 = w84
    b3 = v95; b2 = v95["FromValue"]
    b4 = v94
    b2 = b2(b3, b4)
    b3 = w120
    b2(b3, b4)
    if not ((v92 >= 78)) then
        v92 = 107
        w120 = 1
        w121 = w1[169]
    end
    w120 = 1
    w121 = L12[6]
    v94 = L12[1]
    w121 = (w121 - v94)
    v94 = L12[7]
    w121 = (w121 + v94)
    v94 = L12[2]
    v92 = w1[5]
    w120 = 19
    v83 = "abs"
    fn4 = mathLib[v83]
    state = 94
    w116 = w112
    v91 = w18
    w116(v91)
    state = 70
    if (state ~= 40) then
    else
        w118 = w112
        v92 = v43
        w118(v92)
        w118 = w112
    end
    if not ((33 >= v90)) then
        w116 = w50
        v91 = w45
        w118 = v29
        v92 = w111
    end
    v99 = 43
    v100 = bit32.bxor(b3, 64)
    b6 = w16
    v101 = b3
    b6 = b6(v101)
    w100[v100] = b6
    v100 = 47
    b6 = w36
    v101 = v98
    v102 = b2
    b6(v101, v102)
    w101 = w97
    fn2 = w37
    fn3 = "tostring"
    w101(fn2, fn3)
    state = 123
    if not ((111 >= w124)) then
        w125 = w84
        b2 = v92[15]
        b3 = L7
        b3 = b3()
        b4 = 1
        w125(b2, b3, b4, v97)
        w121 = 67
        v94 = 172
        v95 = 35
        while true do
            b4 = 2
            w125(b2, b3, b4, v97)
        end
    end
    w125 = w84
    b2 = v92[44]
    b3 = L7
    w125 = w97
    b2 = "FromValue"
    b2 = v95[b2]
    b3 = "FromValue"
    w125(b2, b3)
    w125 = w112
    b2 = v95[0]
    w125(b2)
    w125 = w112
    b2 = "FromValue"
    b2 = v95[b2]
    w125(b2)
    w124 = 50
    w121 = w118[14]
    w101[16] = w66
    w120 = 105
    w124 = w83
    w125 = v89
    b2 = "Parent"
    b2 = v92[b2]
    b3 = true
    w124(w125, b2, b3, b4)
    w124 = 31
    v98[328532366] = v294
    v98[1929211092] = v116
    v98[440669232] = v330
    v98[1011881004] = v117
    v98[2267675775] = v128
    v98[1132109174] = v140
    v98[2571219683] = v187
    v98[236808915] = v310
    w125 = v92[27]
    w101[41] = v66
    w125 = w83
    b2 = w52
    b3 = v95
    b2 = b2(b3)
    b3 = "Enum"
    b4 = true
    w125(b2, b3, b4, v97)
    w124 = 110
    w120 = 86
    v94 = v89; w121 = v89["GetService"]
    v95 = "RunService"
    v105 = -9
    v102 = v102(fn10, v103, v104, v105)
    fn10 = fn6
    v103 = 0
    repeat
    until not ((v94 >= 120))
    v94 = 106
    b4 = v92
    v97 = "Y"
    v97 = b2[v97]
    b5 = "Scale"
    v97 = v97[b5]
    b5 = true
    b4(v97, b5)
    fn6 = w112
    v90 = w13
    fn6(v90)
    fn6 = w112
    v90 = w40
    fn6(v90)
    state = 81
    w121 = v92[34]
    w101[26] = w112
    w120 = 41
    w121 = w84
    v94 = v92[6]
    v95 = L7
    v95 = v95()
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = v92[33]
    w101[63] = w121
    w121 = w84
    v94 = L7
    v94 = v94()
    v95 = v92[33]
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = v92[19]
    w101[64] = w120
    w121 = w84
    v94 = L7
    v94 = v94()
    v95 = v92[19]
    w124 = 2
    v99 = fn10
    w121 = 53
    v94 = 233
    v95 = 29
    while true do
        b2 = (b2 // 1)
        w101[83] = fn4
    end
    b2 = (b2 * 100)
    while not ((43 >= v94)) do -- while-exit-cond
        v92 = 4
        w120 = 0
        v94 = 43
        v95 = 0
        w124 = (w120 - 1)
        w125 = 1
    end
    v92 = 60
    w120 = 1
    w121 = w1[166]
    v94 = w1[167]
    v95 = w1[168]
    w124 = L12[2]
    w125 = L12[2]
    w124 = (w124 + w125)
    w125 = L12[1]
    w124 = (w124 + w125)
    v95 = v95(w124)
    v94 = v94(v95)
    v95 = w118[7]
    w124 = 2
    w121(v94, v95, w124, w125)
    w120 = 50
    v97 = w112
    b5 = v95
    v98 = w1[5]
    v97(b5, v98)
    v94 = w13
    v95 = w120
    v94 = v94(v95)
    b2 = "X"
    b2 = w125[b2]
    b3 = "Scale"
    b2 = b2[b3]
    v98 = v98[v99]
    v99 = true
    b5(v98, v99)
    w111 = function(v1, v2, fn1, v3, v4, a6, ...) -- F56
        v2 = (v1 + 3)
        fn1 = w51
        v3 = v2
        v4 = "f"
        fn1 = fn1(v3, v4)
        do return fn1 end
    end
    state = 3
    v100 = "Y"
    v100 = b4[v100]
    v100 = (v100 * 100)
    v100 = (v100 // 1)
    w101[90] = b7
    v95 = w84
    w124 = w13
    w125 = L12[v94]
    w124 = w124(w125)
    w125 = "number"
    v95(w124, w125)
    w120 = 47
    w121 = v92[17]
    w101[47] = w21
    -- (empty spin loop: dispatcher exit the structurer could not
    --  recover; commented out -- it can never terminate on its own)
    -- while true do
    -- end
    v94 = 59
    v95 = w83
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w120 = 107
    w83 = function(v1, v2, v3, v4, v5, n1, i1, i2, i3, n2, n3, i4, i5, i6, n4, i7, n5, a18, a19, ...) -- F94
        local v6
        v4 = w82
        v5 = v1
        n1 = w1[5]
        i1 = 26
        i2 = 107
        i3 = 27
        if (4 >= n3) then
            if not ((n3 >= 121)) then
                if not ((2 >= n3)) then
                    v5 = (v5 == n1)
                    v5 = v1
                    v4 = v5
                    v5 = w61
                    i4 = w1[5]
                    i5 = w1[5]
                    n3 = 51
                        -- (constant test eliminated: if (51 >= n3) then)
                end
            end
        end
        v4 = 1
        n3 = 2
        i4 = 82
        i5 = 106
        i6 = 24
        v5 = v3
        while not ((not v4)) do -- while-exit-cond
        end
        v4 = v5
        v5 = (v5 == n1)
        if not ((not v5)) then
            i4 = 107
            i5 = 288
            i6 = 125
        end
        i6 = v5
        n4 = n1
        i7 = i4
        n5 = i5
        i6(n4, i7, n5, a18)
        i6 = 112
        n4 = 116
        i7 = 2
        -- (empty spin loop: dispatcher exit the structurer could not
        --  recover; commented out -- it can never terminate on its own)
        -- while true do
        -- end
        v5 = w58
        v5 = v2
        do -- (terminates control flow)
            do return  end
        end
        n3 = 4
        n1 = 1
        while true do
            n3 = n3(i4, i5)
            v4 = n3
        end
        i5 = n1
        v4 = v3
        n1 = 2
        if (n5 >= 116) then
        end
        v4 = w55
        n3 = v4
        n3()
        n1 = v2
        n3 = v4
        i4 = v5
        n1 = 1
        v5 = (v5 + n1)
        i5 = v4
        w58 = v5
        v5 = v3
        n3 = 121
    end
    w84 = function(v1, k1, v2, b1, v3, n1, v4, i1, i2, n2, v5, n3, i3, i4, i5, n4, a17, a18, ...) -- F104
        local v6
        b1 = w1[5]
        v3 = w1[5]
        n1 = w1[5]
        v4 = 17
        i1 = 68
        i2 = 3
        n1 = k1
        v5 = b1
        n3 = v3
        i3 = n1
        v5 = v5(n3, i3)
        b1 = v5
        i2 = 76
        v3 = w61
        i1 = b1
        v3 = v1
        b1 = (not b1)
        if (not b1) then
            b1 = v2
        else
            b1 = w55
            v4 = b1
            v4()
        end
        v3 = w58
        i2 = 37
        v3 = (v3 == n1)
        i3 = 0
        i4 = 92
        i5 = 46
        v3 = (v3 == n1)
        repeat
        until not ((59 >= i2))
        n1 = w66
        i2 = 59
        i2 = 64
        n1 = 1
        v3 = (v3 + n1)
        -- (junk closure op at instr 115: child proto not statically decoded)
        w58 = v3
        repeat
        until not ((not b1))
        v4 = 111
        i1 = 197
        i2 = 86
        v3 = k1
        b1 = v3
        v4 = w58
            -- (constant test eliminated: if not ((n2 >= 197)) then)
            b1 = 0
            v3 = v2
        i2 = 94
        n2 = v3
        v5 = n1
        n3 = v4
        i3 = i1
        n2(v5, n3, i3, i4)
        n1 = 2
        v3 = v1
        b1 = v3
        v4 = nil
        i1 = w1[5]
        i2 = 115
        n2 = 219
        n1 = 1
    end
    w85 = w1[5]
    w86 = w1[5]
    v71 = w1[5]
    w88 = w1[5]
    b3 = "IsServer"
    w125(b2, b3)
    state = 2
    if not ((v95 ~= 16)) then
    end
    w124 = w36
    w125 = v92
    b2 = w1[5]
    w124(w125, b2)
    state = 11
    repeat
    until not ((state > 59))
    v83 = w97
    w107 = w39
    w108 = "yield"
    v83(w107, w108)
    v83 = w97
    w107 = v29
    w108 = "close"
    v83 = "wait"
    v82 = taskLib[v83]
    state = 37
    w121 = w84
    v94 = v92[48]
    v95 = L7
    v95 = v95()
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = v92[3]
    w101[49] = w51
    w120 = 20
    w125 = v92[61]
    w101[74] = v90
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = v92[61]
    v94 = 62
    v99 = v92
    v100 = "X"
    state = 112
    w37 = w1[5]
    v26 = w1[5]
    w39 = w1[5]
    w40 = w1[5]
    state = 31
    if not ((217 >= v95)) then
        w125 = v92; w124 = v92["GetChildren"]
        w124, w125, b2, b3 = w124(w125, b2)
        -- generic-for iterator (coroutine desugar) reg R124
        repeat
        until not ((w120 > 50))
    end
    w124 = v91
    w125 = "Folder"
    w124 = w124(w125)
    v92 = w124
    v95 = v92
    w124 = 962686649
    v95 = v95(w124)
    w121 = v95
    v94 = 99
    v100 = 0
    v55 = "tostring"
    w65 = t7[v55]
    state = 64
    fn10 = v92
    v103 = "X"
    v103 = v99[v103]
    b3 = w97
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = v92[36]
    v98 = v44
    v98 = v98()
    v99, v100 = nil
    -- generic-for iterator (coroutine desugar) reg R131
    w124 = w118
    w125 = v92
    b2 = "Folder"
    w124(w125, b2)
    v95 = w84
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w125 = 0.490891385082238
    b2 = true
    v95(w124, w125, b2, b3)
    v94 = 13
    w108 = w97
    v86 = fn1
    w110 = "unpack"
    w108(v86, w110)
    state = 57
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[26]
    w124 = 1
    w121(v94, v95, w124, w125)
    state = 47
    state = 75
    b5 = b5[v98]
    b5 = (b5 * 100)
    b5 = (b5 // 1)
    w101[91] = w80
    v94 = 123
    w125 = w97
    b2 = "IsServer"
    b2 = v92[b2]
    while true do
        w121 = "The metatable is locked"
        v94 = w48
        v95 = v92
    end
    w120 = w83
    v99 = 124
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[54]
    w124 = 1
    w121(v94, v95, w124, w125)
    w120 = 16
    k6 = "traceback"
    k6 = v37[k6]
    w54 = w1[5]
    fn3 = w97
    fn4 = w12
    v82 = "match"
    fn3(fn4, v82)
    while true do
        v100 = true
        b5(v98, v99, v100, b6)
        w125 = 42
    end
    w125(b2, b3, b4, v97)
    v99 = v97
    if (w120 ~= 29) then
    else
        w120 = 88
        w121 = v92[54]
        w101[46] = w75
    end
    w111(w112)
    state = 72
    v95 = w83
    w125 = w121; w124 = w121["NextInteger"]
    b2 = 748
    if not ((v94 ~= 64)) then
        v95 = v91
        w124 = "Frame"
        v95 = v95(w124)
        w121 = v95
        v95 = fn6
        w124 = 0
    end
    v94 = 101
    b5 = v97[0]
    v98 = "Scale"
    b5 = b5[v98]
    while true do
        v105 = 7
        v102 = v102(fn10, v103, v104, v105)
        fn10 = fn6
        v103 = 0
    end
    v103 = -8
    w125 = w97
    b2 = "FromName"
    b2 = v95[b2]
    b3 = "FromName"
    w125(b2, b3)
    w124 = 80
    v102 = fn6
    fn10 = 0
    v103 = 4
    t7 = buffer
    state = 13
    v95 = nil
    w124 = w1[5]
    w125 = nil
    b2 = w1[5]
    state = 39
    v95 = v95()
    w124 = 1
    w121(v94, v95, w124, w125)
    w121 = v92[30]
    b3 = w84
    b4 = 0.09719103083780782
    b5 = w121; v97 = w121["NextNumber"]
    v97 = v97(b5)
    b5 = true
    b3(b4, v97, b5, v98)
    b3 = w83
    v97 = w121; b4 = w121["NextInteger"]
    b5 = 587
    v98 = 618
    b4 = b4(v97, b5, v98)
    w121 = v92[13]
    w101[27] = v62
    w120 = 67
    if (v99 ~= 66) then
        v100 = v92
        b6 = "X"
        b6 = b3[b6]
        v101 = true
        v100(b6, v101)
    end
    w121 = w84
    v94 = v92[55]
    v95 = L7
    fn2 = w97
    fn3 = w45
    fn4 = "pcall"
    fn2(fn3, fn4)
    state = 101
    b3 = w55
    b3()
    w120 = 95
    w121 = w84
    v94 = v92[13]
    v95 = L7
    b3 = v95; b2 = v95["GetPositionOnCurve"]
    b4 = 0.46666666865348816
    b2 = b2(b3, b4)
    w125 = b2
    v98[2950335024] = v120
    v98[945981900] = v114
    v98[2716838150] = v119
    v98[2691622896] = v100
        -- (constant test eliminated: if (state ~= 78) then)
    w111 = v23
    w112 = v22
    v89 = w110
    w112 = w112(v89)
    v89 = 1
    w111(w112, v89)
    w111 = v62
    w112 = w93
    w111(w112)
    w125 = w84
    b2 = w118[2]
    b3 = L7
    b3 = b3()
    b4 = 2
    w125(b2, b3, b4, v97)
        -- (constant test eliminated: if (state >= 85) then)
    w124 = L10
    w124()
    w121 = 16
    v94 = 95
    v95 = 15
    w125 = w84
    b2 = v92[21]
    b3 = L7
    b3 = b3()
    b4 = 1
    w125(b2, b3, b4, v97)
    w124 = true
    w121(v94, v95, w124, w125)
    w121 = w97
    v94 = "IsA"
    v94 = w120[v94]
    v95 = "IsA"
    w121(v94, v95)
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = v92[10]
    b4 = 1
    w125(b2, b3, b4, v97)
    b4 = 1
    w125(b2, b3, b4, v97)
    w125(b2, b3, b4, v97)
        -- (constant test eliminated: if not ((90 >= w120)) then)
            -- (constant test eliminated: if not ((w120 >= 109)) then)
            w120 = 39
            w121 = w84
            v94 = v92[2]
            v95 = L7
    state = 122
    -- (empty spin loop: dispatcher exit the structurer could not
    --  recover; commented out -- it can never terminate on its own)
    -- while true do
    -- end
    v95 = w112
    w124 = v16
    w125 = w1[5]
    v95(w124, w125)
    v94 = 64
    v95 = v91
    w124 = "ScreenGui"
    v95 = v95(w124)
    w120 = v95
    w120 = 31
    w82 = function(v1, v2, k1, v3, v4, i1, i2, v5, a9, a10, ...) -- F283
        local v6, v7
        k1 = w1[5]
        v3 = w1[5]
        v4 = 118
        i1 = 180
        i2 = 62
        do -- (terminates control flow)
            k1 = v4
            k1 = (not k1)
            v4 = k1
            do return v4 end
        end
        k1 = w80
        while true do
            v4 = k1
            i1 = v3
            i2 = v2
            v4 = v4(i1, i2)
        end
        v3 = v1
    end
    w111 = w1[5]
    w112 = 33
    v89 = 156
    fn6 = 123
    while true do
        w124()
    end
    v92 = function(fn1, v1, v2, fn2, fn3, fn4, fn5, v3, v4, a10, ...) -- F473
        local v5, v6, v7
        fn1 = w77
        v1 = w66
        v2 = w58
        fn1, v1, v2 = fn1(v1, v2, fn2)
        v2 = UPVALS[v2]
        fn2 = 8
        v2 = v2(fn2)
        fn2 = w64
        fn3 = v2
        fn4 = 0
        fn5 = fn1
        fn2(fn3, fn4, fn5, v3)
        fn2 = 104
        while true do
            fn3 = w64
            fn4 = v2
            fn5 = 4
            v3 = v1
            fn3(fn4, fn5, v3, v4)
            fn2 = 39
        end
        while true do
            -- table.move range
            do return fn3 end
        end
        fn4(fn5, v3, v4, a10)
            -- (constant test eliminated: if (104 > fn2) then)
            fn3 = {}
            fn4 = UPVALS[fn3]
            fn5 = w65
            v3 = v2
            fn5 = fn5(v3)
            v4 = -1
    end
    v92 = v92()
    w120 = w1[5]
    w121 = w1[5]
    v94 = nil
    state = 57
    w124 = L7
    w125 = 0
    state = 126
    fn6 = UDim2.new
    state = 100
    v89 = game
    state = 48
    w101 = w97
    fn2 = k3
    fn3 = "select"
    w101(fn2, fn3)
    state = 108
        -- (constant test eliminated: if not ((91 >= state)) then)
        w101 = w97
        fn2 = w15
        fn3 = "xpcall"
        w101(fn2, fn3)
        state = 91
    w90 = function(v1, n1, v2, i1, i2, i3, n2, i4, fn1, i5, v3, v4, i6, i7, i8, n3, v5, n4, v6, v7, v8, v9, i9, i10, i11, n5, n6, v10, a29, a30, ...) -- F609
        local v11, v12
        n1 = w1[5]
        v2 = nil
        i1 = 21
        i2 = 184
        i3 = 37
        n6 = (v6 * 403)
        v10 = (n4 * v8)
        v9 = (n6 + v10)
        i9 = (v9 * 65536)
        i9 = (i9 + v7)
        n1 = (i9 % 4294967296)
        do -- (terminates control flow)
            i1 = bit32.bxor(n1, 320281964)
            do return i1 end
        end
        i4 = 1
        fn1 = (#v2)
        i5 = 1
        if (n5 ~= 53) then
        end
        v5 = (n1 * 16777619)
        n1 = (v5 % 4294967296)
        fn1(i5, v3, v4, i6)
        -- table.move range
        v2 = i4
        i5 = v1
        v4 = -1
        v9 = w1[5]
        i9 = 7
        i10 = 174
        i11 = 46
        n4 = (n1 % 65536)
        n1 = 2166136261
        i4 = {}
        fn1 = w17
        repeat
        until not ((n3 > 94))
        v4 = v2[v3]
        n1 = bit32.bxor(n1, v4)
        n4 = w1[5]
        v6 = w1[5]
        v7 = w1[5]
        v8 = w1[5]
        v4 = w1[5]
        i6 = 94
        i7 = 266
        i8 = 55
        n6 = (n1 - n4)
        v6 = (n6 / 65536)
        v7 = (n4 * 403)
    end
    v75 = w1[5]
    w92 = w1[5]
    w93 = w1[5]
    state = 82
    b5 = "X"
    b5 = v97[b5]
    v98 = "Scale"
    k2 = "rep"
    k2 = stringLib[k2]
    w27 = {}
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = w118[16]
    b4 = 2
    w121 = 21
    v94 = 556
    v95 = 107
    while true do
        b2 = v92
        b3 = w124
        b4 = true
    end
    v94 = 111
    w121 = w83
    v94 = "The metatable is locked"
    v95 = w48
    w124 = w120
    v95 = v95(w124)
    w121 = v92[23]
    w101[53] = v23
    w120 = 80
    fn3 = w97
    fn4 = w17
    v82 = "byte"
    v99 = (w121 + b2)
    b5 = b5(v98, v99)
    b3 = b5
    b5 = (b2 % 8)
    b5 = (b5 + 1)
    b4 = v92[b5]
    b5 = w61
    v98 = v94
    v99 = (w121 + b2)
    v100 = bit32.bxor(b3, b4)
    b5(v98, v99, v100, b6)
    v37 = v2
    w50 = debug
    w51 = "The debug library is required on Luau platforms. Please open a support ticket."
    v37 = v37(w50, w51)
    w50 = function(v1, v2, k1, n1, i1, i2, i3, n2, v3, a10, a11, ...) -- F498
        local v4, v5
        v2 = w1[5]
        k1 = w1[5]
        n1 = 102
        k1 = v1
        do -- (terminates control flow)
            do return  end
        end
        while true do
            i1 = 103
            i2 = 257
            i3 = 69
                -- (constant test eliminated: if not ((103 >= n2)) then)
                v3 = v2
                do return v3 end
        end
        k1 = (not k1)
        v2 = w27
        n1 = 13
        v2 = v2[k1]
    end
    w51 = w1[5]
    w52 = w1[5]
    b4 = "Parent"
    w121[b4] = w120
    if (b2 > 163) then
    end
    w121 = v92[55]
    w101[21] = v37
    w120 = 98
    v97 = w121[v97]
    b3(b4, v97)
        -- (constant test eliminated: if (w120 >= 56) then)
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = w118[17]
    w124 = 2
    w121(v94, v95, w124, w125)
    w121 = w118[16]
    w101[5] = w3
    v91 = v91(w118, v92)
    w116 = w116(v91)
    w15 = w1[11]
    state = 11
    v98 = v99
    w121 = w84
    v94 = L7
    v94 = v94()
    v95 = v92[50]
    w124 = 1
    v103 = v95; fn10 = v95["GetTangentOnCurveArcLength"]
    fn10 = fn10(v103, v104)
    v62 = function(v1, fn1, v2, v3, v4, a6, ...) -- F303
        local v5
        fn1 = w61
        v2 = w66
        v3 = w58
        v4 = (v1 % 256)
        fn1(v2, v3, v4, a6)
        fn1 = w58
        fn1 = (fn1 + 1)
        w58 = fn1
        do return  end
    end
    state = 0
    b3 = w1[5]
    b4 = w1[5]
    v97 = 1
    v55 = "writeu8"
    w61 = t7[v55]
    state = 76
    -- (junk op: register-file store with a decoded-at-runtime index)
    v56 = Vector3
    state = 88
    v90 = w37
    fn6(v90)
    fn6 = w112
    v90 = v30
    b4 = L7
    b4()
    v92 = 78
    v97 = 108
    b5 = w46
    v98 = v94
    k6 = "info"
    w51 = v37[k6]
    state = 15
    v92 = w1[111]
    -- generic-for iterator (coroutine desugar) reg R124
    w124, w125, b2 = coroutine.resume(w124, w125, b2)
    if w124 then
        b2 = w55
        b2()
    end
    v98 = {}
    v98[4049439760] = w121
    v98[124078634] = v280
    v98[1259237318] = v420
    v98[2423708338] = v127
    v98[2855685826] = v408
    v98[301381932] = v133
    b5 = v92
    v98 = "X"
    v98 = v97[v98]
    v99 = "Scale"
    v98 = v98[v99]
    v99 = true
    b5(v98, v99)
    v94 = 30
    w111 = v62
    w112 = (w93 % 65536)
    w112 = (w93 - w112)
    w112 = (w112 / 65536)
    b5 = w13
    v98 = b4
    b5 = b5(v98)
    v98 = "function"
    v95 = w84
    w124 = 0.2258909312414879
    b2 = w121; w125 = w121["NextNumber"]
    w125 = w125(b2)
    b2 = true
    v95(w124, w125, b2, b3)
    w101[88] = v153
    v100 = v92
    b6 = "Y"
    b6 = b3[b6]
    v101 = true
    v100(b6, v101)
    b6 = v95; v100 = v95["GetTangentOnCurve"]
    w125 = v92[16]
    w101[79] = v17
    w125 = w83
    b2 = L7
    b2 = b2()
    b3 = v92[16]
    b4 = 2
    w121 = w118[1]
    w101[12] = w121
    w120 = 11
    v97 = w121
    b3 = b3(b4, v97)
    b4 = true
    v95 = v95(w124)
    w121 = v95
    w33 = "cancel"
    v20 = taskLib[w33]
    w33 = "unpack"
    v21 = stringLib[w33]
    w121 = w83
    v94 = L7
    v94 = v94()
    w125 = v92[44]
    w101[75] = v213
    v83(w107, w108)
    state = 59
    b6 = v97[3]
    v99[0] = v94
    b6 = w36
    v101 = b5
    v102 = b2
    b6(v101, v102)
    v100 = 16
    repeat
    until not ((77 >= state))
    v94 = 26
    w48 = w1[43]
    w125 = w84
    b2 = w118[6]
    b3 = L7
    b3 = b3()
    b4 = 2
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = v3
    b3 = b3()
    v95 = b3
    w124 = 97
    state = 90
    w121 = v92[v92]
    w101[58] = w61
    w120 = 104
    b5 = v92
    v98 = v97[0]
    v99 = "Scale"
    fn10 = (fn10 // 1)
    w101[97] = v95
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = v92[1]
    w80 = function(v1, v2, v3, v4, i1, n1, i2, n2, v5, v6, n3, a12, a13, ...) -- F452
        v3 = w1[5]
        v4 = nil
        i1 = 66
        n1 = 294
        i2 = 57
        if (n3 >= 242) then
        end
        v5 = w1[5]
        v3 = (v4 == v5)
        v4 = v1
        i2 = false
        n1 = 80
        n1 = 111
        v3[v4] = i1
        v3[v4] = i1
        if not ((n3 >= 343)) then
            if not ((141 >= n3)) then
                i1 = w1[5]
            end
        end
        v4 = v2
        v6 = w1[5]
        v3 = (v4 == v6)
            -- (constant test eliminated: if not ((66 >= v5)) then)
                -- (constant test eliminated: if not ((68 >= v5)) then)
                if not ((v6 == 26)) then
                    v3 = true
                end
                n3 = v3
                do return n3 end
        v4 = v2
        v3 = i2
        v3 = w75
        n1 = 2
        v4 = v2
        v3 = v3[v4]
        v6 = v3
        n3 = v4
        v6 = v6(n3)
        repeat
        until not ((n2 >= 180))
        v4 = v1
        v5 = v3
        v6 = v4
        v5 = v5(v6)
        v3 = v5
        v3 = w50
        v3 = UPVALS[v2]
        v3 = w75
            -- (constant test eliminated: if (22 >= n1) then)
            n1 = 125
            i1 = true
        i1 = w1[5]
        n1 = 22
        -- (empty spin loop: dispatcher exit the structurer could not
        --  recover; commented out -- it can never terminate on its own)
        -- while true do
        -- end
        v3 = v6
        do -- (terminates control flow)
            n2 = v3
            do return n2 end
        end
        do -- (terminates control flow)
            v3 = false
            v6 = v3
            do return v6 end
        end
        if not ((v6 >= 64)) then
            v4 = v1
            v5 = w1[5]
        end
    end
    v66 = w1[5]
    w82 = w1[5]
    state = 92
    v17 = Instance
    w125 = w84
    b2 = L7
    b2 = b2()
    b3 = w118[15]
    b4 = 2
    w125(b2, b3, b4, v97)
    w125 = w118[17]
    w101[4] = w107
    v97 = w37
    b5 = 481249152
    v97 = v97(b5)
    w124 = v97
    w121 = v92
    v95 = (v92 / 2)
    w124 = (v92 / 4)
    w125 = v92[52]
    w101[20] = v19
    fn6 = w112
    v90 = w36
    fn6(v90)
    fn6 = w112
    v90 = v57
    fn6(v90)
    fn6 = w112
    v83 = w97
    w107 = v26
    w108 = "status"
    b3 = w83
    b4 = v89
    v97 = "Parent"
    v100 = (w124 * b3)
    v100 = (v100 + w92)
    b3 = (v100 % 256)
    while true do
        -- (junk op: register-file store with a decoded-at-runtime index)
        b3 = v92[49]
    end
    w125 = w118[13]
    w101[10] = v21
    b2 = L7
    v105 = 0
    v106 = -8
    b6 = b6(v101, v102, fn10(v103, v104, v105, v106, v107))
    v101 = v16
    w107 = nil
    state = 113
    w121 = w83
    v94 = L7
    v94 = v94()
    v95 = v92[43]
    w124 = 1
    w121(v94, v95, w124, w125)
    w120 = 109
    v44 = "wrap"
    v43 = t4[v44]
    v44 = getfenv
    w58 = 0
    v46 = w1[5]
    w60 = w1[5]
    w61 = w1[5]
    v49 = w1[5]
    w63 = nil
    w64 = w1[5]
    w65 = nil
    w66 = w1[5]
    v54 = w1[5]
    w124 = w124(w125, b2, b3)
    w125 = 526
    b2 = true
    v95(w124, w125, b2, b3)
    v94 = 76
    b2 = 296
    b3 = 1020
    w124 = w124(w125, b2, b3)
    w125 = 692
    b4 = (b4 * 100)
    b4 = (b4 // 1)
    w101[86] = w90
    b4 = w121; b3 = w121["GetChildren"]
    b3, b4, v97, b5 = b3(b4, v97)
    -- generic-for iterator (coroutine desugar) reg R127
    do -- (terminates control flow)
        b3 = function(t1, i1, i2, i3, n1, k1, a7, a8, a9, ...) -- F508
            local v1, v2, v3, v4, v5, v6, v7, v8
            t1 = {}
            i1 = 46
            i2 = 62
            i3 = 8
            i1 = 7
            if not ((i1 ~= 58)) then
                i1 = 81
                i2 = function(a1, a2, a3, v1, n1, v2, a7, ...) -- F514
                    local v3
                    v1 = w1[176]
                    n1 = w101[44]
                    v2 = w101[93]
                    v1 = v1(n1, v2)
                    n1 = w101[89]
                    v1 = (v1 < n1)
                    if not ((not v1)) then
                        v1 = w101[46]
                    end
                    v1 = w101[31]
                    repeat
                    until not (v1)
                    do -- (terminates control flow)
                        do return v1 end
                    end
                end
                t1[8] = v5
            end
            i1 = 58
            i2 = function(a1, a2, fn1, n1, n2, a6, a7, ...) -- F574
                local v1, v2, v3
                do -- (terminates control flow)
                    fn1 = (-4294903594 + fn1)
                    do return fn1 end
                end
                while true do
                    fn1 = w1[177]
                    n1 = w101[1]
                    n2 = w101[34]
                    n1 = (n1 - n2)
                    n2 = w101[86]
                    fn1 = fn1(n1, n2)
                end
            end
            t1[7] = v3
            v8 = (v7 < v6)
            k1 = function(a1, a2, a3, a4, n1, n2, a7, a8, ...) -- F524
                n1 = w101[16]
                n2 = w101[1]
                n1 = (n1 - n2)
                n2 = w101[43]
                n1 = (n1 - n2)
                n1 = (135 + n1)
                do return n1 end
            end
            t1[3] = v1
            k1 = function(a1, a2, v1, z4, a5, a6, ...) -- F534
                v1 = w101[74]
                z4 = w101[12]
                v1 = (v1 + z4)
                z4 = w101[10]
                v1 = (v1 == z4)
                v1 = w101[22]
                v1 = (31 + v1)
                do return v1 end
                v1 = w101[3]
            end
            t1[4] = k1
            k1 = function(a1, a2, a3, a4, n1, n2, a7, a8, ...) -- F544
                n1 = w101[74]
                n2 = w101[78]
                n1 = (n1 - n2)
                while true do
                    n1 = (n1 - n2)
                    n1 = (465 + n1)
                    do return n1 end
                end
                n2 = w101[12]
            end
            t1[5] = i2
            while true do
                do return i2 end
            end
            i2 = t1
            k1 = function(a1, a2, a3, a4, n1, n2, a7, a8, ...) -- F554
                local v1, v2
                n1 = w101[12]
                n2 = w101[80]
                n1 = (n1 + n2)
                n2 = w101[10]
                n1 = (n1 < n2)
                n1 = w101[31]
                if not (n1) then
                    n1 = w101[37]
                end
                n1 = (-137 + n1)
                do return n1 end
            end
            t1[2] = k1
            i1 = 39
            i2 = 113
            i3 = 74
            while true do
                if not ((n1 ~= 54)) then
                    k1 = function(a1, a2, a3, a4, fn1, fn2, v1, v2, a9, ...) -- F564
                        fn1 = w1[168]
                        fn2 = w1[175]
                        v1 = w101[74]
                        v2 = w101[91]
                        fn2 = fn2(v1, v2)
                        fn1 = fn1(fn2)
                        fn1 = (169 + fn1)
                        do return fn1 end
                    end
                    t1[6] = v4
                end
            end
            k1 = function(a1, a2, n1, n2, a5, a6, ...) -- F584
                local v1
                n1 = w101[89]
                n2 = w101[55]
                n1 = (n1 - n2)
                n2 = w101[75]
                n1 = (n1 <= n2)
                if not ((not n1)) then
                    n1 = w101[71]
                end
                if n1 then
                    n1 = (-86 + n1)
                    do return n1 end
                end
                n1 = w101[80]
            end
            t1[1] = v2
        end
        b3 = b3()
        b3 = v95
        do return b3 end
    end
    fn6 = w112
    v90 = w12
    fn6(v90)
    state = 111
    w79 = function(v1, k1, v2, k2, n1, v3, v4, i1, n2, v5, i2, i3, i4, i5, state, fn1, v6, v7, v8, a20, ...) -- F599
        local fn2, v9, v10
        v2 = w1[5]
        k2 = w1[5]
        n1 = 65
        while true do
            v3 = v2
            v4 = k2
            v3 = v3(v4)
            i2 = w58
            k2 = w66
            i3 = 89
            i4 = 350
            i5 = 69
            -- (empty spin loop: dispatcher exit the structurer could not
            --  recover; commented out -- it can never terminate on its own)
            -- while true do
            -- end
        end
        v2 = (v2 + k2)
        w58 = v2
        do return  end
        v2 = UPVALS[k1]
        n1 = 44
        k2 = 1
        v2 = k1
            -- (constant test eliminated: if not ((state >= 227)) then)
            v2 = w58
            -- (constant test eliminated: if not ((state >= 296)) then)
        if (not v2) then
        end
        fn1(v6, v7, v8, a20)
            -- (constant test eliminated: if not ((89 >= state)) then)
            v2 = w55
                -- (constant test eliminated: if not ((v3 ~= 74)) then)
                v4 = v2
                v4()
                v4 = 136
                i1 = 14
        fn1 = v2
        v6 = k2
        v7 = i2
        v8 = v5
        v2 = w61
            -- (constant test eliminated: if (i5 ~= 109) then)
        v2 = v3
        v5 = w1[5]
        i2 = 40
        i3 = 142
        i4 = 69
        n1 = 27
        k2 = v1
    end
    fn10 = "X"
    fn10 = v99[fn10]
    fn10 = (fn10 * 100)
    v94 = 44
    v100 = v95; v99 = v95["GetTangentOnCurveArcLength"]
    b6 = 0.46666666865348816
    v99 = v99(v100, b6)
    w124 = w124(w125)
    w125 = "Random"
    b2 = true
    v95(w124, w125, b2, b3)
    v95 = w97
    state = 68
    w124 = 450
    w125 = 57
    w125 = function(t1, v2, n1, v3, v4, v5, v6, i1, v7, v8, v9, v10, v11, v12, v13, a16, ...) -- F619
        local v1
        v2 = t1[1]
        n1 = t1[2]
        if (n1 ~= "boolean") then
            if not ((n1 ~= "string")) then
                v3 = w17
                v4 = v2
                v3 = v3(v4, v5, v6)
                v3 = (v3 ~= 0)
                v4 = w17
                v5 = v2
                i1 = 2
                v4 = v4(v5, v6, i1)
                v5 = w124
                v5 = (v5 * v4)
                v6 = w92
                v5 = (v5 + v6)
                v4 = (v5 % 256)
            end
            v2 = (-v2)
            v4 = (#t1)
        end
        if not ((v8 > v9)) then
            v10 = v6[v8]
            v11 = (v8 + 1)
            v11 = v6[v11]
        end
        v10 = v6[v8]
        v6[v7] = v10
        v7 = (v7 + 1)
        i1 = (v7 - 1)
        i1 = (#v6)
        v2 = v6[1]
        i1 = t1[v6]
        v7 = (v6 + 1)
        v7 = t1[v7]
        v8 = (v6 + 2)
        v8 = t1[v8]
        v9 = i1[v8]
        v9[v7] = v2
        v9 = w116[v8]
        v9 = i1[v9]
        v9[v7] = v1
        do -- (terminates control flow)
            v6 = {}
            i1 = 3
            v7 = (#v2)
            while true do
                v9 = (i1 - 1)
            end
            do return  end
        end
        v10 = w17
        v11 = v2
        v12 = v9
        v10 = v10(v11, v12)
        v10 = bit32.bxor(v10, v4)
        v10 = w100[v10]
        v6 = (v6 .. v10)
        v10 = w124
        v10 = (v10 * v4)
        v11 = w92
        v10 = (v10 + v11)
        v4 = (v10 % 256)
        v2 = v6
        v4 = w21
        v5 = v2
        v4 = v4(v5, v6)
        v2 = v4
        while true do
            v6[v7] = v10
            v7 = (v7 + 1)
            v8 = (v8 + 2)
        end
        v10 = (v9 - 2)
        v11 = w17
        v12 = v2
        v13 = v9
        v11 = v11(v12, v13)
        v11 = bit32.bxor(v11, v4)
        v11 = w100[v11]
        v6[v10] = v11
        v10 = w124
        v10 = (v10 * v4)
        v11 = w92
        v10 = (v10 + v11)
        v4 = (v10 % 256)
        v10 = (v10 .. v11)
        v5 = (#v2)
        if not ((600 > v5)) then
            v2 = (not v2)
        end
        i1 = 3
        v7 = v5
    end
    state = 46
    w37 = w1[34]
    v29 = "status"
    v26 = t4[v29]
    state = 41
    v98 = w55
    v98()
    w116 = w112
    v91 = w16
    w118 = w1[5]
    w116(v91, w118)
end
-- (empty spin loop: dispatcher exit the structurer could not
--  recover; commented out -- it can never terminate on its own)
-- while true do
-- end
-- (loader exit) opcode 38 is one of the junk ops: it tail-calls
-- with operands the VM rewrites at run time, so the decoded form
-- L14(L15) is what the bytes say, not proof of what runs.
-- Either way this is the call that hands control to the payload.
do return L14(L15) end
