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
-- Naming
--   * a1..aN       parameters of the enclosing proto (VM protos are vararg).
--   * L<n> / v<n>  a proto's own local registers, declared with `local` at the
--                  top of the function so nested protos capture them for real.
--   * A register that a nested proto captures is renamed to <letter><n> when its
--     default name would be shadowed inside that proto.
--
-- Remaining VM artefacts (documented, not silently "fixed")
--   * `UPVALS[i]`  upvalue read with a runtime-computed index.
--   * `<pool>[5]`  the one constant-pool slot the runtime dump did not capture.
--   * junk ops (op121/92/38/179) rewrite their operands at runtime; those few
--     sites are commented instead of rendered.
-- ============================================================================
-- The VM resolves globals through the loader's function environment
-- (Q[13]() == getfenv()); every `ENV.<name>` below is a real global lookup.
local ENV = (getfenv and getfenv()) or _G

-- Deobfuscated source (recovered from Luraph VM bytecode)
-- Main chunk = proto T2; payload = T8 (called with the original arguments)

local L14 = {}  -- Luraph constant pool (keys = constant indices)
local L15   -- T2 scratch register (holds the payload closure)
local L2, v3, L4, L5, L6, L7, v8, v9, L10, L11, L12, v16, L18, L21, L24, L29, v38, L45, L46, L49, L53, L55, L57, L58, L59, L61, L67, v73, v74, v76, v84, v85, v88, v99, v103, v104, v107, v110, v113, v117, v128, v164, v166, v176, v186, v214, v460, v468, v529, v605, v623, v629, v658, v666, v680, v684
L14[0] = ENV.utf8[0] -- loader-installed helper
L14[1] = v16 -- runtime: FN:function: ADDR
L14[2] = L24 -- runtime: FN:function: ADDR
L14[3] = task -- static decode: ENV.task
L14[4] = string -- static decode: v107
L14[5] = v3
L14[6] = table -- static decode: v73
L14[7] = coroutine -- static decode: v38
L14[8] = "gmatch"
L14[9] = "format"
L14[10] = "char"
L14[11] = v9 -- runtime: FN:function: ADDR
L14[12] = "match"
L14[13] = L45 -- runtime: FN:function: ADDR
L14[14] = "find"
L14[15] = "byte"
L14[16] = "gsub"
L14[17] = math -- static decode: L18
L14[18] = "running"
L14[19] = "sub"
L14[20] = Path2DControlPoint.new -- static decode: L29
L14[21] = Instance -- static decode: L49
L14[22] = "isyieldable"
L14[23] = buffer -- static decode: v99
L14[24] = "rep"
L14[25] = false
L14[26] = true
L14[27] = v76 -- runtime: FN:function: ADDR
L14[28] = "concat"
L14[29] = "cancel"
L14[30] = "unpack"
L14[31] = "create"
L14[32] = "resume"
L14[33] = "yield"
L14[34] = v186 -- runtime: FN:function: ADDR
L14[35] = "status"
L14[36] = v605 -- runtime: FN:function: ADDR
L14[37] = v74 -- runtime: FN:function: ADDR
L14[38] = "close"
L14[39] = L59 -- runtime: FN:function: ADDR
L14[40] = "spawn"
L14[41] = "defer"
L14[42] = v110 -- runtime: FN:function: ADDR
L14[43] = v8 -- runtime: FN:function: ADDR
L14[44] = "readu8"
L14[45] = debug -- static decode: L58
L14[46] = "The debug library is required on Luau platforms. Please open a support ticket."
L14[47] = L21 -- runtime: FN:function: ADDR
L14[48] = "info"
L14[49] = "traceback"
L14[50] = "wrap"
L14[51] = "readu32"
L14[52] = getfenv -- static decode: v128
L14[53] = "pack"
L14[54] = L53 -- runtime: FN:function: ADDR
L14[55] = "writeu16"
L14[56] = "tostring"
L14[57] = "writeu8"
L14[58] = CFrame -- static decode: L61
L14[59] = v84 -- runtime: FN:function: ADDR
L14[60] = Vector2 -- static decode: v117
L14[61] = Vector3 -- static decode: L46
L14[62] = v113 -- runtime: FN:function: ADDR
L14[63] = identifyexecutor -- static decode: L57
L14[64] = "insert"
L14[65] = v85 -- runtime: FN:function: ADDR
L14[66] = L55 -- runtime: {new=FN:function: ADDR}
L14[67] = v103 -- runtime: FN:function: ADDR
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
L14[88] = v460 -- runtime: FN:function: ADDR
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
L14[103] = UDim.new -- static decode: v214
L14[104] = "abs"
L14[105] = "wait"
L14[106] = "delay"
L14[107] = game -- static decode: v88
L14[108] = "copy"
L14[109] = UDim2.new -- static decode: v629
L14[110] = utf8 -- static decode: v529
L14[111] = L67
L14[112] = "챒욦떣귌ḯ핐"
L14[113] = v468
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
L14[148] = Enum -- static decode: v658
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
L14[166] = v176 -- runtime: FN:function: ADDR
L14[167] = v623 -- runtime: FN:function: ADDR
L14[168] = v164 -- runtime: FN:function: ADDR
L14[169] = v666 -- runtime: FN:function: ADDR
L14[170] = ":(%d+)[:\r\n]"
L14[171] = "__index"
L14[172] = "Your Lua environment does not support load or loadstring, therefore you are unable to use Luraph's 'LPH_NO_UPVALUES' macro."
L14[173] = "dCWeI"
L14[174] = "Luraph"
L14[175] = v680
L14[176] = v684
L14[177] = ENV.bit32[0] -- loader-installed helper
L14 = {}
L15 = function(w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, a31, a32, w33, a34, a35, w36, w37, a38, w39, w40, a41, a42, a43, a44, w45, w46, a47, w48, a49, w50, w51, w52, a53, w54, w55, a56, a57, w58, a59, w60, w61, a62, w63, w64, w65, w66, a67, a68, a69, a70, w71, a72, a73, w74, w75, a76, w77, w78, w79, w80, a81, w82, w83, w84, w85, w86, a87, w88, a89, w90, a91, w92, w93, a94, w95, a96, w97, a98, a99, w100, w101, a102, a103, a104, a105, a106, w107, w108, a109, w110, w111, w112, a113, a114, a115, w116, a117, w118, a119, w120, w121, a122, a123, w124, w125, a126, a127, a128, a129, a130, a131, a132, a133, a134, a135, a136, a137, a138, a139, a140, a141, a142, a143, ...) -- F8
    local w0, w146, w164, w186, w197, w199, w212, w223, w247, w260, w273, w282, w296, w309, w316, w324, w328, w330, w348, L349, L376, L394, L396, L410, w419, L420, L433, L440, L441, L442, L443, L444, L445, L446, L447, L448, w449, L450, w451, L452, L453, L454, L455, w456, w457, w458, L459, L460, L461, L462, L463, L464, L465, L466, w467, L468, w469, L470, w471, L472, L473, w474, L475, L476, L477, L478, L479, w480, L481, L482, L483, L484, L485, L486, L487, L488, L489, L490, L491, L492, L493, L494, L495, L496, L497, L498, L499, L500, L501, L502, w503, L504, L505, w506, L507, L508, L509, L510, w511, L512, L513, L514, L515, L516, L517, L518, L519, L520, L521, L522, L523, L524, L525, L526, L527, L528, L529, L530, L531, L532, L533, L534, L535, L536, L537, L538, L539, L540, L541, L542, L543, L544, L545, L546, L547, L548, L549, L550, L551, L552, L553, L554, L555, L556, L557, L558, L559, L560, L561, L562, L563, L564, L565, L566, L567, L568, L569, L570, L571, L572, L573, L574, L575, L576, L577, L578, L579, L580, L581, L582, L583, L584, L585, L586, L587, L588, L589, L590, L591, L592, L593, L594, L595, L596, L597, L598, L599, L600, L601, L602, L603, L604, L605, L606, L607, L608, L609, L610, L611, L612, L613, L614, L615, L616, L617, L618, L619, L620, L621, L622, L623, L624, L625, L626, L627, L628, L629, L630, L631, L632, L633, L634, L635, L636, L637, L638, L639, L640, L641, L642, L643, L644, L645, L646, L647, L648, L649, L650, L651, L652, L653, L654, L655, L656, L657, L658, L659, L660, L661, L662, L663, L664, L665, L666, L667, L668, L669, L670, L671, L672, L673, L674, L675, L676, L677, L678, L679, L680, L681, L682, L683, L684, L685, L686, L687, L688, L689, L690, L691, L692, L693, L694, L695, L696, L697, L698, L699, L700, L701, L702, L703, L704, L705, L706, L707, L708, L709, L710, L711, L712, L713, L714, L715, L716, L717, L718, L719, L720, L721, L722, L723, L724, L725, L726, L727, L728, L729, L730, L731, L732, L733, L734, L735, L736, L737, L738, L739, L740, L741, L742, L743, L744, L745, L746, L747, L748, L749, L750, L751, L752, L753, L754, L755, L756, L757, L758, L759, L760, L761, L762, L763, L764, L765, L766, L767, L768, L769, L770, L771, L772, L773, L774, L775, L776, L777, L778, L779, L780, L781, L782, L783, L784, L785, L786, L787, L788, L789, L790, L791, L792, L793, L794, L795, L796, L797, L798, L799, L800, L801, L802, L803, L804, L805, L806, L807, L808, L809, L810, L811, L812, L813, L814, L815, L816, L817, L818, L819, L820, L821, L822, L823, L824, L825, L826, L827, L828, L829, L830, L831, L832, L833, L834, L835, L836, L837, L838, L839, L840, L841, L842, L843, L844, L845, L846, L847, L848, L849, L850, L851, L852, L853, L854, L855
    w2 = w1[1]
    w3 = w1[2]
    w4 = task
    w5 = string
    w6 = w1[5]
    w7 = w1[5]
    w8 = w1[5]
    w9 = w1[5]
    w10 = 102
    w9 = table
    w11 = "format"
    w11 = w5[w11]
    w12 = w1[5]
    w13 = w1[5]
    w14 = w1[5]
    w15 = w1[5]
    w16 = nil
    w10 = 49
    w17 = "char"
    w16 = w5[w17]
    w17 = "byte"
    w17 = w5[w17]
    w18 = "gsub"
    w18 = w5[w18]
    w19 = math
    w20 = w1[5]
    w21 = w1[5]
    w22 = w1[5]
    w23 = w1[5]
    w24 = w1[5]
    w25 = w1[5]
    w10 = 102
    w26 = "sub"
    w21 = w5[w26]
    w10 = 8
    w86 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, ...) -- F14
        local L226, L233, L234
        a4 = nil
        a5 = w1[5]
        a6 = nil
        a7 = 87
        a9 = w58
        a6 = 1
        a4 = (a4 == a6)
        if (not a4) then
            a10 = 65
            a11 = 354
            a12 = 96
        else
            a10 = 18
            while true do
                a4 = a1
                a10 = 73
            end
        end
        w58 = a4
        a6 = w66
        a11 = a4
        a12 = a6
        a13 = a9
        a14 = a10
        a11(a12, a13, a14, a15)
        a4 = w58
        a11 = 18
        a12 = 119
        a13 = 93
        repeat
        until not ((a7 > 12))
        a8 = a5
        a9 = a4
        a10 = a6
        a8 = a8(a9, a10)
        a5 = a8
        a7 = 123
        a5 = a4
        a10 = w1[5]
        a8 = 84
            -- (constant test eliminated: if not ((38 >= a8)) then)
            a4 = w61
            a8 = 35
        a5 = w80
        a7 = 33
        a8 = 106
        a5 = 0
        a8 = 65
        a6 = 2
        a7 = 30
        a6 = 1
        a4 = (a4 + a6)
        while true do
            a7 = 74
            a4 = a1
        end
        do -- (terminates control flow)
            do return  end
        end
        a6 = a2
        a7 = 12
        while not ((18 >= a14)) do -- while-exit-cond
        end
        a5 = a3
        a4 = a3
        a5 = w55
        a8 = a5
        a8()
    end
    w10 = 78
    if not ((60 >= w10)) then
        if not ((w10 >= 79)) then
            a87 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F67
                local L212, L388
                a4 = w1[5]
                a5 = w1[5]
                a6 = w1[5]
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
                repeat
                until not ((a11 == 117))
                a12 = a4
                a12()
                a5 = (a5 == a6)
                if not ((not a5)) then
                    a5 = a2
                    a4 = a5
                end
                a5 = w61
                a8 = w1[5]
                a9 = w1[5]
                a10 = 11
                a11 = 159
                a12 = 8
                a14(a15, a16, a17, a18)
                a10 = 85
                a10 = 79
                a6 = 1
                a5 = (a5 + a6)
                a6 = 2
                a4 = a5
                a6 = w66
                a5 = a3
                    -- (constant test eliminated: if not ((a11 >= 214)) then)
                    -- (constant test eliminated: if not ((27 >= a13)) then)
                    a14 = a5
                    a15 = a6
                    a16 = a9
                    a17 = a8
                a9 = w58
                repeat
                until not ((31 >= a8))
                a8 = 114
                a5 = a1
                while true do -- (empty spin loop: unrestructured dispatcher exit)
                end
                a8 = 31
                a7 = 109
                a5 = (a5 == a6)
                a8 = 66
                a6 = 1
                do -- (terminates control flow)
                    do return  end
                end
                a8 = 86
                a9 = 214
                a10 = 64
                a4 = 1
                a8 = 57
                a5 = a3
                a4 = a3
                a10 = 48
                a5 = w58
                a7 = 77
                a4 = w82
            end
            w10 = 85
            w125 = w83
            a126 = w13
            a127 = w120
            a126 = a126(a127)
            a127 = "userdata"
            a128 = true
            w125(a126, a127, a128, a129)
        end
    end
    if not ((85 >= w10)) then
        a102 = w97
        a103 = w52
        a104 = "typeof"
        a102(a103, a104)
        a102 = "new"
        a102 = a69[a102]
        a103 = w97
        a104 = w7
        a105 = "gmatch"
        a103(a104, a105)
        a103 = w97
        a104 = w11
        a105 = "format"
        a103(a104, a105)
        w10 = 115
        if (w10 > 54) then
        else
            a103 = w97
            a104 = w14
            a105 = "find"
            a103(a104, a105)
            w10 = 29
        end
        w120[3699368772] = 452242525
        w120[1831891793] = 1560434486
        w118(a119, w120)
        w118 = w1[5]
        w10 = 82
        if (w10 ~= 84) then
            if (w10 ~= 82) then
                a119 = w118
                w120 = a113
                w121 = "DataModel"
                a119(w120, w121)
                w10 = 84
                w121 = a119[60]
                w101[28] = w97
                w121 = w83
                a122 = L7
                a122 = a122()
                a123 = a119[60]
                w124 = 1
                w121(a122, a123, w124, w125)
                w121 = 90
                a122 = 153
                a123 = 33
            else
                w118 = function(p1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, p17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, ...) -- F126
                    local L0, L190
                    a3 = w83
                    a4 = "userdata"
                    a5 = w13
                    a6 = p1
                    a5 = a5(a6)
                    a3(a4, a5)
                    a3 = w84
                    a4 = w52
                    a5 = p1
                    a4 = a4(a5)
                    a5 = "Instance"
                    a3(a4, a5)
                    a3 = w1[5]
                    a4 = w1[5]
                    a5 = 61
                    a3 = p1[0]
                    a6 = "Parent"
                    a4 = p1[a6]
                    a5 = 120
                    a10 = 92
                        -- (constant test eliminated: if not ((11 >= a10)) then)
                            -- (constant test eliminated: if not ((a10 >= 110)) then)
                            a10 = 11
                            a7 = "AncestryChanged"
                    a9 = p1[a7]
                    a10 = 117
                    while true do
                        a7 = p1[a10]
                        a9 = 78
                    end
                    a3 = 31
                    a4 = 119
                    a5 = 44
                    a10 = "Name"
                    a7 = w83
                    a8 = a2
                    a9 = "ClassName"
                    a9 = p1[a9]
                    a7(a8, a9)
                    if not ((a10 >= 92)) then
                        a10 = 110
                        a8 = p1[a7]
                    end
                    if (110 >= a10) then
                    else
                        a11 = w86
                        a12 = a8
                        a13 = a9
                        a11(a12, a13)
                        a11 = w78
                        a12 = (a8 == a9)
                        a11(a12)
                        a11 = "Connect"
                    end
                    a10 = w83
                    a11 = (#a7)
                    a12 = (#a8)
                    a10(a11, a12)
                    a10 = UPVALS[L0]
                    a11 = w37
                    a12 = p1
                    a11 = a11(a12)
                    a12 = a7
                    a10(a11, a12)
                    p17 = false
                    a18 = "Destroying"
                    a18 = p1[a18]
                    a19 = a18; a18 = a18["Connect"]
                    a20 = function(a1, a2, a3, a4, ...) -- F132
                        local L436
                        a1 = true
                        p17 = a1
                        do return  end
                    end
                    a18 = a18(a19, a20)
                    a19 = 60
                    a20 = 204
                    a21 = 72
                    if not ((a9 ~= 85)) then
                        a10 = w83
                        a11 = "string"
                        a12 = w13
                        a13 = a7
                        a12 = a12(a13)
                        a10(a11, a12)
                        a10 = w84
                        a11 = a7
                        a12 = a8
                        a10(a11, a12)
                    end
                    a10 = "Name"
                    a8 = p1[a10]
                    a9 = 85
                    p17 = w97
                    a18 = a12
                    a19 = "Connect"
                    p17(a18, a19)
                    p17 = w86
                    a18 = a11
                    a19 = a12
                    p17(a18, a19)
                    if not ((a22 > 60)) then
                        a23 = w79
                        a24 = p17
                        a23(a24)
                    end
                    a23 = w1[5]
                    a24 = 19
                    a25 = 238
                    a26 = 73
                    a28 = w112
                    a29 = a23
                    a30 = w1[5]
                    a28(a29, a30)
                    repeat
                    until not ((a6 ~= 31))
                    a7 = w1[5]
                    a8 = w1[5]
                    a9 = 107
                    a7 = w1[5]
                    a8 = w1[5]
                    a9 = w1[5]
                    p17 = w97
                    a18 = a11
                    a19 = "Connect"
                    p17(a18, a19)
                    a24 = w78
                    a25 = "Connected"
                    a25 = a18[a25]
                    a25 = (not a25)
                    a24(a25)
                    if not ((a6 ~= 75)) then
                    end
                    a28(a29, a30)
                    a7 = w83
                    a8 = "The metatable is locked"
                    a9 = w48
                    a10 = p1
                    a7(a8, a9(a10, a11))
                    do -- (terminates control flow)
                        do return  end
                    end
                    if (a27 ~= 19) then
                        a28 = w97
                        a29 = a23
                        a30 = "Disconnect"
                    else
                        a28 = "Disconnect"
                        a23 = a18[a28]
                    end
                    a11 = a8[a11]
                    a12 = "Connect"
                    a12 = a8[a12]
                    a13 = 118
                    a14 = 264
                    a15 = 10
                    a23 = w78
                    a24 = "Connected"
                    a24 = a18[a24]
                    a23(a24)
                    a28 = a23
                    a29 = a18
                    a28(a29)
                end
                w10 = 9
                w125 = a119[59]
                w101[72] = w348
            end
        else
            a119 = w118
            w120 = a106
            w121 = "Workspace"
            a119(w120, w121)
            a119 = w83
            w120 = a113
            w121 = "Parent"
            w121 = a106[w121]
            a122 = true
            a119(w120, w121, a122, a123)
            a119 = nil
            w120 = 104
            w121 = 330
            a122 = 113
        end
        a104(a105, a106)
        a104 = w97
        a105 = w26
        a106 = "rep"
        a104(a105, a106)
        w10 = 93
            -- (constant test eliminated: if not ((23 >= w10)) then)
        a104 = w97
        a105 = a72
        a106 = "insert"
        a104(a105, a106)
        w10 = 10
        a131[4286544108] = w330
        a131[4113771706] = L477
        a131[4054428537] = L645
        a131[1373830112] = w199
        a131[1485835597] = L543
        a131[3571856872] = w146
        a126 = a131
    end
    w85 = w1[67]
    w10 = 107
    a126 = true
    a123(w124, w125, a126, a127)
        -- (constant test eliminated: if (a122 ~= 20) then)
    a99 = w1[88]
    w10 = 58
    w100 = w97
    w101 = w36
    a102 = "setmetatable"
    w100(w101, a102)
    w100 = w97
    w101 = a70
    a102 = "tonumber"
    w100(w101, a102)
    w100 = w1[5]
    w10 = 12
    w125 = a119[22]
    w101[77] = w23
    if not ((not w121)) then
        a126 = w55
        a126()
    end
    a126 = w55
    a126()
    a126 = w1[5]
    a127 = w1[5]
    a128 = w1[5]
    a129 = 87
    a130 = 163
    a131 = 19
    a127 = w97
    a128 = "Shuffle"
    a128 = w121[a128]
    a129 = "Shuffle"
    a127(a128, a129)
    w118 = w97
    a119 = a102
    w120 = "new"
    w118(a119, w120)
    w118 = w97
    a119 = a98
    w120 = "new"
    w118(a119, w120)
    w10 = 14
    w121 = a119[29]
    w101[43] = w121
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[29]
    w124 = 2
    w121(a122, a123, w124, w125)
    w120 = 115
    w120 = 54
    w121 = a119[12]
    w101[44] = w13
    w121 = w84
    a122 = L7
    a122 = a122()
    a123 = a119[12]
    w124 = 1
    w121(a122, a123, w124, w125)
    w120 = w84
    w121 = w52
    a122 = a119
    w121 = w121(a122)
    a122 = "Enums"
    a123 = true
    w120(w121, a122, a123, w124)
    w121 = a119[a119]
    w101[51] = a98
    w121 = w84
    a122 = a119[5]
    a123 = L7
    a123 = a123()
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = a119[20]
    w101[52] = a128
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[20]
    w124 = 1
    w121(a122, a123, w124, w125)
    w120 = 117
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[23]
    w124 = 1
    w121(a122, a123, w124, w125)
    w120 = 111
    w125 = w84
    a126 = w52
    a127 = w120
    a126 = a126(a127)
    a127 = "EnumItem"
    a128 = true
    w125(a126, a127, a128, a129)
    a139 = true
    a137(a138, a139)
    a133 = w1[w1]
    a133 = a132[a133]
    a133 = (a133 * 100)
    a133 = (a133 // 1)
    w101[98] = w36
    a122 = 46
    if (46 >= a122) then
        a133 = a119
        a134 = "Y"
        a134 = a132[a134]
        a135 = true
        a133(a134, a135)
        a122 = 53
        w125 = a119[7]
        w101[37] = w74
    else
        a134 = w120; a133 = w120["Destroy"]
        a133(a134)
        w10 = 66
    end
    a49 = w1[w1]
    w46 = w20[a49]
    a47 = w4[0]
    w10 = 51
        -- (constant test eliminated: if not ((25 >= w10)) then)
    w45 = w1[42]
    w10 = 36
    w125 = w84
    a126 = w13
    a127 = a123
    a126 = a126(a127)
    a127 = "userdata"
    a128 = true
    w125(a126, a127, a128, a129)
    w124 = 11
    a128 = 263
    w124 = w124(w125, a126, a127, a128)
    w121[a123] = w124
    a123 = w1[5]
    w124 = 40
    w125 = 386
    a126 = 114
    w125 = a119[4]
    w101[36] = L605
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[4]
    a128 = 1
    w125(a126, a127, a128, a129)
    a123 = w84
    w124 = "userdata"
    w125 = w13
    a126 = w121
    w125 = w125(a126)
    a126 = w1[w1]
    a123(w124, w125, a126, a127)
    a122 = 46
        -- (constant test eliminated: if (72 >= w10) then)
            -- (constant test eliminated: if not ((w10 >= 77)) then)
            if not ((58 >= w10)) then
                w112 = w1[5]
                a113 = w1[w1]
                a114 = 36
                a115 = 244
                w116 = 76
                w77 = w1[5]
                w78 = w1[5]
                w79 = w1[5]
                w10 = 101
            end
    w121 = w84
    a122 = a119[25]
    a123 = L7
    a123 = a123()
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = 50
    a122 = 89
    a123 = 39
    a114(a115)
    a114 = w112
    a115 = a68
    a114(a115)
    a114 = w112
    a115 = w2
    a114(a115)
    w10 = 58
    a114 = w112
    a115 = w7
    a114(a115)
    w10 = 117
    a114 = w112
    a115 = w14
    a114(a115)
    a114 = w1[5]
    a115 = w1[w1]
    w10 = 89
    if (100 >= w10) then
    else
        a115 = w1[5]
        w10 = 67
    end
    w26 = "isyieldable"
    w22 = w6[w26]
    w10 = 71
    w101[93] = L410
    a131 = w1[5]
    a122 = 119
    while true do
        a122 = 106
        a132 = a119
        a133 = "X"
        a133 = a130[a133]
        a134 = "Scale"
        a133 = a133[a134]
        a134 = true
        a132(a133, a134)
    end
    a123 = w84
    w124 = 0.36546066092082763
    a126 = w121; w125 = w121["NextNumber"]
    w125 = w125(a126)
    a126 = true
    a123(w124, w125, a126, a127)
    a123 = w84
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w125 = 0.9399625980565814
    a126 = true
    a123(w124, w125, a126, a127)
    a123 = 42
    w124 = 60
    w125 = 4
    a119 = w79
    w120 = w45
    w121 = "GetChildren"
    w121 = a113[w121]
    w120 = w120(w121)
    w121 = true
    a119(w120, w121)
    a119 = w1[5]
    w120 = 50
    w121 = 228
    a122 = 104
    a129 = 22
    while true do
        w121 = w118[8]
        w101[18] = a43
    end
    w120 = 122
    a126 = a126()
    a127 = a119[24]
    a128 = 1
    w125(a126, a127, a128, a129)
    a114 = w112
    a115 = w11
    a114(a115)
    w10 = 80
        -- (constant test eliminated: if not ((30 >= w10)) then)
        a102 = {}
        w101 = a102
        w10 = 0
    a102 = w97
    a103 = w13
    a104 = "type"
    a102(a103, a104)
    a102 = w97
    a103 = w40
    a104 = "next"
    a102(a103, a104)
    w10 = 119
    w125 = "Name"
    w121[w125] = w124
    w125 = w83
    a126 = w121
    a127 = a123
    a128 = w120
    a129 = w124
    a127 = a127(a128, a129)
    a128 = true
    w125(a126, a127, a128, a129)
    a126 = w120; w125 = w120["Destroy"]
    w125(a126)
    a126 = w121; w125 = w121["Destroy"]
    w125(a126)
    w125 = w79
    a126 = "Parent"
    a126 = w121[a126]
    a127 = true
    w125(a126, a127)
    w125 = w78
    a126 = w45
    a127 = function(a1, a2, a3, a4, ...) -- F44
        a1 = w120
        w121["Parent"] = a1
        do return  end
    end
    a126 = a126(a127)
    a126 = (not a126)
    a127 = true
    w125(a126, a127)
    a119 = w1[5]
    w120 = 32
    w121 = 137
    a122 = 105
    w112 = function(s1, a2, s3, s4, s5, a6, a7, a8, a9, ...) -- F258
        local L188
        s3 = w33
        s4 = s1
        s3 = s3(s4)
        if not ((not s3)) then
            s3 = function(a1, a2, a3, a4, a5, a6, ...) -- F264
                local L131
                a2 = w83
                a3 = w111
                do -- (terminates control flow)
                    a5 = 3
                    a2(a3, a4(a5, a6))
                    a2 = UPVALS[a3]
                    a3 = s1
                    a4 = w111
                    a5 = 4
                    a2(a3, a4(a5, a6))
                    a2 = w84
                    a3 = w111
                    a4 = 5
                    a3 = a3(a4)
                    a4 = w15
                    a2(a3, a4)
                    a2 = w84
                    a3 = w111
                    a4 = 7
                    a3 = a3(a4)
                    a4 = w45
                    a2(a3, a4)
                    a2 = w84
                    a3 = w111
                    a4 = 8
                    a3 = a3(a4)
                    a4 = w112
                    a2(a3, a4)
                    a2 = ...  -- vararg fill: also writes R3, R4, ... (count is runtime dependent)
                    do return ... end
                end
                while true do
                    a3 = a3(a4)
                    a4 = w45
                    a2(a3, a4)
                end
                a4 = 2
                a2 = w84
                a3 = s3
                a4 = w111
            end
            s4 = w15
            s5 = s1
            a6 = s3
            a7 = ...  -- vararg fill: also writes R8, R9, ... (count is runtime dependent)
            s4, s5, a6 = s4()
            a6 = w79
            a7 = s4
            a6(a7)
            a6 = w86
            a7 = s5
            a8 = "error in error handling"
            a6(a7, a8)
        end
        do return  end
    end
    w10 = 6
    w125 = w118[3]
    w101[6] = a73
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = w118[3]
    a128 = 1
    w125(a126, a127, a128, a129)
    a91 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F352
        local L474
        a3 = w1[5]
        a4 = w1[5]
        a5 = 18
        a3 = w40
        a5 = 73
        a12 = a10
        a13 = a11
        a14 = a12
        a13 = a13(a14)
        a11 = a13
        a13 = w1[5]
        a14 = 30
        a13 = a2
        a14 = 101
        a8 = nil
        a5 = 68
            -- (constant test eliminated: if not ((56 >= a5)) then)
            a5 = 83
            a9 = a6
            a10 = a7
            a11 = a8
            -- generic-for iterator (coroutine desugar) reg R9
            repeat
            until not ((155 > a16))
        a11 = nil
        a12 = 82
        a13 = 195
        a14 = 62
        repeat
        until not ((82 >= a15))
        a16 = a11
        a16()
        a9, a10, a11 = coroutine.resume(a9, a10, a11)
        if a9 then
        else
            do return  end
        end
        a14 = 0
        a12 = w1[5]
        a6, a7, a8 = nil
        a6 = a3
        a7 = a4
        a4 = a2
        a5 = 125
        a6 = a3
        a7 = a4
        a8 = nil
        a5 = 56
        -- generic-for iterator (coroutine desugar) reg R9
        a9, a10, a11 = coroutine.resume(a9, a10, a11)
        if a9 then
        else
            a11 = w1[5]
            a12 = w1[5]
            a13 = 100
            a14 = 275
            a15 = 55
            repeat
            until not ((a5 > 22))
        end
        a10 = a7
        a11 = a8
        -- generic-for iterator (coroutine desugar) reg R9
            -- (constant test eliminated: if not ((a15 >= 144)) then)
            a11 = w55
        a4 = a1
    end
    w10 = 9
    w92 = 77
    a94 = a89
    w95 = w25
    a94(w95)
    a94 = a89
    w95 = a69
    a94(w95)
    w93 = 13521840
    a94 = a89
    w95 = a73
    a94(w95)
    a94 = a89
    w95 = a62
    a94(w95)
    a94 = w1[5]
    w95 = w1[5]
    a96 = w1[5]
    w97, a98 = nil
    w10 = 44
    if (44 >= w10) then
        a99 = a89
        w100 = a81
        a99(w100)
        w10 = 27
        a132 = "Y"
        a132 = a130[a132]
        a133 = "Scale"
        a132 = a132[a133]
        a132 = (a132 * 100)
        a132 = (a132 // 1)
        w101[94] = w28
        a122 = 65
        a132 = a119
        a133 = "Y"
        a133 = a130[a133]
        a134 = "Scale"
        a133 = a133[a134]
        a134 = true
        a132(a133, a134)
        if (78 >= w10) then
            a89 = function(a1, a2, a3, a4, a5, a6, a7, ...) -- F78
                local L294, L457
                a2 = w79
                a3 = (not a1)
                a2(a3)
                a2 = UPVALS[a1]
                a3 = "table"
                a4 = w13
                a5 = a1
                a4 = a4(a5)
                a2(a3, a4)
                a2 = 116
                    -- (constant test eliminated: if not ((67 >= a2)) then)
                    a2 = 67
                    a3 = w84
                    a4 = w1[5]
                    a5 = w48
                    a6 = a1
                    a5 = a5(a6)
                    a3(a4, a5)
                a3 = w45
                a4 = w36
                a5 = a1
                a6 = w1[5]
                a3(a4, a5, a6, a7)
                do return  end
            end
            w10 = 79
        end
        w120 = 100
        w121 = w84
        a122 = a119[30]
        a123 = L7
        a123 = a123()
        w124 = 1
        w121(a122, a123, w124, w125)
        w121 = a119[25]
        w101[23] = a99
    else
        a99 = {}
        w95 = a99
        a99 = {}
        w100 = "lastlinedefined"
        a99[w100] = -1
        w100 = "linedefined"
        a99[w100] = -1
        w100 = "nparams"
        a99[w100] = 0
        w100 = "short_src"
        w101 = "[C]"
        a99[w100] = w101
        w100 = "source"
        w101 = "=[C]"
        a99[w100] = w101
        w100 = "what"
        w101 = "C"
        a99[w100] = w101
        w100 = "currentline"
        a99[w100] = -1
        w100 = "namewhat"
        w101 = ""
    end
    a59 = nil
    w10 = 28
    a128 = true
    w125(a126, a127, a128, a129)
    w10 = 71
    a119 = w1[5]
    w120 = 67
        -- (constant test eliminated: if not ((w120 >= 70)) then)
        w120 = 70
        w121 = "new"
        a119 = a81[w121]
    w121 = w97
    a122 = a119
    a123 = "new"
    w121(a122, a123)
    w121 = w112
    a122 = a119
    a123 = {}
    w121(a122, a123)
    w120 = 0
        -- (constant test eliminated: if not ((w120 > 0)) then)
        w121 = w1[5]
        a122 = 28
    w121 = w1[5]
    a122 = 20
    a122 = 323
    a123 = 106
    while true do
        a133 = (a133 * 100)
        a133 = (a133 // 1)
    end
    a133 = a127[0]
    a128 = a113; a127 = a113["GetService"]
    a129 = "StarterPlayer"
    a127 = a127(a128, a129)
    w121 = a127
    a114 = w112
    a115 = w48
    a114(a115)
    w10 = 85
    if not ((a132 ~= 87)) then
        a126 = function(m1, a2, a3, a4, a5, a6, m7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F164
            local L0, L278, L430
            a2 = w12
            a3 = m1
            a4 = w1[170]
            a2 = a2(a3, a4)
            a3 = w7
            a4 = m1
            a5 = w1[170]
            a3 = a3(a4, a5)
            a3 = a3()
            a4 = w1[5]
            a5 = w1[5]
            a6 = 83
            m7 = 199
            a8 = 25
            a9 = 106
            a15 = w83
            a16 = a12
            a17 = a10
            a15(a16, a17)
            a9 = 119
            a15 = w83
            a16 = a11
            a17 = a12
            a15(a16, a17)
            while not ((a9 ~= 61)) do -- while-exit-cond
                a9 = 120
                a15 = w83
                a16 = a8
                a17 = m7
                a15(a16, a17)
                a11 = w55
                a11()
            end
            a10 = w55
            a10()
            if not (a3) then
                a10 = w55
                a10()
            end
            if not (a4) then
                a10 = w55
                a10()
            end
            a9 = 103
            a14 = (a8 + 0)
            a15 = w83
            a16 = a3
            a17 = a6
            a15(a16, a17)
            a15 = w84
            a16 = a6
            a17 = a8
            a15(a16, a17)
            a9 = 61
            a14 = w1[5]
            a9 = 3
            do -- (terminates control flow)
                a15 = w83
                a16 = a10
                a17 = a14
                a15(a16, a17)
                a15 = w84
                a16 = a14
                a17 = a13
                a15(a16, a17)
                a15 = a11
                do return a15 end
            end
            a6 = w55
            a6()
            repeat
            until not (a5)
            m7 = w1[5]
            a8 = w1[5]
            a9 = 45
            a10 = w16
            a11 = UPVALS[a6]
            a12 = m1
            a13 = (a4 + 1)
            a14 = (a5 - 1)
            a10 = a10(a11(a12, a13, a14, a15))
            a8 = a10
            a10 = w18
            a11 = m1
            a12 = w1[170]
            a13 = function(a1, a2, a3, ...) -- F170
                local L121
                m7 = a1
                do return  end
            end
            a10(a11, a12, a13, a14)
            a9 = 40
            a13 = (m7 + 0)
            m7 = L0
            a9 = 103
            a11 = w55
            a11()
            a11 = w1[5]
            a12 = w1[5]
            a13 = w1[5]
            a10 = w14
            a11 = m1
            a12 = w1[170]
            a10, a11, a12 = a10(a11, a12, a13)
            a4 = a10
            a5 = a11
            a9 = 6
            a11 = (a2 + 0)
            L278 = (nil / L430)
            repeat
            until not (a6)
            a10 = w55
            a10()
            a9 = 105
            a9 = 26
            a15 = w83
            a16 = a2
            a17 = a3
            a15(a16, a17)
            a9 = 52
            a10 = (a6 + 0)
            a9 = 40
            a10 = w21
            a11 = m1
            a12 = (a4 + 1)
            a13 = (a5 - 1)
            a10 = a10(a11, a12, a13)
            a6 = a10
            a12 = (a3 + 0)
            a9 = 45
        end
        a133 = a126
        a134 = w120
        a133 = a133(a134)
        a127 = a133
    end
        -- (constant test eliminated: if not ((a123 >= 154)) then)
        a119 = w1[w1]
    w124 = w83
    w125 = w13
    a126 = a119
    w125 = w125(a126)
    a126 = "userdata"
    a127 = true
    w124(w125, a126, a127, a128)
    if (a126 == 106) then
        a127 = w118
        a128 = w121
        a129 = "StarterPlayer"
        a127(a128, a129)
    end
    a128 = "Parent"
    a123[a128] = w121
    a129 = a123; a128 = a123["SetControlPoints"]
    a130 = {} -- size 4
    a131 = w24
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
    a131 = a131(a132, a133, a134(a135, a136, a137, a138, a139))
    a132 = w24
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
    a132 = a132(a133, a134, a135(a136, a137, a138, a139, a140))
    a133 = w24
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
    a133 = a133(a134, a135, a136(a137, a138, a139, a140, a141))
    a134 = w24
    a135 = a114
    a136 = 0
    a137 = -1
    a138 = 0
    a139 = -4
    a135 = a135(a136, a137, a138, a139)
    a136 = a114
    a137 = 0
    a123 = w118[14]
    w124 = 2
    w121(a122, a123, w124, w125)
    w120 = 13
    w24 = Path2DControlPoint.new
    w10 = 17
    w121 = w84
    a122 = w118[18]
    a123 = L7
    a123 = a123()
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = w118[12]
    w101[2] = w24
    w121 = 124
    a122 = 176
    a123 = 26
    w121 = a119[46]
    w101[38] = w4
    w121 = w84
    a122 = a119[46]
    a123 = L7
    a123 = a123()
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = a119[41]
    w101[39] = a59
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[41]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[40]
    w101[40] = w92
    w121 = 118
    a122 = 171
    a123 = 33
    repeat
    until not ((w10 ~= 8))
    if not ((w10 >= 53)) then
        a127 = {}
        a128 = w1[171]
        a129 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, ...) -- F364
            a3 = w1[5]
            a4 = 28
            a5 = 50
            a6 = 22
            if not ((17 >= a12)) then
                a13 = w125
                a14 = a8
                a13(a14)
            end
            do -- (terminates control flow)
                repeat
                until not ((a7 ~= 50))
                UP324[nil] = nil
                a8 = w107[a3]
                a9 = 17
                a10 = 224
                a11 = 71
                a4 = w55
                a4()
                do return  end
            end
            if (a12 >= 88) then
                if not ((88 >= a12)) then
                    a13 = a1[a2]
                    do return a13 end
                end
            end
            a13 = w1[5]
            w107[a3] = a13
            a8 = a1[0]
            a3 = a8[a2]
        end
        a127[a128] = a129
        a126 = a127
        w10 = 53
    end
    a127 = w1[5]
    a128 = w1[5]
    a129 = 65
    if not ((a129 >= 65)) then
        if not ((not a127)) then
        end
        a128 = function(a1, a2, a3, ...) -- F293
            a1 = w3
            a2 = w1[172]
            a1(a2)
        end
    end
    a130 = w45
    a131 = a99
    a132 = w11
    a133 = " --[[%s]] return setfenv(function(...) return %s(...) end, setmetatable({ [\"%s\"] = ... }, { __index = getfenv((...)) })) "
    a134 = "\n				 .@%(/*,.......      ...,,*/(#%&@@.\n			 (*   ,/(#%%&&@@@@&%((////(((##%###((/**,,.     ,//(&.\n		   /* .%@@@@@@@@%,  .(&@@@&&&&&&@@@@@@&#(*,........*%@@@(.  ,#.\n		 */ .&@@@@@@@*  (%,   *(&&@@@@@&%(*,.             .,*(#%(*@@&*  *,\n		#, /@@@@@@* *&( ,&&/.,/#%&&@@@&(&@@@@@@@@@@@@#*,.....,/&@@@@@@@@( .%\n	   #  #@@@@@*/@% .#%./(,.,/*,//*,.,/(*@@@@@@@@@@@@%@@@@@@@@@#.#@@@@@@&. %\n	  /  &@@@@@@@@(%@# *&&*&@@@@#/&@@@@/%%.,%@@@@@@@%/@@&(,  ,,,...  *%@@@# *\n	#  .&@@@@@@@@@@@,((%@@@@@#.    ,&@@#@@&* .&@@@@@&,.#@@@@/&@@%(@@@&(/,(&, /,\n (/   (@&&&%&@@@&/, ,@#(@@@@,        #@@/,&@& /@@@@@,%#%@@@@@(     *@@@@@&,%%. .\n/  #/,#@@@&#(//#@@@/ %@@@&@@@(.    ,&@@(.*/*  %@@*   %@@@@@@%       (@@&(*...%&.\n ///@@&,  (&@@#,   /@/ ,*&@@@@#&@@%#%((%@&* /@@@@@@&. #@@@#&@@@&%%@@@@@@&,/(*@/#\n%%.&@# .&@@@# /@@@@%&@@@&/.   ,/((/*,  ./&@@@@@@@@@@,*&(./%@@#*&@@@(#(....,&#*@/\n@%.&& .&@@@&*    /&@@@@@@@@@@@@@@@@&@@#/(%@@@@@@@@@@&,  (@@@@@@@@@@@@/,@@@@@#.&*\n&&,%% .&*    /@@@(.  ,(@@@@@&/(////#( /&@@@@@@@@@@@@@@@(  ,&@@@@@@@@&, (@@&*/@(/\n.%*#@( /@@@@( *@@@@@@/     *%@@@@@@@&.,@& ,#, .&@@@@@@# .#*%&/,#@@@@*   *@@&/*&*\n .&/.#@@@@@@@,   *&@@%.,&@@&(,    ,(%@%&@@@@@@@@@(.*,  /@@@@@@@@@&,      %@@@@..\n@* .%@@@@@@@@(       .   (@@@@@@@@(       .*(%&@@@@@@@@@@@@&(,  ./.*@%   /@@% ./\n  @* .&@@@@@@&.             ./&@@@*.&@@@@@@@&, ,**,.    .,*(&(.%@@# %@*  ,@@% ,#\n	&, /@@@@@@*                    .#@@@@@@@@*.%@@@@@(,@@@@@@& ,%(.      .&@% ,#\n	  / *@@@@@#                                                           %@&.,#\n	  (( .&@@@@*                                                          #@&.,#\n	   .&. ,&@@@,                                                         (@&.,#\n		  #. .%@@* /@@/                                                   /@&.,(\n			./  #@%. %@&,,#,                                              /@@,./\n			  *(  #@%. . (@@@@@%/,                                        /@@,.*\n				//  %@&, *@@@@@@@@( (@%/.                                 #@@, (\n				  #* .&@@#. (@@@@&.*@@@@@@@@%. */.                  *..%*.&@@, /\n					@* .%@@@%, ,/ .@@@@@@@@@@,.%@@@@@% .&@@@* #@&..&@*,* %@@&. *\n					   /  *&@@@@%,   *(&@@@@&. #@@@@@* #@@@% (@@* ,.   /@@@@* (\n						 @#. .#@@@@@@&(,.                      .,*(%&@@@@@&..(\n							 &(.   ./%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(. ((\n								  ,#/*.       ..,,,,,,,,....          ,/#\n\n"
    a135 = w1[173]
    a136 = w1[173]
    a132 = a132(a133, a134, a135, a136)
    a133 = w1[174]
    a134 = w1[5]
    a130, a131, a132 = a130(a131, a132, a133, a134, a135)
    a127 = a130
    a128 = a131
    a129 = 44
        -- (constant test eliminated: if not ((16 >= w10)) then)
    w101 = w97
    a102 = a68
    a103 = "rawget"
    w101(a102, a103)
    w10 = 101
    w125 = w125[a126]
    a126 = "EnumType"
    w125 = w125[a126]
    a126 = w125; w125 = w125["FromValue"]
    a127 = 1
    w125 = w125(a126, a127)
    w125 = w125[0]
    a126 = w125; w125 = w125["FromValue"]
    a127 = 1
    w125 = w125(a126, a127)
    a126 = "EnumType"
    w125 = w125[a126]
    a126 = w125; w125 = w125["FromValue"]
    a127 = 1
    w125 = w125(a126, a127)
    a126 = "EnumType"
    w125 = w125[a126]
    a126 = w125; w125 = w125["FromName"]
    a127 = "OuterBox"
    w125 = w125(a126, a127)
    w120 = w125
        -- (constant test eliminated: if (97 >= w124) then)
    a41 = w1[5]
    a42 = w1[5]
    a43 = w1[5]
    a44 = w1[5]
    w45 = w1[5]
    w46 = w1[5]
    a47 = nil
    w48 = w1[5]
    w10 = 34
    a119 = 1
    w120 = 9
    w121 = 1
    a122 = 120
    a128 = "X"
    a128 = a126[a128]
    a128 = a128[0]
    a128 = (a128 * 100)
    a128 = (a128 // 1)
    w101[85] = a89
    a128 = a119
    a129 = "X"
    a129 = a126[a129]
    a130 = "Scale"
    a129 = a129[a130]
    a130 = true
    a128(a129, a130)
    a137 = a119
    a138 = "Y"
    a138 = a131[a138]
    a139 = true
    a137(a138, a139)
    a103(a104, a105)
    a103 = UDim.new
    a104 = w97
    a105 = w18
    a106 = "gsub"
    a104(a105, a106)
    a104 = w97
    a105 = w21
    a106 = "sub"
    w77 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, ...) -- F340
        local L228, L382, L506
        a3 = w1[5]
        a4 = w1[5]
        a5 = w1[5]
        a6 = w1[5]
        a7 = 50
        a8 = 325
        a9 = 85
        while true do
            a14 = 21
            a15 = (a6 + 4)
            a16 = w1[5]
            a17 = 0
                -- (constant test eliminated: if (0 >= a17) then)
                a18 = w54
                a19 = a1
                a20 = a6
                a18 = a18(a19, a20)
                a16 = a18
                a18 = bit32.band(a16, 255)
                a11 = bit32.bxor(a9, a18)
                a12 = (a11 * 435)
                a17 = 95
                a9 = (a12 % a5)
            a3 = 2216829733
            a4 = 3421674724
        end
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
        a17 = 4
        a18 = (a11 * 256)
        a18 = (a13 + a18)
        a19 = (a10 * 435)
        a18 = (a18 + a19)
        a10 = (a18 % a5)
        if (4 >= a17) then
        else
        end
        do -- (terminates control flow)
            a15 = a9
            a16 = a10
            do return  end
        end
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
        a22 = (a12 - a9)
        a13 = (a22 / a5)
        a22 = (a11 * 256)
        a22 = (a13 + a22)
        a23 = (a10 * 435)
        a22 = (a22 + a23)
        a10 = (a22 % a5)
        a6 = 0
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
        a16 = w46
        a17 = a1
        a18 = a6
        a13 = nil
    end
    w10 = 95
    a123(w124, w125, a126, a127)
    w125 = "EnumType"
    a123 = w120[w125]
    w124 = 26
    a127 = a127()
    a128 = 1
    w125(a126, a127, a128, a129)
    a122 = L7
    a122 = a122()
    a123 = a119[47]
    w124 = 2
    w121(a122, a123, w124, w125)
    a106(w107, w108)
    a106 = w97
    w107 = a35
    w108 = "resume"
    a106(w107, w108)
    a106 = ENV.workspace
    w107 = w97
    w108 = a56
    a109 = "wrap"
    w107(w108, a109)
    w10 = 109
    if (w10 ~= 104) then
    else
        w107 = w97
        w108 = a43
        a109 = "spawn"
        w107(w108, a109)
        w107 = w97
        w108 = a44
        a109 = "defer"
        w107(w108, a109)
        w107 = w97
        w108 = a47
        a109 = "delay"
        w107(w108, a109)
        w107 = w97
        w108 = a105
        a109 = "wait"
        w107(w108, a109)
        w107 = w1[5]
        w10 = 66
        while true do
            w107 = w0
            w108 = w97
            a109 = a53
            w110 = "traceback"
            w108(a109, w110)
            w108 = w1[5]
            a109 = w1[5]
            w10 = 41
            if (w10 >= 116) then
                w110 = function(a1, ...) -- F202
                    do return  end
                end
                a109 = w110
                w110 = function(n1, a2, a3, a4, a5, a6, ...) -- F212
                    a2 = w8
                    a2 = w108
                    a2()
                    a2 = w93
                    a2 = (892841 * a2)
                    a2 = (a2 + 297308)
                    a2 = (a2 % 16777216)
                    w93 = a2
                    a2 = w93
                    a2 = (888359 * a2)
                    a2 = (a2 + 5530975)
                    a2 = (a2 % 16777216)
                    w93 = a2
                    a2 = w93
                    a2 = (517693 * a2)
                    a2 = (a2 + 10063901)
                    a2 = (a2 % 16777216)
                    w93 = a2
                    a2 = w93
                    a2 = (34723 * a2)
                    a2 = (a2 + 6399898)
                    a2 = (a2 % 16777216)
                    w93 = a2
                    a2 = w93
                    do -- (terminates control flow)
                        while true do
                            a2 = (a2 + 11944249)
                            a2 = (a2 % 16777216)
                        end
                        while true do
                            a2 = w93
                            a2 = (619511 * a2)
                            a2 = (a2 + 13158945)
                            a2 = (a2 % 16777216)
                            w93 = a2
                            a2 = w93
                        end
                        a3 = w93
                        a3 = (211673 * a3)
                        a3 = (a3 + 16505416)
                        a3 = (a3 % 16777216)
                        w93 = a3
                        do return  end
                    end
                    a2 = (884145 * a2)
                    do -- (terminates control flow)
                        a2 = (a2 + 8368439)
                        a2 = (a2 % 16777216)
                        w93 = a2
                        a2 = w93
                        a2 = (892893 * a2)
                        a2 = (a2 + 1892924)
                        a2 = (a2 % 16777216)
                        w93 = a2
                        do return  end
                    end
                    a2 = w110
                    a3 = (n1 + 1)
                    a2(a3)
                    a2 = w8
                    a2 = (a2 - 1)
                    do -- (terminates control flow)
                        do return a2 end
                    end
                    a2 = a2(a3, a4)
                    if not (a2) then
                        w93 = a2
                        a2 = w93
                        a2 = (77149 * a2)
                    end
                    a3 = function(a1, a2, a3, a4, ...) -- F228
                        local L212, L250
                        a1 = w93
                        a1 = (488551 * a1)
                        a1 = (a1 + 11463257)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        a1 = w93
                        a1 = (218691 * a1)
                        a1 = (a1 + 2359832)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        a1 = w93
                        a1 = (21605 * a1)
                        a1 = (a1 + 1243276)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        a1 = w93
                        a1 = (339477 * a1)
                        a1 = (a1 + 7553257)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        a1 = w93
                        a1 = (636249 * a1)
                        a1 = (a1 + 9752435)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        a1 = w93
                        a1 = (891329 * a1)
                        a1 = (a1 + 16497462)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        a1 = w93
                        a1 = (753455 * a1)
                        a1 = (a1 + 3820704)
                        a1 = (a1 % 16777216)
                        w93 = a1
                    end
                    a4 = a3
                    a4()
                    a2 = w15
                    a3 = w108
                    a4 = function(a1, a2, a3, a4, ...) -- F218
                        local L102, L360, L362
                        a1 = w93
                        a1 = (43789 * a1)
                        a1 = (a1 + 6517415)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        a1 = w93
                        a1 = (327245 * a1)
                        a1 = (a1 + 8953997)
                        a1 = (a1 % 16777216)
                        w93 = a1
                        do return  end
                    end
                end
                w10 = 111
            else
                w110 = w97
                w111 = a99
                w112 = w1[5]
                a113 = true
                w110(w111, w112, a113, a114)
                w110 = function(a1, ...) -- F191
                    do return  end
                end
                w108 = w110
                w10 = 116
                a123 = w97
                w124 = w24
                w125 = "new"
                a123(w124, w125)
                a122 = 37
            end
        end
    end
    w125 = w112
    a126 = "IsStudio"
    a126 = a119[a126]
    w125(a126)
    a129 = a123; a128 = a123["GetTangentOnCurve"]
    a130 = 0.375
    a128 = a128(a129, a130)
    a127 = a128
    a128 = "X"
    a128 = a127[a128]
    a128 = (a128 * 100)
    a128 = (a128 // 1)
    w101[87] = a70
    a128 = w1[5]
    a129 = 20
    a130 = 176
    a131 = 46
    a119 = w1[5]
    w120 = w1[5]
    w121 = w1[5]
    a122 = w1[5]
    a123 = w1[5]
    w124 = w1[5]
    w125 = 7
    w125 = 58
    a126 = w45
    a127 = L4
    a126, a127, a128 = a126(a127, a128)
    a119 = a126
    w120 = a127
    a126 = w45
    a127 = L5
    a126, a127, a128 = a126(a127, a128)
    w121 = a126
    a122 = a127
        -- (constant test eliminated: if (w10 >= 100) then)
    a123 = "string"
    if not ((a122 == a123)) then
        a122 = w55
        a122()
    end
    w10 = 92
    w125 = a113; w124 = a113["GetService"]
    a126 = "HttpService"
    w124 = w124(w125, a126)
    a119 = w124
    w124 = w118
    w125 = a119
    a126 = "HttpService"
    w124(w125, a126)
    if (a122 ~= 123) then
    end
    w118 = "new"
    a117 = w25[w118]
    w118 = w112
    a119 = a35
    w118(a119)
    w10 = 40
    a130 = a123; a129 = a123["GetPositionOnCurveArcLength"]
    a131 = 0.6666666865348816
    a129 = a129(a130, a131)
    a122 = 12
    w121 = a119[57]
    w101[55] = w65
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[57]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[56]
    w101[56] = a68
    w121 = w84
    a122 = a119[56]
    a123 = L7
    a123 = a123()
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[43]
    w101[57] = w79
    w120 = 70
        -- (constant test eliminated: if not ((39 >= w120)) then)
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[45]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[28]
    w101[60] = a117
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[28]
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = a119[63]
    w101[61] = w46
    w121 = w84
    a122 = a119[63]
    a123 = L7
    a123 = a123()
    w124 = 2
    w121(a122, a123, w124, w125)
    w120 = 56
    w121 = a119[6]
    w101[62] = a113
    w120 = 55
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = a119[22]
    a128 = 1
    w125(a126, a127, a128, a129)
    w124 = 117
    w125 = w84
    a126 = "The metatable is locked"
    a127 = w48
    a128 = a123
    a127 = a127(a128)
    a128 = true
    w125(a126, a127, a128, a129)
    w125(a126, a127, a128, a129)
    w125 = a119[35]
    w101[80] = w78
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[35]
    a128 = 1
    w125(a126, a127, a128, a129)
    w121 = w1[5]
    a128 = a133
    a129 = a126
    a130 = w124
    a129 = a129(a130)
    a130 = w83
    a131 = a127
    a132 = a128
    a133 = true
    a130(a131, a132, a133, a134)
    a130 = w84
    a131 = a128
    a127 = a127()
    a128 = 1
    w125(a126, a127, a128, a129)
    w125 = w118[2]
    w101[9] = w125
    w107 = w97
    w108 = w30
    a109 = "cancel"
    w107(w108, a109)
    w10 = 104
    w10 = 13
    a133 = a131[a133]
    a134 = true
    a132(a133, a134)
    a122 = a122()
    a123 = a119[9]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[8]
    w101[71] = w71
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[8]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = 125
    a122 = 224
    a123 = 33
        -- (constant test eliminated: if (16 >= w124) then)
    w121 = 72
    a122 = 173
    a123 = 25
    while true do
        a128 = "Clone"
        a128 = w121[a128]
        a129 = "Clone"
        a127(a128, a129)
    end
    w116 = w112
    a117 = a67
    w116(a117)
    w116 = w112
    a117 = w29
    w116(a117)
    w116 = {}
    w116[4] = 3
    w116[5] = 1
    w116[10] = 6
    w10 = 72
    a117 = w112
    w118 = a38
    a117(w118)
    a117 = w112
    w118 = a41
    a117(w118)
    a117 = nil
    w10 = 45
    w120 = 102
    w121 = a119[58]
    w101[50] = w77
    w120 = 99
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[3]
    w124 = 2
    w121(a122, a123, w124, w125)
    while true do
        a128 = true
        a126(a127, a128)
        a122 = 49
    end
    a122 = w45
    a123 = w2
    w124 = false
    a122, a123, w124 = a122(a123, w124, w125)
    a119 = a122
    w120 = a123
    w121 = 61
        -- (constant test eliminated: if not ((w121 >= 86)) then)
        if a119 then
        end
    a127 = a127[a128]
    w111 = a41
    w112 = a47
    a113 = 299
    a114 = w55
    w112 = w112(a113, a114)
    w111(w112)
    w111 = w1[5]
    w112 = nil
    w10 = 52
    a104 = w97
    a105 = a31
    a106 = "unpack"
    a104(a105, a106)
    w10 = 24
    w10 = 58
    a126 = a126(a127, a128)
    a127 = w1[5]
    a122 = 61
    w118 = w112
    a119 = a44
    w118(a119)
    w118 = w112
    a119 = a47
    w118(a119)
    w10 = 108
    w118 = w112
    a119 = a43
    w118(a119)
    w10 = 1
    a57 = "readu32"
    w54 = w20[a57]
    w10 = 117
    w55 = function(t1, t2, t3, t4, ...) -- F376
        local L0, L5
        t1 = w1[5]
        t3 = nil
        L7 = t1
        v8 = t3
        v9 = t3
        L10 = t3
        L11 = t3
        v3 = t3
        t1 = function(r1, r2, a3, r4, r5, r6, r7, r8, a9, r10, a11, ...) -- F382
            local r311
            r1 = ENV.string
            r1 = r1[0]
            r2 = ENV.string
            r2 = r2[0]
            r4 = r2
            r5 = " "
            r6 = 8
            r4 = r4(r5, r6)
            r5 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...) -- F388
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
                a1 = (nil / 2)
                a7 = (a2 - a6)
                a2 = (a7 / 2)
                a3 = (a3 * 2)
                do -- (terminates control flow)
                    a5 = a4
                    do return a5 end
                end
                a4 = (a4 + a3)
                a5 = (a1 % 2)
                a6 = (a2 % 2)
            end
            r6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...) -- F398
                local L162
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
                a5 = 0
                repeat
                until not (a5)
            end
            r7 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...) -- F408
                local L68, L69, L70, L71, L72, L73, L74, L75, L76, L77, L78, L79, L80, L81, L82, L83, L84, L85, L86, L87, L88, L89, L90, L91, L92, L93, L94, L95, L96, L97, L98, L99, L100, L101, L102, L103, L104, L105, L106, L107, L108, L109, L110, L111, L112, L113, L114, L115, L116, L117, L118, L119, L120, L121, L122, L123, L124, L125, L126, L127, L128, L129, L130, L131, L132, L133, L134, L135, L136, L137, L138, L139, L140, L141, L142, L143, L144, L145, L146, L147, L148, L149, L150, L151, L152, L153, L154, L155, L156, L157, L158, L159, L160, L161, L162, L163, L164, L165, L166, L167, L168, L169, L170, L171, L172, L173, L174, L175, L176, L177, L178, L179, L180, L181, L182, L183, L184, L185, L186, L187, L188, L189, L190, L191, L192, L193, L194, L195, L196, L197, L198, L199, L200, L201, L202, L203, L204, L205, L206, L207, L208, L209, L210, L211, L212, L213, L214, L215, L216, L217, L218, L219, L220, L221, L222, L223, L224, L225, L226, L227, L228, L229, L230, L231, L232, L233, L234, L235, L236, L237, L238, L239, L240, L241, L242, L243, L244, L245, L246, L247, L248, L249, L250, L251, L252, L253, L254, L255, L256, L257, L258, L259, L260, L261, L262, L263, L264, L265, L266, L267, L268, L269, L270, L271, L272, L273, L274, L275, L276, L277, L278, L279, L280, L281, L282, L283, L284, L285, L286, L287, L288, L289, L290, L291, L292, L293, L294, L295, L296, L297, L298, L299, L300, L301, L302, L303, L304, L305, L306, L307, L308, L309, L310, L311, L312, L313, L314, L315, L316, L317, L318, L319, L320, L321, L322, L323, L324, L325, L326, L327, L328, L329, L330, L331, L332, L333, L334, L335, L336, L337
                a1 = r1
                a2 = UPVALS[a1]
                a3 = 1
                a4 = 4
                a1, a2, a3, a4, a5 = a1(a2, a3, a4, a5)
                a5 = r5
                a6 = a4
                a7 = 64
                a5 = a5(a6, a7)
                a5 = (a5 * 16777216)
                a6 = r5
                a7 = a3
                a8 = 32
                a6 = a6(a7, a8)
                a6 = (a6 * 65536)
                a5 = (a5 + a6)
                a6 = r5
                a7 = a2
                a8 = 16
                a6 = a6(a7, a8)
                a6 = (a6 * 256)
                a5 = (a5 + a6)
                a6 = r5
                a7 = a1
                a8 = 8
                a6 = a6(a7, a8)
                a5 = (a5 + a6)
                do return a5 end
            end
            r8 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, ...) -- F420
                local L101
                a1 = r7
                -- (junk op: register-file store with a decoded-at-runtime index)
                a2 = r7
                a2 = a2()
                a3 = 1
                a4 = UPVALS[a1]
                a5 = a2
                a6 = 1
                a7 = 20
                a4 = a4(a5, a6, a7)
                a4 = (a4 * 4294967296)
                a4 = (a4 + a1)
                a5 = r6
                a6 = a2
                a7 = 21
                a8 = 31
                a5 = a5(a6, a7, a8)
                a6 = r6
                a7 = a2
                a8 = 32
                a6 = a6(a7, a8)
                a6 = (1 ^ a6)
                a6 = (-a6)
                do -- (terminates control flow)
                    repeat
                    until not (a7)
                    a7 = (a6 * 0)
                    a7 = (a7 / 0)
                    a7 = (a5 - 1023)
                    a7 = (2 ^ a7)
                    a7 = (a6 * a7)
                    a8 = (a4 / 4503599627370496)
                    a8 = (a3 + a8)
                    a7 = (a7 * a8)
                    do return a7 end
                end
                if not ((a4 ~= 0)) then
                    a7 = (a6 * 0)
                    do return a7 end
                end
                a5 = 1
                a3 = 0
                a7 = (a4 == 0)
                a7 = (a6 * 1)
                a7 = (a7 / 0)
            end
            a9 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F432
                a1 = 1
                a2 = r7
                a2 = a2()
                a3 = 1
                a15 = r8
                -- (junk op: register-file store with a decoded-at-runtime index)
                a15 = a5[a15]
                a15 = r5
                a16 = r8
                a16 = a16()
                a17 = r8
                a15 = a15(a16, a17(a18))
                a5[a14] = a15
                a14 = r7
                a14 = a14()
                a15 = r8
                a15 = a15()
                if (not a15) then
                    a5[a14] = a15
                    a14 = r6
                    a15 = r8
                    a15 = a15()
                    a16 = r7
                    a14 = a14(a15, a16(a17))
                    a15 = {} -- size 1
                    a16 = r8
                    a16 = a16()
                    a17 = r7
                    a17(a18)
                    -- table.move range
                    a5[a14] = a15
                end
                a15 = UPVALS[a2]
                a15 = a15()
                do -- (terminates control flow)
                    a1 = r5
                    a2 = r8
                    a2 = a2()
                    a3 = r7
                    a3(a4)
                    do return a1(...--[[registers a2..top of stack]]) end
                end
                a10 = 0
                a11 = 255
                a12 = 1
                while true do
                    a5 = {}
                    a6 = 0
                    a7 = 255
                    a8 = 1
                end
                while true do
                    a11 = a11(a12, a13(a14))
                    a5[a10] = a11
                    a10 = r5
                    a11 = r7
                    a11 = a11()
                    a12 = r7
                    a10 = a10(a11, a12(a13))
                    a11 = UPVALS[a1]
                    a12 = r7
                    a12 = a12()
                    a13 = r7
                    a11 = a11(a12, a13(a14))
                    a5[a10] = a11
                end
                a6 = 1
                a7 = r7
                a7 = a7()
                a8 = 1
                a10 = r5
                a11 = r7
                a11 = a11()
                a12 = r7
                a10 = a10(a11, a12(a13))
                a11 = r5
                a14 = r7
                a14 = a14()
                a14 = r8
                a14 = a14()
                while true do
                    a12 = a12()
                    a13 = r7
                end
                a12 = r7
            end
            r10 = a9
            r10 = r10()
            if not ((not r10)) then
                r10 = a9
                r10()
            end
            do return  end
        end
        t1()
        L0, t1, t2, t3, t4 = nil
        -- opaque op 125 (instr 10)
        t1 = 2
        L0 = L0[t1]
        t1 = {}
        t2 = 1
        t3 = (#L0)
        t4 = 1
        while true do -- (empty spin loop: unrestructured dispatcher exit)
        end
        L0[L5] = t1
    end
    w10 = 80
    w121 = w84
    a122 = L7
    a122 = a122()
    a123 = a119[14]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[9]
    w101[70] = a127
    w121 = w84
    a122 = L7
    w125(a126, a127, a128, a129)
    w121 = w1[5]
    a122 = w1[5]
    a123 = w1[5]
    w124 = 71
    if not ((a117 >= 188)) then
        if not ((36 >= a117)) then
            w118 = a56
            a119 = function(a1, a2, a3, ...) -- F114
                a1 = w39
                a2 = 1468268675
                a1(a2)
                a1 = w39
                a2 = w112
                a1(a2)
                do return  end
            end
            w118 = w118(a119)
            a113 = w118
        end
    end
    w118 = w83
    a119 = a113
    a119 = a119()
    w120 = 1468268675
    w121 = true
    w118(a119, w120, w121, a122)
    w118 = w83
    a119 = a113
    a119 = a119()
    w120 = w112
    w121 = true
    w118(a119, w120, w121, a122)
    w10 = 7
    a68 = a34
    a69 = 2048
    a68 = a68(a69)
    w66 = a68
    w10 = 31
        -- (constant test eliminated: if (41 >= w10) then)
        if (114 >= w10) then
                -- (constant test eliminated: if not ((w10 >= 41)) then)
                w36 = w1[37]
                w10 = 114
        else
            w40 = w1[36]
        end
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[37]
    a128 = 1
    w125(a126, a127, a128, a129)
    w118 = a91
    a119 = w19
    w120 = {}
    w120[2728713478] = 1541303681
    w120[901450932] = 1153969210
    w120[889552922] = 784453481
    w118(a119, w120)
    w10 = 57
    w118 = a91
    a119 = a49
    w120 = {}
    w120[410403160] = 452019009
    w120[749373828] = 168960940
    w120[2260094527] = 595074863
    w120[1939539207] = 1070924627
    w120[2267345195] = 659079966
    w118(a119, w120)
    w118 = a91
    a119 = w4
    w120 = {}
        -- (constant test eliminated: if not ((w10 >= 119)) then)
        a102 = w97
        a103 = w60
        a104 = "setfenv"
        a102(a103, a104)
        w10 = 65
    w120 = 13
    w121 = w84
    a122 = a119[58]
    a123 = L7
    a123 = a123()
    w124 = 2
    w121(a122, a123, w124, w125)
    if (31 >= w120) then
        w120 = 114
        w121 = w84
        a122 = L7
        a122 = a122()
        a123 = a119[11]
        w124 = 1
        w121(a122, a123, w124, w125)
    else
        w120 = 116
        w121 = w84
        a122 = L7
        a122 = a122()
        a123 = a119[34]
        w124 = 2
        w121(a122, a123, w124, w125)
    end
    while true do -- (empty spin loop: unrestructured dispatcher exit)
    end
        -- (constant test eliminated: if (w120 > 47) then)
        w121 = a119[48]
        w101[48] = w22
        w120 = 57
    w88 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, ...) -- F463
        local L449
        a4 = a2
        a5 = w45
        a6 = w1[5]
        a7 = 93
            -- (constant test eliminated: if not ((93 > a7)) then)
            a6 = w1[5]
            a7 = 24
            a9 = 24
            a10 = 237
            a11 = 108
            while true do
                a9 = a4
                a6 = w83
            end
        a8 = a5
        a9 = a4
        a10 = ...  -- vararg fill: also writes R11, R12, ... (count is runtime dependent)
        a8, a9, a10 = a8()
        a5 = a8
        a4 = a9
        a6 = w79
        a8 = w1[5]
        a8 = a5
        L449 = UP120[nil]
        a8 = a1
        a10 = a6
        a11 = a8
        a12 = a9
        a10(a11, a12)
        a13 = a6
        a14 = a8
        a13(a14)
        while true do -- (empty spin loop: unrestructured dispatcher exit)
        end
        do -- (terminates control flow)
            do return  end
        end
    end
    w10 = 48
    a129 = "X"
    a129 = a128[a129]
    a129 = (a129 * 100)
    a129 = (a129 // 1)
    w101[89] = a105
    a129 = a119
    a130 = "X"
    a130 = a128[a130]
    a131 = true
    a129(a130, a131)
    a129 = 6
    a130 = 231
    a131 = 117
    w10 = 54
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = a119[18]
    a128 = 1
    w125(a126, a127, a128, a129)
    a126 = "Y"
    a126 = w125[a126]
    a126 = a126[0]
    a126 = (a126 * 100)
    a126 = (a126 // 1)
    w101[84] = a126
    a126 = a119
    a127 = "Y"
    a127 = w125[a127]
    a128 = "Scale"
    a127 = a127[a128]
    a128 = true
    a126(a127, a128)
    a127 = a123; a126 = a123["GetPositionOnCurve"]
    a128 = 0.2857142984867096
    w125 = a119[49]
    w101[78] = w5
    w125 = w83
    if (w120 ~= 99) then
    else
        w118 = {}
        a119 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, ...) -- F30
            local L0, L332, L467
            a3 = w1[5]
            a4 = 4
            a3 = v9
            a4 = 19
            a10 = w1[5]
            a11 = 40
            a12 = 246
            a13 = 107
            repeat
            until not ((a14 >= 147))
            a6 = w63
            a6 = w58
            a5 = (a5 + a6)
            a8 = 100
            do -- (terminates control flow)
                do return  end
            end
            a8 = a8[a9]
            a10 = a6
            a11 = a8
            a10(a11)
            a6 = UPVALS[a5]
            a10 = 2
            a11 = 30
            a12 = 7
            a8 = a7
            a9 = true
            while true do
                a6[a8] = a9
                a10 = 51
                a11 = 245
                a12 = 97
            end
            a8 = a3
            a4 = 100
                -- (constant test eliminated: if not ((98 >= a4)) then)
                a9 = true
            a8 = w118
            if (a13 ~= 9) then
                a8 = a3
            else
                a9 = L0
                a6[a8] = a9
            end
            a6 = (a6 // a8)
            a10 = 68
            a11 = 83
            a12 = 15
            while true do
                a6 = UPVALS[a5]
                a4 = 89
                a7 = (a7 - a5)
            end
            a5 = a3
            a8 = w1[5]
            a9 = w1[5]
            a10 = 112
            a11 = 463
            a12 = 71
            a6 = 1
            a13 = 70
            a14 = 21
            repeat
            until not ((a15 ~= 28))
            a8 = 2
            a8 = 61
            a9 = 175
            a10 = 57
            a8 = a5
            a8 = 1
            a1 = a6
            a6 = a2
            a9 = w1[5]
            while true do
                a8 = w66
                a11 = w1[5]
                a12 = 7
                a19 = a10
                a16(a17, a18, a19, a20)
            end
            a6 = w118
            a4 = 48
            a6 = (a6 + a8)
            a6 = (a6 * a8)
            a11 = 231
            a12 = 71
            repeat
            until not ((a13 ~= 254))
            a9 = true
                -- (constant test eliminated: if (a13 ~= 69) then)
                a6[a8] = a9
            a11 = w58
            a16 = a6
            a17 = a8
            a18 = a11
            a9 = a1
            a11 = 213
            a12 = 91
            while true do -- (empty spin loop: unrestructured dispatcher exit)
            end
            a6 = w78
            a6 = w118
            a9 = w1[5]
            a6[a8] = a9
            a4 = 98
            a6[a8] = a9
            a6 = a1
            a6 = w118
            a8 = a5
            a10 = 69
            a5 = 1
            a6 = w1[5]
            a7 = w1[5]
            w58 = a6
            a6[a8] = a9
            a6 = w118
            a10 = 17
        end
        w120 = w1[5]
        w121 = w1[5]
        a122 = 94
    end
    a123 = a123()
    w124 = 2
    w121(a122, a123, w124, w125)
    w116 = w112
    a117 = w17
    w116(a117)
    w116 = w112
    a117 = w18
    w116(a117)
    w10 = 115
    w121(a122, a123, w124, w125)
    w121 = w118[10]
    w101[13] = w121
    w121 = w84
    a122 = L7
    a122 = a122()
    a123 = w118[10]
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = w118[4]
    w101[14] = w40
    w121 = w84
    a122 = w118[4]
    a123 = L7
    a123 = a123()
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = w118[7]
    w101[15] = w30
    w120 = 95
    a129 = 613
    a130 = true
    a127(a128, a129, a130, a131)
    w121 = a119[45]
    w101[59] = w84
    w120 = 90
    w101(a102, a103)
    w101 = w1[5]
    w10 = 30
    if (w120 >= 21) then
    else
        w74 = w1[65]
        w75 = {}
        a76 = w1[5]
    end
    a127 = 813
    w124 = w124(w125, a126, a127)
    w125 = 807
    a126 = true
    a123(w124, w125, a126, a127)
    a122 = 102
    a132 = a129[4]
    a133 = 95
        -- (constant test eliminated: if (36 >= w10) then)
    a68 = w1[59]
    w10 = 29
    w124 = "NextUnitVector"
    w124 = w121[w124]
    w125 = "NextUnitVector"
    a123(w124, w125)
    a123 = w97
    w124 = "NextInteger"
    w124 = w121[w124]
    w125 = "NextInteger"
    a123(w124, w125)
    a123 = w97
    w124 = "NextNumber"
    w124 = w121[w124]
    w125 = "NextNumber"
    a123(w124, w125)
    a123 = 23
    w124 = 66
    w125 = 43
    w121 = w84
    a122 = L7
    a122 = a122()
    a123 = a119[a119]
    w124 = 2
    w121(a122, a123, w124, w125)
    w120 = 79
    a89 = w1[5]
    w90 = w1[5]
    w10 = 60
    a81 = w1[66]
    w10 = 11
    a127 = a119[31]
    a128 = 1
    w125(a126, a127, a128, a129)
    w120 = 92
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = w118[1]
    w124 = 1
    w121 = 87
    a122 = 281
    a123 = 97
    while true do
        a128 = "Y"
        a128 = a126[a128]
        a129 = "Scale"
        a128 = a128[a129]
    end
    w124 = 2
    w121(a122, a123, w124, w125)
    w120 = 78
    w121 = w84
    a122 = a119[51]
    a123 = L7
    a123 = a123()
    a122 = 119
    w125 = w97
    a126 = "GetAsync"
    a126 = a119[a126]
    a127 = "GetAsync"
    w125(a126, a127)
    w124 = 114
    w125 = w97
    a126 = "PostAsync"
    a126 = a119[a126]
    a127 = "PostAsync"
    w125(a126, a127)
    w125 = w97
    a126 = "RequestAsync"
    a126 = a119[a126]
    a127 = "RequestAsync"
    w125(a126, a127)
    a122 = 15
    a123 = w118
    w124 = w121
    w125 = "Folder"
    a123(w124, w125)
    a123 = w84
    w124 = "Parent"
    w124 = w121[w124]
    w125 = w120
    a126 = true
    a123(w124, w125, a126, a127)
    a123 = "WaitForChild"
    a123 = w120[a123]
    w124 = w84
    w125 = "Parent"
    w125 = w121[w125]
    a126 = "Parent"
    a126 = w121[a126]
    a127 = true
    w124(w125, a126, a127, a128)
    w124 = w97
    w125 = a123
    a126 = "WaitForChild"
    w124(w125, a126)
    w124 = w1[5]
    w125 = 116
    a126 = 133
    a127 = 17
    if (not a119) then
    else
        a126 = w55
        a126()
    end
    a127 = w118[12]
    a128 = 1
    w125(a126, a127, a128, a129)
    a126 = L7
    a126 = a126()
    a127 = a119[38]
    a128 = 2
    w125(a126, a127, a128, a129)
    w121 = 6
    a122 = 334
    a123 = 82
    a126 = w45
    a127 = L6
    a126, a127, a128 = a126(a127, a128)
    a123 = a126
    w124 = a127
    w125 = 81
    w120 = 55
    w120 = 42
    w121 = a119[26]
    w101[81] = L635
    a119 = w30
    w118(a119)
    w10 = 42
    w125 = a119[36]
    w101[67] = a103
        -- (constant test eliminated: if (a122 >= 106) then)
    w125 = a119[1]
    w101[31] = w125
    w10 = 10
    a122 = w1[169]
    a123 = L12[4]
    a122 = a122(a123)
    w121 = w121(a122)
    a122 = L12[6]
    w121 = (w121 + a122)
    a122 = L12[1]
    w121 = (w121 - a122)
    a122 = L12[7]
    w121 = (w121 + a122)
    w121 = (-7254156035 + w121)
    a122 = 1
    w121 = w118[9]
    w101[17] = w18
    w120 = 8
    w71 = identifyexecutor
    w10 = 74
    if not ((w124 == 252)) then
        w125 = a119[51]
        w101[33] = w27
    end
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[32]
    a128 = 1
    w125(a126, a127, a128, a129)
    w120 = 66
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[17]
    w124 = 1
    w121(a122, a123, w124, w125)
    a132 = "X"
    a132 = a131[a132]
    a132 = (a132 * 100)
    a132 = (a132 // 1)
    w101[95] = a126
    a122 = 27
    a133 = a133(a134, a135)
    a133 = (#a132)
    a133 = w90
    a134 = a132
    a133 = a133(a134)
    a133 = a126[a133]
    if a133 then
        w120 = (w120 + a133)
        w125 = (w125 + 1)
        if (50 >= w125) then
            a131, a132, a133 = coroutine.resume(a131, a132, a133)
            if a131 then
                a133 = w80
                a134 = "string"
                a135 = w13
                a136 = a132
                a135 = a135(a136)
            else
                w125 = "HumanoidCollisionType"
                w125 = a119[w125]
                a126 = "OuterBox"
                w125 = w83
                a126 = L7
                a126 = a126()
                a127 = w118[13]
                a128 = 2
                w125(a126, a127, a128, a129)
                w125 = w118[6]
            end
        end
    end
    a128 = 1
    w125(a126, a127, a128, a129)
    w97 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, ...) -- F313
        local L38, L201
        a4 = w33
        a5 = a1
        a4 = a4(a5)
        a4 = w84
        a5 = w13
        a6 = a1
        a5 = a5(a6)
        a6 = "function"
        a4(a5, a6)
        a4 = w88
        a5 = "'setfenv' cannot change environment of given object"
        a6 = w60
        a7 = a1
        a8 = w95
        a4(a5, a6, a7, a8, a9)
        a4 = w51
        a5 = a1
        a6 = "slnaf"
        a4, a5, a6, a7, a8, a9, a10 = a4(a5, a6, a7)
        a10 = w83
        a11 = "[C]"
        a12 = a4
        a10(a11, a12)
        a10 = 66
        a11 = 430
        a12 = 60
        a4 = w55
        a4()
        repeat
        until not (a3)
        a14 = w84
        a15 = a6
        a16 = a2
        a14(a15, a16)
        a14 = w84
        a15 = 0
        a16 = a7
        a14(a15, a16)
        a14 = w84
        a15 = true
        a16 = a8
        a14(a15, a16)
        a14 = UPVALS[a1]
        a15 = a1
        a16 = a9
        a14(a15, a16)
        while true do
            a14 = 65
        end
        a14 = w71
        a15(a16, a17)
        a15 = w84
        a16 = w74
        a17 = a1
        a16 = a16(a17)
        a17 = true
        a15 = w84
        a16 = false
        a17 = w85
        a18 = a1
        a15(a16, a17(a18, a19))
        a14 = 106
    end
    a99 = w97
    w100 = w48
    w101 = "getmetatable"
    a99(w100, w101)
    w10 = 32
    a128 = a117
    a129 = "Path2D"
    a128 = a128(a129)
    a123 = a128
    a113 = w112
    a114 = a57
    a115 = -19393
    a113(a114, a115)
    a113 = w1[5]
    w10 = 107
    w118 = w112
    a119 = a94
    w118(a119)
    w118 = w112
    a119 = w51
    w118(a119)
    w118 = w112
    a119 = a99
    w118(a119)
    w118 = w97
    a119 = a117
    w120 = "new"
    w118(a119, w120)
    w118 = w112
    a119 = a117
    w120 = w1[5]
    w118(a119, w120)
    w10 = 43
    a123 = v9
    a123 = a123()
    w120 = bit32.bxor(a123, 1180920661)
    w10 = 68
    w121 = w83
    a122 = L7
    a122 = a122()
        -- (constant test eliminated: if (w10 >= 46) then)
            -- (constant test eliminated: if not ((w10 >= 75)) then)
            if not ((46 >= w10)) then
                a127 = a59
                a128, a129 = nil
                -- generic-for iterator (coroutine desugar) reg R127
                w125 = a119[24]
                w101[24] = w52
                w125 = w84
                a126 = L7
            end
    w121 = w121(a122)
    w121 = (-26 + w121)
    a122 = 1
    w121(a122, a123, w124, w125)
    w121 = a119[10]
    w101[65] = w85
    if not ((w120 ~= 78)) then
        w121 = a119[42]
        w101[34] = w186
        w121 = w83
        a122 = L7
        a122 = a122()
        a123 = a119[42]
        w124 = 1
        w121(a122, a123, w124, w125)
        w121 = a119[53]
        w101[35] = L551
        w121 = w83
        a122 = L7
        a122 = a122()
        a123 = a119[53]
        w124 = 1
        w121(a122, a123, w124, w125)
        w121 = 111
        w125 = a119[31]
        w101[29] = a106
        w125 = w83
        a126 = L7
        a126 = a126()
    end
    while true do
        a134 = "Y"
        a134 = a128[a134]
        a135 = true
        a133(a134, a135)
    end
    a133 = a119
    w101 = w97
    a102 = w2
    a103 = "assert"
    w101(a102, a103)
    w101 = w97
    a102 = w3
    a103 = "error"
    w78 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, ...) -- F329
        local L78
        a3 = w50
        a4 = w1[5]
        a5 = 38
        if not ((a8 ~= 9)) then
            a3 = w58
            a4 = 1
            a3 = (a3 + a4)
            w58 = a3
            repeat
            until not ((not a3))
            a6 = w1[5]
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
        a9(a10, a11, a12, a13)
        a8 = 9
        a5 = 77
        a4 = a1
        while true do -- (empty spin loop: unrestructured dispatcher exit)
        end
        a3 = w61
        a3 = w55
        a4 = w66
        a7 = w58
        a8 = 82
        a10 = a3
        a10()
        a6 = 1
        a6 = 61
        a7 = 254
        a8 = 92
    end
    w10 = 50
    a133 = a126
    a134 = a122
    a133 = a133(a134)
    a128 = 1
    w125(a126, a127, a128, a129)
    a123 = a123()
    w124 = 2
    w121(a122, a123, w124, w125)
    w125 = a119[39]
    w101[68] = w64
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[39]
    a128 = 1
    w125(a126, a127, a128, a129)
    w125 = a119[14]
    w101[69] = a42
    w111 = w1[5]
    w116 = a43
    a117 = function(a1, a2, a3, ...) -- F246
        local L28, L451
        while true do
            -- (junk op: register-file store with a decoded-at-runtime index)
            w111 = a1
            do return  end
        end
        a1 = w23
    end
    w116(a117)
    a104 = w97
    a105 = w22
    a106 = "isyieldable"
    a104(a105, a106)
    w10 = 97
    a123 = w83
    w124 = "table"
    w125 = w13
    a126 = L12
    w125 = w125(a126)
    a126 = true
    a123(w124, w125, a126, a127)
    w28 = false
    w29 = true
    w27[w28] = w29
    w28 = true
    w29 = false
    w27[w28] = w29
    w28 = w1[27]
    w29 = "concat"
    w29 = w9[w29]
    w30 = w1[5]
    a31 = w1[5]
    a32 = w1[5]
    w10 = 91
    w33 = "create"
    a32 = w6[w33]
    w33 = function(a1, a2, a3, a4, a5, a6, a7, ...) -- F487
        local L137, L278, L309
        a2 = w1[5]
        a3 = w1[5]
        a4 = 96
        a4 = 63
        a2 = a1
        while true do
            a3 = UPVALS[a1]
            a2 = (not a2)
            a3 = a3[a2]
            a5 = a3
            do return a5 end
        end
    end
    a34 = "create"
    a34 = w20[a34]
    a119 = w1[5]
    w120 = w1[5]
    w121 = 86
    a130 = (a130 * 100)
    a130 = (a130 // 1)
    w101[92] = w6
    a135 = 0.20000000298023224
    a133 = a133(a134, a135)
    a128 = a133
    w124 = a89
    w125 = a119
    w124(w125)
    w111 = a41
    w112 = a43
    a113 = function(a1, a2, ...) -- F154
        a1 = w39
        a1()
        do return  end
    end
    w112 = w112(a113)
    w111(w112)
    w10 = 81
    a114 = w112
    a115 = w60
    w116 = -31710
    a114(a115, w116)
    w10 = 78
    a132 = "Y"
    a132 = a131[a132]
    a132 = (a132 * 100)
    a132 = (a132 // 1)
    w101[96] = L609
    a132 = w1[5]
    a133 = 69
    a134 = 491
    a135 = 125
    while true do
        a126 = 0
        a127 = 0
        a123 = a123(w124, w125, a126, a127)
        w121["Position"] = w212
        a123 = "Size"
        w124 = a114
        w125 = 0
        a126 = 144
        a127 = 0
    end
    w112 = 1188220356
    w125 = w118[15]
    w101[3] = w14
    w121 = L12[4]
    w121 = L12[2]
    w121 = (-2535928120 + w121)
    a122 = 1
    a122 = a122(a123)
    a123 = true
    w120(w121, a122, a123, w124)
    w120 = w1[5]
    w121 = 67
    a122 = 99
    a123 = 16
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[7]
    a128 = 2
    w125(a126, a127, a128, a129)
    w55 = nil
    a56 = w1[5]
    w10 = 110
    a139 = 0
    a140 = 0
    a141 = 0
    a137 = a137(a138, a139, a140, a141)
    a138 = a114
    a139 = 0
    a140 = -7
    a141 = 0
    a142 = 2
    a138(a139, a140, a141, a142, a143)
    a135()
    -- table.move range
    a128(a129, a130)
    w125 = a123; w124 = a123["GetLength"]
    w124 = w124(w125)
    w125 = (w124 * 100)
    w125 = (w125 // 1)
    w101[82] = w111
    w125 = w1[5]
    a122 = 80
    w125 = a119[38]
    w101[30] = w50
    w125 = w84
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[40]
    a128 = 1
    w125(a126, a127, a128, a129)
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[27]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[50]
    w101[42] = w110
    w120 = 7
    a73 = Vector2
    w101[22] = a69
    w120 = 89
    while true do
        a131 = a127
        a132 = a129
        a133 = true
        a130(a131, a132, a133, a134)
        w125 = 1
    end
    a130 = w84
    w121 = a119; w120 = a119["Destroy"]
    w120(w121)
    w120 = w1[w1]
    w121 = w1[5]
    a122 = 14
    w125 = a119[15]
    w101[76] = w124
    if (a122 ~= 63) then
        w124 = 1
        w125 = a123
        a126 = 1
    else
        a122 = 18
        w125 = w121; w124 = w121["NextInteger"]
        a126 = 181
        a127 = 605
        w124 = w124(w125, a126, a127)
        a123 = (w124 % 24)
    end
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[59]
    a128 = 1
    w125(a126, a127, a128, a129)
    w125 = a119[18]
    w101[73] = a96
    w125 = 0
    a126 = w1[5]
    a127 = 54
    a128 = 98
    a127, a128, a129 = coroutine.resume(a127, a128, a129)
    if a127 then
        a122 = (a122 + 1)
        a99 = w1[5]
        w10 = 7
    end
    w121 = a119[47]
    w101[45] = w58
    w120 = 29
    w121 = w83
    w121 = a119[62]
    w101[54] = a53
    w121 = w84
    a122 = a119[62]
    a123 = L7
    a123 = a123()
    w124 = 1
    w121(a122, a123, w124, w125)
    w125 = a119[11]
    w101[25] = a102
    w17 = "match"
    w12 = w5[w17]
    w13 = w1[13]
    w17 = "find"
    w14 = w5[w17]
    w10 = 92
        -- (constant test eliminated: if not ((8 >= w10)) then)
            -- (constant test eliminated: if not ((w10 >= 102)) then)
            w8 = 6666
            w10 = 8
            w125 = w84
            a126 = L7
            a126 = a126()
            a127 = w118[5]
            a128 = 2
            w125(a126, a127, a128, a129)
            w120 = a119
            a122 = 21
            a115 = a127
            a119 = w1[5]
            w120 = 14
            w121 = 79
            a122 = 2
            a99[w100] = w101
            w100 = "isvararg"
            w101 = true
            a99[w100] = w101
            a96 = a99
            w10 = 5
    w6 = coroutine
    w11 = "gmatch"
    w7 = w5[w11]
    w124 = v9
    w124()
    a131 = a123; a130 = a123["GetPositionOnCurveArcLength"]
    a132 = 0.4000000059604645
    a130 = a130(a131, a132)
    a131 = a130[0]
    a132 = "Scale"
    a131 = a131[a132]
    a131 = (a131 * 100)
    a131 = (a131 // 1)
    w125 = 0.9787031188959563
    a126 = true
    a123(w124, w125, a126, a127)
    a123 = w83
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w125 = 0.5760869541013449
    a126 = true
    a123(w124, w125, a126, a127)
    a123 = w1[5]
    a122 = 63
    w125 = w84
    a126 = a123[w121]
    a127 = w120
    a128 = true
    w125(a126, a127, a128, a129)
    w124 = 92
    w121 = w118
    a122 = a119
    a123 = "RunService"
    w121(a122, a123)
    w120 = 61
    w121 = w83
    a122 = a113
    a123 = "Parent"
    a123 = a119[a123]
    w124 = true
    w121(a122, a123, w124, w125)
    w121 = w97
    a122 = w1[w1]
    a122 = a119[a122]
    a123 = "IsStudio"
    w121(a122, a123)
    w121 = w97
    a122 = "IsClient"
    a122 = a119[a122]
    a123 = "IsClient"
    w121(a122, a123)
    w121 = 31
    a122 = 39
    a123 = 8
    a102 = w97
    a103 = a57
    a104 = "getfenv"
    a102(a103, a104)
    w10 = 106
    a104 = w97
    a105 = w23
    a106 = "running"
    a104(a105, a106)
    a104 = w97
    a105 = a32
    a106 = "create"
    a104(a105, a106)
    a104 = w1[5]
    a105 = w1[5]
    w10 = 76
    a122 = 0
    w111 = a76
    w112 = (w93 % 256)
    w112 = (w93 - w112)
    w112 = (w112 / 256)
    w111(w112)
    w10 = 77
    w121 = (w121 - a122)
    a122 = L12[1]
    w121 = (w121 - a122)
    a122 = L12[7]
    w121 = (w121 ~= a122)
    if (not w121) then
    end
    w101[11] = w9
    a41 = "yield"
    w39 = w6[a41]
    w10 = 116
    w125 = a119[32]
    w101[32] = w26
    w125 = w84
    a127 = a123; a126 = a123["FromValue"]
    a128 = a122
    a126 = a126(a127, a128)
    a127 = w120
    a126(a127, a128)
    if not ((a119 >= 78)) then
        a119 = 107
        w120 = 1
        w121 = w1[169]
    end
    w120 = 1
    w121 = L12[6]
    a122 = L12[1]
    w121 = (w121 - a122)
    a122 = L12[7]
    w121 = (w121 + a122)
    a122 = L12[2]
    a119 = w1[5]
    w120 = 19
    a106 = "abs"
    a104 = w19[a106]
    w10 = 94
    w116 = w112
    a117 = w18
    w116(a117)
    w10 = 70
    if (w10 ~= 40) then
    else
        w118 = w112
        a119 = a56
        w118(a119)
        w118 = w112
    end
    if not ((33 >= a115)) then
        w116 = w50
        a117 = w45
        w118 = a41
        a119 = w111
    end
    a132 = 43
    a133 = bit32.bxor(a127, 64)
    a134 = w16
    a135 = a127
    a134 = a134(a135)
    w100[a133] = a134
    a133 = 47
    a134 = w36
    a135 = a131
    a136 = a126
    a134(a135, a136)
    w101 = w97
    a102 = w37
    a103 = "tostring"
    w101(a102, a103)
    w10 = 123
    if not ((111 >= w124)) then
        w125 = w84
        a126 = a119[15]
        a127 = L7
        a127 = a127()
        a128 = 1
        w125(a126, a127, a128, a129)
        w121 = 67
        a122 = 172
        a123 = 35
        while true do
            a128 = 2
            w125(a126, a127, a128, a129)
        end
    end
    w125 = w84
    a126 = a119[44]
    a127 = L7
    w125 = w97
    a126 = "FromValue"
    a126 = a123[a126]
    a127 = "FromValue"
    w125(a126, a127)
    w125 = w112
    a126 = a123[0]
    w125(a126)
    w125 = w112
    a126 = "FromValue"
    a126 = a123[a126]
    w125(a126)
    w124 = 50
    w121 = w118[14]
    w101[16] = w66
    w120 = 105
    w124 = w83
    w125 = a113
    a126 = "Parent"
    a126 = a119[a126]
    a127 = true
    w124(w125, a126, a127, a128)
    w124 = 31
    a131[328532366] = L602
    a131[1929211092] = w260
    a131[440669232] = L638
    a131[1011881004] = w273
    a131[2267675775] = L394
    a131[1132109174] = L447
    a131[2571219683] = L495
    a131[236808915] = L618
    w125 = a119[27]
    w101[41] = a81
    w125 = w83
    a126 = w52
    a127 = a123
    a126 = a126(a127)
    a127 = "Enum"
    a128 = true
    w125(a126, a127, a128, a129)
    w124 = 110
    w120 = 86
    a122 = a113; w121 = a113["GetService"]
    a123 = "RunService"
    a140 = -9
    a136 = a136(a137, a138, a139, a140)
    a137 = a114
    a138 = 0
    repeat
    until not ((a122 >= 120))
    a122 = 106
    a128 = a119
    a129 = "Y"
    a129 = a126[a129]
    a130 = "Scale"
    a129 = a129[a130]
    a130 = true
    a128(a129, a130)
    a114 = w112
    a115 = w13
    a114(a115)
    a114 = w112
    a115 = w40
    a114(a115)
    w10 = 81
    w121 = a119[34]
    w101[26] = w112
    w120 = 41
    w121 = w84
    a122 = a119[6]
    a123 = L7
    a123 = a123()
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = a119[33]
    w101[63] = w121
    w121 = w84
    a122 = L7
    a122 = a122()
    a123 = a119[33]
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = a119[19]
    w101[64] = w120
    w121 = w84
    a122 = L7
    a122 = a122()
    a123 = a119[19]
    w124 = 2
    a132 = a137
    w121 = 53
    a122 = 233
    a123 = 29
    while true do
        a126 = (a126 // 1)
        w101[83] = a104
    end
    a126 = (a126 * 100)
    while not ((43 >= a122)) do -- while-exit-cond
        a119 = 4
        w120 = 0
        a122 = 43
        a123 = 0
        w124 = (w120 - 1)
        w125 = 1
    end
    a119 = 60
    w120 = 1
    w121 = w1[166]
    a122 = w1[167]
    a123 = w1[168]
    w124 = L12[2]
    w125 = L12[2]
    w124 = (w124 + w125)
    w125 = L12[1]
    w124 = (w124 + w125)
    a123 = a123(w124)
    a122 = a122(a123)
    a123 = w118[7]
    w124 = 2
    w121(a122, a123, w124, w125)
    w120 = 50
    a129 = w112
    a130 = a123
    a131 = w1[5]
    a129(a130, a131)
    a122 = w13
    a123 = w120
    a122 = a122(a123)
    a126 = "X"
    a126 = w125[a126]
    a127 = "Scale"
    a126 = a126[a127]
    a131 = a131[a132]
    a132 = true
    a130(a131, a132)
    w111 = function(a1, a2, a3, a4, a5, a6, ...) -- F56
        a2 = (a1 + 3)
        a3 = w51
        a4 = a2
        a5 = "f"
        a3 = a3(a4, a5)
        do return a3 end
    end
    w10 = 3
    a133 = "Y"
    a133 = a128[a133]
    a133 = (a133 * 100)
    a133 = (a133 // 1)
    w101[90] = L466
    a123 = w84
    w124 = w13
    w125 = L12[a122]
    w124 = w124(w125)
    w125 = "number"
    a123(w124, w125)
    w120 = 47
    w121 = a119[17]
    w101[47] = w21
    while true do -- (empty spin loop: unrestructured dispatcher exit)
    end
    a122 = 59
    a123 = w83
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w120 = 107
    w83 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, ...) -- F94
        local L348
        a4 = w82
        a5 = a1
        a6 = w1[5]
        a7 = 26
        a8 = 107
        a9 = 27
        if (4 >= a11) then
            if not ((a11 >= 121)) then
                if not ((2 >= a11)) then
                    a5 = (a5 == a6)
                    a5 = a1
                    a4 = a5
                    a5 = w61
                    a12 = w1[5]
                    a13 = w1[5]
                    a11 = 51
                        -- (constant test eliminated: if (51 >= a11) then)
                end
            end
        end
        a4 = 1
        a11 = 2
        a12 = 82
        a13 = 106
        a14 = 24
        a5 = a3
        while not ((not a4)) do -- while-exit-cond
        end
        a4 = a5
        a5 = (a5 == a6)
        if not ((not a5)) then
            a12 = 107
            a13 = 288
            a14 = 125
        end
        a14 = a5
        a15 = a6
        a16 = a12
        a17 = a13
        a14(a15, a16, a17, a18)
        a14 = 112
        a15 = 116
        a16 = 2
        while true do -- (empty spin loop: unrestructured dispatcher exit)
        end
        a5 = w58
        a5 = a2
        do -- (terminates control flow)
            do return  end
        end
        a11 = 4
        a6 = 1
        while true do
            a11 = a11(a12, a13)
            a4 = a11
        end
        a13 = a6
        a4 = a3
        a6 = 2
        if (a17 >= 116) then
        end
        a4 = w55
        a11 = a4
        a11()
        a6 = a2
        a11 = a4
        a12 = a5
        a6 = 1
        a5 = (a5 + a6)
        a13 = a4
        w58 = a5
        a5 = a3
        a11 = 121
    end
    w84 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, ...) -- F104
        local L287
        a4 = w1[5]
        a5 = w1[5]
        a6 = w1[5]
        a7 = 17
        a8 = 68
        a9 = 3
        a6 = a2
        a11 = a4
        a12 = a5
        a13 = a6
        a11 = a11(a12, a13)
        a4 = a11
        a9 = 76
        a5 = w61
        a8 = a4
        if not ((a10 ~= 17)) then
            a4 = w80
        end
        a5 = a1
        a4 = (not a4)
        if (not a4) then
            a4 = a3
        else
            a4 = w55
            a7 = a4
            a7()
        end
        a5 = w58
        a9 = 37
        a5 = (a5 == a6)
        a13 = 0
        a14 = 92
        a15 = 46
        a5 = (a5 == a6)
        repeat
        until not ((59 >= a9))
        a6 = w66
        a9 = 59
        a9 = 64
        a6 = 1
        a5 = (a5 + a6)
        -- (junk closure op at instr 115: child proto not statically decoded)
        w58 = a5
        repeat
        until not ((not a4))
        a7 = 111
        a8 = 197
        a9 = 86
        a5 = a2
        a4 = a5
        a7 = w58
        if not ((a10 >= 197)) then
            a4 = 0
            a5 = a3
        end
        a9 = 94
        a10 = a5
        a11 = a6
        a12 = a7
        a13 = a8
        a10(a11, a12, a13, a14)
        a6 = 2
        a5 = a1
        a4 = a5
        a7 = nil
        a8 = w1[5]
        a9 = 115
        a10 = 219
        a11 = 52
        a6 = 1
    end
    w85 = w1[5]
    w86 = w1[5]
    a87 = w1[5]
    w88 = w1[5]
    a127 = "IsServer"
    w125(a126, a127)
    w10 = 2
    if not ((a123 ~= 16)) then
    end
    w124 = w36
    w125 = a119
    a126 = w1[5]
    w124(w125, a126)
    w10 = 11
    repeat
    until not ((w10 > 59))
    a106 = w97
    w107 = w39
    w108 = "yield"
    a106(w107, w108)
    a106 = w97
    w107 = a41
    w108 = "close"
    a106 = "wait"
    a105 = w4[a106]
    w10 = 37
    w121 = w84
    a122 = a119[48]
    a123 = L7
    a123 = a123()
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = a119[3]
    w101[49] = w51
    w120 = 20
    w125 = a119[61]
    w101[74] = a115
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = a119[61]
    a122 = 62
    a132 = a119
    a133 = "X"
    w10 = 112
    w37 = w1[5]
    a38 = w1[5]
    w39 = w1[5]
    w40 = w1[5]
    w10 = 31
    if not ((217 >= a123)) then
        w125 = a119; w124 = a119["GetChildren"]
        w124, w125, a126, a127 = w124(w125, a126)
        -- generic-for iterator (coroutine desugar) reg R124
        repeat
        until not ((w120 > 50))
    end
    w124 = a117
    w125 = "Folder"
    w124 = w124(w125)
    a119 = w124
    a123 = a119
    w124 = 962686649
    a123 = a123(w124)
    w121 = a123
    a122 = 99
    a133 = 0
    a68 = "tostring"
    w65 = w20[a68]
    w10 = 64
    a137 = a119
    a138 = "X"
    a138 = a132[a138]
    a127 = w97
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = a119[36]
    a131 = a57
    a131 = a131()
    a132, a133 = nil
    -- generic-for iterator (coroutine desugar) reg R131
    w124 = w118
    w125 = a119
    a126 = "Folder"
    w124(w125, a126)
    a123 = w84
    w125 = w121; w124 = w121["NextNumber"]
    w124 = w124(w125)
    w125 = 0.490891385082238
    a126 = true
    a123(w124, w125, a126, a127)
    a122 = 13
    w108 = w97
    a109 = a94
    w110 = "unpack"
    w108(a109, w110)
    w10 = 57
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[26]
    w124 = 1
    w121(a122, a123, w124, w125)
    w10 = 47
    w10 = 75
    a130 = a130[a131]
    a130 = (a130 * 100)
    a130 = (a130 // 1)
    w101[91] = w80
    a122 = 123
    w125 = w97
    a126 = "IsServer"
    a126 = a119[a126]
    while true do
        w121 = "The metatable is locked"
        a122 = w48
        a123 = a119
    end
    w120 = w83
    a132 = 124
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[54]
    w124 = 1
    w121(a122, a123, w124, w125)
    w120 = 16
    a53 = "traceback"
    a53 = a49[a53]
    w54 = w1[5]
    a103 = w97
    a104 = w12
    a105 = "match"
    a103(a104, a105)
    while true do
        a133 = true
        a130(a131, a132, a133, a134)
        w125 = 42
    end
    w125(a126, a127, a128, a129)
    a132 = a129
    if (w120 ~= 29) then
    else
        w120 = 88
        w121 = a119[54]
        w101[46] = w75
    end
    w111(w112)
    w10 = 72
    a123 = w83
    w125 = w121; w124 = w121["NextInteger"]
    a126 = 748
    if not ((a122 ~= 64)) then
        a123 = a117
        w124 = "Frame"
        a123 = a123(w124)
        w121 = a123
        a123 = a114
        w124 = 0
    end
    a122 = 101
    a130 = a129[0]
    a131 = "Scale"
    a130 = a130[a131]
    while true do
        a139 = 0
        a140 = 7
        a136 = a136(a137, a138, a139, a140)
        a137 = a114
        a138 = 0
    end
    a138 = -8
    w125 = w97
    a126 = "FromName"
    a126 = a123[a126]
    a127 = "FromName"
    w125(a126, a127)
    w124 = 80
    a136 = a114
    a137 = 0
    a138 = 4
    a139 = 0
    w20 = buffer
    w10 = 13
    a123 = nil
    w124 = w1[5]
    w125 = nil
    a126 = w1[5]
    w10 = 39
    a123 = a123()
    w124 = 1
    w121(a122, a123, w124, w125)
    w121 = a119[30]
    a127 = w84
    a128 = 0.09719103083780782
    a130 = w121; a129 = w121["NextNumber"]
    a129 = a129(a130)
    a130 = true
    a127(a128, a129, a130, a131)
    a127 = w83
    a129 = w121; a128 = w121["NextInteger"]
    a130 = 587
    a131 = 618
    a128 = a128(a129, a130, a131)
    w121 = a119[13]
    w101[27] = a76
    w120 = 67
    if (a132 ~= 66) then
        a133 = a119
        a134 = "X"
        a134 = a127[a134]
        a135 = true
        a133(a134, a135)
    end
    w121 = w84
    a122 = a119[55]
    a123 = L7
    a102 = w97
    a103 = w45
    a104 = "pcall"
    a102(a103, a104)
    w10 = 101
    a127 = w55
    a127()
    w120 = 95
    w121 = w84
    a122 = a119[13]
    a123 = L7
    a127 = a123; a126 = a123["GetPositionOnCurve"]
    a128 = 0.46666666865348816
    a126 = a126(a127, a128)
    w125 = a126
    a131[2950335024] = w309
    a131[945981900] = w223
    a131[2716838150] = w296
    a131[2691622896] = a133
        -- (constant test eliminated: if (w10 ~= 78) then)
    w111 = a35
    w112 = a32
    a113 = w110
    w112 = w112(a113)
    a113 = 1
    w111(w112, a113)
    w111 = a76
    w112 = w93
    w111(w112)
    w125 = w84
    a126 = w118[2]
    a127 = L7
    a127 = a127()
    a128 = 2
    w125(a126, a127, a128, a129)
        -- (constant test eliminated: if (w10 >= 85) then)
    w124 = L10
    w124()
    w121 = 16
    a122 = 95
    a123 = 15
    w125 = w84
    a126 = a119[21]
    a127 = L7
    a127 = a127()
    a128 = 1
    w125(a126, a127, a128, a129)
    w124 = true
    w121(a122, a123, w124, w125)
    w121 = w97
    a122 = "IsA"
    a122 = w120[a122]
    a123 = "IsA"
    w121(a122, a123)
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = a119[10]
    a128 = 1
    w125(a126, a127, a128, a129)
    a128 = 1
    w125(a126, a127, a128, a129)
    w125(a126, a127, a128, a129)
        -- (constant test eliminated: if not ((90 >= w120)) then)
            -- (constant test eliminated: if not ((w120 >= 109)) then)
            w120 = 39
            w121 = w84
            a122 = a119[2]
            a123 = L7
    w10 = 122
    while true do -- (empty spin loop: unrestructured dispatcher exit)
    end
    a123 = w112
    w124 = w24
    w125 = w1[5]
    a123(w124, w125)
    a122 = 64
    a123 = a117
    w124 = "ScreenGui"
    a123 = a123(w124)
    w120 = a123
    w120 = 31
    w82 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, ...) -- F283
        local L217, L419
        a3 = w1[5]
        a4 = w1[5]
        a5 = 118
        a6 = 180
        a7 = 62
        do -- (terminates control flow)
            a3 = a5
            a3 = (not a3)
            a5 = a3
            do return a5 end
        end
        a3 = w80
        while true do
            a5 = a3
            a6 = a4
            a7 = a2
            a5 = a5(a6, a7)
        end
        L419 = L217[0]
        a4 = a1
    end
    w111 = w1[5]
    w112 = 33
    a113 = 156
    a114 = 123
    while true do
        w124()
    end
    a119 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, ...) -- F473
        local L112, L417, L469
        a1 = w77
        a2 = w66
        a3 = w58
        a1, a2, a3 = a1(a2, a3, a4)
        a3 = UPVALS[a3]
        a4 = 8
        a3 = a3(a4)
        a4 = w64
        a5 = a3
        a6 = 0
        a7 = a1
        a4(a5, a6, a7, a8)
        a4 = 104
        while true do
            a5 = w64
            a6 = a3
            a7 = 4
            a8 = a2
            a5(a6, a7, a8, a9)
            a4 = 39
        end
        while true do
            -- table.move range
            do return a5 end
        end
        a6(a7, a8, a9, a10)
            -- (constant test eliminated: if (104 > a4) then)
            a5 = {}
            a6 = UPVALS[a5]
            a7 = w65
            a8 = a3
            a7 = a7(a8)
            a8 = 1
            a9 = -1
    end
    a119 = a119()
    w120 = w1[5]
    w121 = w1[5]
    a122 = nil
    w10 = 57
    w124 = L7
    w125 = 0
    w10 = 126
    a114 = UDim2.new
    w10 = 100
    a113 = game
    w10 = 48
    w101 = w97
    a102 = w28
    a103 = "select"
    w101(a102, a103)
    w10 = 108
        -- (constant test eliminated: if not ((91 >= w10)) then)
        w101 = w97
        a102 = w15
        a103 = "xpcall"
        w101(a102, a103)
        w10 = 91
    w90 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, ...) -- F609
        local L471, L503
        a2 = w1[5]
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
        do -- (terminates control flow)
            a4 = bit32.bxor(a2, 320281964)
            do return a4 end
        end
        a8 = 1
        a9 = (#a3)
        a10 = 1
            -- (constant test eliminated: if (a26 ~= 53) then)
        a17 = (a2 * 16777619)
        a2 = (a17 % 4294967296)
        a9(a10, a11, a12, a13)
        -- table.move range
        a3 = a8
        a10 = a1
        a11 = 1
        a12 = -1
        a22 = w1[5]
        a23 = 7
        a24 = 174
        a25 = 46
        a18 = (a2 % 65536)
        a2 = 2166136261
        a8 = {}
        a9 = w17
        repeat
        until not ((a16 > 94))
        a12 = a3[a11]
        a2 = bit32.bxor(a2, a12)
        a18 = w1[5]
        a19 = w1[5]
        a20 = w1[5]
        a21 = w1[5]
        a12 = w1[5]
        a13 = 94
        a14 = 266
        a15 = 55
        a27 = (a2 - a18)
        a19 = (a27 / 65536)
        a20 = (a18 * 403)
        a21 = 256
    end
    a91 = w1[5]
    w92 = w1[5]
    w93 = w1[5]
    w10 = 82
    a130 = "X"
    a130 = a129[a130]
    a131 = "Scale"
    w26 = "rep"
    w26 = w5[w26]
    w27 = {}
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = w118[16]
    a128 = 2
    w121 = 21
    a122 = 556
    a123 = 107
    while true do
        a126 = a119
        a127 = w124
        a128 = true
    end
    a122 = 111
    w121 = w83
    a122 = "The metatable is locked"
    a123 = w48
    w124 = w120
    a123 = a123(w124)
    w121 = a119[23]
    w101[53] = a35
    w120 = 80
    a103 = w97
    a104 = w17
    a105 = "byte"
    a132 = (w121 + a126)
    a130 = a130(a131, a132)
    a127 = a130
    a130 = (a126 % 8)
    a130 = (a130 + 1)
    a128 = a119[a130]
    a130 = w61
    a131 = a122
    a132 = (w121 + a126)
    a133 = bit32.bxor(a127, a128)
    a130(a131, a132, a133, a134)
    a49 = w2
    w50 = debug
    w51 = "The debug library is required on Luau platforms. Please open a support ticket."
    a49 = a49(w50, w51)
    w50 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, ...) -- F498
        local L23, L181
        a2 = w1[5]
        a3 = w1[5]
        a4 = 102
        a3 = a1
        do -- (terminates control flow)
            do return  end
        end
        while true do
            a5 = 103
            a6 = 257
            a7 = 69
            if not ((103 >= a8)) then
                if not ((a8 ~= 172)) then
                    a2 = (not a2)
                end
                a9 = a2
                do return a9 end
            end
        end
        a3 = (not a3)
        a2 = w27
        a4 = 13
        a2 = a2[a3]
    end
    w51 = w1[5]
    w52 = w1[5]
    a128 = "Parent"
    w121[a128] = w120
    if (a126 > 163) then
    end
    w121 = a119[55]
    w101[21] = a49
    w120 = 98
    a129 = w121[a129]
    a127(a128, a129)
        -- (constant test eliminated: if (w120 >= 56) then)
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = w118[17]
    w124 = 2
    w121(a122, a123, w124, w125)
    w121 = w118[16]
    w101[5] = w3
    a117 = a117(w118, a119)
    w116 = w116(a117)
    w15 = w1[11]
    w10 = 11
    a131 = a132
    w121 = w84
    a122 = L7
    a122 = a122()
    a123 = a119[50]
    w124 = 1
    a138 = a123; a137 = a123["GetTangentOnCurveArcLength"]
    a139 = 0.75
    a137 = a137(a138, a139)
    a76 = function(a1, a2, a3, a4, a5, a6, ...) -- F303
        local L480
        a2 = w61
        a3 = w66
        a4 = w58
        a5 = (a1 % 256)
        a2(a3, a4, a5, a6)
        a2 = w58
        a2 = (a2 + 1)
        w58 = a2
        do return  end
    end
    w10 = 0
    a127 = w1[5]
    a128 = w1[5]
    a129 = 1
    a68 = "writeu8"
    w61 = w20[a68]
    w10 = 76
    -- (junk op: register-file store with a decoded-at-runtime index)
    a69 = Vector3
    w10 = 88
    a115 = w37
    a114(a115)
    a114 = w112
    a115 = a42
    a128 = L7
    a128()
    a119 = 78
    a129 = 108
    a130 = w46
    a131 = a122
    a53 = "info"
    w51 = a49[a53]
    w10 = 15
    a119 = w1[111]
    -- generic-for iterator (coroutine desugar) reg R124
    w124, w125, a126 = coroutine.resume(w124, w125, a126)
    if w124 then
        a126 = w55
        a126()
    end
    a131 = {}
    a131[4049439760] = w121
    a131[124078634] = L588
    a131[1259237318] = L728
    a131[2423708338] = L376
    a131[2855685826] = L716
    a131[301381932] = L433
    a130 = a119
    a131 = "X"
    a131 = a129[a131]
    a132 = "Scale"
    a131 = a131[a132]
    a132 = true
    a130(a131, a132)
    a122 = 30
    w111 = a76
    w112 = (w93 % 65536)
    w112 = (w93 - w112)
    w112 = (w112 / 65536)
    a130 = w13
    a131 = a128
    a130 = a130(a131)
    a131 = "function"
    a123 = w84
    w124 = 0.2258909312414879
    a126 = w121; w125 = w121["NextNumber"]
    w125 = w125(a126)
    a126 = true
    a123(w124, w125, a126, a127)
    w101[88] = L460
    a133 = a119
    a134 = "Y"
    a134 = a127[a134]
    a135 = true
    a133(a134, a135)
    a134 = a123; a133 = a123["GetTangentOnCurve"]
    w125 = a119[16]
    w101[79] = w25
    w125 = w83
    a126 = L7
    a126 = a126()
    a127 = a119[16]
    a128 = 2
    w121 = w118[1]
    w101[12] = w121
    w120 = 11
    a129 = w121
    a127 = a127(a128, a129)
    a128 = true
    a123 = a123(w124)
    w121 = a123
    w33 = "cancel"
    w30 = w4[w33]
    w33 = "unpack"
    a31 = w5[w33]
    w121 = w83
    a122 = L7
    a122 = a122()
    w125 = a119[44]
    w101[75] = L521
    a106(w107, w108)
    w10 = 59
    a134 = a129[3]
    a132[0] = a122
    a134 = w36
    a135 = a130
    a136 = a126
    a134(a135, a136)
    a133 = 16
    repeat
    until not ((77 >= w10))
    a122 = 26
    w48 = w1[43]
    w125 = w84
    a126 = w118[6]
    a127 = L7
    a127 = a127()
    a128 = 2
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = v3
    a127 = a127()
    a123 = a127
    w124 = 97
    w10 = 90
    w121 = a119[a119]
    w101[58] = w61
    w120 = 104
    a130 = a119
    a131 = a129[0]
    a132 = "Scale"
    a137 = (a137 // 1)
    w101[97] = a123
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = a119[1]
    w80 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, ...) -- F452
        a3 = w1[5]
        a4 = nil
        a5 = 66
        a6 = 294
        a7 = 57
        a9 = w1[5]
        a10 = 37
        a3 = (a4 == a9)
        a4 = a1
        a7 = false
        a6 = 80
        a6 = 111
        a3[a4] = a5
        a3[a4] = a5
            -- (constant test eliminated: if not ((a11 >= 343)) then)
        a4 = a2
        a10 = w1[5]
        a3 = (a4 == a10)
        a9 = 83
            -- (constant test eliminated: if not ((66 >= a9)) then)
                -- (constant test eliminated: if not ((68 >= a9)) then)
                a10 = 103
                    -- (constant test eliminated: if not ((a10 == 26)) then)
                    a10 = 26
                    a3 = true
                a11 = a3
                do return a11 end
        a9 = 68
        a4 = a2
        a3 = a7
        a3 = w75
        a6 = 2
        a4 = a2
        a3 = a3[a4]
        a10 = a3
        a11 = a4
        a10 = a10(a11)
        repeat
        until not ((a8 >= 180))
        a4 = a1
        a9 = a3
        a10 = a4
        a9 = a9(a10)
        a3 = a9
        a9 = 57
        a3 = w50
        a3 = UPVALS[a2]
        a3 = w75
            -- (constant test eliminated: if (22 >= a6) then)
            a6 = 125
            a5 = true
            if (a8 >= 237) then
                a3 = w50
                a4 = a1
            else
            end
        a5 = w1[5]
        a6 = 22
        a9 = 66
        while true do -- (empty spin loop: unrestructured dispatcher exit)
        end
        a3 = a10
        do -- (terminates control flow)
            a8 = a3
            do return a8 end
        end
        do -- (terminates control flow)
            a3 = false
            a10 = a3
            do return a10 end
        end
        if not ((a10 >= 64)) then
            a4 = a1
            a9 = w1[5]
            a10 = 64
        end
    end
    a81 = w1[5]
    w82 = w1[5]
    w10 = 92
    w25 = Instance
    w125 = w84
    a126 = L7
    a126 = a126()
    a127 = w118[15]
    a128 = 2
    w125(a126, a127, a128, a129)
    w125 = w118[17]
    w101[4] = w107
    a129 = w37
    a130 = 481249152
    a129 = a129(a130)
    w124 = a129
    w121 = a119
    a123 = (a119 / 2)
    w124 = (a119 / 4)
    w125 = a119[52]
    w101[20] = w29
    a114 = w112
    a115 = w36
    a114(a115)
    a114 = w112
    a115 = a70
    a114(a115)
    a114 = w112
    a106 = w97
    w107 = a38
    w108 = "status"
    a127 = w83
    a128 = a113
    a129 = "Parent"
    a133 = (w124 * a127)
    a133 = (a133 + w92)
    a127 = (a133 % 256)
    while true do
        -- (junk op: register-file store with a decoded-at-runtime index)
        a127 = a119[49]
    end
    w125 = w118[13]
    w101[10] = a31
    a126 = L7
    a139 = 1
    a140 = 0
    a141 = -8
    a134 = a134(a135, a136, a137(a138, a139, a140, a141, a142))
    a135 = w24
    w107 = nil
    w10 = 113
    w121 = w83
    a122 = L7
    a122 = a122()
    a123 = a119[43]
    w124 = 1
    w121(a122, a123, w124, w125)
    w120 = 109
    a57 = "wrap"
    a56 = w6[a57]
    a57 = getfenv
    w58 = 0
    a59 = w1[5]
    w60 = w1[5]
    w61 = w1[5]
    a62 = w1[5]
    w63 = nil
    w64 = w1[5]
    w65 = nil
    w66 = w1[5]
    a67 = w1[5]
    w124 = w124(w125, a126, a127)
    w125 = 526
    a126 = true
    a123(w124, w125, a126, a127)
    a122 = 76
    a126 = 296
    a127 = 1020
    w124 = w124(w125, a126, a127)
    w125 = 692
    a128 = (a128 * 100)
    a128 = (a128 // 1)
    w101[86] = w90
    a128 = w121; a127 = w121["GetChildren"]
    a127, a128, a129, a130 = a127(a128, a129)
    -- generic-for iterator (coroutine desugar) reg R127
    do -- (terminates control flow)
        a127 = function(a1, a2, q3, q4, q5, q6, a7, a8, a9, ...) -- F508
            local q14, L16, L38, L73, L91, L411, L456, L511
            a1 = {}
            a2 = 46
            q3 = 62
            q4 = 8
            a2 = 7
            if not ((a2 ~= 58)) then
                a2 = 81
                q3 = function(a1, a2, a3, a4, a5, a6, a7, ...) -- F514
                    local L280
                    a4 = w1[176]
                    a5 = w101[44]
                    a6 = w101[93]
                    a4 = a4(a5, a6)
                    a5 = w101[89]
                    a4 = (a4 < a5)
                    if not ((not a4)) then
                        a4 = w101[46]
                    end
                    a4 = w101[31]
                    repeat
                    until not (a4)
                    do -- (terminates control flow)
                        do return a4 end
                    end
                end
                a1[8] = L91
            end
            a2 = 58
            q3 = function(a1, a2, a3, a4, a5, a6, a7, ...) -- F574
                local L77, L288, L289
                do -- (terminates control flow)
                    a3 = (-4294903594 + a3)
                    do return a3 end
                end
                while true do
                    a3 = w1[177]
                    a4 = w101[1]
                    a5 = w101[34]
                    a4 = (a4 - a5)
                    a5 = w101[86]
                    a3 = a3(a4, a5)
                end
            end
            a1[7] = L38
            L511 = (L456 < L411)
            q6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...) -- F524
                a5 = w101[16]
                a6 = w101[1]
                a5 = (a5 - a6)
                a6 = w101[43]
                a5 = (a5 - a6)
                a5 = (135 + a5)
                do return a5 end
            end
            a1[3] = q14
            q6 = function(a1, a2, a3, a4, a5, a6, ...) -- F534
                a3 = w101[74]
                a4 = w101[12]
                a3 = (a3 + a4)
                a4 = w101[10]
                a3 = (a3 == a4)
                a3 = w101[22]
                a3 = (31 + a3)
                do return a3 end
                a3 = w101[3]
            end
            a1[4] = q6
            q6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...) -- F544
                a5 = w101[74]
                a6 = w101[78]
                a5 = (a5 - a6)
                while true do
                    a5 = (a5 - a6)
                    a5 = (465 + a5)
                    do return a5 end
                end
                a6 = w101[12]
            end
            a1[5] = q3
            while true do
                do return q3 end
            end
            q3 = a1
            q6 = function(a1, a2, a3, a4, a5, a6, a7, a8, ...) -- F554
                local L54, L458
                a5 = w101[12]
                a6 = w101[80]
                a5 = (a5 + a6)
                a6 = w101[10]
                a5 = (a5 < a6)
                a5 = w101[31]
                if not (a5) then
                    a5 = w101[37]
                end
                a5 = (-137 + a5)
                do return a5 end
            end
            a1[2] = q6
            a2 = 39
            q3 = 113
            q4 = 74
            while true do
                if not ((q5 ~= 54)) then
                    q6 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, ...) -- F564
                        a5 = w1[168]
                        a6 = w1[175]
                        a7 = w101[74]
                        a8 = w101[91]
                        a6 = a6(a7, a8)
                        a5 = a5(a6)
                        a5 = (169 + a5)
                        do return a5 end
                    end
                    a1[6] = L73
                end
            end
            q6 = function(a1, a2, a3, a4, a5, a6, ...) -- F584
                local L457
                a3 = w101[89]
                a4 = w101[55]
                a3 = (a3 - a4)
                a4 = w101[75]
                a3 = (a3 <= a4)
                if not ((not a3)) then
                    a3 = w101[71]
                end
                if a3 then
                    a3 = (-86 + a3)
                    do return a3 end
                end
                a3 = w101[80]
            end
            a1[1] = L16
        end
        a127 = a127()
        a127 = a123
        do return a127 end
    end
    a114 = w112
    a115 = w12
    a114(a115)
    w10 = 111
    w79 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, ...) -- F599
        local L254, L255, L256
        a3 = w1[5]
        a4 = w1[5]
        a5 = 65
        while true do
            a6 = a3
            a7 = a4
            a6 = a6(a7)
            a10 = 0
            a11 = w58
            a4 = w66
            a12 = 89
            a13 = 350
            a14 = 69
            while true do -- (empty spin loop: unrestructured dispatcher exit)
            end
        end
        a3 = (a3 + a4)
        w58 = a3
        do return  end
        a3 = UPVALS[a2]
        a5 = 44
        a4 = 1
        a3 = a2
            -- (constant test eliminated: if not ((a15 >= 227)) then)
            a3 = w58
            -- (constant test eliminated: if not ((a15 >= 296)) then)
        if (not a3) then
        end
        a16(a17, a18, a19, a20)
        a6 = 87
        a16 = a3
        a17 = a4
        a18 = a11
        a19 = a10
        a3 = w61
            -- (constant test eliminated: if (a14 ~= 109) then)
        a3 = a6
        a10 = w1[5]
        a11 = 40
        a12 = 142
        a13 = 69
        a5 = 27
        a4 = a1
    end
    a137 = "X"
    a137 = a132[a137]
    a137 = (a137 * 100)
    a122 = 44
    a133 = a123; a132 = a123["GetTangentOnCurveArcLength"]
    a134 = 0.46666666865348816
    a132 = a132(a133, a134)
    w124 = w124(w125)
    w125 = "Random"
    a126 = true
    a123(w124, w125, a126, a127)
    a123 = w97
    w10 = 68
    w124 = 450
    w125 = 57
    w125 = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, ...) -- F619
        local L0
        a2 = a1[1]
        a3 = a1[2]
        if (a3 ~= "boolean") then
            if not ((a3 ~= "string")) then
                a4 = w17
                a5 = a2
                a6 = 1
                a7 = 1
                a4 = a4(a5, a6, a7)
                a4 = (a4 ~= 0)
                a5 = w17
                a6 = a2
                a7 = 2
                a8 = 2
                a5 = a5(a6, a7, a8)
                a6 = w124
                a6 = (a6 * a5)
                a7 = w92
                a6 = (a6 + a7)
                a5 = (a6 % 256)
            end
            a2 = (-a2)
            a4 = 3
            a5 = (#a1)
            a6 = 3
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
        a8 = (#a7)
        a2 = a7[1]
        a8 = a1[a7]
        a9 = (a7 + 1)
        a9 = a1[a9]
        a10 = (a7 + 2)
        a10 = a1[a10]
        a11 = a8[a10]
        a11[a9] = a2
        a11 = w116[a10]
        a11 = a8[a11]
        a11[a9] = L0
        do -- (terminates control flow)
            a7 = {}
            a8 = 3
            a9 = (#a2)
            a10 = 1
            while true do
                a10 = 1
                a11 = (a8 - 1)
            end
            do return  end
        end
        a12 = w17
        a13 = a2
        a14 = a11
        a12 = a12(a13, a14)
        a12 = bit32.bxor(a12, a5)
        a12 = w100[a12]
        a7 = (a7 .. a12)
        a12 = w124
        a12 = (a12 * a5)
        a13 = w92
        a12 = (a12 + a13)
        a5 = (a12 % 256)
        a2 = a7
        a5 = w21
        a6 = a2
        a7 = 2
        a5 = a5(a6, a7)
        a2 = a5
        while true do
            a7[a9] = a12
            a9 = (a9 + 1)
            a10 = (a10 + 2)
        end
        a12 = (a11 - 2)
        a13 = w17
        a14 = a2
        a15 = a11
        a13 = a13(a14, a15)
        a13 = bit32.bxor(a13, a5)
        a13 = w100[a13]
        a7[a12] = a13
        a12 = w124
        a12 = (a12 * a5)
        a13 = w92
        a12 = (a12 + a13)
        a5 = (a12 % 256)
        a12 = (a12 .. a13)
        a9 = 1
        a6 = (#a2)
        if not ((600 > a6)) then
            a2 = (not a2)
        end
        a7 = ""
        a8 = 3
        a9 = a6
        a10 = 1
    end
    w10 = 46
    w37 = w1[34]
    a41 = "status"
    a38 = w6[a41]
    w10 = 41
    a131 = w55
    a131()
    w116 = w112
    a117 = w16
    w118 = w1[5]
    w116(a117, w118)
end
while true do -- (empty spin loop: unrestructured dispatcher exit)
end
