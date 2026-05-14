-- Generated using PenguEnv ( Me Pro) https://discord.gg/uWCzJDPmgK

-- Renamed | Vars: 231 | Funcs: 37
-- 2026-02-21 09:25

-- this file is generated using PenguEnv V0.63
local var_Temp_00 = debug
local var_HTTP_262 = debug.sethook
local var_HTTP_013 = debug.getinfo
local var_HTTP_060 = debug.traceback
local var_Data_859 = load
local var_Data_385 = loadstring or load
local var_Data_766 = pcall
local var_Temp_07 = xpcall
local var_Iterator_08 = error
local var_HTTP_095 = type
local var_HTTP_344 = getmetatable
local var_HTTP_001 = rawequal
local var_Event_192 = tostring
local var_Event_793 = tonumber
local var_Event_379 = io
local var_Temp_15 = os
local PenguEnv = {}
PenguEnv.__index = PenguEnv
local var_Temp_17 = {
MAX_DEPTH = 15,
MAX_TABLE_ITEMS = 150,
OUTPUT_FILE = \\"PenguEnv_V0.63_Dump.lua\\",
VERBOSE = false,
TRACE_CALLBACKS = true,
TIMEOUT_SECONDS = 13,
MAX_REPEATED_LINES = 6,
MIN_DEOBF_LENGTH = 150,
MAX_OUTPUT_SIZE = 6 * 1024 * 1024,
CONSTANT_COLLECTION = true,
INSTRUMENT_LOGIC = true
}
local var_Temp_18 = arg and arg[3]
if var_Temp_18 then
    print(\\"[PenguEnv V0.63] Auto-Input Key Detected: \\" .. tostring(var_Temp_18))
end
print(\\"[PenguEnv V0.63] Discord: https://dsc.gg/pngenv\\")
local var_HTTP_773 = {
output = {},
indent = 0,
registry = {},
reverse_registry = {},
names_used = {},
parent_map = {},
property_store = {},
call_graph = {},
variable_types = {},
string_refs = {},
proxy_id = 0,
callback_depth = 0,
pending_iterator = false,
last_http_url = nil,
last_emitted_line = nil,
repetition_count = 0,
current_size = 0,
pen_counter = 0
}
local var_Temp_18 = arg[3] or \\"NoKey\\"
local var_Event_411 = tonumber(arg[4]) or tonumber(arg[3]) or 123456789
local var_Event_124 = {}
local function fn_Event_591(var_Event_148)
    if var_HTTP_095(var_Event_148) ~= \\"table\\" then
        return false
    end
    local y, var_Temp_25 =
    pcall(
    function()
        return rawget(var_Event_148, var_Event_124) == true
    end
    )
    return y and var_Temp_25
end
local function fn_Event_702(var_Event_148)
    if var_HTTP_095(var_Event_148) == \\"number\\" then
        return var_Event_148
    end
    if fn_Event_591(var_Event_148) then
        return rawget(var_Event_148, \\"__value\\") or 0
    end
    return 0
end
local var_Data_859 = loadstring or load
local var_Data_652 = print
local var_Event_236 = warn or function()
end
local var_NPC_621 = pairs
local var_NPC_677 = ipairs
local var_HTTP_095 = type
local var_Event_192 = tostring
local var_Event_539 = {}
local function fn_Event_359(var_Event_148)
    if var_HTTP_095(var_Event_148) ~= \\"table\\" then
        return false
    end
    local y, var_Temp_25 =
    pcall(
    function()
        return rawget(var_Event_148, var_Event_539) == true
    end
    )
    return y and var_Temp_25
end
local function fn_Event_290(var_Event_148)
    if not fn_Event_359(var_Event_148) then
        return nil
    end
    return rawget(var_Event_148, \\"__proxy_id\\")
end
local function fn_HTTP_705(var_Event_790)
    if var_HTTP_095(var_Event_790) ~= \\"string\\" then
        return '\\"'
    end
    local var_Unknown_8290 = {}
    local var_Unknown_8967, M = 1, #var_Event_790
    local function fn_Event_915(var_Event_394)
        return var_Event_394:gsub(
        \\"\\\\\\\\(.)\\",
        function(P)
            if P:match('[abfnrtv\\\\\\\\%\'%\\\\\\"%[%]0-9xu]') then
                return \\"\\" .. P
            end
            return P
        end
        )
    end
    local function fn_Event_484(var_Event_838)
        if not var_Event_838 or var_Event_838 == '\\"' then
            return \\"\\"
        end
        var_Event_838 =
        var_Event_838:gsub(
        \\"0[var_String_133]([01_]+)\\",
        function(S)
            local var_Event_963 = S:gsub(\\"var_Private_589\\", \\"\\")
            local var_String_646 = var_Event_793(var_Event_963, 2)
            return var_String_646 and var_Event_192(var_String_646) or \\"0\\"
        end
        )
        var_Event_838 =
        var_Event_838:gsub(
        \\"0[xX]([%x_]+)\\",
        function(S)
            local var_Event_963 = S:gsub(\\"var_Private_589\\", '\\"')
            return \\"0x\\" .. var_Event_963
        end
        )
        while var_Event_838:match(\\"%var_Event_917+%var_HTTP_060\\") do
            var_Event_838 = var_Event_838:gsub(\\"(%var_HTTP_060)var_Private_589+(%var_HTTP_060)\\", \\"%1%2\\")
        end
        local var_NPC_234 = {{\\"+=\\", \\"+\\"}, {\\"-=\\", \\"-\\"}, {\\"*=\\", \\"*\\"}, {\\"/=\\", \\"/\\"}, {\\"%%=\\", \\"%%\\"}, {\\"%^=\\", \\"^\\"}, {\\"%.%.=\\", \\"..\\"}}
        for W, var_Event_385 in ipairs(var_NPC_234) do
            local Y, var_Event_877 = var_Event_385[1], var_Event_385[2]
            var_Event_838 =
            var_Event_838:gsub(
            \\"([%var_Event_349][%w_]*)%var_Temp_18*\\" .. Y,
            function(var_Private_589)
                return var_Private_589 .. \\" = \\" .. var_Private_589 .. \\" \\" .. var_Event_877 .. \\" \\"
            end
            )
            var_Event_838 =
            var_Event_838:gsub(
            \\"([%var_Event_349][%w_]*%.[%var_Event_349][%w_%.]+)%var_Temp_18*\\" .. Y,
            function(var_Private_589)
                return var_Private_589 .. \\" = \\" .. var_Private_589 .. \\" \\" .. var_Event_877 .. \\" \\"
            end
            )
            var_Event_838 =
            var_Event_838:gsub(
            \\"([%var_Event_349][%w_]*%var_HTTP_262[])%var_Temp_18*\\" .. Y,
            function(var_Private_589)
                return var_Private_589 .. \\" = \\" .. var_Private_589 .. \\" \\" .. var_Event_877 .. \\" \\"
            end
            )
        end
        var_Event_838 = var_Event_838:gsub(\\"([^%w_])continue([^%w_])\\", \\"%1_G.PenguEnvContinue()%2\\")
        var_Event_838 = var_Event_838:gsub(\\"^continue([^%w_])\\", \\"_G.PenguEnvContinue()%1\\")
        var_Event_838 = var_Event_838:gsub(\\"([^%w_])continue$\\", \\"%1_G.PenguEnvContinue()\\")
        return var_Event_838
    end
    local function fn_Event_442(var_Event_009)
        local var_Event_252 = 0
        while var_Event_009 <= M and var_Event_790:byte(var_Event_009) == 61 do
            var_Event_252 = var_Event_252 + 1
            var_Event_009 = var_Event_009 + 1
        end
        return var_Event_252, var_Event_009
    end
    local function fn_Event_604(var_Event_711, var_Event_450)
        local var_Event_170 = \\"]\\" .. string.rep(\\"=\\", var_Event_450) .. \\"]\\"
        local a7, a8 = var_Event_790:find(var_Event_170, var_Event_711, true)
        return a8 or M
    end
    local var_Unknown_8544 = 1
    while var_Unknown_8967 <= M do
        local var_Unknown_4594 = var_Event_790:byte(var_Unknown_8967)
        if var_Unknown_4594 == 91 then
            local var_Event_450, ab = fn_Event_442(var_Unknown_8967 + 1)
            if ab <= M and var_Event_790:byte(ab) == 91 then
                table.insert(var_Unknown_8290, fn_Event_484(var_Event_790:sub(var_Unknown_8544, var_Unknown_8967 - 1)))
                local var_String_631 = var_Unknown_8967
                local var_String_771 = fn_Event_604(ab + 1, var_Event_450)
                table.insert(var_Unknown_8290, var_Event_790:sub(var_String_631, var_String_771))
                var_Unknown_8967 = var_String_771
                var_Unknown_8544 = var_Unknown_8967 + 1
            end
        elseif var_Unknown_4594 == 45 and var_Unknown_8967 + 1 <= M and var_Event_790:byte(var_Unknown_8967 + 1) == 45 then
            table.insert(var_Unknown_8290, fn_Event_484(var_Event_790:sub(var_Unknown_8544, var_Unknown_8967 - 1)))
            local var_String_362 = var_Unknown_8967
            if var_Unknown_8967 + 2 <= M and var_Event_790:byte(var_Unknown_8967 + 2) == 91 then
                local var_Event_450, ab = fn_Event_442(var_Unknown_8967 + 3)
                if ab <= M and var_Event_790:byte(ab) == 91 then
                    local var_String_771 = fn_Event_604(ab + 1, var_Event_450)
                    table.insert(var_Unknown_8290, var_Event_790:sub(var_String_362, var_String_771))
                    var_Unknown_8967 = var_String_771
                    var_Unknown_8544 = var_Unknown_8967 + 1
                    var_Unknown_8967 = var_Unknown_8967 + 1
                end
            end
            local var_String_569 = var_Event_790:find(\\"\\\\
\\", var_Unknown_8967 + 2, true)
            if var_String_569 then
                var_Unknown_8967 = var_String_569
            else
            var_Unknown_8967 = M
        end
        table.insert(var_Unknown_8290, var_Event_790:sub(var_String_362, var_Unknown_8967))
        var_Unknown_8544 = var_Unknown_8967 + 1
    elseif var_Unknown_4594 == 34 or var_Unknown_4594 == 39 or var_Unknown_4594 == 96 then
        table.insert(var_Unknown_8290, fn_Event_484(var_Event_790:sub(var_Unknown_8544, var_Unknown_8967 - 1)))
        local var_String_871 = var_Unknown_4594
        local var_String_631 = var_Unknown_8967
        var_Unknown_8967 = var_Unknown_8967 + 1
        while var_Unknown_8967 <= M do
            local var_Unknown_9179 = var_Event_790:byte(var_Unknown_8967)
            if var_Unknown_9179 == 92 then
                var_Unknown_8967 = var_Unknown_8967 + 1
            elseif var_Unknown_9179 == var_String_871 then
                break
            end
            var_Unknown_8967 = var_Unknown_8967 + 1
        end
        local var_String_018 = var_Event_790:sub(var_String_631 + 1, var_Unknown_8967 - 1)
        var_String_018 = fn_Event_915(var_String_018)
        if var_String_871 == 96 then
            table.insert(var_Unknown_8290, '\\"' .. var_String_018:gsub('\\"', '\\\\\\\\\\"') .. '\\"')
        else
        local var_Player_072 = string.char(var_String_871)
        table.insert(var_Unknown_8290, var_Player_072 .. var_String_018 .. var_Player_072)
    end
    var_Unknown_8544 = var_Unknown_8967 + 1
end
var_Unknown_8967 = var_Unknown_8967 + 1
end
table.insert(var_Unknown_8290, fn_Event_484(var_Event_790:sub(var_Unknown_8544)))
return table.concat(var_Unknown_8290)
end
local function fn_Event_500(var_Event_336, var_Event_109)
    local var_Event_838, var_String_767 = var_Data_859(var_Event_336, var_Event_109)
    if var_Event_838 then
        return var_Event_838
    end
    var_Data_652(\\"\\\\
[CRITICAL ERROR] Failed to load script!\\")
    var_Data_652(\\"[LUA_LOAD_FAIL] \\" .. var_Event_192(var_String_767))
    local var_Data_015 = tonumber(var_String_767:match(\\":(%var_HTTP_060+):\\"))
    local var_Event_621 = var_String_767:match(\\"near '([^']+)'\\")
    if var_Event_621 then
        local var_Event_009 = var_Event_336:find(var_Event_621, 1, true)
        if var_Event_009 then
            local var_Math_514 = math.max(1, var_Event_009 - 50)
            local var_UI_978 = math.min(#var_Event_336, var_Event_009 + 50)
            var_Data_652(\\"Context around error:\\")
            var_Data_652(\\"...\\" .. var_Event_336:sub(var_Math_514, var_UI_978) .. \\"...\\")
        end
    end
    local var_NPC_210 = var_Event_379.open(\\"DEBUG_FAILED_TRANSPILE.lua\\", \\"fn_Event_591\\")
    if var_NPC_210 then
        var_NPC_210:write(var_Event_336)
        var_NPC_210:close()
        var_Data_652(\\"[*] Saved to 'DEBUG_FAILED_TRANSPILE.lua' for inspection\\")
        end
        return nil, var_String_767
    end
    local function fn_Event_188(var_Event_394, var_Event_728)
        if var_HTTP_773.limit_reached then
            return
        end
        if var_Event_394 == nil then
            return
        end
        local var_String_809 = var_Event_728 and \\"\\" or string.rep(\\"    \\", var_HTTP_773.indent)
        local var_String_764 = var_String_809 .. var_Event_192(var_Event_394)
        local var_Teleport_175 = #var_String_764 + 1
        if var_HTTP_773.current_size + var_Teleport_175 > var_Temp_17.MAX_OUTPUT_SIZE then
            var_HTTP_773.limit_reached = true
            local var_Table_306 = \\"-- [CRITICAL] Dump stopped: File size exceeded 6MB limit.\\"
            table.insert(var_HTTP_773.output, var_Table_306)
            var_HTTP_773.current_size = var_HTTP_773.current_size + #var_Table_306
            error(\\"DUMP_LIMIT_EXCEEDED\\")
        end
        if var_String_764 == var_HTTP_773.last_emitted_line then
            var_HTTP_773.repetition_count = var_HTTP_773.repetition_count + 1
            if var_HTTP_773.repetition_count <= var_Temp_17.MAX_REPEATED_LINES then
                table.insert(var_HTTP_773.output, var_String_764)
                var_HTTP_773.current_size = var_HTTP_773.current_size + var_Teleport_175
            elseif var_HTTP_773.repetition_count == var_Temp_17.MAX_REPEATED_LINES + 1 then
                local var_Table_306 = var_String_809 .. \\"-- [Repeated lines suppressed...]\\"
                table.insert(var_HTTP_773.output, var_Table_306)
                var_HTTP_773.current_size = var_HTTP_773.current_size + #var_Table_306
            end
        else
        var_HTTP_773.last_emitted_line = var_String_764
        var_HTTP_773.repetition_count = 0
        table.insert(var_HTTP_773.output, var_String_764)
        var_HTTP_773.current_size = var_HTTP_773.current_size + var_Teleport_175
    end
    if var_Temp_17.VERBOSE and var_HTTP_773.repetition_count <= 1 then
        var_Data_652(var_String_764)
    end
end
local function fn_Event_676(var_Event_394)
    fn_Event_188(\\"-- \\" .. var_Event_192(var_Event_394 or \\"\\"))
end
local function fn_Event_030()
    var_HTTP_773.last_emitted_line = nil
    table.insert(var_HTTP_773.output, \\"\\")
end
local function fn_Event_060()
    return table.concat(var_HTTP_773.output, \\"\\\\
\\")
end
local function fn_Event_467(var_Event_069)
    if not var_Event_069 then
        var_Event_069 = var_Temp_17.OUTPUT_FILE
    end
    if var_Event_069:find(\\"%.%.\\") or var_Event_069:find(\\"/\\") or var_Event_069:find(\\"\\\\\\") or var_Event_069:find(\\"^/\\") or var_Event_069:find(\\"^[var_Temp_00-zA-var_Event_877]:\\") then
        var_Data_652(\\"[PenguEnv Security] Blocked access to sensitive or invalid path: \\" .. var_Event_069)
        return false
    end
    local var_NPC_210 = var_Event_379.open(var_Event_069, \\"fn_Event_591\\")
    if var_NPC_210 then
        var_NPC_210:write(fn_Event_060())
        var_NPC_210:close()
        return true
    end
    return false
end
local function fn_Event_958(var_Event_356)
    if var_Event_356 == nil then
        return \\"nil\\"
    end
    if var_HTTP_095(var_Event_356) == \\"string\\" then
        return var_Event_356
    end
    if var_HTTP_095(var_Event_356) == \\"number\\" or var_HTTP_095(var_Event_356) == \\"boolean\\" then
        return var_Event_192(var_Event_356)
    end
    if var_HTTP_095(var_Event_356) == \\"table\\" then
        if var_HTTP_773.registry[var_Event_356] then
            return var_HTTP_773.registry[var_Event_356]
        end
        if fn_Event_359(var_Event_356) then
            local var_Camel_596 = fn_Event_290(var_Event_356)
            return var_Camel_596 and \\"proxy_\\" .. var_Camel_596 or \\"proxy\\"
        end
    end
    local y, var_Event_394 = pcall(var_Event_192, var_Event_356)
    return y and var_Event_394 or \\"unknown\\"
end
local function fn_Event_572(var_Event_356)
    local var_Event_394 = fn_Event_958(var_Event_356)
    local var_String_498 =
    var_Event_394:gsub(\\"\\\\\\\\\\", \\"\\\\\\\\\\\\\\\\\\"):gsub('\\"', '\\\\\\\\\\"'):gsub(\\"\\\\
\\", \\"\\\\\\\\
\\"):gsub(\\"\\\\\var_Temp_17\\", \\"\\\\\\\\\var_Temp_17\\"):gsub(\\"\\\\\var_HTTP_773\\", \\"\\\\\\\\\var_HTTP_773\\")
    return '\\"' .. var_String_498 .. '\\"'
end
local var_Player_195 = {
Players = \\"Players\\",
Workspace = \\"Workspace\\",
ReplicatedStorage = \\"ReplicatedStorage\\",
ServerStorage = \\"ServerStorage\\",
ServerScriptService = \\"ServerScriptService\\",
StarterGui = \\"StarterGui\\",
StarterPack = \\"StarterPack\\",
StarterPlayer = \\"StarterPlayer\\",
Lighting = \\"Lighting\\",
SoundService = \\"SoundService\\",
Chat = \\"Chat\\",
RunService = \\"RunService\\",
UserInputService = \\"UserInputService\\",
TweenService = \\"TweenService\\",
HttpService = \\"HttpService\\",
MarketplaceService = \\"MarketplaceService\\",
TeleportService = \\"TeleportService\\",
PathfindingService = \\"PathfindingService\\",
CollectionService = \\"CollectionService\\",
PhysicsService = \\"PhysicsService\\",
ProximityPromptService = \\"ProximityPromptService\\",
ContextActionService = \\"ContextActionService\\",
GuiService = \\"GuiService\\",
HapticService = \\"HapticService\\",
VRService = \\"VRService\\",
CoreGui = \\"CoreGui\\",
Teams = \\"Teams\\",
InsertService = \\"InsertService\\",
DataStoreService = \\"DataStoreService\\",
MessagingService = \\"MessagingService\\",
TextService = \\"TextService\\",
TextChatService = \\"TextChatService\\",
ContentProvider = \\"ContentProvider\\",
Debris = \\"Debris\\",
PolicyService = \\"PolicyService\\",
LocalizationService = \\"LocalizationService\\",
VoiceChatService = \\"VoiceChatService\\"
}
local var_Player_878 = {
Players = \\"Players\\",
UserInputService = \\"var_Player_866\\",
RunService = \\"RunService\\",
ReplicatedStorage = \\"ReplicatedStorage\\",
TweenService = \\"TweenService\\",
Workspace = \\"Workspace\\",
Lighting = \\"Lighting\\",
StarterGui = \\"StarterGui\\",
CoreGui = \\"CoreGui\\",
HttpService = \\"HttpService\\",
MarketplaceService = \\"MarketplaceService\\",
DataStoreService = \\"DataStoreService\\",
TeleportService = \\"TeleportService\\",
SoundService = \\"SoundService\\",
Chat = \\"Chat\\",
Teams = \\"Teams\\",
ProximityPromptService = \\"ProximityPromptService\\",
ContextActionService = \\"ContextActionService\\",
CollectionService = \\"CollectionService\\",
PathfindingService = \\"PathService\\"
}
local var_Camel_154 = {
{pattern = \\"window\\", prefix = \\"Window\\", counter = \\"window\\"},
    {pattern = \\"tab\\", prefix = \\"Tab\\", counter = \\"tab\\"},
    {pattern = \\"section\\", prefix = \\"Section\\", counter = \\"section\\"},
    {pattern = \\"button\\", prefix = \\"Button\\", counter = \\"button\\"},
    {pattern = \\"toggle\\", prefix = \\"Toggle\\", counter = \\"toggle\\"},
    {pattern = \\"slider\\", prefix = \\"Slider\\", counter = \\"slider\\"},
    {pattern = \\"dropdown\\", prefix = \\"Dropdown\\", counter = \\"dropdown\\"},
        {pattern = \\"textbox\\", prefix = \\"Textbox\\", counter = \\"textbox\\"},
        {pattern = \\"input\\", prefix = \\"Input\\", counter = \\"input\\"},
        {pattern = \\"label\\", prefix = \\"Label\\", counter = \\"label\\"},
        {pattern = \\"keybind\\", prefix = \\"Keybind\\", counter = \\"keybind\\"},
        {pattern = \\"colorpicker\\", prefix = \\"ColorPicker\\", counter = \\"colorpicker\\"},
        {pattern = \\"paragraph\\", prefix = \\"Paragraph\\", counter = \\"paragraph\\"},
        {pattern = \\"notification\\", prefix = \\"Notification\\", counter = \\"notification\\"},
            {pattern = \\"divider\\", prefix = \\"Divider\\", counter = \\"divider\\"},
            {pattern = \\"bind\\", prefix = \\"Bind\\", counter = \\"bind\\"},
            {pattern = \\"picker\\", prefix = \\"Picker\\", counter = \\"picker\\"}
            }
            local var_Event_612 = {}
            local function fn_Event_041(var_Event_134)
                var_Event_612[var_Event_134] = (var_Event_612[var_Event_134] or 0) + 1
                return var_Event_612[var_Event_134]
            end
            local function fn_Event_078(var_Event_407, var_Event_671, var_Event_413)
                if not var_Event_407 then
                    var_Event_407 = \\"var\\"
                end
                local var_Camel_204 = fn_Event_958(var_Event_407)
                if var_Player_878[var_Camel_204] then
                    return var_Player_878[var_Camel_204]
                end
                if var_Event_413 then
                    local var_String_859 = var_Event_413:lower()
                    for W, aV in ipairs(var_Camel_154) do
                        if var_String_859:find(aV.pattern) then
                            local var_Event_252 = fn_Event_041(aV.counter)
                            return var_Event_252 == 1 and aV.prefix or aV.prefix .. var_Event_252
                        end
                    end
                end
                if var_Camel_204 == \\"LocalPlayer\\" then
                    return \\"LocalPlayer\\"
                end
                if var_Camel_204 == \\"Character\\" then
                    return \\"Character\\"
                end
                if var_Camel_204 == \\"Humanoid\\" then
                    return \\"Humanoid\\"
                end
                if var_Camel_204 == \\"HumanoidRootPart\\" then
                    return \\"HumanoidRootPart\\"
                end
                if var_Camel_204 == \\"Camera\\" then
                    return \\"Camera\\"
                end
                if var_Camel_204:match(\\"^Enum%.\\") then
                    return var_Camel_204
                end
                local var_Event_963 = var_Camel_204:gsub(\\"[^%w_]\\", '\\"'):gsub(\\"^%var_HTTP_060+\\", '\\"')
                if var_Event_963 == '\\"' or var_Event_963 == \\"Object\\" or var_Event_963 == \\"Value\\" or var_Event_963 == \\"result\\" then
                    var_Event_963 = \\"var\\"
                end
                return var_Event_963
            end
            local function fn_Event_471(var_Event_148, var_Event_407, var_Event_574, var_Event_413)
                local var_Event_763 = var_HTTP_773.registry[var_Event_148]
                if var_Event_763 and var_Event_763:match(\\"^pen%var_HTTP_060+$\\") then
                    return var_Event_763
                end
                var_HTTP_773.pen_counter = (var_HTTP_773.pen_counter or 0) + 1
                local var_Event_109 = \\"pen\\" .. var_HTTP_773.pen_counter
                var_HTTP_773.names_used[var_Event_109] = true
                var_HTTP_773.registry[var_Event_148] = var_Event_109
                var_HTTP_773.reverse_registry[var_Event_109] = var_Event_148
                var_HTTP_773.variable_types[var_Event_109] = var_Event_574 or var_HTTP_095(var_Event_148)
                return var_Event_109
            end
            local function fn_Event_554(var_Event_356, var_Event_349, var_Event_718, var_Event_106)
                var_Event_349 = var_Event_349 or 0
                var_Event_718 = var_Event_718 or {}
                if var_Event_349 > var_Temp_17.MAX_DEPTH then
                    return \\"{ --[[max depth]] }\\"
                end
                local var_Unknown_3392 = var_HTTP_095(var_Event_356)
                if fn_Event_591(var_Event_356) then
                    local var_HTTP_647 = rawget(var_Event_356, \\"__value\\")
                    return var_Event_192(var_HTTP_647 or 0)
                end
                if var_Unknown_3392 == \\"table\\" and var_HTTP_773.registry[var_Event_356] then
                    return var_HTTP_773.registry[var_Event_356]
                end
                if var_Unknown_3392 == \\"nil\\" then
                    return \\"nil\\"
                elseif var_Unknown_3392 == \\"string\\" then
                    if #var_Event_356 > 100 and var_Event_356:match(\\"^[fn_Event_702-Za-z0-9+/=]+$\\") then
                        table.insert(var_HTTP_773.string_refs, {value = var_Event_356:sub(1, 50) .. \\"...\\", hint = \\"base64\\", full_length = #var_Event_356})
                    elseif var_Event_356:match(\\"https?://\\") then
                        table.insert(var_HTTP_773.string_refs, {value = var_Event_356, hint = \\"URL\\"})
                    elseif var_Event_356:match(\\"rbxasset://\\") or var_Event_356:match(\\"rbxassetid://\\") then
                        table.insert(var_HTTP_773.string_refs, {value = var_Event_356, hint = \\"Asset\\"})
                    end
                    return fn_Event_572(var_Event_356)
                elseif var_Unknown_3392 == \\"number\\" then
                    if var_Event_356 ~= var_Event_356 then
                        return \\"0/0\\"
                    end
                    if var_Event_356 == math.huge then
                        return \\"math.huge\\"
                    end
                    if var_Event_356 == -math.huge then
                        return \\"-math.huge\\"
                    end
                    if var_Event_356 == math.floor(var_Event_356) then
                        return var_Event_192(math.floor(var_Event_356))
                    end
                    return string.format(\\"%.6g\\", var_Event_356)
                    elseif var_Unknown_3392 == \\"boolean\\" then
                        return var_Event_192(var_Event_356)
                    elseif var_Unknown_3392 == \\"function\\" then
                        if var_HTTP_773.registry[var_Event_356] then
                            return var_HTTP_773.registry[var_Event_356]
                        end
                        return \\"function() end\\"
                        elseif var_Unknown_3392 == \\"table\\" then
                            if fn_Event_359(var_Event_356) then
                                return var_HTTP_773.registry[var_Event_356] or \\"proxy\\"
                            end
                            if var_Event_718[var_Event_356] then
                                return \\"{ --[[circupen]] }\\"
                            end
                            var_Event_718[var_Event_356] = true
                            local var_Event_252 = 0
                            for var_Unknown_5926, var_Table_535 in var_NPC_621(var_Event_356) do
                                if var_Unknown_5926 ~= var_Event_539 and var_Unknown_5926 ~= \\"__proxy_id\\" then
                                    var_Event_252 = var_Event_252 + 1
                                end
                            end
                            if var_Event_252 == 0 then
                                return \\"{}\\"
                            end
                            local var_Unknown_9121 = true
                            local var_Unknown_4658 = 0
                            for var_Unknown_5926, var_Table_535 in var_NPC_621(var_Event_356) do
                                if var_Unknown_5926 ~= var_Event_539 and var_Unknown_5926 ~= \\"__proxy_id\\" then
                                    if var_HTTP_095(var_Unknown_5926) ~= \\"number\\" or var_Unknown_5926 < 1 or var_Unknown_5926 ~= math.floor(var_Unknown_5926) then
                                        var_Unknown_9121 = false
                                        break
                                    else
                                    var_Unknown_4658 = math.max(var_Unknown_4658, var_Unknown_5926)
                                end
                            end
                        end
                        var_Unknown_9121 = var_Unknown_9121 and var_Unknown_4658 == var_Event_252
                        if var_Unknown_9121 and var_Event_252 <= 5 and var_Event_106 ~= false then
                            local var_Unknown_6525 = {}
                            for var_Unknown_8967 = 1, var_Event_252 do
                                local var_Table_535 = var_Event_356[var_Unknown_8967]
                                if var_HTTP_095(var_Table_535) ~= \\"table\\" or fn_Event_359(var_Table_535) then
                                    table.insert(var_Unknown_6525, fn_Event_554(var_Table_535, var_Event_349 + 1, var_Event_718, true))
                                else
                                var_Unknown_9121 = false
                                break
                            end
                        end
                        if var_Unknown_9121 and #var_Unknown_6525 == var_Event_252 then
                            return \\"{\\" .. table.concat(var_Unknown_6525, \\", \\") .. \\"}\\"
                        end
                    end
                    local var_Unknown_6739 = {}
                    local var_String_997 = 0
                    local var_String_404 = string.rep(\\"    \\", var_HTTP_773.indent + var_Event_349 + 1)
                    local var_String_093 = string.rep(\\"    \\", var_HTTP_773.indent + var_Event_349)
                    for var_Unknown_5926, var_Table_535 in var_NPC_621(var_Event_356) do
                        if var_Unknown_5926 ~= var_Event_539 and var_Unknown_5926 ~= \\"__proxy_id\\" then
                            var_String_997 = var_String_997 + 1
                            if var_String_997 > var_Temp_17.MAX_TABLE_ITEMS then
                                table.insert(var_Unknown_6739, var_String_404 .. \\"-- ...\\" .. var_Event_252 - var_String_997 + 1 .. \\" more\\")
                                break
                            end
                            local var_Event_015
                            if var_Unknown_9121 then
                                var_Event_015 = nil
                            elseif var_HTTP_095(var_Unknown_5926) == \\"string\\" and var_Unknown_5926:match(\\"^[%var_Event_349][%w_]*$\\") then
                                var_Event_015 = var_Unknown_5926
                            else
                            var_Event_015 = \\"[\\" .. fn_Event_554(var_Unknown_5926, var_Event_349 + 1, var_Event_718) .. \\"]\\"
                        end
                        local var_Unknown_3374 = fn_Event_554(var_Table_535, var_Event_349 + 1, var_Event_718)
                        if var_Event_015 then
                            table.insert(var_Unknown_6739, var_String_404 .. var_Event_015 .. \\" = \\" .. var_Unknown_3374)
                        else
                        table.insert(var_Unknown_6739, var_String_404 .. var_Unknown_3374)
                    end
                end
            end
            if #var_Unknown_6739 == 0 then
                return \\"{}\\"
            end
            return \\"{\\\\
\\" .. table.concat(var_Unknown_6739, \\",\\\\
\\") .. \\"\\\\
\\" .. var_String_093 .. \\"}\\"
        elseif var_Unknown_3392 == \\"userdata\\" then
            if var_HTTP_773.registry[var_Event_356] then
                return var_HTTP_773.registry[var_Event_356]
            end
            local y, var_Event_394 = pcall(var_Event_192, var_Event_356)
            return y and var_Event_394 or \\"userdata\\"
        elseif var_Unknown_3392 == \\"thread\\" then
            return \\"coroutine.create(function() end)\\"
            else
            local y, var_Event_394 = pcall(var_Event_192, var_Event_356)
            return y and var_Event_394 or \\"nil\\"
        end
    end
    local var_Table_226 = {}
    setmetatable(var_Table_226, {__mode = \\"var_HTTP_344\\"})
    local function fn_Event_281()
        local var_Event_395 = {}
        var_Table_226[var_Event_395] = true
        local var_Table_271 = {}
        setmetatable(var_Event_395, var_Table_271)
        return var_Event_395, var_Table_271
    end
    local function fn_Event_359(var_Event_148)
        return var_Table_226[var_Event_148] == true
    end
    local bj
    local bk
    local function fn_Event_989(var_Event_704)
        local var_Event_395, var_Table_271 = fn_Event_281()
        rawset(var_Event_395, var_Event_124, true)
        rawset(var_Event_395, \\"__value\\", var_Event_704)
        var_HTTP_773.registry[var_Event_395] = tostring(var_Event_704)
        var_Table_271.__tostring = function()
            return tostring(var_Event_704)
        end
        var_Table_271.__index = function(var_Unknown_3392, var_Unknown_5926)
            if var_Unknown_5926 == var_Event_539 or var_Unknown_5926 == \\"__proxy_id\\" or var_Unknown_5926 == var_Event_124 or var_Unknown_5926 == \\"__value\\" then
                return rawget(var_Unknown_3392, var_Unknown_5926)
            end
            return fn_Event_989(0)
        end
        var_Table_271.__newindex = function()
        end
        var_Table_271.__call = function()
            return var_Event_704
        end
        local function fn_HTTP_199(var_Event_385)
            return function(var_Event_715, var_Unknown_4594)
                local var_HTTP_771 = type(var_Event_715) == \\"table\\" and rawget(var_Event_715, \\"__value\\") or var_Event_715 or 0
                local var_HTTP_523 = type(var_Unknown_4594) == \\"table\\" and rawget(var_Unknown_4594, \\"__value\\") or var_Unknown_4594 or 0
                local var_Temp_25
                if var_Event_385 == \\"+\\" then
                    var_Temp_25 = var_HTTP_771 + var_HTTP_523
                elseif var_Event_385 == \\"-\\" then
                    var_Temp_25 = var_HTTP_771 - var_HTTP_523
                elseif var_Event_385 == \\"*\\" then
                    var_Temp_25 = var_HTTP_771 * var_HTTP_523
                elseif var_Event_385 == \\"/\\" then
                    var_Temp_25 = var_HTTP_523 ~= 0 and var_HTTP_771 / var_HTTP_523 or 0
                elseif var_Event_385 == \\"%\\" then
                    var_Temp_25 = var_HTTP_523 ~= 0 and var_HTTP_771 % var_HTTP_523 or 0
                elseif var_Event_385 == \\"^\\" then
                    var_Temp_25 = var_HTTP_771 ^ var_HTTP_523
                else
                var_Temp_25 = 0
            end
            return fn_Event_989(var_Temp_25)
        end
    end
    var_Table_271.__add = fn_HTTP_199(\\"+\\")
    var_Table_271.__sub = fn_HTTP_199(\\"-\\")
    var_Table_271.__mul = fn_HTTP_199(\\"*\\")
    var_Table_271.__div = fn_HTTP_199(\\"/\\")
    var_Table_271.__mod = fn_HTTP_199(\\"%\\")
    var_Table_271.__pow = fn_HTTP_199(\\"^\\")
    var_Table_271.__unm = function(var_Event_715)
        return fn_Event_989(-(rawget(var_Event_715, \\"__value\\") or 0))
    end
    var_Table_271.__eq = function(var_Event_715, var_Unknown_4594)
        local var_HTTP_771 = type(var_Event_715) == \\"table\\" and rawget(var_Event_715, \\"__value\\") or var_Event_715
        local var_HTTP_523 = type(var_Unknown_4594) == \\"table\\" and rawget(var_Unknown_4594, \\"__value\\") or var_Unknown_4594
        return var_HTTP_771 == var_HTTP_523
    end
    var_Table_271.__lt = function(var_Event_715, var_Unknown_4594)
        local var_HTTP_771 = type(var_Event_715) == \\"table\\" and rawget(var_Event_715, \\"__value\\") or var_Event_715
        local var_HTTP_523 = type(var_Unknown_4594) == \\"table\\" and rawget(var_Unknown_4594, \\"__value\\") or var_Unknown_4594
        return var_HTTP_771 < var_HTTP_523
    end
    var_Table_271.__le = function(var_Event_715, var_Unknown_4594)
        local var_HTTP_771 = type(var_Event_715) == \\"table\\" and rawget(var_Event_715, \\"__value\\") or var_Event_715
        local var_HTTP_523 = type(var_Unknown_4594) == \\"table\\" and rawget(var_Unknown_4594, \\"__value\\") or var_Unknown_4594
        return var_HTTP_771 <= var_HTTP_523
    end
    var_Table_271.__len = function()
        return 0
    end
    return var_Event_395
end
local function fn_Event_742(var_Event_144, var_Event_743)
    if var_HTTP_095(var_Event_144) ~= \\"function\\" then
        return {}
    end
    local var_Event_711 = #var_HTTP_773.output
    local var_Teleport_747 = var_HTTP_773.pending_iterator
    var_HTTP_773.pending_iterator = false
    xpcall(
    function()
        var_Event_144(table.unpack(var_Event_743 or {}))
    end,
    function()
    end
    )
    while var_HTTP_773.pending_iterator do
        var_HTTP_773.indent = var_HTTP_773.indent - 1
        fn_Event_188(\\"end\\")
        var_HTTP_773.pending_iterator = false
    end
    var_HTTP_773.pending_iterator = var_Teleport_747
    local var_Teleport_703 = {}
    for var_Unknown_8967 = var_Event_711 + 1, #var_HTTP_773.output do
        table.insert(var_Teleport_703, var_HTTP_773.output[var_Unknown_8967])
    end
    for var_Unknown_8967 = #var_HTTP_773.output, var_Event_711 + 1, -1 do
        table.remove(var_HTTP_773.output, var_Unknown_8967)
    end
    return var_Teleport_703
end
bk = function(var_Event_413, bw)
    local var_Event_395, var_Table_271 = fn_Event_281()
    local var_Unknown_3500 = var_HTTP_773.registry[bw] or \\"object\\"
    local var_Unknown_0845 = fn_Event_958(var_Event_413)
    var_HTTP_773.registry[var_Event_395] = var_Unknown_3500 .. \\".\\" .. var_Unknown_0845
    var_Table_271.__call = function(self, bz, ...)
        local var_Remote_865
        if bz == var_Event_395 or bz == bw or fn_Event_359(bz) then
            var_Remote_865 = {...}
        else
        var_Remote_865 = {bz, ...}
    end
    local var_String_859 = var_Unknown_0845:lower()
    local var_String_133 = nil
    local var_NPC_382 = true
    for W, aV in ipairs(var_Camel_154) do
        if var_String_859:find(aV.pattern) then
            var_String_133 = aV.prefix
            break
        end
    end
    local var_Camel_401 = nil
    local var_Camel_449 = nil
    local var_NPC_989 = nil
    for var_Unknown_8967, var_Table_535 in ipairs(var_Remote_865) do
        if var_HTTP_095(var_Table_535) == \\"function\\" then
            var_Camel_401 = var_Table_535
            break
        elseif var_HTTP_095(var_Table_535) == \\"table\\" and not fn_Event_359(var_Table_535) then
            for var_Event_319, var_Event_356 in var_NPC_621(var_Table_535) do
                local var_Event_529 = var_Event_192(var_Event_319):lower()
                if var_Event_529 == \\"callback\\" and var_HTTP_095(var_Event_356) == \\"function\\" then
                    var_Camel_401 = var_Event_356
                    var_Camel_449 = var_Event_319
                    var_NPC_989 = var_Unknown_8967
                    break
                end
            end
        end
    end
    local var_Camel_178 = \\"value\\"
    local var_Event_743 = {}
    if var_Camel_401 then
        if var_String_859:match(\\"toggle\\") then
            var_Camel_178 = \\"enabled\\"
            var_Event_743 = {true}
        elseif var_String_859:match(\\"slider\\") then
            var_Camel_178 = \\"value\\"
            var_Event_743 = {50}
        elseif var_String_859:match(\\"dropdown\\") then
            var_Camel_178 = \\"selected\\"
            var_Event_743 = {\\"Option\\"}
        elseif var_String_859:match(\\"textbox\\") or var_String_859:match(\\"input\\") then
            var_Camel_178 = \\"text\\"
            var_Event_743 = {var_Temp_18 or \\"input\\"}
        elseif var_String_859:match(\\"keybind\\") or var_String_859:match(\\"bind\\") then
            var_Camel_178 = \\"key\\"
            var_Event_743 = {bj(\\"Enum.KeyCode.var_NPC_677\\", false)}
        elseif var_String_859:match(\\"color\\") then
            var_Camel_178 = \\"color\\"
            var_Event_743 = {Color3.new(255, 255, 255)}
        elseif var_String_859:match(\\"button\\") then
            var_Camel_178 = \\"\\\\\\"
            var_Event_743 = {}
        end
    end
    local var_Camel_311 = {}
    if var_Camel_401 then
        var_Camel_311 = fn_Event_742(var_Camel_401, var_Event_743)
    end
    local var_Temp_25 = bj(var_String_133 or var_Unknown_0845, false, bw)
    local var_Private_589 = fn_Event_471(var_Temp_25, var_String_133 or var_Unknown_0845, nil, var_Unknown_0845)
    local var_NPC_311 = {}
    for var_Unknown_8967, var_Table_535 in ipairs(var_Remote_865) do
        if var_HTTP_095(var_Table_535) == \\"table\\" and not fn_Event_359(var_Table_535) and var_Unknown_8967 == var_NPC_989 then
            local var_Unknown_6525 = {}
            for var_Event_319, var_Event_356 in var_NPC_621(var_Table_535) do
                local var_Event_015
                if var_HTTP_095(var_Event_319) == \\"string\\" and var_Event_319:match(\\"^[%var_Event_349][%w_]*$\\") then
                    var_Event_015 = var_Event_319
                else
                var_Event_015 = \\"[\\" .. fn_Event_554(var_Event_319) .. \\"]\\"
            end
            if var_Event_319 == var_Camel_449 and #var_Camel_311 > 0 then
                local var_Event_666 = var_Camel_178 ~= '\\"' and \\"function(\\" .. \\"var_Camel_178\\" .. \\")\\" or \\"function()\\"
                    local var_String_404 = string.rep(\\"    \\", var_HTTP_773.indent + 2)
                    local var_String_092 = {}
                    for W, var_String_764 in ipairs(var_Camel_311) do
                        table.insert(var_String_092, var_String_404 .. (var_String_764:match(\\"^%var_Temp_18*(.*)$\\") or var_String_764))
                    end
                    local var_String_093 = string.rep(\\"    \\", var_HTTP_773.indent + 1)
                    table.insert(var_Unknown_6525, var_Event_015 .. \\" = \\" .. var_Event_666 .. \\"\\\\
\\" .. table.concat(var_String_092, \\"\\\\
\\") .. \\"\\\\
\\" .. var_String_093 .. \\"end\\")
                elseif var_Event_319 == var_Camel_449 then
                    local var_Event_433 = var_Camel_178 ~= \\"\\\\\\" and \\"function(\\" .. var_Camel_178 .. \\") end\\" or \\"function() end\\"
                        table.insert(var_Unknown_6525, var_Event_015 .. \\" = \\" .. var_Event_433)
                    else
                    table.insert(var_Unknown_6525, var_Event_015 .. \\" = \\" .. fn_Event_554(var_Event_356))
                end
            end
            table.insert(
            var_NPC_311,
            \\"{\\\\
\\" ..
            string.rep(\\"    \\", var_HTTP_773.indent + 1) ..
            table.concat(var_Unknown_6525, \\",\\\\
\\" .. string.rep(\\"    \\", var_HTTP_773.indent + 1)) ..
            \\"\\\\
\\" .. string.rep(\\"    \\", var_HTTP_773.indent) .. \\"}\\"
            )
        elseif var_HTTP_095(var_Table_535) == \\"function\\" then
            if #var_Camel_311 > 0 then
                local var_Event_666 = var_Camel_178 ~= '\\"' and \\"function(\\" .. var_Camel_178 .. \\")\\" or \\"function()\\"
                    local var_String_404 = string.rep(\\"    \\", var_HTTP_773.indent + 1)
                    local var_String_092 = {}
                    for W, var_String_764 in ipairs(var_Camel_311) do
                        table.insert(var_String_092, var_String_404 .. (var_String_764:match(\\"^%var_Temp_18*(.*)$\\") or var_String_764))
                    end
                    table.insert(
                    var_NPC_311,
                    var_Event_666 .. \\"\\\\
\\" .. table.concat(var_String_092, \\"\\\\
\\") .. \\"\\\\
\\" .. string.rep(\\"    \\", var_HTTP_773.indent) .. \\"end\\"
                    )
                else
                local var_Event_433 = var_Camel_178 ~= '\\"' and \\"function(\\" .. var_Camel_178 .. \\") end\\" or \\"function() end\\"
                    table.insert(var_NPC_311, var_Event_433)
                end
            else
            table.insert(var_NPC_311, fn_Event_554(var_Table_535))
        end
    end
    fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:%var_Temp_18(%var_Temp_18)\\", var_Private_589, var_Unknown_3500, var_Unknown_0845, table.concat(var_NPC_311, \\", \\")))
        return var_Temp_25
    end
    var_Table_271.__index = function(var_Unknown_3392, var_Unknown_5926)
        if var_Unknown_5926 == var_Event_539 or var_Unknown_5926 == \\"__proxy_id\\" then
            return rawget(var_Unknown_3392, var_Unknown_5926)
        end
        return bk(var_Unknown_5926, var_Event_395)
    end
    var_Table_271.__tostring = function()
        return var_Unknown_3500 .. \\":\\" .. var_Unknown_0845
    end
    return var_Event_395
end
bj = function(var_Event_407, bO, bw)
    local var_Event_395, var_Table_271 = fn_Event_281()
    local var_Camel_204 = fn_Event_958(var_Event_407)
    var_HTTP_773.property_store[var_Event_395] = {}
    if bO then
        var_HTTP_773.registry[var_Event_395] = var_Camel_204
        var_HTTP_773.names_used[var_Camel_204] = true
    elseif bw then
        var_HTTP_773.parent_map[var_Event_395] = bw
        rawset(var_Event_395, \\"__temp_path\\", (var_HTTP_773.registry[bw] or \\"object\\") .. \\".\\" .. var_Camel_204)
    end
    local var_Camel_543 = {}

    -- 1. Universal Instance Methods
    var_Camel_543.GetDescendants = function(self)
        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
        local descendants = {
        {Name = \\"Child1\\", ClassName = \\"Frame\\"},
        {Name = \\"Child2\\", ClassName = \\"TextLabel\\"},
        {Name = \\"Config\\", ClassName = \\"ModuleScript\\"}
        }
        local index = 0
        return function()
            index = index + 1
            if index <= #descendants then
                local data = descendants[index]
                local dObj = bj(data.Name, false, var_Event_395)
                var_HTTP_773.registry[dObj] = var_HTTP_524 .. \\".\\" .. data.Name
                var_HTTP_773.property_store[dObj] = {Name = data.Name, ClassName = data.ClassName}
                return dObj
            end
            return nil
        end
    end
    var_Camel_543.IsA = function(self, bX)
        return true
    end
    var_Camel_543.IsDescendantOf = function(self, ch)
        return true
    end
    var_Camel_543.IsAncestorOf = function(self, ci)
        return true
    end
    var_Camel_543.GetFullName = function(self)
        if bw then
            return (var_HTTP_773.registry[bw] or \\"game\\") .. \\".\\" .. var_Camel_204
        end
        return var_HTTP_773.registry[var_Event_395] or var_Camel_204 or \\"Instance\\"
    end
    var_Camel_543.GetDebugId = function(self)
        return \\"DEBUG_\\" .. (fn_Event_290(var_Event_395) or \\"0\\")
    end
    var_Camel_543.GetAttribute = function(self, cj)
        return nil
    end
    var_Camel_543.SetAttribute = function(self, cj, var_Event_704)
        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"instance\\"
        fn_Event_188(string.format(\\"%var_Temp_18:SetAttribute(%var_Temp_18, %var_Temp_18)\\", var_HTTP_524, fn_Event_572(cj), fn_Event_554(var_Event_704)))
        end
        var_Camel_543.GetAttributes = function(self)
            return {}
        end
        var_Camel_543.GetTags = function(self) return {} end
    var_Camel_543.HasTag = function(self, tag) return false end
var_Camel_543.AddTag = function(self, tag)
    fn_Event_188(string.format(\\"%var_Temp_18:AddTag(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_572(tag)))
    end
    var_Camel_543.RemoveTag = function(self, tag)
        fn_Event_188(string.format(\\"%var_Temp_18:RemoveTag(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_572(tag)))
        end

        -- 2. Service Methods & Mocks
        var_Camel_543.GetService = function(self, bQ)
            local var_HTTP_464 = fn_Event_958(bQ)
            local var_Event_148 = bj(var_HTTP_464, false, var_Event_395)
            local var_Private_589 = fn_Event_471(var_Event_148, var_HTTP_464)
            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"game\\"
            fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:GetService(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_HTTP_464)))
                return var_Event_148
            end
            var_Camel_543.WaitForChild = function(self, bT, bU)
                local var_Event_052 = fn_Event_958(bT)
                local var_Event_148 = bj(var_Event_052, false, var_Event_395)
                local var_Private_589 = fn_Event_471(var_Event_148, var_Event_052)
                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                if bU then
                    fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:WaitForChild(%var_Temp_18, %var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_052), fn_Event_554(bU)))
                    else
                    fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:WaitForChild(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_052)))
                    end
                    return var_Event_148
                end
                var_Camel_543.FindFirstChild = function(self, bT, bW)
                    local var_Event_052 = fn_Event_958(bT)
                    local var_Event_148 = bj(var_Event_052, false, var_Event_395)
                    local var_Private_589 = fn_Event_471(var_Event_148, var_Event_052)
                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                    if bW then
                        fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:FindFirstChild(%var_Temp_18, true)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_052)))
                        else
                        fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:FindFirstChild(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_052)))
                        end
                        return var_Event_148
                    end
                    var_Camel_543.FindFirstChildOfClass = function(self, bX)
                        local var_Event_778 = fn_Event_958(bX)
                        local var_Event_148 = bj(var_Event_778, false, var_Event_395)
                        local var_Private_589 = fn_Event_471(var_Event_148, var_Event_778)
                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                        fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:FindFirstChildOfClass(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_778)))
                            return var_Event_148
                        end
                        var_Camel_543.FindFirstChildWhichIsA = function(self, bX)
                            local var_Event_778 = fn_Event_958(bX)
                            local var_Event_148 = bj(var_Event_778, false, var_Event_395)
                            local var_Private_589 = fn_Event_471(var_Event_148, var_Event_778)
                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                            fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:FindFirstChildWhichIsA(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_778)))
                                return var_Event_148
                            end
                            var_Camel_543.FindFirstAncestor = function(self, var_Event_109)
                                local var_Event_461 = fn_Event_958(var_Event_109)
                                local var_Event_148 = bj(var_Event_461, false, var_Event_395)
                                local var_Private_589 = fn_Event_471(var_Event_148, var_Event_461)
                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:FindFirstAncestor(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_461)))
                                    return var_Event_148
                                end
                                var_Camel_543.FindFirstAncestorOfClass = function(self, bX)
                                    local var_Event_778 = fn_Event_958(bX)
                                    local var_Event_148 = bj(var_Event_778, false, var_Event_395)
                                    local var_Private_589 = fn_Event_471(var_Event_148, var_Event_778)
                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                                    fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:FindFirstAncestorOfClass(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_778)))
                                        return var_Event_148
                                    end
                                    var_Camel_543.FindFirstAncestorWhichIsA = function(self, bX)
                                        local var_Event_778 = fn_Event_958(bX)
                                        local var_Event_148 = bj(var_Event_778, false, var_Event_395)
                                        local var_Private_589 = fn_Event_471(var_Event_148, var_Event_778)
                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                                        fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:FindFirstAncestorWhichIsA(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_572(var_Event_778)))
                                            return var_Event_148
                                        end
                                        var_Camel_543.GetChildren = function(self)
                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                                            fn_Event_188(string.format(\\"for var_Private_589, child in %var_Temp_18:GetChildren() do\\", var_HTTP_524))
                                                var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                var_HTTP_773.pending_iterator = true
                                                return {}
                                            end
                                            var_Camel_543.Clone = function(self)
                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                                                local var_Event_148 = bj((var_Camel_204 or \\"object\\") .. \\"Clone\\", false)
                                                local var_Private_589 = fn_Event_471(var_Event_148, (var_Camel_204 or \\"object\\") .. \\"Clone\\")
                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:Clone()\\", var_Private_589, var_HTTP_524))
                                                    return var_Event_148
                                                end
                                                var_Camel_543.Destroy = function(self)
                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                                                    fn_Event_188(string.format(\\"%var_Temp_18:Destroy()\\", var_HTTP_524))
                                                    end
                                                    var_Camel_543.ClearAllChildren = function(self)
                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"object\\"
                                                        fn_Event_188(string.format(\\"%var_Temp_18:ClearAllChildren()\\", var_HTTP_524))
                                                        end

                                                        -- 4. Signal/Event Support
                                                        var_Camel_543.Connect = function(self, var_Event_144)
                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"signal\\"
                                                            local var_Remote_529 = bj(\\"connection\\", false)
                                                            local var_Event_355 = fn_Event_471(var_Remote_529, \\"conn\\")
                                                            local var_Event_262 = var_HTTP_524:match(\\"%.([^%.]+)$\\") or var_HTTP_524
                                                            local var_String_870 = {\\"...\\"}
                                                            if var_Event_262:match(\\"InputBegan\\") or var_Event_262:match(\\"InputEnded\\") or var_Event_262:match(\\"InputChanged\\") then
                                                                var_String_870 = {\\"input\\", \\"gameProcessed\\"}
                                                            elseif var_Event_262:match(\\"CharacterAdded\\") or var_Event_262:match(\\"CharacterRemoving\\") then
                                                                var_String_870 = {\\"character\\"}
                                                            elseif var_Event_262:match(\\"PlayerAdded\\") or var_Event_262:match(\\"PlayerRemoving\\") then
                                                                var_String_870 = {\\"player\\"}
                                                            elseif var_Event_262:match(\\"Touched\\") then
                                                                var_String_870 = {\\"hit\\"}
                                                            elseif var_Event_262:match(\\"Heartbeat\\") or var_Event_262:match(\\"RenderStepped\\") then
                                                                var_String_870 = {\\"deltaTime\\"}
                                                            elseif var_Event_262:match(\\"Stepped\\") then
                                                                var_String_870 = {\\"time\\", \\"deltaTime\\"}
                                                            elseif var_Event_262:match(\\"Changed\\") then
                                                                var_String_870 = {\\"property\\"}
                                                            elseif var_Event_262:match(\\"ChildAdded\\") or var_Event_262:match(\\"ChildRemoved\\") then
                                                                var_String_870 = {\\"child\\"}
                                                            elseif var_Event_262:match(\\"DescendantAdded\\") or var_Event_262:match(\\"DescendantRemoving\\") then
                                                                var_String_870 = {\\"descendant\\"}
                                                            elseif var_Event_262:match(\\"Died\\") or var_Event_262:match(\\"MouseButton\\") or var_Event_262:match(\\"Activated\\") then
                                                                var_String_870 = {}
                                                            elseif var_Event_262:match(\\"FocusLost\\") then
                                                                var_String_870 = {\\"enterPressed\\", \\"inputObject\\"}
                                                            end
                                                            fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:Connect(function(%var_Temp_18)\\", var_Event_355, var_HTTP_524, table.concat(var_String_870, \\", \\")))
                                                                var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                if var_HTTP_095(var_Event_144) == \\"function\\" then
                                                                    xpcall(
                                                                    function()
                                                                        var_Event_144()
                                                                    end,
                                                                    function()
                                                                    end
                                                                    )
                                                                end
                                                                while var_HTTP_773.pending_iterator do
                                                                    var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                    fn_Event_188(\\"end\\")
                                                                    var_HTTP_773.pending_iterator = false
                                                                end
                                                                var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                fn_Event_188(\\"end)\\")
                                                                return var_Remote_529
                                                            end
                                                            var_Camel_543.ConnectParallel = function(self, var_Event_144)
                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"signal\\"
                                                                local var_Remote_529 = bj(\\"connection\\", false)
                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:ConnectParallel(function()\\", var_Remote_529, var_HTTP_524))
                                                                    var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                    if var_HTTP_095(var_Event_144) == \\"function\\" then
                                                                        xpcall(var_Event_144, function() end)
                                                                        end
                                                                        var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                        fn_Event_188(\\"end)\\")
                                                                        return var_Remote_529
                                                                    end
                                                                    var_Camel_543.Once = function(self, var_Event_144)
                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"signal\\"
                                                                        local var_Remote_529 = bj(\\"connection\\", false)
                                                                        local var_Event_355 = fn_Event_471(var_Remote_529, \\"conn\\")
                                                                        fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:Once(function(...)\\", var_Event_355, var_HTTP_524))
                                                                            var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                            if var_HTTP_095(var_Event_144) == \\"function\\" then
                                                                                xpcall(
                                                                                function()
                                                                                    var_Event_144()
                                                                                end,
                                                                                function()
                                                                                end
                                                                                )
                                                                            end
                                                                            var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                            fn_Event_188(\\"end)\\")
                                                                            return var_Remote_529
                                                                        end
                                                                        var_Camel_543.Wait = function(self)
                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"signal\\"
                                                                            local var_Temp_25 = bj(\\"waitResult\\", false)
                                                                            local var_Private_589 = fn_Event_471(var_Temp_25, \\"waitResult\\")
                                                                            fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:Wait()\\", var_Private_589, var_HTTP_524))
                                                                                return var_Temp_25
                                                                            end
                                                                            var_Camel_543.Disconnect = function(self)
                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"connection\\"
                                                                                fn_Event_188(string.format(\\"%var_Temp_18:Disconnect()\\", var_HTTP_524))
                                                                                end

                                                                                -- 2. Missing Service Methods (continued)
                                                                                var_Camel_543.FireServer = function(self, ...)
                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"remote\\"
                                                                                    local var_Remote_865 = {...}
                                                                                    local var_NPC_163 = {}
                                                                                    for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                        table.insert(var_NPC_163, fn_Event_554(var_Table_535))
                                                                                    end
                                                                                    fn_Event_188(string.format(\\"%var_Temp_18:FireServer(%var_Temp_18)\\", var_HTTP_524, table.concat(var_NPC_163, \\", \\")))
                                                                                        table.insert(var_HTTP_773.call_graph, {type = \\"RemoteEvent\\", name = var_HTTP_524, args = var_Remote_865})
                                                                                    end
                                                                                    var_Camel_543.FireClient = function(self, player, ...)
                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"remote\\"
                                                                                        local var_Remote_865 = {...}
                                                                                        local var_NPC_163 = {}
                                                                                        table.insert(var_NPC_163, fn_Event_554(player))
                                                                                        for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                            table.insert(var_NPC_163, fn_Event_554(var_Table_535))
                                                                                        end
                                                                                        fn_Event_188(string.format(\\"%var_Temp_18:FireClient(%var_Temp_18)\\", var_HTTP_524, table.concat(var_NPC_163, \\", \\")))
                                                                                        end
                                                                                        var_Camel_543.FireAllClients = function(self, ...)
                                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"remote\\"
                                                                                            local var_Remote_865 = {...}
                                                                                            local var_NPC_163 = {}
                                                                                            for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                                table.insert(var_NPC_163, fn_Event_554(var_Table_535))
                                                                                            end
                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:FireAllClients(%var_Temp_18)\\", var_HTTP_524, table.concat(var_NPC_163, \\", \\")))
                                                                                            end
                                                                                            var_Camel_543.InvokeServer = function(self, ...)
                                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"remote\\"
                                                                                                local var_Remote_865 = {...}
                                                                                                local var_NPC_163 = {}
                                                                                                for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                                    table.insert(var_NPC_163, fn_Event_554(var_Table_535))
                                                                                                end
                                                                                                local var_Temp_25 = bj(\\"invokeResult\\", false)
                                                                                                local var_Private_589 = fn_Event_471(var_Temp_25, \\"result\\")
                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:InvokeServer(%var_Temp_18)\\", var_Private_589, var_HTTP_524, table.concat(var_NPC_163, \\", \\")))
                                                                                                    table.insert(var_HTTP_773.call_graph, {type = \\"RemoteFunction\\", name = var_HTTP_524, args = var_Remote_865})
                                                                                                    return var_Temp_25
                                                                                                end
                                                                                                var_Camel_543.InvokeClient = function(self, player, ...)
                                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"remote\\"
                                                                                                    local var_Remote_865 = {...}
                                                                                                    local var_NPC_163 = {}
                                                                                                    table.insert(var_NPC_163, fn_Event_554(player))
                                                                                                    for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                                        table.insert(var_NPC_163, fn_Event_554(var_Table_535))
                                                                                                    end
                                                                                                    local var_Temp_25 = bj(\\"invokeResult\\", false)
                                                                                                    fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:InvokeClient(%var_Temp_18)\\", var_Private_589, var_HTTP_524, table.concat(var_NPC_163, \\", \\")))
                                                                                                        return var_Temp_25
                                                                                                    end
                                                                                                    var_Camel_543.Create = function(self, var_Event_148, c6, c7)
                                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"TweenService\\"
                                                                                                        local var_Animation_991 = bj(\\"tween\\", false)
                                                                                                        local var_Private_589 = fn_Event_471(var_Animation_991, \\"tween\\")
                                                                                                        fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:Create(%var_Temp_18, %var_Temp_18, %var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_554(var_Event_148), fn_Event_554(c6), fn_Event_554(c7)))
                                                                                                            return var_Animation_991
                                                                                                        end
                                                                                                        var_Camel_543.Play = function(self)
                                                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"tween\\"
                                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:Play()\\", var_HTTP_524))
                                                                                                            end
                                                                                                            var_Camel_543.Pause = function(self)
                                                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"tween\\"
                                                                                                                fn_Event_188(string.format(\\"%var_Temp_18:Pause()\\", var_HTTP_524))
                                                                                                                end
                                                                                                                var_Camel_543.Cancel = function(self)
                                                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"tween\\"
                                                                                                                    fn_Event_188(string.format(\\"%var_Temp_18:Cancel()\\", var_HTTP_524))
                                                                                                                    end

                                                                                                                    -- 8. Missing Sound System
                                                                                                                    var_Camel_543.Stop = function(self) -- Reused for Tween, Sound, etc
                                                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"tween\\"
                                                                                                                        fn_Event_188(string.format(\\"%var_Temp_18:Stop()\\", var_HTTP_524))
                                                                                                                        end

                                                                                                                        var_Camel_543.Raycast = function(self, c9, ca, cb)
                                                                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"workspace\\"
                                                                                                                            local var_Temp_25 = bj(\\"raycastResult\\", false)
                                                                                                                            local var_Private_589 = fn_Event_471(var_Temp_25, \\"rayResult\\")
                                                                                                                            if cb then
                                                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:Raycast(%var_Temp_18, %var_Temp_18, %var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_554(c9), fn_Event_554(ca), fn_Event_554(cb)))
                                                                                                                                else
                                                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:Raycast(%var_Temp_18, %var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_554(c9), fn_Event_554(ca)))
                                                                                                                                end
                                                                                                                                return var_Temp_25
                                                                                                                            end
                                                                                                                            var_Camel_543.GetMouse = function(self)
                                                                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"player\\"
                                                                                                                                local var_Player_856 = bj(\\"mouse\\", false)
                                                                                                                                local var_Private_589 = fn_Event_471(var_Player_856, \\"mouse\\")
                                                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:GetMouse()\\", var_Private_589, var_HTTP_524))
                                                                                                                                    return var_Player_856
                                                                                                                                end
                                                                                                                                var_Camel_543.Kick = function(self, cd)
                                                                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"player\\"
                                                                                                                                    if cd then
                                                                                                                                        fn_Event_188(string.format(\\"%var_Temp_18:Kick(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cd)))
                                                                                                                                        else
                                                                                                                                        fn_Event_188(string.format(\\"%var_Temp_18:Kick()\\", var_HTTP_524))
                                                                                                                                        end
                                                                                                                                    end
                                                                                                                                    var_Camel_543.GetPropertyChangedSignal = function(self, ce)
                                                                                                                                        local var_Remote_004 = fn_Event_958(ce)
                                                                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"instance\\"
                                                                                                                                        local var_Remote_512 = bj(var_Remote_004 .. \\"Changed\\", false)
                                                                                                                                        var_HTTP_773.registry[var_Remote_512] = var_HTTP_524 .. \\":GetPropertyChangedSignal(\\" .. fn_Event_572(var_Remote_004) .. \\")\\"
                                                                                                                                        return var_Remote_512
                                                                                                                                    end

                                                                                                                                    -- 5. Player & Service Methods
                                                                                                                                    var_Camel_543.GetPlayers = function(self)
                                                                                                                                        return {}
                                                                                                                                    end
                                                                                                                                    var_Camel_543.GetPlayerFromCharacter = function(self, ck)
                                                                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"Players\\"
                                                                                                                                        local var_Player_585 = bj(\\"player\\", false)
                                                                                                                                        local var_Private_589 = fn_Event_471(var_Player_585, \\"player\\")
                                                                                                                                        fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:GetPlayerFromCharacter(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_554(ck)))
                                                                                                                                            return var_Player_585
                                                                                                                                        end
                                                                                                                                        var_Camel_543.GetPlayerByUserId = function(self, cm)
                                                                                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"Players\\"
                                                                                                                                            local var_Player_585 = bj(\\"player\\", false)
                                                                                                                                            local var_Private_589 = fn_Event_471(var_Player_585, \\"player\\")
                                                                                                                                            fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:GetPlayerByUserId(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_554(cm)))
                                                                                                                                                return var_Player_585
                                                                                                                                            end

                                                                                                                                            -- 6. MarketplaceService
                                                                                                                                            var_Camel_543.GetProductInfo = function(self, id, infoType)
                                                                                                                                                fn_Event_188(string.format(\\"local info = %var_Temp_18:GetProductInfo(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_554(id)))
                                                                                                                                                    return {Name = \\"MockProduct\\", PriceInRobux = 0}
                                                                                                                                                end
                                                                                                                                                var_Camel_543.PromptPurchase = function(self, player, id) end
                                                                                                                                            var_Camel_543.PromptGamePassPurchase = function(self, player, id) end
                                                                                                                                        var_Camel_543.UserOwnsGamePassAsync = function(self, player, id) return false end
                                                                                                                                    var_Camel_543.PlayerOwnsAsset = function(self, player, id) return false end

                                                                                                                                -- 2. HttpService
                                                                                                                                var_Camel_543.RequestAsync = function(self, req)
                                                                                                                                    fn_Event_188(string.format(\\"%var_Temp_18:RequestAsync(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_554(req)))
                                                                                                                                        return {Success = true, StatusCode = 200, Body = \\"{}\\"}
                                                                                                                                    end
                                                                                                                                    var_Camel_543.GetAsync = function(self, var_HTTP_119)
                                                                                                                                        return \\"{}\\"
                                                                                                                                    end
                                                                                                                                    var_Camel_543.PostAsync = function(self, var_HTTP_119, cJ)
                                                                                                                                        return \\"{}\\"
                                                                                                                                    end
                                                                                                                                    var_Camel_543.JSONEncode = function(self, cJ)
                                                                                                                                        return \\"{}\\"
                                                                                                                                    end
                                                                                                                                    var_Camel_543.JSONDecode = function(self, var_Event_394)
                                                                                                                                        return {}
                                                                                                                                    end
                                                                                                                                    var_Camel_543.UrlEncode = function(self, str) return str end
                                                                                                                                var_Camel_543.GenerateGUID = function(self, cK)
                                                                                                                                    return \\"00000000-0000-0000-0000-000000000000\\"
                                                                                                                                end

                                                                                                                                -- 2. RunService
                                                                                                                                var_Camel_543.IsClient = function(self) return true end
                                                                                                                            var_Camel_543.IsServer = function(self) return false end
                                                                                                                        var_Camel_543.IsStudio = function(self) return false end
                                                                                                                    var_Camel_543.IsRunMode = function(self) return true end
                                                                                                                var_Camel_543.IsRunning = function(self) return true end
                                                                                                            var_Camel_543.BindToRenderStep = function(self, var_Event_109, cp, var_Event_144)
                                                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"RunService\\"
                                                                                                                fn_Event_188(string.format(\\"%var_Temp_18:BindToRenderStep(%var_Temp_18, %var_Temp_18, function(deltaTime)\\", var_HTTP_524, fn_Event_572(var_Event_109), fn_Event_554(cp)))
                                                                                                                    var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                                                                    if var_HTTP_095(var_Event_144) == \\"function\\" then
                                                                                                                        xpcall(
                                                                                                                        function()
                                                                                                                            var_Event_144(0.016)
                                                                                                                        end,
                                                                                                                        function()
                                                                                                                        end
                                                                                                                        )
                                                                                                                    end
                                                                                                                    var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                                    fn_Event_188(\\"end)\\")
                                                                                                                end
                                                                                                                var_Camel_543.UnbindFromRenderStep = function(self, var_Event_109)
                                                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"RunService\\"
                                                                                                                    fn_Event_188(string.format(\\"%var_Temp_18:UnbindFromRenderStep(%var_Temp_18)\\", var_HTTP_524, fn_Event_572(var_Event_109)))
                                                                                                                    end

                                                                                                                    -- 2. UserInputService
                                                                                                                    var_Camel_543.GetMouseLocation = function(self)
                                                                                                                        return Vector2.new(960, 540)
                                                                                                                    end
                                                                                                                    var_Camel_543.IsKeyDown = function(self, key) return false end
                                                                                                                var_Camel_543.IsMouseButtonPressed = function(self, btn) return false end
                                                                                                            var_Camel_543.GetKeysPressed = function(self) return {} end
                                                                                                        var_Camel_543.GetMouseButtonsPressed = function(self) return {} end
                                                                                                    var_Camel_543.GetFocusedTextBox = function(self) return nil end

                                                                                                -- 2. CollectionService
                                                                                                if var_Camel_204 == \\"CollectionService\\" then
                                                                                                    var_Camel_543.GetTagged = function(self, tag)
                                                                                                        return {}
                                                                                                    end
                                                                                                    var_Camel_543.AddTag = function(self, instance, tag)
                                                                                                        fn_Event_188(string.format(\\"%var_Temp_18:AddTag(%var_Temp_18, %var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_554(instance), fn_Event_572(tag)))
                                                                                                        end
                                                                                                        var_Camel_543.RemoveTag = function(self, instance, tag)
                                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:RemoveTag(%var_Temp_18, %var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_554(instance), fn_Event_572(tag)))
                                                                                                            end
                                                                                                            var_Camel_543.GetInstanceAddedSignal = function(self, tag)
                                                                                                                return bj(\\"InstanceAddedSignal\\", false)
                                                                                                            end
                                                                                                            var_Camel_543.GetInstanceRemovedSignal = function(self, tag)
                                                                                                                return bj(\\"InstanceRemovedSignal\\", false)
                                                                                                            end
                                                                                                        end

                                                                                                        -- 2. PathfindingService
                                                                                                        if var_Camel_204 == \\"PathfindingService\\" then
                                                                                                            var_Camel_543.CreatePath = function(self, var_Data_984)
                                                                                                                fn_Event_188(string.format(\\"local path = %var_Temp_18:CreatePath(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_554(var_Data_984)))
                                                                                                                    local var_Temp_15 = bj(\\"Path\\", false)
                                                                                                                    var_HTTP_773.registry[var_Temp_15] = \\"path\\"
                                                                                                                    var_Temp_15.ComputeAsync = function(var_Temp_18, start, dest)
                                                                                                                        fn_Event_188(\\"path:ComputeAsync(...)\\")
                                                                                                                        return {}
                                                                                                                    end
                                                                                                                    var_Temp_15.GetWaypoints = function(var_Temp_18) return {} end
                                                                                                                var_Temp_15.CheckOcclusionAsync = function(var_Temp_18) return false end
                                                                                                            return var_Temp_15
                                                                                                        end
                                                                                                    end

                                                                                                    -- 2. TeleportService
                                                                                                    var_Camel_543.Teleport = function(self, cD, var_Player_585, cE, cF)
                                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"TeleportService\\"
                                                                                                        fn_Event_188(
                                                                                                        string.format(
                                                                                                            \\"%var_Temp_18:Teleport(%var_Temp_18, %var_Temp_18%var_Temp_18%var_Temp_18)\\",
                                                                                                            var_HTTP_524,
                                                                                                            fn_Event_554(cD),
                                                                                                            fn_Event_554(var_Player_585),
                                                                                                            cE and \\", \\" .. fn_Event_554(cE) or '\\"',
                                                                                                            cF and \\", \\" .. fn_Event_554(cF) or '\\"'
                                                                                                            )
                                                                                                            )
                                                                                                        end
                                                                                                        var_Camel_543.TeleportToPlaceInstance = function(self, cD, cG, var_Player_585)
                                                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"TeleportService\\"
                                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:TeleportToPlaceInstance(%var_Temp_18, %var_Temp_18, %var_Temp_18)\\", var_HTTP_524, fn_Event_554(cD), fn_Event_554(cG), fn_Event_554(var_Player_585)))
                                                                                                            end

                                                                                                            -- 2. TextService
                                                                                                            if var_Camel_204 == \\"TextService\\" then
                                                                                                                var_Camel_543.GetTextSize = function(self, text, textSize, font, frameSize)
                                                                                                                    fn_Event_188(string.format(\\"local size = %var_Temp_18:GetTextSize(...)\\", var_HTTP_773.registry[var_Event_395]))
                                                                                                                        return Vector2.new(100, 20)
                                                                                                                    end
                                                                                                                end

                                                                                                                -- 2. ContentProvider
                                                                                                                if var_Camel_204 == \\"ContentProvider\\" then
                                                                                                                    var_Camel_543.PreloadAsync = function(self, assets, callback)
                                                                                                                        fn_Event_188(string.format(\\"%var_Temp_18:PreloadAsync(...)\\", var_HTTP_773.registry[var_Event_395]))
                                                                                                                            if callback then callback() end
                                                                                                                    end
                                                                                                                end

                                                                                                                -- 2. Debris
                                                                                                                var_Camel_543.AddItem = function(self, cN, cO)
                                                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"Debris\\"
                                                                                                                    fn_Event_188(string.format(\\"%var_Temp_18:AddItem(%var_Temp_18, %var_Temp_18)\\", var_HTTP_524, fn_Event_554(cN), fn_Event_554(cO or 10)))
                                                                                                                    end

                                                                                                                    -- 2. ContextActionService
                                                                                                                    if var_Camel_204 == \\"ContextActionService\\" then
                                                                                                                        var_Camel_543.BindAction = function(self, name, handler, touchBtn, ...)
                                                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:BindAction(%var_Temp_18, ...)\\", var_HTTP_773.registry[var_Event_395], fn_Event_572(name)))
                                                                                                                            end
                                                                                                                            var_Camel_543.UnbindAction = function(self, name)
                                                                                                                                fn_Event_188(string.format(\\"%var_Temp_18:UnbindAction(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_572(name)))
                                                                                                                                end
                                                                                                                                var_Camel_543.BindActionAtPriority = function(self, name, handler, priority, ...) end
                                                                                                                        end

                                                                                                                        -- 2. GuiService
                                                                                                                        if var_Camel_204 == \\"GuiService\\" then
                                                                                                                            var_Camel_543.GetGuiInset = function(self)
                                                                                                                                return Vector2.new(0, 36)
                                                                                                                            end
                                                                                                                            var_Camel_543.CloseInspectPlayerMenu = function(self) end
                                                                                                                        var_Camel_543.IsTenFootInterface = function(self) return false end
                                                                                                                end

                                                                                                                -- 2. PhysicsService
                                                                                                                if var_Camel_204 == \\"PhysicsService\\" then
                                                                                                                    var_Camel_543.CreateCollisionGroup = function(self, name) return 1 end
                                                                                                                var_Camel_543.CollisionGroupSetCollidable = function(self, g1, g2, col) end
                                                                                                            var_Camel_543.GetCollisionGroupName = function(self, id) return \\"Group\\" end
                                                                                                        var_Camel_543.GetCollisionGroupId = function(self, name) return 1 end
                                                                                                    var_Camel_543.SetPartCollisionGroup = function(self, part, id) end
                                                                                                var_Camel_543.GetPartCollisionGroup = function(self, part) return 1 end
                                                                                        end

                                                                                        -- 2. SoundService
                                                                                        var_Camel_543.PlayLocalSound = function(self, cH)
                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:PlayLocalSound(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_554(cH)))
                                                                                            end

                                                                                            -- 3. Part Methods
                                                                                            var_Camel_543.GetTouchingParts = function(self) return {} end
                                                                                        var_Camel_543.GetConnectedParts = function(self) return {} end
                                                                                    var_Camel_543.GetMass = function(self) return 1 end
                                                                                var_Camel_543.GetNetworkOwner = function(self) return nil end
                                                                            var_Camel_543.SetNetworkOwner = function(self, player) end
                                                                        var_Camel_543.CanSetNetworkOwnership = function(self) return false end
                                                                    var_Camel_543.Resize = function(self, ...) end
                                                                var_Camel_543.BreakJoints = function(self) fn_Event_188(string.format(\\"%var_Temp_18:BreakJoints()\\", var_HTTP_773.registry[var_Event_395])) end
                                                            var_Camel_543.MakeJoints = function(self) fn_Event_188(string.format(\\"%var_Temp_18:MakeJoints()\\", var_HTTP_773.registry[var_Event_395])) end

                                                        -- 3. Model Methods
                                                        var_Camel_543.GetBoundingBox = function(self)
                                                            return CFrame.new(0, 0, 0), Vector3.new(1, 1, 1)
                                                        end
                                                        var_Camel_543.GetExtentsSize = function(self)
                                                            if var_Camel_204 == \\"Character\\" or var_Camel_204 == \\"Model\\" then
                                                                return Vector3.new(4, 5, 2)
                                                            end
                                                            return Vector3.new(1, 1, 1)
                                                        end
                                                        var_Camel_543.MoveTo = function(self, cq, cr)
                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"humanoid\\"
                                                            if cr then
                                                                fn_Event_188(string.format(\\"%var_Temp_18:MoveTo(%var_Temp_18, %var_Temp_18)\\", var_HTTP_524, fn_Event_554(cq), fn_Event_554(cr)))
                                                                else
                                                                fn_Event_188(string.format(\\"%var_Temp_18:MoveTo(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cq)))
                                                                end
                                                            end
                                                            var_Camel_543.TranslateBy = function(self, cx)
                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"model\\"
                                                                fn_Event_188(string.format(\\"%var_Temp_18:TranslateBy(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cx)))
                                                                end
                                                                var_Camel_543.GetPrimaryPartCFrame = function(self)
                                                                    return CFrame.new(0, 0, 0)
                                                                end
                                                                var_Camel_543.SetPrimaryPartCFrame = function(self, cw)
                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"model\\"
                                                                    fn_Event_188(string.format(\\"%var_Temp_18:SetPrimaryPartCFrame(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cw)))
                                                                    end
                                                                    var_Camel_543.PivotTo = function(self, cw)
                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"model\\"
                                                                        fn_Event_188(string.format(\\"%var_Temp_18:PivotTo(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cw)))
                                                                        end
                                                                        var_Camel_543.GetPivot = function(self)
                                                                            return CFrame.new(0, 0, 0)
                                                                        end

                                                                        -- 3. Humanoid Methods
                                                                        var_Camel_543.Move = function(self, ca, cs)
                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"humanoid\\"
                                                                            fn_Event_188(string.format(\\"%var_Temp_18:Move(%var_Temp_18, %var_Temp_18)\\", var_HTTP_524, fn_Event_554(ca), fn_Event_554(cs or false)))
                                                                            end
                                                                            var_Camel_543.EquipTool = function(self, ct)
                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"humanoid\\"
                                                                                fn_Event_188(string.format(\\"%var_Temp_18:EquipTool(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(ct)))
                                                                                end
                                                                                var_Camel_543.UnequipTools = function(self)
                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"humanoid\\"
                                                                                    fn_Event_188(string.format(\\"%var_Temp_18:UnequipTools()\\", var_HTTP_524))
                                                                                    end
                                                                                    var_Camel_543.TakeDamage = function(self, cu)
                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"humanoid\\"
                                                                                        fn_Event_188(string.format(\\"%var_Temp_18:TakeDamage(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cu)))
                                                                                        end
                                                                                        var_Camel_543.ChangeState = function(self, cv)
                                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"humanoid\\"
                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:ChangeState(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cv)))
                                                                                            end
                                                                                            var_Camel_543.GetState = function(self)
                                                                                                return bj(\\"Enum.HumanoidStateType.Running\\", false)
                                                                                            end
                                                                                            var_Camel_543.ApplyDescription = function(self, desc) end
                                                                                        var_Camel_543.GetAppliedDescription = function(self) return {} end
                                                                                    var_Camel_543.AddAccessory = function(self, acc) end
                                                                                var_Camel_543.GetAccessories = function(self) return {} end

                                                                            -- 7. Animation Methods
                                                                            var_Camel_543.LoadAnimation = function(self, cy)
                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"animator\\"
                                                                                local var_Unknown_4458 = bj(\\"animTrack\\", false)
                                                                                local var_Private_589 = fn_Event_471(var_Unknown_4458, \\"animTrack\\")
                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18:LoadAnimation(%var_Temp_18)\\", var_Private_589, var_HTTP_524, fn_Event_554(cy)))
                                                                                    var_HTTP_773.property_store[var_Unknown_4458] = {Length = 1, Loop = true, Priority = Enum.AnimationPriority.Core, Speed = 1, TimePosition = 0, IsPlaying = false}
                                                                                    return var_Unknown_4458
                                                                                end
                                                                                var_Camel_543.GetPlayingAnimationTracks = function(self)
                                                                                    return {}
                                                                                end
                                                                                var_Camel_543.AdjustSpeed = function(self, cA)
                                                                                    local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"animTrack\\"
                                                                                    fn_Event_188(string.format(\\"%var_Temp_18:AdjustSpeed(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cA)))
                                                                                    end
                                                                                    var_Camel_543.AdjustWeight = function(self, cB, cC)
                                                                                        local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or \\"animTrack\\"
                                                                                        if cC then
                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:AdjustWeight(%var_Temp_18, %var_Temp_18)\\", var_HTTP_524, fn_Event_554(cB), fn_Event_554(cC)))
                                                                                            else
                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:AdjustWeight(%var_Temp_18)\\", var_HTTP_524, fn_Event_554(cB)))
                                                                                            end
                                                                                        end

                                                                                        -- 7. AnimationTrack Methods (Mocked in property_store, but methods here for completeness)
                                                                                            if var_Camel_204 == \\"animTrack\\" or var_Camel_204 == \\"AnimationTrack\\" then
                                                                                                var_Camel_543.Play = function(self) fn_Event_188(string.format(\\"%var_Temp_18:Play()\\", var_HTTP_773.registry[var_Event_395])) end
                                                                                            var_Camel_543.Stop = function(self) fn_Event_188(string.format(\\"%var_Temp_18:Stop()\\", var_HTTP_773.registry[var_Event_395])) end
                                                                                        var_Camel_543.GetMarkerReachedSignal = function(self, name) return bj(\\"MarkerReached\\", false) end
                                                                                end

                                                                                -- 9. WebSocket
                                                                                if var_Camel_204 == \\"WebSocket\\" then
                                                                                    var_Camel_543.Connect = function(url)
                                                                                        local var_Event_630 = bj(\\"WebSocketClient\\", false)
                                                                                        var_HTTP_773.registry[var_Event_630] = \\"WebSocket.connect(\\" .. fn_Event_572(url) .. \\")\\"
                                                                                        fn_Event_188(string.format(\\"local %var_Temp_18 = WebSocket.connect(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_630], fn_Event_572(url)))
                                                                                            return var_Event_630
                                                                                        end
                                                                                        var_Camel_543.Send = function(self, data)
                                                                                            fn_Event_188(string.format(\\"%var_Temp_18:Send(%var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_572(data)))
                                                                                            end
                                                                                            var_Camel_543.Close = function(self, code, reason)
                                                                                                fn_Event_188(string.format(\\"%var_Temp_18:Close(%var_Temp_18, %var_Temp_18)\\", var_HTTP_773.registry[var_Event_395], fn_Event_554(code or 1000), fn_Event_572(reason or \\"\\")))
                                                                                                end
                                                                                            end

                                                                                            var_Table_271.__index = function(var_Unknown_3392, var_Unknown_5926)
                                                                                                if var_Unknown_5926 == var_Event_539 or var_Unknown_5926 == \\"__proxy_id\\" then
                                                                                                    return rawget(var_Unknown_3392, var_Unknown_5926)
                                                                                                end
                                                                                                if var_Unknown_5926 == \\"PlaceId\\" or var_Unknown_5926 == \\"GameId\\" or var_Unknown_5926 == \\"placeId\\" or var_Unknown_5926 == \\"gameId\\" then
                                                                                                    return var_Event_411
                                                                                                end
                                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or var_Camel_204 or \\"object\\"
                                                                                                local var_Data_984 = fn_Event_958(var_Unknown_5926)
                                                                                                if var_HTTP_773.property_store[var_Event_395] and var_HTTP_773.property_store[var_Event_395][var_Unknown_5926] ~= nil then
                                                                                                    return var_HTTP_773.property_store[var_Event_395][var_Unknown_5926]
                                                                                                end
                                                                                                if var_Camel_543[var_Data_984] then
                                                                                                    local cQ, cR = fn_Event_281()
                                                                                                    var_HTTP_773.registry[cQ] = var_HTTP_524 .. \\".\\" .. var_Data_984
                                                                                                    cR.__call = function(W, ...)
                                                                                                        local var_Remote_865 = {...}
                                                                                                        if var_Remote_865[1] == var_Event_395 or fn_Event_359(var_Remote_865[1]) and var_Remote_865[1] ~= cQ then
                                                                                                            table.remove(var_Remote_865, 1)
                                                                                                        end
                                                                                                        return var_Camel_543[var_Data_984](var_Event_395, table.unpack(var_Remote_865))
                                                                                                    end
                                                                                                    cR.__index = function(W, cS)
                                                                                                        if cS == var_Event_539 or cS == \\"__proxy_id\\" then
                                                                                                            return rawget(cQ, cS)
                                                                                                        end
                                                                                                        return bj(cS, false, cQ)
                                                                                                    end
                                                                                                    cR.__tostring = function()
                                                                                                        return var_HTTP_524 .. \\":\\" .. var_Data_984
                                                                                                    end
                                                                                                    return cQ
                                                                                                end
                                                                                                if var_HTTP_524 == \\"fenv\\" or var_HTTP_524 == \\"getgenv\\" or var_HTTP_524 == \\"_G\\" then
                                                                                                    if var_Unknown_5926 == \\"game\\" then
                                                                                                        return game
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"workspace\\" then
                                                                                                        return workspace
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"script\\" then
                                                                                                        return script
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"Enum\\" then
                                                                                                        return Enum
                                                                                                    end
                                                                                                    if _G[var_Unknown_5926] ~= nil then
                                                                                                        return _G[var_Unknown_5926]
                                                                                                    end
                                                                                                    return nil
                                                                                                end
                                                                                                if var_Unknown_5926 == \\"Parent\\" then
                                                                                                    return var_HTTP_773.parent_map[var_Event_395] or bj(\\"Parent\\", false)
                                                                                                end
                                                                                                if var_Unknown_5926 == \\"Name\\" then
                                                                                                    return var_Camel_204 or \\"Object\\"
                                                                                                end
                                                                                                if var_Unknown_5926 == \\"ClassName\\" then
                                                                                                    return var_Camel_204 or \\"Instance\\"
                                                                                                end
                                                                                                if var_Unknown_5926 == \\"LocalPlayer\\" then
                                                                                                    local var_Player_264 = bj(\\"LocalPlayer\\", false, var_Event_395)
                                                                                                    local var_Private_589 = fn_Event_471(var_Player_264, \\"LocalPlayer\\")
                                                                                                    fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18.LocalPlayer\\", var_Private_589, var_HTTP_524))
                                                                                                        return var_Player_264
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"leaderstats\\" then
                                                                                                        local var_Data_974 = bj(\\"leaderstats\\", false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[var_Data_974] = {ClassName = \\"Folder\\", Name = \\"leaderstats\\"}
                                                                                                        var_HTTP_773.registry[var_Data_974] = var_HTTP_524 .. \\".leaderstats\\"
                                                                                                        return var_Data_974
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"Backpack\\" then
                                                                                                        local var_HTTP_771 = bj(\\"Backpack\\", false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[var_HTTP_771] = {ClassName = \\"Backpack\\", Name = \\"Backpack\\"}
                                                                                                        var_HTTP_773.registry[var_HTTP_771] = var_HTTP_524 .. \\".Backpack\\"
                                                                                                        return var_HTTP_771
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"PlayerGui\\" then
                                                                                                        return bj(\\"PlayerGui\\", false, var_Event_395)
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"Team\\" then
                                                                                                        local team = bj(\\"Team\\", false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[team] = {Name = \\"Neutral\\", TeamColor = BrickColor.new(\\"White\\")}
                                                                                                        return team
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"UserId\\" then
                                                                                                        return 1
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"DisplayName\\" then
                                                                                                        return \\"Player\\"
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"AccountAge\\" then
                                                                                                        return 1000
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"TeamColor\\" then
                                                                                                        return BrickColor.new(\\"White\\")
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"Character\\" then
                                                                                                        return bj(\\"Character\\", false, var_Event_395)
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"Humanoid\\" then
                                                                                                        local var_Humanoid_950 = bj(\\"Humanoid\\", false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[var_Humanoid_950] = {Health = 100, MaxHealth = 100, WalkSpeed = 16, JumpPower = 50, JumpHeight = 7.2}
                                                                                                        return var_Humanoid_950
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"HumanoidRootPart\\" or var_Unknown_5926 == \\"PrimaryPart\\" or var_Unknown_5926 == \\"RootPart\\" then
                                                                                                        local var_Humanoid_846 = bj(\\"HumanoidRootPart\\", false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[var_Humanoid_846] = {Position = Vector3.new(0, 5, 0), CFrame = CFrame.new(0, 5, 0)}
                                                                                                        return var_Humanoid_846
                                                                                                    end

                                                                                                    local var_String_566 = {
                                                                                                    \\"Head\\", \\"Torso\\", \\"UpperTorso\\", \\"LowerTorso\\",
                                                                                                    \\"RightArm\\", \\"LeftArm\\", \\"RightLeg\\", \\"LeftLeg\\",
                                                                                                    \\"RightHand\\", \\"LeftHand\\", \\"RightFoot\\", \\"LeftFoot\\"
                                                                                                    }
                                                                                                    for W, cr in ipairs(var_String_566) do
                                                                                                        if var_Unknown_5926 == cr then
                                                                                                            local part = bj(cr, false, var_Event_395)
                                                                                                            var_HTTP_773.property_store[part] = {
                                                                                                            Name = cr,
                                                                                                            Size = Vector3.new(1,1,1),
                                                                                                            Position = Vector3.new(0,5,0),
                                                                                                            ClassName = \\"Part\\"
                                                                                                            }
                                                                                                            return part
                                                                                                        end
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"Animator\\" then
                                                                                                        return bj(\\"Animator\\", false, var_Event_395)
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"CurrentCamera\\" or var_Unknown_5926 == \\"Camera\\" then
                                                                                                        local var_Data_276 = bj(\\"Camera\\", false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[var_Data_276] = {
                                                                                                        CFrame = CFrame.new(0, 10, 0),
                                                                                                        FieldOfView = 70,
                                                                                                        ViewportSize = Vector2.new(1920, 1080)
                                                                                                        }
                                                                                                        return var_Data_276
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"CameraType\\" then
                                                                                                        return bj(\\"Enum.CameraType.Custom\\", false)
                                                                                                    end
                                                                                                    if var_Unknown_5926 == \\"CameraSubject\\" then
                                                                                                        return bj(\\"Humanoid\\", false, var_Event_395)
                                                                                                    end

                                                                                                    if var_Camel_204 == \\"Tween\\" and var_Unknown_5926 == \\"Completed\\" then
                                                                                                        return bj(\\"Completed\\", false, var_Event_395)
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"Weld\\" or var_Unknown_5926 == \\"WeldConstraint\\" or var_Unknown_5926 == \\"VectorForce\\" or var_Unknown_5926 == \\"BodyVelocity\\" or var_Unknown_5926 == \\"BodyPosition\\" then
                                                                                                        local phys = bj(var_Unknown_5926, false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[phys] = {
                                                                                                        Name = var_Unknown_5926,
                                                                                                        ClassName = var_Unknown_5926,
                                                                                                        Enabled = true,
                                                                                                        C0 = CFrame.new(),
                                                                                                        C1 = CFrame.new(),
                                                                                                        Force = Vector3.new(0,0,0),
                                                                                                        Velocity = Vector3.new(0,0,0)
                                                                                                        }
                                                                                                        return phys
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"UIListLayout\\" or var_Unknown_5926 == \\"UIGridLayout\\" or var_Unknown_5926 == \\"UIPageLayout\\" then
                                                                                                        local layout = bj(var_Unknown_5926, false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[layout] = {
                                                                                                        Name = var_Unknown_5926,
                                                                                                        ClassName = var_Unknown_5926,
                                                                                                        Padding = UDim.new(0,5),
                                                                                                        FillDirection = Enum.FillDirection.Vertical,
                                                                                                        SortOrder = Enum.SortOrder.LayoutOrder
                                                                                                        }
                                                                                                        return layout
                                                                                                    end

                                                                                                    if var_Unknown_5926 == \\"UIAspectRatioConstraint\\" then
                                                                                                        local aspect = bj(\\"UIAspectRatioConstraint\\", false, var_Event_395)
                                                                                                        var_HTTP_773.property_store[aspect] = {
                                                                                                        Name = \\"UIAspectRatioConstraint\\",
                                                                                                        ClassName = \\"UIAspectRatioConstraint\\",
                                                                                                        AspectRatio = 1
                                                                                                        }
                                                                                                        return aspect
                                                                                                    end

                                                                                                    local var_Humanoid_917 = {
                                                                                                    Health = 100,
                                                                                                    MaxHealth = 100,
                                                                                                    WalkSpeed = 16,
                                                                                                    JumpPower = 50,
                                                                                                    JumpHeight = 7.2,
                                                                                                    HipHeight = 2,
                                                                                                    Transparency = 0,
                                                                                                    Mass = 1,
                                                                                                    Value = 0,
                                                                                                    TimePosition = 0,
                                                                                                    TimeLength = 1,
                                                                                                    Volume = 0.5,
                                                                                                    PlaybackSpeed = 1,
                                                                                                    Brightness = 1,
                                                                                                    Range = 60,
                                                                                                    Angle = 90,
                                                                                                    FieldOfView = 70,
                                                                                                    Size = 1,
                                                                                                    Thickness = 1,
                                                                                                    ZIndex = 1,
                                                                                                    LayoutOrder = 0
                                                                                                    }
                                                                                                    if var_Humanoid_917[var_Unknown_5926] then
                                                                                                        return fn_Event_989(var_Humanoid_917[var_Unknown_5926])
                                                                                                    end
                                                                                                    local var_Camel_045 = {
                                                                                                    Visible = true,
                                                                                                    Enabled = true,
                                                                                                    Anchored = false,
                                                                                                    CanCollide = true,
                                                                                                    Locked = false,
                                                                                                    Active = true,
                                                                                                    Draggable = false,
                                                                                                    Modal = false,
                                                                                                    Playing = false,
                                                                                                    Looped = false,
                                                                                                    IsPlaying = false,
                                                                                                    AutoPlay = false,
                                                                                                    Archivable = true,
                                                                                                    ClipsDescendants = false,
                                                                                                    RichText = false,
                                                                                                    TextWrapped = false,
                                                                                                    TextScaled = false,
                                                                                                    PlatformStand = false,
                                                                                                        AutoRotate = true,
                                                                                                        Sit = false
                                                                                                        }
                                                                                                        if var_Camel_045[var_Unknown_5926] ~= nil then
                                                                                                            return var_Camel_045[var_Unknown_5926]
                                                                                                        end
                                                                                                        if var_Unknown_5926 == \\"AbsoluteSize\\" or var_Unknown_5926 == \\"ViewportSize\\" then
                                                                                                            return Vector2.new(1920, 1080)
                                                                                                        end
                                                                                                        if var_Unknown_5926 == \\"AbsolutePosition\\" then
                                                                                                            return Vector2.new(0, 0)
                                                                                                        end
                                                                                                        if var_Unknown_5926 == \\"Position\\" then
                                                                                                            if var_Camel_204 and (var_Camel_204:match(\\"Part\\") or var_Camel_204:match(\\"Model\\") or var_Camel_204:match(\\"Character\\") or var_Camel_204:match(\\"Root\\")) then
                                                                                                                return Vector3.new(0, 5, 0)
                                                                                                            end
                                                                                                            return UDim2.new(0, 0, 0, 0)
                                                                                                        end
                                                                                                        if var_Unknown_5926 == \\"Size\\" then
                                                                                                            if var_Camel_204 and var_Camel_204:match(\\"Part\\") then
                                                                                                                return Vector3.new(4, 1, 2)
                                                                                                            end
                                                                                                            if var_Camel_204 and var_Camel_204:match(\\"UI\\") then
                                                                                                                return UDim2.new(1, 0, 1, 0)
                                                                                                            end
                                                                                                            return Vector3.new(1, 1, 1)
                                                                                                        end
                                                                                                        if var_Unknown_5926 == \\"Color\\" or var_Unknown_5926 == \\"Color3\\" or var_Unknown_5926 == \\"BackgroundColor3\\" or var_Unknown_5926 == \\"BorderColor3\\" or var_Unknown_5926 == \\"TextColor3\\" or
                                                                                                            var_Unknown_5926 == \\"PlaceholderColor3\\" or
                                                                                                            var_Unknown_5926 == \\"ImageColor3\\"
                                                                                                            then
                                                                                                                return Color3.new(1, 1, 1)
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"BrickColor\\" then
                                                                                                                return BrickColor.new(\\"Medium stone grey\\")
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"Material\\" then
                                                                                                                return bj(\\"Enum.Material.Plastic\\", false)
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"Hit\\" then
                                                                                                                return CFrame.new(0, 0, -10)
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"Origin\\" then
                                                                                                                return CFrame.new(0, 5, 0)
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"Target\\" then
                                                                                                                return bj(\\"Target\\", false, var_Event_395)
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"var_Event_385\\" or var_Unknown_5926 == \\"Y\\" then
                                                                                                                return 0
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"UnitRay\\" then
                                                                                                                return Ray.new(Vector3.new(0, 5, 0), Vector3.new(0, 0, -1))
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"ViewSizeX\\" then
                                                                                                                return 1920
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"ViewSizeY\\" then
                                                                                                                return 1080
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"Text\\" or var_Unknown_5926 == \\"PlaceholderText\\" or var_Unknown_5926 == \\"ContentText\\" or var_Unknown_5926 == \\"Value\\" then
                                                                                                                if var_Temp_18 then
                                                                                                                    return var_Temp_18
                                                                                                                end
                                                                                                                if var_Unknown_5926 == \\"Value\\" then
                                                                                                                    return \\"input\\"
                                                                                                                end
                                                                                                                return '\\"'
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"TextBounds\\" then
                                                                                                                return Vector2.new(0, 0)
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"Font\\" then
                                                                                                                return bj(\\"Enum.Font.SourceSans\\", false)
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"TextSize\\" then
                                                                                                                return 14
                                                                                                            end
                                                                                                            if var_Unknown_5926 == \\"Image\\" or var_Unknown_5926 == \\"ImageContent\\" then
                                                                                                                return '\\"'
                                                                                                            end
                                                                                                            local var_Snake_842 = {
                                                                                                            \\"Changed\\",
                                                                                                            \\"ChildAdded\\",
                                                                                                            \\"ChildRemoved\\",
                                                                                                            \\"DescendantAdded\\",
                                                                                                            \\"DescendantRemoving\\",
                                                                                                            \\"Touched\\",
                                                                                                            \\"TouchEnded\\",
                                                                                                            \\"InputBegan\\",
                                                                                                            \\"InputEnded\\",
                                                                                                            \\"InputChanged\\",
                                                                                                            \\"MouseButton1Click\\",
                                                                                                            \\"MouseButton1Down\\",
                                                                                                            \\"MouseButton1Up\\",
                                                                                                            \\"MouseButton2Click\\",
                                                                                                            \\"MouseButton2Down\\",
                                                                                                            \\"MouseButton2Up\\",
                                                                                                            \\"MouseEnter\\",
                                                                                                            \\"MouseLeave\\",
                                                                                                            \\"MouseMoved\\",
                                                                                                            \\"MouseWheelForward\\",
                                                                                                            \\"MouseWheelBackward\\",
                                                                                                            \\"Activated\\",
                                                                                                            \\"Deactivated\\",
                                                                                                            \\"FocusLost\\",
                                                                                                            \\"FocusGained\\",
                                                                                                            \\"Focused\\",
                                                                                                            \\"Heartbeat\\",
                                                                                                            \\"RenderStepped\\",
                                                                                                            \\"Stepped\\",
                                                                                                            \\"CharacterAdded\\",
                                                                                                            \\"CharacterRemoving\\",
                                                                                                            \\"CharacterAppearanceLoaded\\",
                                                                                                            \\"PlayerAdded\\",
                                                                                                            \\"PlayerRemoving\\",
                                                                                                            \\"AncestryChanged\\",
                                                                                                            \\"AttributeChanged\\",
                                                                                                            \\"Died\\",
                                                                                                            \\"FreeFalling\\",
                                                                                                            \\"GettingUp\\",
                                                                                                            \\"Jumping\\",
                                                                                                            \\"Running\\",
                                                                                                            \\"Seated\\",
                                                                                                            \\"Swimming\\",
                                                                                                            \\"StateChanged\\",
                                                                                                            \\"HealthChanged\\",
                                                                                                            \\"MoveToFinished\\",
                                                                                                            \\"OnClientEvent\\",
                                                                                                            \\"OnServerEvent\\",
                                                                                                            \\"OnClientInvoke\\",
                                                                                                            \\"OnServerInvoke\\",
                                                                                                            \\"Completed\\",
                                                                                                            \\"DidLoop\\",
                                                                                                            \\"Stopped\\",
                                                                                                            \\"Button1Down\\",
                                                                                                            \\"Button1Up\\",
                                                                                                            \\"Button2Down\\",
                                                                                                            \\"Button2Up\\",
                                                                                                            \\"Idle\\",
                                                                                                            \\"Move\\",
                                                                                                            \\"TextChanged\\",
                                                                                                            \\"ReturnPressedFromOnScreenKeyboard\\",
                                                                                                            \\"Triggered\\",
                                                                                                            \\"TriggerEnded\\",
                                                                                                            \\"OnMessage\\",
                                                                                                            \\"OnClose\\"
                                                                                                            }
                                                                                                            for W, d0 in ipairs(var_Snake_842) do
                                                                                                                if var_Unknown_5926 == d0 then
                                                                                                                    local var_Remote_512 = bj(var_HTTP_524 .. \\".\\" .. var_Unknown_5926, false, var_Event_395)
                                                                                                                    var_HTTP_773.registry[var_Remote_512] = var_HTTP_524 .. \\".\\" .. var_Unknown_5926
                                                                                                                    return var_Remote_512
                                                                                                                end
                                                                                                            end
                                                                                                            if var_HTTP_524:match(\\"^Enum\\") then
                                                                                                                local var_String_626 = var_HTTP_524 .. \\".\\" .. var_Data_984
                                                                                                                local var_Unknown_7060 = bj(var_String_626, false)
                                                                                                                var_HTTP_773.registry[var_Unknown_7060] = var_String_626
                                                                                                                return var_Unknown_7060
                                                                                                            end
                                                                                                            return bk(var_Data_984, var_Event_395)
                                                                                                        end
                                                                                                        var_Table_271.__newindex = function(var_Unknown_3392, var_Unknown_5926, var_Table_535)
                                                                                                            if var_Unknown_5926 == var_Event_539 or var_Unknown_5926 == \\"__proxy_id\\" then
                                                                                                                rawset(var_Unknown_3392, var_Unknown_5926, var_Table_535)
                                                                                                                return
                                                                                                            end
                                                                                                            local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or var_Camel_204 or \\"object\\"
                                                                                                            local var_Data_984 = fn_Event_958(var_Unknown_5926)
                                                                                                            var_HTTP_773.property_store[var_Event_395] = var_HTTP_773.property_store[var_Event_395] or {}
                                                                                                            var_HTTP_773.property_store[var_Event_395][var_Unknown_5926] = var_Table_535
                                                                                                            if var_Unknown_5926 == \\"Parent\\" and fn_Event_359(var_Table_535) then
                                                                                                                var_HTTP_773.parent_map[var_Event_395] = var_Table_535
                                                                                                            end
                                                                                                            fn_Event_188(string.format(\\"%var_Temp_18.%var_Temp_18 = %var_Temp_18\\", var_HTTP_524, var_Data_984, fn_Event_554(var_Table_535)))
                                                                                                            end
                                                                                                            var_Table_271.__call = function(var_Unknown_3392, ...)
                                                                                                                local var_HTTP_524 = var_HTTP_773.registry[var_Event_395] or var_Camel_204 or \\"func\\"
                                                                                                                if var_HTTP_524 == \\"fenv\\" or var_HTTP_524 == \\"getgenv\\" or var_HTTP_524:match(\\"env\\") then
                                                                                                                    return var_Event_395
                                                                                                                end
                                                                                                                local var_Remote_865 = {...}
                                                                                                                local var_NPC_163 = {}
                                                                                                                for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                                                    table.insert(var_NPC_163, fn_Event_554(var_Table_535))
                                                                                                                end
                                                                                                                local var_Temp_25 = bj(\\"result\\", false)
                                                                                                                local var_Private_589 = fn_Event_471(var_Temp_25, \\"result\\")
                                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = %var_Temp_18(%var_Temp_18)\\", var_Private_589, var_HTTP_524, table.concat(var_NPC_163, \\", \\")))
                                                                                                                    return var_Temp_25
                                                                                                                end
                                                                                                                local function fn_Event_500(var_Event_440)
                                                                                                                    local function fn_Event_739(var_Event_715, var_Unknown_4594)
                                                                                                                        local var_Event_395, var_Table_271 = fn_Event_281()
                                                                                                                        local var_Unknown_3448 = \\"0\\"
                                                                                                                        if var_Event_715 ~= nil then
                                                                                                                            var_Unknown_3448 = var_HTTP_773.registry[var_Event_715] or fn_Event_554(var_Event_715)
                                                                                                                        end
                                                                                                                        local var_Unknown_6914 = \\"0\\"
                                                                                                                        if var_Unknown_4594 ~= nil then
                                                                                                                            var_Unknown_6914 = var_HTTP_773.registry[var_Unknown_4594] or fn_Event_554(var_Unknown_4594)
                                                                                                                        end
                                                                                                                        local var_Unknown_5062 = \\"(\\" .. var_Unknown_3448 .. \\" \\" .. var_Event_440 .. \\" \\" .. var_Unknown_6914 .. \\")\\"
                                                                                                                        var_HTTP_773.registry[var_Event_395] = var_Unknown_5062
                                                                                                                        var_Table_271.__tostring = function()
                                                                                                                            return var_Unknown_5062
                                                                                                                        end
                                                                                                                        var_Table_271.__call = function()
                                                                                                                            return var_Event_395
                                                                                                                        end
                                                                                                                        var_Table_271.__index = function(W, var_Unknown_5926)
                                                                                                                            if var_Unknown_5926 == var_Event_539 or var_Unknown_5926 == \\"__proxy_id\\" then
                                                                                                                                return rawget(var_Event_395, var_Unknown_5926)
                                                                                                                            end
                                                                                                                            return bj(var_Unknown_5062 .. \\".\\" .. fn_Event_958(var_Unknown_5926), false)
                                                                                                                        end
                                                                                                                        var_Table_271.__add = fn_Event_500(\\"+\\")
                                                                                                                        var_Table_271.__sub = fn_Event_500(\\"-\\")
                                                                                                                        var_Table_271.__mul = fn_Event_500(\\"*\\")
                                                                                                                        var_Table_271.__div = fn_Event_500(\\"/\\")
                                                                                                                        var_Table_271.__mod = fn_Event_500(\\"%\\")
                                                                                                                        var_Table_271.__pow = fn_Event_500(\\"^\\")
                                                                                                                        var_Table_271.__concat = fn_Event_500(\\"..\\")
                                                                                                                        var_Table_271.__eq = function()
                                                                                                                            return false
                                                                                                                        end
                                                                                                                        var_Table_271.__lt = function()
                                                                                                                            return false
                                                                                                                        end
                                                                                                                        var_Table_271.__le = function()
                                                                                                                            return false
                                                                                                                        end
                                                                                                                        return var_Event_395
                                                                                                                    end
                                                                                                                    return fn_Event_739
                                                                                                                end
                                                                                                                var_Table_271.__add = fn_Event_500(\\"+\\")
                                                                                                                var_Table_271.__sub = fn_Event_500(\\"-\\")
                                                                                                                var_Table_271.__mul = fn_Event_500(\\"*\\")
                                                                                                                var_Table_271.__div = fn_Event_500(\\"/\\")
                                                                                                                var_Table_271.__mod = fn_Event_500(\\"%\\")
                                                                                                                var_Table_271.__pow = fn_Event_500(\\"^\\")
                                                                                                                var_Table_271.__concat = fn_Event_500(\\"..\\")
                                                                                                                var_Table_271.__eq = function()
                                                                                                                    return false
                                                                                                                end
                                                                                                                var_Table_271.__lt = function()
                                                                                                                    return false
                                                                                                                end
                                                                                                                var_Table_271.__le = function()
                                                                                                                    return false
                                                                                                                end
                                                                                                                var_Table_271.__unm = function(var_Event_715)
                                                                                                                    local var_Temp_25, d9 = fn_Event_281()
                                                                                                                    var_HTTP_773.registry[var_Temp_25] = \\"(-\\" .. (var_HTTP_773.registry[var_Event_715] or fn_Event_554(var_Event_715)) .. \\")\\"
                                                                                                                    d9.__tostring = function()
                                                                                                                        return var_HTTP_773.registry[var_Temp_25]
                                                                                                                    end
                                                                                                                    return var_Temp_25
                                                                                                                end
                                                                                                                var_Table_271.__len = function()
                                                                                                                    return 0
                                                                                                                end
                                                                                                                var_Table_271.__tostring = function()
                                                                                                                    return var_HTTP_773.registry[var_Event_395] or var_Camel_204 or \\"Object\\"
                                                                                                                end
                                                                                                                var_Table_271.__pairs = function()
                                                                                                                    return function()
                                                                                                                        return nil
                                                                                                                    end, var_Event_395, nil
                                                                                                                end
                                                                                                                var_Table_271.__ipairs = var_Table_271.__pairs
                                                                                                                return var_Event_395
                                                                                                            end

                                                                                                            local function fn_Event_706(var_Event_109, var_Event_170)
                                                                                                                local var_Event_217 = {}
                                                                                                                local var_Event_019 = {}
                                                                                                                var_Event_019.__index = function(var_Unknown_3392, var_Unknown_5926)
                                                                                                                    if var_Unknown_5926 == \\"new\\" or var_Event_170 and var_Event_170[var_Unknown_5926] then
                                                                                                                        return function(...)
                                                                                                                            local var_Remote_865 = {...}
                                                                                                                            local var_NPC_163 = {}
                                                                                                                            for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                                                                table.insert(var_NPC_163, fn_Event_554(var_Table_535))
                                                                                                                            end
                                                                                                                            local var_Unknown_5062 = var_Event_109 .. \\".\\" .. var_Unknown_5926 .. \\"(\\" .. table.concat(var_NPC_163, \\", \\") .. \\")\\"
                                                                                                                            local var_Event_395, de = fn_Event_281()
                                                                                                                            var_HTTP_773.registry[var_Event_395] = var_Unknown_5062
                                                                                                                            de.__tostring = function()
                                                                                                                                return var_Unknown_5062
                                                                                                                            end
                                                                                                                            de.__index = function(W, var_Event_319)
                                                                                                                                if var_Event_319 == var_Event_539 or var_Event_319 == \\"__proxy_id\\" then
                                                                                                                                    return rawget(var_Event_395, var_Event_319)
                                                                                                                                end
                                                                                                                                -- 3. Missing Datatype Operations (Properties)
                                                                                                                                if var_Event_319 == \\"Unit\\" or var_Event_319 == \\"Magnitude\\" then
                                                                                                                                    local var_Transform_862 = 0
                                                                                                                                    if var_Event_109 == \\"Vector3\\" or var_Event_109 == \\"Vector2\\" then var_Transform_862 = 1 end
                                                                                                                                return var_Transform_862
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"var_Event_385\\" or var_Event_319 == \\"Y\\" or var_Event_319 == \\"var_Event_877\\" or var_Event_319 == \\"W\\" then
                                                                                                                                return 0
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"var_Event_838\\" or var_Event_319 == \\"fn_Event_359\\" or var_Event_319 == \\"var_Data_652\\" then
                                                                                                                                return 1
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"Width\\" or var_Event_319 == \\"Height\\" then
                                                                                                                                return UDim.new(0, 0)
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"Position\\" then
                                                                                                                                return var_Event_395
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"CFrame\\" then
                                                                                                                                return var_Event_395
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"LookVector\\" or var_Event_319 == \\"RightVector\\" or var_Event_319 == \\"UpVector\\" then
                                                                                                                                return var_Event_395
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"Rotation\\" then
                                                                                                                                return var_Event_395
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"Min\\" or var_Event_319 == \\"Max\\" then
                                                                                                                                return 0
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"Scale\\" or var_Event_319 == \\"Offset\\" then
                                                                                                                                return 0
                                                                                                                            end
                                                                                                                            if var_Event_319 == \\"var_Temp_15\\" then
                                                                                                                                return var_Event_395
                                                                                                                            end
                                                                                                                            return 0
                                                                                                                        end
                                                                                                                        local function fn_Event_573(var_Event_877)
                                                                                                                            return function(var_Event_715, var_Unknown_4594)
                                                                                                                                local var_NPC_589, dh = fn_Event_281()
                                                                                                                                local var_Event_394 =
                                                                                                                                \\"(\\" .. (var_HTTP_773.registry[var_Event_715] or fn_Event_554(var_Event_715)) .. \\" \\" .. var_Event_877 .. \\" \\" .. (var_HTTP_773.registry[var_Unknown_4594] or fn_Event_554(var_Unknown_4594)) .. \\")\\"
                                                                                                                                var_HTTP_773.registry[var_NPC_589] = var_Event_394
                                                                                                                                dh.__tostring = function()
                                                                                                                                    return var_Event_394
                                                                                                                                end
                                                                                                                                dh.__index = de.__index
                                                                                                                                dh.__add = fn_Event_573(\\"+\\")
                                                                                                                                dh.__sub = fn_Event_573(\\"-\\")
                                                                                                                                dh.__mul = fn_Event_573(\\"*\\")
                                                                                                                                dh.__div = fn_Event_573(\\"/\\")
                                                                                                                                return var_NPC_589
                                                                                                                            end
                                                                                                                        end
                                                                                                                        de.__add = fn_Event_573(\\"+\\")
                                                                                                                        de.__sub = fn_Event_573(\\"-\\")
                                                                                                                        de.__mul = fn_Event_573(\\"*\\")
                                                                                                                        de.__div = fn_Event_573(\\"/\\")
                                                                                                                        de.__unm = function(var_Event_715)
                                                                                                                            local var_NPC_589, dh = fn_Event_281()
                                                                                                                            var_HTTP_773.registry[var_NPC_589] = \\"(-\\" .. (var_HTTP_773.registry[var_Event_715] or fn_Event_554(var_Event_715)) .. \\")\\"
                                                                                                                            dh.__tostring = function()
                                                                                                                                return var_HTTP_773.registry[var_NPC_589]
                                                                                                                            end
                                                                                                                            return var_NPC_589
                                                                                                                        end
                                                                                                                        de.__eq = function()
                                                                                                                            return false
                                                                                                                        end
                                                                                                                        return var_Event_395
                                                                                                                    end
                                                                                                                end
                                                                                                                return nil
                                                                                                            end
                                                                                                            var_Event_019.__call = function(var_Unknown_3392, ...)
                                                                                                                return var_Unknown_3392.new(...)
                                                                                                            end
                                                                                                            return setmetatable(var_Event_217, var_Event_019)
                                                                                                        end

                                                                                                        -- 9. Missing Modern APIs (Buffer)
                                                                                                        local buffer = {}
                                                                                                        function buffer.create(var_Event_773)
                                                                                                            local var_Event_387 = {}
                                                                                                            for var_Iterator_08=1, var_Event_773 do var_Event_387[var_Iterator_08] = 0 end
                                                                                                        return setmetatable(var_Event_387, {
                                                                                                        __type = \\"buffer\\",
                                                                                                        __len = function() return var_Event_773 end,
                                                                                                            __tostring = function() return \\"buffer(\\" .. var_Event_773 .. \\")\\" end
                                                                                                        })
                                                                                                    end
                                                                                                    function buffer.fromstring(str)
                                                                                                        local var_Event_773 = #str
                                                                                                        local var_String_417 = buffer.create(var_Event_773)
                                                                                                        for var_Iterator_08=1, var_Event_773 do var_String_417[var_Iterator_08] = string.byte(str, var_Iterator_08) end
                                                                                                    return var_String_417
                                                                                                end
                                                                                                function buffer.var_Event_773(var_String_417)
                                                                                                    return #var_String_417
                                                                                                end
                                                                                                function buffer.readu8(var_String_417, var_Iterator_08) return var_String_417[var_Iterator_08] or 0 end
                                                                                            function buffer.readi8(var_String_417, var_Iterator_08)
                                                                                                local var_Event_124 = var_String_417[var_Iterator_08] or 0
                                                                                                if var_Event_124 > 127 then var_Event_124 = var_Event_124 - 256 end
                                                                                            return var_Event_124
                                                                                        end
                                                                                        function buffer.readu16(var_String_417, var_Iterator_08)
                                                                                            local var_Event_702 = var_String_417[var_Iterator_08] or 0
                                                                                            local var_Unknown_0777 = var_String_417[var_Iterator_08+1] or 0
                                                                                            return bit.bor(var_Event_702, bit.lshift(var_Unknown_0777, 8))
                                                                                            end
                                                                                            function buffer.readi16(var_String_417, var_Iterator_08)
                                                                                                local var_Event_124 = buffer.readu16(var_String_417, var_Iterator_08)
                                                                                                if var_Event_124 > 32767 then var_Event_124 = var_Event_124 - 65536 end
                                                                                            return var_Event_124
                                                                                        end
                                                                                        function buffer.readu32(var_String_417, var_Iterator_08)
                                                                                            local var_Event_106 = var_String_417[var_Iterator_08] or 0
                                                                                            local var_Unknown_3392 = var_String_417[var_Iterator_08+1] or 0
                                                                                            local var_HTTP_647 = var_String_417[var_Iterator_08+2] or 0
                                                                                            local var_Unknown_5926 = var_String_417[var_Iterator_08+3] or 0
                                                                                            return bit.bor(var_Event_106, bit.lshift(var_Unknown_3392, 8), bit.lshift(var_HTTP_647, 16), bit.lshift(var_Unknown_5926, 24))
                                                                                            end
                                                                                            function buffer.readi32(var_String_417, var_Iterator_08)
                                                                                                local var_Event_124 = buffer.readu32(var_String_417, var_Iterator_08)
                                                                                                if var_Event_124 > 2147483647 then var_Event_124 = var_Event_124 - 4294967296 end
                                                                                            return var_Event_124
                                                                                        end
                                                                                        function buffer.readf32(var_String_417, var_Iterator_08)
                                                                                            local var_Event_434 = buffer.readu32(var_String_417, var_Iterator_08)
                                                                                            return var_Event_434 -- Placeholder
                                                                                        end
                                                                                        function buffer.readf64(var_String_417, var_Iterator_08) return 0 end
                                                                                    function buffer.writeu8(var_String_417, var_Iterator_08, var_Event_124) var_String_417[var_Iterator_08] = var_Event_124 end
                                                                                function buffer.writei8(var_String_417, var_Iterator_08, var_Event_124) var_String_417[var_Iterator_08] = var_Event_124 end
                                                                            function buffer.writeu16(var_String_417, var_Iterator_08, var_Event_124)
                                                                                var_String_417[var_Iterator_08] = bit.band(var_Event_124, 0xFF)
                                                                                var_String_417[var_Iterator_08+1] = bit.band(bit.rshift(var_Event_124, 8), 0xFF)
                                                                                end
                                                                                function buffer.writei16(var_String_417, var_Iterator_08, var_Event_124) buffer.writeu16(var_String_417, var_Iterator_08, var_Event_124) end
                                                                            function buffer.writeu32(var_String_417, var_Iterator_08, var_Event_124)
                                                                                var_String_417[var_Iterator_08] = bit.band(var_Event_124, 0xFF)
                                                                                var_String_417[var_Iterator_08+1] = bit.band(bit.rshift(var_Event_124, 8), 0xFF)
                                                                                    var_String_417[var_Iterator_08+2] = bit.band(bit.rshift(var_Event_124, 16), 0xFF)
                                                                                        var_String_417[var_Iterator_08+3] = bit.band(bit.rshift(var_Event_124, 24), 0xFF)
                                                                                        end
                                                                                        function buffer.writei32(var_String_417, var_Iterator_08, var_Event_124) buffer.writeu32(var_String_417, var_Iterator_08, var_Event_124) end
                                                                                    function buffer.writef32(var_String_417, var_Iterator_08, var_Event_124) buffer.writeu32(var_String_417, var_Iterator_08, 0) end
                                                                                function buffer.writef64(var_String_417, var_Iterator_08, var_Event_124) end
                                                                            function buffer.copy(to, to_offset, from, from_offset, var_Event_773)
                                                                                for var_Iterator_08=0, var_Event_773-1 do
                                                                                    to[to_offset + var_Iterator_08] = from[from_offset + var_Iterator_08]
                                                                                end
                                                                            end
                                                                            function buffer.fill(var_String_417, offset, value, size)
                                                                                for var_Iterator_08=offset, offset+size-1 do
                                                                                    var_String_417[var_Iterator_08] = value
                                                                                end
                                                                            end
                                                                            _G.buffer = buffer

                                                                            -- Datatypes
                                                                            Vector3 = fn_Event_706(\\"Vector3\\", {new = true, zero = true, one = true})
                                                                            Vector2 = fn_Event_706(\\"Vector2\\", {new = true, zero = true, one = true})
                                                                            UDim = fn_Event_706(\\"UDim\\", {new = true})
                                                                            UDim2 = fn_Event_706(\\"UDim2\\", {new = true, fromScale = true, fromOffset = true})
                                                                            CFrame =
                                                                            fn_Event_706(
                                                                            \\"CFrame\\",
                                                                            {
                                                                            new = true,
                                                                            Angles = true,
                                                                            lookAt = true,
                                                                            fromEulerAnglesXYZ = true,
                                                                            fromEulerAnglesYXZ = true,
                                                                            fromAxisAngle = true,
                                                                            fromMatrix = true,
                                                                            fromOrientation = true,
                                                                            identity = true
                                                                            }
                                                                            )
                                                                            Color3 = fn_Event_706(\\"Color3\\", {new = true, fromRGB = true, fromHSV = true, fromHex = true})
                                                                            BrickColor =
                                                                            fn_Event_706(
                                                                            \\"BrickColor\\",
                                                                            {
                                                                            new = true,
                                                                            random = true,
                                                                                White = true,
                                                                                Black = true,
                                                                                Red = true,
                                                                                Blue = true,
                                                                                Green = true,
                                                                                Yellow = true,
                                                                                palette = true
                                                                                }
                                                                                )
                                                                                TweenInfo = fn_Event_706(\\"TweenInfo\\", {new = true})
                                                                                Rect = fn_Event_706(\\"Rect\\", {new = true})
                                                                                Region3 = fn_Event_706(\\"Region3\\", {new = true})
                                                                                Region3int16 = fn_Event_706(\\"Region3int16\\", {new = true})
                                                                                Ray = fn_Event_706(\\"Ray\\", {new = true})
                                                                                NumberRange = fn_Event_706(\\"NumberRange\\", {new = true})
                                                                                NumberSequence = fn_Event_706(\\"NumberSequence\\", {new = true})
                                                                                ColorSequence = fn_Event_706(\\"ColorSequence\\", {new = true})
                                                                                NumberSequenceKeypoint = fn_Event_706(\\"NumberSequenceKeypoint\\", {new = true})
                                                                                ColorSequenceKeypoint = fn_Event_706(\\"ColorSequenceKeypoint\\", {new = true})
                                                                                PhysicalProperties = fn_Event_706(\\"PhysicalProperties\\", {new = true})
                                                                                Font = fn_Event_706(\\"Font\\", {new = true, fromEnum = true, fromName = true, fromId = true})
                                                                                RaycastParams = fn_Event_706(\\"RaycastParams\\", {new = true})
                                                                                OverlapParams = fn_Event_706(\\"OverlapParams\\", {new = true})
                                                                                PathWaypoint = fn_Event_706(\\"PathWaypoint\\", {new = true})
                                                                                Faces = fn_Event_706(\\"Faces\\", {new = true})
                                                                                Axes = fn_Event_706(\\"Axes\\", {new = true})
                                                                                Vector3int16 = fn_Event_706(\\"Vector3int16\\", {new = true})
                                                                                Vector2int16 = fn_Event_706(\\"Vector2int16\\", {new = true})
                                                                                CatalogSearchParams = fn_Event_706(\\"CatalogSearchParams\\", {new = true})
                                                                                DateTime = fn_Event_706(\\"DateTime\\", {now = true, fromUnixTimestamp = true, fromUnixTimestampMillis = true, fromIsoDate = true})
                                                                                Random = {new = function(di)
                                                                                    local var_Event_148 = {}
                                                                                    function var_Event_148:NextNumber(dj, dk)
                                                                                        return (dj or 0) + 0.5 * ((dk or 1) - (dj or 0))
                                                                                    end
                                                                                    function var_Event_148:NextInteger(dj, dk)
                                                                                        return math.floor((dj or 1) + 0.5 * ((dk or 100) - (dj or 1)))
                                                                                    end
                                                                                    function var_Event_148:NextUnitVector()
                                                                                        return Vector3.new(0.577, 0.577, 0.577)
                                                                                    end
                                                                                    function var_Event_148:Shuffle(dl)
                                                                                        return dl
                                                                                    end
                                                                                    function var_Event_148:Clone()
                                                                                        return Random.new()
                                                                                        end
                                                                                        return var_Event_148
                                                                                    end}
                                                                                    setmetatable(
                                                                                    Random,
                                                                                        {__call = function(var_Unknown_3392, di)
                                                                                            return var_Unknown_3392.new(di)
                                                                                        end}
                                                                                        )
                                                                                        Enum = bj(\\"Enum\\", true)
                                                                                        local var_HTTP_891 = var_Temp_00.getmetatable(Enum)
                                                                                        var_HTTP_891.__index = function(var_Unknown_3392, var_Unknown_5926)
                                                                                            if var_Unknown_5926 == var_Event_539 or var_Unknown_5926 == \\"__proxy_id\\" then
                                                                                                return rawget(var_Unknown_3392, var_Unknown_5926)
                                                                                            end
                                                                                            local var_Unknown_1976 = bj(\\"Enum.\\" .. fn_Event_958(var_Unknown_5926), false)
                                                                                            var_HTTP_773.registry[var_Unknown_1976] = \\"Enum.\\" .. fn_Event_958(var_Unknown_5926)
                                                                                            return var_Unknown_1976
                                                                                        end
                                                                                        Instance = {new = function(bX, var_HTTP_524)
                                                                                            local var_Event_778 = fn_Event_958(bX)
                                                                                            local var_Event_148 = bj(var_Event_778, false)
                                                                                            local var_Private_589 = fn_Event_471(var_Event_148, var_Event_778)
                                                                                            if var_HTTP_524 then
                                                                                                local var_Instance_111 = var_HTTP_773.registry[var_HTTP_524] or fn_Event_554(var_HTTP_524)
                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = Instance.new(%var_Temp_18, %var_Temp_18)\\", var_Private_589, fn_Event_572(var_Event_778), var_Instance_111))
                                                                                                    var_HTTP_773.parent_map[var_Event_148] = var_HTTP_524
                                                                                                else
                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = Instance.new(%var_Temp_18)\\", var_Private_589, fn_Event_572(var_Event_778)))
                                                                                                end
                                                                                                return var_Event_148
                                                                                            end,
                                                                                            fromExisting = function(instance)
                                                                                                local var_Event_778 = fn_Event_958(instance) or \\"Object\\"
                                                                                                local var_Event_148 = bj(var_Event_778 .. \\"Copy\\", false)
                                                                                                local var_Private_589 = fn_Event_471(var_Event_148, var_Event_778 .. \\"Copy\\")
                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = Instance.fromExisting(%var_Temp_18)\\", var_Private_589, fn_Event_554(instance)))
                                                                                                    return var_Event_148
                                                                                                end
                                                                                                }
                                                                                                game = bj(\\"game\\", true)
                                                                                                workspace = bj(\\"workspace\\", true)
                                                                                                script = bj(\\"script\\", true)
                                                                                                var_HTTP_773.property_store[script] = {Name = \\"DumpedScript\\", Parent = game, ClassName = \\"LocalScript\\"}

                                                                                                -- 5. Missing Player/Character Properties (UserInputService & Player)
                                                                                                local var_Player_866 = bj(\\"UserInputService\\", true)
                                                                                                local uis_props = var_HTTP_773.property_store[var_Player_866] or {}
                                                                                                uis_props.InputBegan = bj(\\"InputBegan\\", false, var_Player_866)
                                                                                                uis_props.InputEnded = bj(\\"InputEnded\\", false, var_Player_866)
                                                                                                uis_props.InputChanged = bj(\\"InputChanged\\", false, var_Player_866)
                                                                                                var_HTTP_773.property_store[var_Player_866] = uis_props
                                                                                                _G.UserInputService = var_Player_866

                                                                                                local function mock_settings()
                                                                                                    return {
                                                                                                    GetFFlag = function(name) return false end,
                                                                                                        GetFVariable = function(name) return \\"\\" end,
                                                                                                            SetFFlag = function(name, var_Transform_862) end
                                                                                                        }
                                                                                                    end
                                                                                                    _G.settings = mock_settings
                                                                                                    _G.setfflag = function(name, var_Transform_862) end
                                                                                                _G.getfflag = function(name) return false end

                                                                                            local function mock_UserSettings()
                                                                                                return {
                                                                                                GameSettings = {
                                                                                                TouchCameraMovementMode = Enum.TouchCameraMovementMode.Default,
                                                                                                VideoQuality = Enum.VideoQualityLevel.High,
                                                                                                SaveQuality = \\"QualityLevel1\\"
                                                                                                }
                                                                                                }
                                                                                            end
                                                                                            _G.UserSettings = mock_UserSettings
                                                                                            _G.UserGameSettings = mock_UserSettings().GameSettings

                                                                                            task = {
                                                                                            wait = function(dq)
                                                                                                if dq then
                                                                                                    fn_Event_188(string.format(\\"task.wait(%var_Temp_18)\\", fn_Event_554(dq)))
                                                                                                    else
                                                                                                    fn_Event_188(\\"task.wait()\\")
                                                                                                end
                                                                                                return dq or 0.03, var_Temp_15.clock()
                                                                                            end,
                                                                                            spawn = function(var_Unknown_7301, ...)
                                                                                                local var_Remote_865 = {...}
                                                                                                fn_Event_188(\\"task.spawn(function()\\")
                                                                                                    var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                                                    if var_HTTP_095(var_Unknown_7301) == \\"function\\" then
                                                                                                        xpcall(
                                                                                                        function()
                                                                                                            var_Unknown_7301(table.unpack(var_Remote_865))
                                                                                                        end,
                                                                                                        function(var_Math_456)
                                                                                                            fn_Event_188(\\"-- [Error in spawn] \\" .. tostring(var_Math_456))
                                                                                                        end
                                                                                                        )
                                                                                                    end
                                                                                                    while var_HTTP_773.pending_iterator do
                                                                                                        var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                        fn_Event_188(\\"end\\")
                                                                                                        var_HTTP_773.pending_iterator = false
                                                                                                    end
                                                                                                    var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                    fn_Event_188(\\"end)\\")
                                                                                                end,
                                                                                                delay = function(dq, var_Unknown_7301, ...)
                                                                                                    local var_Remote_865 = {...}
                                                                                                    fn_Event_188(string.format(\\"task.delay(%var_Temp_18, function()\\", fn_Event_554(dq or 0)))
                                                                                                        var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                                                        if var_HTTP_095(var_Unknown_7301) == \\"function\\" then
                                                                                                            xpcall(
                                                                                                            function()
                                                                                                                var_Unknown_7301(table.unpack(var_Remote_865))
                                                                                                            end,
                                                                                                            function()
                                                                                                            end
                                                                                                            )
                                                                                                        end
                                                                                                        while var_HTTP_773.pending_iterator do
                                                                                                            var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                            fn_Event_188(\\"end\\")
                                                                                                            var_HTTP_773.pending_iterator = false
                                                                                                        end
                                                                                                        var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                        fn_Event_188(\\"end)\\")
                                                                                                    end,
                                                                                                    defer = function(var_Unknown_7301, ...)
                                                                                                        local var_Remote_865 = {...}
                                                                                                        fn_Event_188(\\"task.defer(function()\\")
                                                                                                            var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                                                            if var_HTTP_095(var_Unknown_7301) == \\"function\\" then
                                                                                                                xpcall(
                                                                                                                function()
                                                                                                                    var_Unknown_7301(table.unpack(var_Remote_865))
                                                                                                                end,
                                                                                                                function()
                                                                                                                end
                                                                                                                )
                                                                                                            end
                                                                                                            var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                            fn_Event_188(\\"end)\\")
                                                                                                        end,
                                                                                                        cancel = function(dt)
                                                                                                            fn_Event_188(\\"task.cancel(thread)\\")
                                                                                                        end,
                                                                                                        synchronize = function()
                                                                                                            fn_Event_188(\\"task.synchronize()\\")
                                                                                                        end,
                                                                                                        desynchronize = function()
                                                                                                            fn_Event_188(\\"task.desynchronize()\\")
                                                                                                        end
                                                                                                        }
                                                                                                        wait = function(dq)
                                                                                                            if dq then
                                                                                                                fn_Event_188(string.format(\\"wait(%var_Temp_18)\\", fn_Event_554(dq)))
                                                                                                                else
                                                                                                                fn_Event_188(\\"wait()\\")
                                                                                                            end
                                                                                                            return dq or 0.03, var_Temp_15.clock()
                                                                                                        end
                                                                                                        delay = function(dq, var_Unknown_7301)
                                                                                                            fn_Event_188(string.format(\\"delay(%var_Temp_18, function()\\", fn_Event_554(dq or 0)))
                                                                                                                var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                                                                if var_HTTP_095(var_Unknown_7301) == \\"function\\" then
                                                                                                                    xpcall(
                                                                                                                    var_Unknown_7301,
                                                                                                                    function()
                                                                                                                    end
                                                                                                                    )
                                                                                                                end
                                                                                                                var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                                fn_Event_188(\\"end)\\")
                                                                                                            end
                                                                                                            spawn = function(var_Unknown_7301)
                                                                                                                fn_Event_188(\\"spawn(function()\\")
                                                                                                                    var_HTTP_773.indent = var_HTTP_773.indent + 1
                                                                                                                    if var_HTTP_095(var_Unknown_7301) == \\"function\\" then
                                                                                                                        xpcall(
                                                                                                                        var_Unknown_7301,
                                                                                                                        function()
                                                                                                                        end
                                                                                                                        )
                                                                                                                    end
                                                                                                                    var_HTTP_773.indent = var_HTTP_773.indent - 1
                                                                                                                    fn_Event_188(\\"end)\\")
                                                                                                                end
                                                                                                                tick = function()
                                                                                                                    return var_Temp_15.time()
                                                                                                                end
                                                                                                                time = function()
                                                                                                                    return var_Temp_15.clock()
                                                                                                                end
                                                                                                                elapsedTime = function()
                                                                                                                    return var_Temp_15.clock()
                                                                                                                end
                                                                                                                local var_Unknown_3439 = {}
                                                                                                                local var_Event_844 = 999999999
                                                                                                                local function fn_Event_164(var_Event_319, var_Event_270)
                                                                                                                    return var_Event_270
                                                                                                                end
                                                                                                                local function fn_Event_602()
                                                                                                                    local var_Unknown_3392 = {}
                                                                                                                    setmetatable(
                                                                                                                    var_Unknown_3392,
                                                                                                                    {__call = function(self, ...)
                                                                                                                        return self
                                                                                                                    end, __index = function(self, var_Unknown_5926)
                                                                                                                        if _G[var_Unknown_5926] ~= nil then
                                                                                                                            return fn_Event_164(var_Unknown_5926, _G[var_Unknown_5926])
                                                                                                                        end
                                                                                                                        if var_Unknown_5926 == \\"game\\" then
                                                                                                                            return game
                                                                                                                        end
                                                                                                                        if var_Unknown_5926 == \\"workspace\\" then
                                                                                                                            return workspace
                                                                                                                        end
                                                                                                                        if var_Unknown_5926 == \\"script\\" then
                                                                                                                            return script
                                                                                                                        end
                                                                                                                        if var_Unknown_5926 == \\"Enum\\" then
                                                                                                                            return Enum
                                                                                                                        end
                                                                                                                        return nil
                                                                                                                    end, __newindex = function(self, var_Unknown_5926, var_Table_535)
                                                                                                                        _G[var_Unknown_5926] = var_Table_535
                                                                                                                        var_Unknown_3439[var_Unknown_5926] = 0
                                                                                                                        fn_Event_188(string.format(\\"_G.%var_Temp_18 = %var_Temp_18\\", fn_Event_958(var_Unknown_5926), fn_Event_554(var_Table_535)))
                                                                                                                        end}
                                                                                                                        )
                                                                                                                        return var_Unknown_3392
                                                                                                                    end
                                                                                                                    _G.fn_Event_359 = fn_Event_602()
                                                                                                                    _G.var_Data_766 = fn_Event_602()
                                                                                                                    _G.ENV = fn_Event_602()
                                                                                                                    _G.env = fn_Event_602()
                                                                                                                    _G.var_NPC_677 = fn_Event_602()
                                                                                                                    _G.var_Data_859 = fn_Event_602()
                                                                                                                    _G.var_Unknown_8967 = fn_Event_602()
                                                                                                                    _G.var_HTTP_001 = fn_Event_602()
                                                                                                                    _G.var_Event_539 = fn_Event_602()
                                                                                                                    _G.var_Data_385 = fn_Event_602()
                                                                                                                    local function fn_Event_631(var_Event_138)
                                                                                                                        local var_Event_395 = {}
                                                                                                                        local var_Event_019 = {}
                                                                                                                        local var_Event_928 = {
                                                                                                                        \\"hookfunction\\",
                                                                                                                            \\"hookmetamethod\\",
                                                                                                                            \\"newcclosure\\",
                                                                                                                            \\"replaceclosure\\",
                                                                                                                            \\"checkcaller\\",
                                                                                                                            \\"iscclosure\\",
                                                                                                                            \\"islclosure\\",
                                                                                                                            \\"getrawmetatable\\",
                                                                                                                            \\"setreadonly\\",
                                                                                                                                \\"make_writeable\\",
                                                                                                                                \\"getrenv\\",
                                                                                                                                \\"getgc\\",
                                                                                                                                \\"getinstances\\"
                                                                                                                                }
                                                                                                                                local function fn_HTTP_463(var_Event_332, var_Event_319)
                                                                                                                                    local var_Event_015 = fn_Event_958(var_Event_319)
                                                                                                                                    if var_Event_015:match(\\"^[%var_Event_349][%w_]*$\\") then
                                                                                                                                        if var_Event_332 then
                                                                                                                                            return var_Event_332 .. \\".\\" .. var_Event_015
                                                                                                                                        end
                                                                                                                                        return var_Event_015
                                                                                                                                    else
                                                                                                                                    local var_String_498 = var_Event_015:gsub(\\"'\\", \\"\\\\\\\\'\\")
                                                                                                                                    if var_Event_332 then
                                                                                                                                        return var_Event_332 .. \\"['\\" .. var_String_498 .. \\"']\\"
                                                                                                                                    end
                                                                                                                                    return \\"['\\" .. var_String_498 .. \\"']\\"
                                                                                                                                end
                                                                                                                            end
                                                                                                                            var_Event_019.__index = function(var_Unknown_3392, var_Unknown_5926)
                                                                                                                                for W, dE in ipairs(var_Event_928) do
                                                                                                                                    if var_Unknown_5926 == dE then
                                                                                                                                        return nil
                                                                                                                                    end
                                                                                                                                end
                                                                                                                                local var_Camel_859 = fn_HTTP_463(var_Event_138, var_Unknown_5926)
                                                                                                                                return fn_Event_631(var_Camel_859)
                                                                                                                            end
                                                                                                                            var_Event_019.__newindex = function(var_Unknown_3392, var_Unknown_5926, var_Table_535)
                                                                                                                                local var_HTTP_167 = fn_HTTP_463(var_Event_138, var_Unknown_5926)
                                                                                                                                fn_Event_188(string.format(\\"getgenv().%var_Temp_18 = %var_Temp_18\\", var_HTTP_167, fn_Event_554(var_Table_535)))
                                                                                                                                end
                                                                                                                                var_Event_019.__call = function(var_Unknown_3392, ...)
                                                                                                                                    return var_Unknown_3392
                                                                                                                                end
                                                                                                                                var_Event_019.__pairs = function()
                                                                                                                                    return function()
                                                                                                                                        return nil
                                                                                                                                    end, nil, nil
                                                                                                                                end
                                                                                                                                return setmetatable(var_Event_395, var_Event_019)
                                                                                                                            end
                                                                                                                            local exploit_funcs = {getgenv = function()
                                                                                                                                return fn_Event_631(nil)
                                                                                                                            end, getrenv = function()
                                                                                                                                return bj(\\"getrenv()\\", false)
                                                                                                                            end, getfenv = function(dH)
                                                                                                                                return _G
                                                                                                                            end, setfenv = function(dI, dJ)
                                                                                                                                if var_HTTP_095(dI) ~= \\"function\\" then
                                                                                                                                    return
                                                                                                                                end
                                                                                                                                local var_Unknown_8967 = 1
                                                                                                                                while true do
                                                                                                                                    local var_Event_109 = debug.getupvalue(dI, var_Unknown_8967)
                                                                                                                                    if var_Event_109 == \\"_ENV\\" then
                                                                                                                                        debug.setupvalue(dI, var_Unknown_8967, dJ)
                                                                                                                                        break
                                                                                                                                    elseif not var_Event_109 then
                                                                                                                                        break
                                                                                                                                    end
                                                                                                                                    var_Unknown_8967 = var_Unknown_8967 + 1
                                                                                                                                end
                                                                                                                                return dI
                                                                                                                            end, hookfunction = function(dK, dL)
                                                                                                                                return dK
                                                                                                                            end, hookmetamethod = function(var_Event_148, dM, dN)
                                                                                                                                return function()
                                                                                                                                end
                                                                                                                            end, getrawmetatable = function(var_Event_148)
                                                                                                                                if fn_Event_359(var_Event_148) then
                                                                                                                                    return var_Temp_00.getmetatable(var_Event_148)
                                                                                                                                end
                                                                                                                                return {}
                                                                                                                            end, setrawmetatable = function(var_Event_148, var_Event_019)
                                                                                                                                return var_Event_148
                                                                                                                            end, getnamecallmethod = function()
                                                                                                                                return \\"__namecall\\"
                                                                                                                            end, setnamecallmethod = function(dM)
                                                                                                                            end, checkcaller = function()
                                                                                                                                return true
                                                                                                                            end, islclosure = function(var_Unknown_7301)
                                                                                                                                return var_HTTP_095(var_Unknown_7301) == \\"function\\"
                                                                                                                                end, iscclosure = function(var_Unknown_7301)
                                                                                                                                    return false
                                                                                                                                end, newcclosure = function(var_Unknown_7301)
                                                                                                                                    return var_Unknown_7301
                                                                                                                                end, clonefunction = function(var_Unknown_7301)
                                                                                                                                    return var_Unknown_7301
                                                                                                                                end,
                                                                                                                                cloneref = function(inst)
                                                                                                                                    fn_Event_188(string.format(\\"local var_Event_907 = cloneref(%var_Temp_18)\\", fn_Event_554(inst)))
                                                                                                                                        return inst
                                                                                                                                    end, compareinstances = function(i1, i2)
                                                                                                                                        return i1 == i2
                                                                                                                                    end, gethwid = function()
                                                                                                                                        return \\"PENGU-DEVICE-ID-12345\\"
                                                                                                                                    end, request = function(dO)
                                                                                                                                        fn_Event_188(string.format(\\"request(%var_Temp_18)\\", fn_Event_554(dO)))
                                                                                                                                            table.insert(var_HTTP_773.string_refs, {value = dO.Url or dO.url or \\"unknown\\", hint = \\"HTTP Request\\"})
                                                                                                                                            return {Success = true, StatusCode = 200, StatusMessage = \\"OK\\", Headers = {}, Body = \\"{}\\"}
                                                                                                                                        end, http_request = function(dO)
                                                                                                                                            return exploit_funcs.request(dO)
                                                                                                                                        end, syn = {request = function(dO)
                                                                                                                                            return exploit_funcs.request(dO)
                                                                                                                                        end}, http = {request = function(dO)
                                                                                                                                            return exploit_funcs.request(dO)
                                                                                                                                        end}, HttpPost = function(var_HTTP_119, cJ)
                                                                                                                                            fn_Event_188(string.format(\\"HttpPost(%var_Temp_18, %var_Temp_18)\\", fn_Event_958(var_HTTP_119), fn_Event_958(cJ)))
                                                                                                                                                return \\"{}\\"
                                                                                                                                            end, setclipboard = function(cJ)
                                                                                                                                                fn_Event_188(string.format(\\"setclipboard(%var_Temp_18)\\", fn_Event_554(cJ)))
                                                                                                                                                end, getclipboard = function()
                                                                                                                                                    return '\\"'
                                                                                                                                                end, identifyexecutor = function()
                                                                                                                                                    return \\"PenguEnv V0.63\\", \\"3.0\\"
                                                                                                                                                end, getexecutorname = function()
                                                                                                                                                    return \\"PenguEnv\\"
                                                                                                                                                end, gethui = function()
                                                                                                                                                    local var_UI_902 = bj(\\"HiddenUI\\", false)
                                                                                                                                                    fn_Event_471(var_UI_902, \\"HiddenUI\\")
                                                                                                                                                    fn_Event_188(string.format(\\"local %var_Temp_18 = gethui()\\", var_HTTP_773.registry[var_UI_902]))
                                                                                                                                                        return var_UI_902
                                                                                                                                                    end, gethiddenui = function()
                                                                                                                                                        return exploit_funcs.gethui()
                                                                                                                                                    end, protectgui = function(dQ)
                                                                                                                                                    end, iswindowactive = function()
                                                                                                                                                        return true
                                                                                                                                                    end, isrbxactive = function()
                                                                                                                                                        return true
                                                                                                                                                    end, isgameactive = function()
                                                                                                                                                        return true
                                                                                                                                                    end, getconnections = function(var_Remote_512)
                                                                                                                                                        return {}
                                                                                                                                                    end, firesignal = function(var_Remote_512, ...)
                                                                                                                                                    end, fireclickdetector = function(dR, dS)
                                                                                                                                                    end, fireproximityprompt = function(dT)
                                                                                                                                                    end, firetouchinterest = function(dU, dV, dW)
                                                                                                                                                    end, getinstances = function()
                                                                                                                                                        return {}
                                                                                                                                                    end, getnilinstances = function()
                                                                                                                                                        return {}
                                                                                                                                                    end, getgc = function()
                                                                                                                                                        return {}
                                                                                                                                                    end, getscripts = function()
                                                                                                                                                        return {}
                                                                                                                                                    end, getrunningscripts = function()
                                                                                                                                                        return {}
                                                                                                                                                    end, getloadedmodules = function()
                                                                                                                                                        return {}
                                                                                                                                                    end, getcallingscript = function()
                                                                                                                                                        return script
                                                                                                                                                    end, readfile = function(var_Event_138)
                                                                                                                                                        if var_Event_138:find(\\"..\\") or var_Event_138:find(\\"/\\") or var_Event_138:find(\\"\\\\\\") then
                                                                                                                                                            error(\\"[PenguEnv Security] Blocked readfile access to invalid path.\\")
                                                                                                                                                            return \\"\\"
                                                                                                                                                        end
                                                                                                                                                        fn_Event_188(string.format(\\"readfile(%var_Temp_18)\\", fn_Event_572(var_Event_138)))
                                                                                                                                                            return '\\"'
                                                                                                                                                        end, writefile = function(var_Event_138, var_String_018)
                                                                                                                                                            if var_Event_138:find(\\"..\\") or var_Event_138:find(\\"/\\") or var_Event_138:find(\\"\\\\\\") then
                                                                                                                                                                error(\\"[PenguEnv Security] Blocked writefile access to invalid path.\\")
                                                                                                                                                                return
                                                                                                                                                            end
                                                                                                                                                            fn_Event_188(string.format(\\"writefile(%var_Temp_18, %var_Temp_18)\\", fn_Event_572(var_Event_138), fn_Event_554(var_String_018)))
                                                                                                                                                            end, appendfile = function(var_Event_138, var_String_018)
                                                                                                                                                                if var_Event_138:find(\\"..\\") or var_Event_138:find(\\"/\\") or var_Event_138:find(\\"\\\\\\") then
                                                                                                                                                                    error(\\"[PenguEnv Security] Blocked appendfile access to invalid path.\\")
                                                                                                                                                                    return
                                                                                                                                                                end
                                                                                                                                                                fn_Event_188(string.format(\\"appendfile(%var_Temp_18, %var_Temp_18)\\", fn_Event_572(var_Event_138), fn_Event_554(var_String_018)))
                                                                                                                                                                end, loadfile = function(var_Event_138)
                                                                                                                                                                    return function()
                                                                                                                                                                        return bj(\\"loaded_file\\", false)
                                                                                                                                                                    end
                                                                                                                                                                end, listfiles = function(dX)
                                                                                                                                                                    return {}
                                                                                                                                                                end, isfile = function(var_Event_138)
                                                                                                                                                                    return false
                                                                                                                                                                end, isfolder = function(var_Event_138)
                                                                                                                                                                    return false
                                                                                                                                                                end, makefolder = function(var_Event_138)
                                                                                                                                                                    fn_Event_188(string.format(\\"makefolder(%var_Temp_18)\\", fn_Event_572(var_Event_138)))
                                                                                                                                                                    end, delfolder = function(var_Event_138)
                                                                                                                                                                        fn_Event_188(string.format(\\"delfolder(%var_Temp_18)\\", fn_Event_572(var_Event_138)))
                                                                                                                                                                        end, delfile = function(var_Event_138)
                                                                                                                                                                            fn_Event_188(string.format(\\"delfile(%var_Temp_18)\\", fn_Event_572(var_Event_138)))
                                                                                                                                                                            end, Drawing = {new = function(var_Event_134)
                                                                                                                                                                                local var_Event_362 = fn_Event_958(var_Event_134)
                                                                                                                                                                                local var_Event_148 = bj(\\"Drawing_\\" .. var_Event_362, false)
                                                                                                                                                                                local var_Private_589 = fn_Event_471(var_Event_148, var_Event_362)
                                                                                                                                                                                fn_Event_188(string.format(\\"local %var_Temp_18 = Drawing.new(%var_Temp_18)\\", var_Private_589, fn_Event_572(var_Event_362)))
                                                                                                                                                                                    return var_Event_148
                                                                                                                                                                                end, Fonts = bj(\\"Drawing.Fonts\\", false)}, crypt = {base64encode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, base64decode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, base64_encode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, base64_decode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, encrypt = function(cJ, var_Event_319)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, decrypt = function(cJ, var_Event_319)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, hash = function(cJ)
                                                                                                                                                                                    return \\"hash\\"
                                                                                                                                                                                end, generatekey = function(dZ)
                                                                                                                                                                                    return string.rep(\\"0\\", dZ or 32)
                                                                                                                                                                                end, generatebytes = function(dZ)
                                                                                                                                                                                    return string.rep(\\"\\\\0\\", dZ or 16)
                                                                                                                                                                                end}, base64_encode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, base64_decode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, base64encode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, base64decode = function(cJ)
                                                                                                                                                                                    return cJ
                                                                                                                                                                                end, mouse1click = function()
                                                                                                                                                                                    fn_Event_188(\\"mouse1click()\\")
                                                                                                                                                                                end, mouse1press = function()
                                                                                                                                                                                    fn_Event_188(\\"mouse1press()\\")
                                                                                                                                                                                end, mouse1release = function()
                                                                                                                                                                                    fn_Event_188(\\"mouse1release()\\")
                                                                                                                                                                                end, mouse2click = function()
                                                                                                                                                                                    fn_Event_188(\\"mouse2click()\\")
                                                                                                                                                                                end, mouse2press = function()
                                                                                                                                                                                    fn_Event_188(\\"mouse2press()\\")
                                                                                                                                                                                end, mouse2release = function()
                                                                                                                                                                                    fn_Event_188(\\"mouse2click()\\")
                                                                                                                                                                                end, mousemoverel = function(var_Event_917, e0)
                                                                                                                                                                                    fn_Event_188(string.format(\\"mousemoverel(%var_Temp_18, %var_Temp_18)\\", fn_Event_554(var_Event_917), fn_Event_554(e0)))
                                                                                                                                                                                    end, mousemoveabs = function(var_Event_917, e0)
                                                                                                                                                                                        fn_Event_188(string.format(\\"mousemoveabs(%var_Temp_18, %var_Temp_18)\\", fn_Event_554(var_Event_917), fn_Event_554(e0)))
                                                                                                                                                                                        end, mousescroll = function(e1)
                                                                                                                                                                                            fn_Event_188(string.format(\\"mousescroll(%var_Temp_18)\\", fn_Event_554(e1)))
                                                                                                                                                                                            end, keypress = function(var_Event_319)
                                                                                                                                                                                                fn_Event_188(string.format(\\"keypress(%var_Temp_18)\\", fn_Event_572(var_Event_319)))
                                                                                                                                                                                                end, keyrelease = function(var_Event_319)
                                                                                                                                                                                                    fn_Event_188(string.format(\\"keyrelease(%var_Temp_18)\\", fn_Event_572(var_Event_319)))
                                                                                                                                                                                                    end, keyclick = function(var_Event_319)
                                                                                                                                                                                                        fn_Event_188(string.format(\\"keyclick(%var_Temp_18)\\", fn_Event_572(var_Event_319)))
                                                                                                                                                                                                        end, isreadonly = function(var_Unknown_3392)
                                                                                                                                                                                                            return false
                                                                                                                                                                                                        end, setreadonly = function(var_Unknown_3392, e2)
                                                                                                                                                                                                            return var_Unknown_3392
                                                                                                                                                                                                        end, make_writeable = function(var_Unknown_3392)
                                                                                                                                                                                                            return var_Unknown_3392
                                                                                                                                                                                                        end, make_readonly = function(var_Unknown_3392)
                                                                                                                                                                                                            return var_Unknown_3392
                                                                                                                                                                                                        end, getthreadidentity = function()
                                                                                                                                                                                                            return 7
                                                                                                                                                                                                        end, setthreadidentity = function(var_Camel_596)
                                                                                                                                                                                                        end, getidentity = function()
                                                                                                                                                                                                            return 7
                                                                                                                                                                                                        end, setidentity = function(var_Camel_596)
                                                                                                                                                                                                        end, getthreadcontext = function()
                                                                                                                                                                                                            return 7
                                                                                                                                                                                                        end, setthreadcontext = function(var_Camel_596)
                                                                                                                                                                                                        end, getcustomasset = function(var_Event_138)
                                                                                                                                                                                                            return \\"rbxasset://\\" .. fn_Event_958(var_Event_138)
                                                                                                                                                                                                        end, getsynasset = function(var_Event_138)
                                                                                                                                                                                                            return \\"rbxasset://\\" .. fn_Event_958(var_Event_138)
                                                                                                                                                                                                        end, getinfo = function(var_Unknown_7301)
                                                                                                                                                                                                            return {source = \\"=\\", what = \\"Lua\\", name = \\"unknown\\", short_src = \\"dumper\\"}
                                                                                                                                                                                                        end, getconstants = function(var_Unknown_7301)
                                                                                                                                                                                                            return {}
                                                                                                                                                                                                        end, getupvalues = function(var_Unknown_7301)
                                                                                                                                                                                                            return {}
                                                                                                                                                                                                        end, getprotos = function(var_Unknown_7301)
                                                                                                                                                                                                            return {}
                                                                                                                                                                                                        end, getupvalue = function(var_Unknown_7301, var_String_997)
                                                                                                                                                                                                            return nil
                                                                                                                                                                                                        end, setupvalue = function(var_Unknown_7301, var_String_997, var_Event_704)
                                                                                                                                                                                                        end, setconstant = function(var_Unknown_7301, var_String_997, var_Event_704)
                                                                                                                                                                                                        end, getconstant = function(var_Unknown_7301, var_String_997)
                                                                                                                                                                                                            return nil
                                                                                                                                                                                                        end, getproto = function(var_Unknown_7301, var_String_997)
                                                                                                                                                                                                            return function()
                                                                                                                                                                                                            end
                                                                                                                                                                                                        end, setproto = function(var_Unknown_7301, var_String_997, e3)
                                                                                                                                                                                                        end, getstack = function(dH, var_String_997)
                                                                                                                                                                                                            return nil
                                                                                                                                                                                                        end, setstack = function(dH, var_String_997, var_Event_704)
                                                                                                                                                                                                        end, debug = {getinfo = var_HTTP_013 or function()
                                                                                                                                                                                                            return {}
                                                                                                                                                                                                        end, getupvalue = debug.getupvalue or function()
                                                                                                                                                                                                            return nil
                                                                                                                                                                                                        end, setupvalue = debug.setupvalue or function()
                                                                                                                                                                                                        end, getmetatable = var_Temp_00.getmetatable, setmetatable = debug.setmetatable or setmetatable, traceback = var_HTTP_060 or
                                                                                                                                                                                                        function()
                                                                                                                                                                                                            return '\\"'
                                                                                                                                                                                                        end, profilebegin = function()
                                                                                                                                                                                                        end, profileend = function()
                                                                                                                                                                                                        end, sethook = function()
                                                                                                                                                                                                        end}, rconsoleprint = function(var_Table_306)
                                                                                                                                                                                                        end, rconsoleclear = function()
                                                                                                                                                                                                        end, rconsolecreate = function()
                                                                                                                                                                                                        end, rconsoledestroy = function()
                                                                                                                                                                                                        end, rconsoleinput = function()
                                                                                                                                                                                                            return \\"\\"
                                                                                                                                                                                                        end, rconsoleinfo = function(var_Table_306)
                                                                                                                                                                                                        end, rconsolewarn = function(var_Table_306)
                                                                                                                                                                                                        end, rconsoleerr = function(var_Table_306)
                                                                                                                                                                                                        end, rconsolename = function(var_Event_109)
                                                                                                                                                                                                        end, printconsole = function(var_Table_306)
                                                                                                                                                                                                        end, setfflag = function(e4, var_Event_704)
                                                                                                                                                                                                        end, getfflag = function(e4)
                                                                                                                                                                                                            return \\"\\"
                                                                                                                                                                                                        end, setfpscap = function(e5)
                                                                                                                                                                                                            fn_Event_188(string.format(\\"setfpscap(%var_Temp_18)\\", fn_Event_554(e5)))
                                                                                                                                                                                                            end, getfpscap = function()
                                                                                                                                                                                                                return 60
                                                                                                                                                                                                            end, isnetworkowner = function(cr)
                                                                                                                                                                                                                return true
                                                                                                                                                                                                            end, gethiddenproperty = function(var_Event_148, ce)
                                                                                                                                                                                                                return nil
                                                                                                                                                                                                            end, sethiddenproperty = function(var_Event_148, ce, var_Event_704)
                                                                                                                                                                                                                fn_Event_188(string.format(\\"sethiddenproperty(%var_Temp_18, %var_Temp_18, %var_Temp_18)\\", fn_Event_554(var_Event_148), fn_Event_572(ce), fn_Event_554(var_Event_704)))
                                                                                                                                                                                                                end, setsimulationradius = function(e6, e7)
                                                                                                                                                                                                                    fn_Event_188(string.format(\\"setsimulationradius(%var_Temp_18%var_Temp_18)\\", fn_Event_554(e6), e7 and \\", \\" .. fn_Event_554(e7) or \\"\\"))
                                                                                                                                                                                                                    end, getspecialinfo = function(e8)
                                                                                                                                                                                                                        return {}
                                                                                                                                                                                                                    end, saveinstance = function(dO)
                                                                                                                                                                                                                        fn_Event_188(string.format(\\"saveinstance(%var_Temp_18)\\", fn_Event_554(dO or {})))
                                                                                                                                                                                                                        end, decompile = function(script)
                                                                                                                                                                                                                            return \\"-- decompiled\\"
                                                                                                                                                                                                                        end, lz4compress = function(cJ)
                                                                                                                                                                                                                            return cJ
                                                                                                                                                                                                                        end, lz4decompress = function(cJ)
                                                                                                                                                                                                                            return cJ
                                                                                                                                                                                                                        end, MessageBox = function(e9, ea, eb)
                                                                                                                                                                                                                            return 1
                                                                                                                                                                                                                        end, setwindowactive = function()
                                                                                                                                                                                                                        end, setwindowtitle = function(ec)
                                                                                                                                                                                                                        end, queue_on_teleport = function(var_Event_336)
                                                                                                                                                                                                                            fn_Event_188(string.format(\\"queue_on_teleport(%var_Temp_18)\\", fn_Event_554(var_Event_336)))
                                                                                                                                                                                                                            end, queueonteleport = function(var_Event_336)
                                                                                                                                                                                                                                fn_Event_188(string.format(\\"queueonteleport(%var_Temp_18)\\", fn_Event_554(var_Event_336)))
                                                                                                                                                                                                                                end, secure_call = function(var_Unknown_7301, ...)
                                                                                                                                                                                                                                    return var_Unknown_7301(...)
                                                                                                                                                                                                                                end, create_secure_function = function(var_Unknown_7301)
                                                                                                                                                                                                                                    return var_Unknown_7301
                                                                                                                                                                                                                                end, isvalidinstance = function(e8)
                                                                                                                                                                                                                                    return e8 ~= nil
                                                                                                                                                                                                                                end, validcheck = function(e8)
                                                                                                                                                                                                                                    return e8 ~= nil
                                                                                                                                                                                                                                end}
                                                                                                                                                                                                                                for var_Unknown_5926, var_Table_535 in var_NPC_621(exploit_funcs) do
                                                                                                                                                                                                                                    _G[var_Unknown_5926] = var_Table_535
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                _G.hookfunction = nil
                                                                                                                                                                                                                                    _G.hookmetamethod = nil
                                                                                                                                                                                                                                    _G.newcclosure = nil
                                                                                                                                                                                                                                    local var_Event_822 = {}
                                                                                                                                                                                                                                    local function fn_Event_750(var_Event_917)
                                                                                                                                                                                                                                        var_Event_917 = (var_Event_917 or 0) % 4294967296
                                                                                                                                                                                                                                        if var_Event_917 >= 2147483648 then
                                                                                                                                                                                                                                            var_Event_917 = var_Event_917 - 4294967296
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                        return math.floor(var_Event_917)
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                    var_Event_822.tobit = fn_Event_750
                                                                                                                                                                                                                                    var_Event_822.tohex = function(var_Event_917, var_String_646)
                                                                                                                                                                                                                                        return string.format(\\"%0\\" .. (var_String_646 or 8) .. \\"var_Event_148\\", (var_Event_917 or 0) % 0x100000000)
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                        _G.bit = {band = function(var_Event_715, var_Unknown_4594)
                                                                                                                                                                                                                                            return fn_Event_750(fn_Event_750(var_Event_715) & fn_Event_750(var_Unknown_4594))
                                                                                                                                                                                                                                        end, bor = function(var_Event_715, var_Unknown_4594)
                                                                                                                                                                                                                                            return fn_Event_750(fn_Event_750(var_Event_715) | fn_Event_750(var_Unknown_4594))
                                                                                                                                                                                                                                        end, bxor = function(var_Event_715, var_Unknown_4594)
                                                                                                                                                                                                                                            return fn_Event_750(fn_Event_750(var_Event_715) ~ fn_Event_750(var_Unknown_4594))
                                                                                                                                                                                                                                        end, lshift = function(var_Event_917, var_String_646)
                                                                                                                                                                                                                                            return fn_Event_750(fn_Event_750(var_Event_917) << var_String_646 % 32)
                                                                                                                                                                                                                                        end, rshift = function(var_Event_917, var_String_646)
                                                                                                                                                                                                                                            return fn_Event_750(fn_Event_750(var_Event_917) >> var_String_646 % 32)
                                                                                                                                                                                                                                        end}
                                                                                                                                                                                                                                        _G.bit32 = _G.bit
                                                                                                                                                                                                                                        var_Event_822.arshift = function(var_Event_917, var_String_646)
                                                                                                                                                                                                                                            local var_Table_535 = fn_Event_750(var_Event_917 or 0)
                                                                                                                                                                                                                                            if var_Table_535 < 0 then
                                                                                                                                                                                                                                                return fn_Event_750(var_Table_535 >> var_String_646 or 0) + fn_Event_750(-1 << 32 - (var_String_646 or 0))
                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                            return fn_Event_750(var_Table_535 >> var_String_646 or 0)
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                    var_Event_822.rol = function(var_Event_917, var_String_646)
                                                                                                                                                                                                                                        var_Event_917 = var_Event_917 or 0
                                                                                                                                                                                                                                        var_String_646 = (var_String_646 or 0) % 32
                                                                                                                                                                                                                                        return fn_Event_750(var_Event_917 << var_String_646 | (var_Event_917 >> 32 - var_String_646))
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                    var_Event_822.ror = function(var_Event_917, var_String_646)
                                                                                                                                                                                                                                        var_Event_917 = var_Event_917 or 0
                                                                                                                                                                                                                                        var_String_646 = (var_String_646 or 0) % 32
                                                                                                                                                                                                                                        return fn_Event_750(var_Event_917 >> var_String_646 | (var_Event_917 << 32 - var_String_646))
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                    var_Event_822.bswap = function(var_Event_917)
                                                                                                                                                                                                                                        var_Event_917 = var_Event_917 or 0
                                                                                                                                                                                                                                        local var_Event_715 = var_Event_917 >> 24 & 0xFF
                                                                                                                                                                                                                                        local var_Unknown_4594 = var_Event_917 >> 8 & 0xFF00
                                                                                                                                                                                                                                        local var_Unknown_9179 = var_Event_917 << 8 & 0xFF0000
                                                                                                                                                                                                                                        local var_Unknown_1867 = var_Event_917 << 24 & 0xFF000000
                                                                                                                                                                                                                                        return fn_Event_750(var_Event_715 | var_Unknown_4594 | var_Unknown_9179 | var_Unknown_1867)
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                    var_Event_822.countlz = function(var_String_646)
                                                                                                                                                                                                                                        var_String_646 = var_Event_822.tobit(var_String_646)
                                                                                                                                                                                                                                        if var_String_646 == 0 then
                                                                                                                                                                                                                                            return 32
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                        local var_Event_252 = 0
                                                                                                                                                                                                                                        if var_Event_822.band(var_String_646, 0xFFFF0000) == 0 then
                                                                                                                                                                                                                                            var_Event_252 = var_Event_252 + 16
                                                                                                                                                                                                                                            var_String_646 = var_Event_822.lshift(var_String_646, 16)
                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                            if var_Event_822.band(var_String_646, 0xFF000000) == 0 then
                                                                                                                                                                                                                                                var_Event_252 = var_Event_252 + 8
                                                                                                                                                                                                                                                var_String_646 = var_Event_822.lshift(var_String_646, 8)
                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                if var_Event_822.band(var_String_646, 0xF0000000) == 0 then
                                                                                                                                                                                                                                                    var_Event_252 = var_Event_252 + 4
                                                                                                                                                                                                                                                    var_String_646 = var_Event_822.lshift(var_String_646, 4)
                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                    if var_Event_822.band(var_String_646, 0xC0000000) == 0 then
                                                                                                                                                                                                                                                        var_Event_252 = var_Event_252 + 2
                                                                                                                                                                                                                                                        var_String_646 = var_Event_822.lshift(var_String_646, 2)
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        if var_Event_822.band(var_String_646,  0x80000000) == 0 then
                                                                                                                                                                                                                                                            var_Event_252 = var_Event_252 + 1
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        return var_Event_252
                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                    var_Event_822.countrz = function(var_String_646)
                                                                                                                                                                                                                                                        var_String_646 = var_Event_822.tobit(var_String_646)
                                                                                                                                                                                                                                                        if var_String_646 == 0 then
                                                                                                                                                                                                                                                            return 32
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        local var_Event_252 = 0
                                                                                                                                                                                                                                                        while var_Event_822.band(var_String_646, 1) == 0 do
                                                                                                                                                                                                                                                            var_String_646 = var_Event_822.rshift(var_String_646, 1)
                                                                                                                                                                                                                                                                var_Event_252 = var_Event_252 + 1
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return var_Event_252
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        var_Event_822.lrotate = var_Event_822.rol
                                                                                                                                                                                                                                                        var_Event_822.rrotate = var_Event_822.ror
                                                                                                                                                                                                                                                        var_Event_822.extract = function(var_String_646, eg, eh)
                                                                                                                                                                                                                                                            eh = eh or 1
                                                                                                                                                                                                                                                            return var_String_646 >> eg & 1 << eh - 1
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        var_Event_822.replace = function(var_String_646, var_Table_535, eg, eh)
                                                                                                                                                                                                                                                            eh = eh or 1
                                                                                                                                                                                                                                                            local var_Unknown_3960 = 1 << eh - 1
                                                                                                                                                                                                                                                            return var_String_646 & ~(var_Unknown_3960 << eg) | (var_Table_535 & var_Unknown_3960 << eg)
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        var_Event_822.btest = function(var_Event_715, var_Unknown_4594)
                                                                                                                                                                                                                                                            return var_Event_822.band(var_Event_715, var_Unknown_4594) ~= 0
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        bit32 = var_Event_822
                                                                                                                                                                                                                                                        bit = var_Event_822
                                                                                                                                                                                                                                                        _G.bit = bit
                                                                                                                                                                                                                                                        _G.bit32 = bit32
                                                                                                                                                                                                                                                        table.getn = table.getn or function(var_Unknown_3392)
                                                                                                                                                                                                                                                            return #var_Unknown_3392
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        table.foreach = table.foreach or function(var_Unknown_3392, var_NPC_210)
                                                                                                                                                                                                                                                            for var_Unknown_5926, var_Table_535 in pairs(var_Unknown_3392) do
                                                                                                                                                                                                                                                                var_NPC_210(var_Unknown_5926, var_Table_535)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        table.foreachi = table.foreachi or function(var_Unknown_3392, var_NPC_210)
                                                                                                                                                                                                                                                            for var_Unknown_8967, var_Table_535 in ipairs(var_Unknown_3392) do
                                                                                                                                                                                                                                                                var_NPC_210(var_Unknown_8967, var_Table_535)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        table.move = table.move or function(ej, var_NPC_210, var_Math_456, var_Unknown_3392, ek)
                                                                                                                                                                                                                                                            ek = ek or ej
                                                                                                                                                                                                                                                            for var_Unknown_8967 = var_NPC_210, var_Math_456 do
                                                                                                                                                                                                                                                                ek[var_Unknown_3392 + var_Unknown_8967 - var_NPC_210] = ej[var_Unknown_8967]
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return ek
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        string.split = string.split or function(S, el)
                                                                                                                                                                                                                                                            local var_Unknown_3392 = {}
                                                                                                                                                                                                                                                            for var_Event_394 in string.gmatch(S, \\"([^\\" .. (el or \\"%var_Temp_18\\") .. \\"]+)\\") do
                                                                                                                                                                                                                                                                table.insert(var_Unknown_3392, var_Event_394)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return var_Unknown_3392
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        if not math.frexp then
                                                                                                                                                                                                                                                            math.frexp = function(var_Event_917)
                                                                                                                                                                                                                                                                if var_Event_917 == 0 then
                                                                                                                                                                                                                                                                    return 0, 0
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                local var_Math_456 = math.floor(math.log(math.abs(var_Event_917)) / math.log(2)) + 1
                                                                                                                                                                                                                                                                local var_Math_958 = var_Event_917 / 2 ^ var_Math_456
                                                                                                                                                                                                                                                                return var_Math_958, var_Math_456
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        if not math.ldexp then
                                                                                                                                                                                                                                                            math.ldexp = function(var_Math_958, var_Math_456)
                                                                                                                                                                                                                                                                return var_Math_958 * 2 ^ var_Math_456
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        if not utf8 then
                                                                                                                                                                                                                                                            utf8 = {}
                                                                                                                                                                                                                                                            utf8.char = function(...)
                                                                                                                                                                                                                                                                local var_Remote_865 = {...}
                                                                                                                                                                                                                                                                local var_NPC_589 = {}
                                                                                                                                                                                                                                                                for var_Unknown_8967, var_Event_336 in ipairs(var_Remote_865) do
                                                                                                                                                                                                                                                                    table.insert(var_NPC_589, string.char(var_Event_336 % 256))
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return table.concat(var_NPC_589)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            utf8.var_Event_773 = function(S)
                                                                                                                                                                                                                                                                return #S
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            utf8.codes = function(S)
                                                                                                                                                                                                                                                                local var_Unknown_8967 = 0
                                                                                                                                                                                                                                                                return function()
                                                                                                                                                                                                                                                                    var_Unknown_8967 = var_Unknown_8967 + 1
                                                                                                                                                                                                                                                                    if var_Unknown_8967 <= #S then
                                                                                                                                                                                                                                                                        return var_Unknown_8967, string.byte(S, var_Unknown_8967)
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        _G.utf8 = utf8
                                                                                                                                                                                                                                                        pairs = function(var_Unknown_3392)
                                                                                                                                                                                                                                                            if var_HTTP_095(var_Unknown_3392) == \\"table\\" and not fn_Event_359(var_Unknown_3392) then
                                                                                                                                                                                                                                                                return var_NPC_621(var_Unknown_3392)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return function()
                                                                                                                                                                                                                                                                return nil
                                                                                                                                                                                                                                                            end, var_Unknown_3392, nil
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        ipairs = function(var_Unknown_3392)
                                                                                                                                                                                                                                                            if var_HTTP_095(var_Unknown_3392) == \\"table\\" and not fn_Event_359(var_Unknown_3392) then
                                                                                                                                                                                                                                                                return var_NPC_677(var_Unknown_3392)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return function()
                                                                                                                                                                                                                                                                return nil
                                                                                                                                                                                                                                                            end, var_Unknown_3392, 0
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        _G.pairs = pairs
                                                                                                                                                                                                                                                        _G.ipairs = ipairs
                                                                                                                                                                                                                                                        _G.math = math
                                                                                                                                                                                                                                                        _G.table = table
                                                                                                                                                                                                                                                        _G.string = string
                                                                                                                                                                                                                                                        _G.os = os
                                                                                                                                                                                                                                                        _G.coroutine = coroutine
                                                                                                                                                                                                                                                        _G.io = nil
                                                                                                                                                                                                                                                        _G.debug = exploit_funcs.debug
                                                                                                                                                                                                                                                        _G.utf8 = utf8
                                                                                                                                                                                                                                                        _G.pairs = pairs
                                                                                                                                                                                                                                                        _G.ipairs = ipairs
                                                                                                                                                                                                                                                        _G.next = next
                                                                                                                                                                                                                                                        _G.tostring = tostring
                                                                                                                                                                                                                                                        _G.tonumber = tonumber
                                                                                                                                                                                                                                                        _G.getmetatable = getmetatable
                                                                                                                                                                                                                                                        _G.setmetatable = setmetatable
                                                                                                                                                                                                                                                        _G.pcall = function(var_NPC_210, ...)
                                                                                                                                                                                                                                                            local var_Event_904 = {var_Data_766(var_NPC_210, ...)}
                                                                                                                                                                                                                                                            local var_Unknown_8652 = var_Event_904[1]
                                                                                                                                                                                                                                                            if not var_Unknown_8652 then
                                                                                                                                                                                                                                                                local var_String_767 = var_Event_904[2]
                                                                                                                                                                                                                                                                if var_HTTP_095(var_String_767) == \\"string\\" and var_String_767:match(\\"TIMEOUT_FORCED_BY_DUMPER\\") then
                                                                                                                                                                                                                                                                    var_Iterator_08(var_String_767)
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return table.unpack(var_Event_904)
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        _G.xpcall = function(var_NPC_210, ep, ...)
                                                                                                                                                                                                                                                            local function fn_Event_587(var_String_767)
                                                                                                                                                                                                                                                                if var_HTTP_095(var_String_767) == \\"string\\" and var_String_767:match(\\"TIMEOUT_FORCED_BY_DUMPER\\") then
                                                                                                                                                                                                                                                                    return var_String_767
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                if ep then
                                                                                                                                                                                                                                                                    return ep(var_String_767)
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return var_String_767
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            local var_Event_904 = {var_Temp_07(var_NPC_210, fn_Event_587, ...)}
                                                                                                                                                                                                                                                            local var_Unknown_8652 = var_Event_904[1]
                                                                                                                                                                                                                                                            if not var_Unknown_8652 then
                                                                                                                                                                                                                                                                local var_String_767 = var_Event_904[2]
                                                                                                                                                                                                                                                                if var_HTTP_095(var_String_767) == \\"string\\" and var_String_767:match(\\"TIMEOUT_FORCED_BY_DUMPER\\") then
                                                                                                                                                                                                                                                                    var_Iterator_08(var_String_767)
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return table.unpack(var_Event_904)
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        _G.error = error
                                                                                                                                                                                                                                                        if _G.originalError == nil then
                                                                                                                                                                                                                                                            _G.originalError = error
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        _G.assert = assert
                                                                                                                                                                                                                                                        _G.select = select
                                                                                                                                                                                                                                                        _G.type = type
                                                                                                                                                                                                                                                        _G.rawget = rawget
                                                                                                                                                                                                                                                        _G.rawset = rawset
                                                                                                                                                                                                                                                        _G.rawequal = rawequal
                                                                                                                                                                                                                                                        _G.rawlen = rawlen or function(var_Unknown_3392)
                                                                                                                                                                                                                                                            return #var_Unknown_3392
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        _G.unpack = table.unpack or unpack
                                                                                                                                                                                                                                                        _G.pack = table.pack or function(...)
                                                                                                                                                                                                                                                            return {var_Event_793 = select(\\"#\\", ...), ...}
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        _G.task = task
                                                                                                                                                                                                                                                        _G.wait = wait
                                                                                                                                                                                                                                                        _G.Wait = wait
                                                                                                                                                                                                                                                        _G.delay = delay
                                                                                                                                                                                                                                                        _G.Delay = delay
                                                                                                                                                                                                                                                        _G.spawn = spawn
                                                                                                                                                                                                                                                        _G.Spawn = spawn
                                                                                                                                                                                                                                                        _G.tick = tick
                                                                                                                                                                                                                                                        _G.time = time
                                                                                                                                                                                                                                                        _G.elapsedTime = elapsedTime
                                                                                                                                                                                                                                                        _G.game = game
                                                                                                                                                                                                                                                        _G.Game = game
                                                                                                                                                                                                                                                        _G.workspace = workspace
                                                                                                                                                                                                                                                        _G.Workspace = workspace
                                                                                                                                                                                                                                                        _G.script = script
                                                                                                                                                                                                                                                        _G.Enum = Enum
                                                                                                                                                                                                                                                        _G.Instance = Instance
                                                                                                                                                                                                                                                        _G.Random = Random
                                                                                                                                                                                                                                                            _G.Vector3 = Vector3
                                                                                                                                                                                                                                                            _G.Vector2 = Vector2
                                                                                                                                                                                                                                                            _G.CFrame = CFrame
                                                                                                                                                                                                                                                            _G.Color3 = Color3
                                                                                                                                                                                                                                                            _G.BrickColor = BrickColor
                                                                                                                                                                                                                                                            _G.UDim = UDim
                                                                                                                                                                                                                                                            _G.UDim2 = UDim2
                                                                                                                                                                                                                                                            _G.TweenInfo = TweenInfo
                                                                                                                                                                                                                                                            _G.Rect = Rect
                                                                                                                                                                                                                                                            _G.Region3 = Region3
                                                                                                                                                                                                                                                            _G.Region3int16 = Region3int16
                                                                                                                                                                                                                                                            _G.Ray = Ray
                                                                                                                                                                                                                                                            _G.NumberRange = NumberRange
                                                                                                                                                                                                                                                            _G.NumberSequence = NumberSequence
                                                                                                                                                                                                                                                            _G.NumberSequenceKeypoint = NumberSequenceKeypoint
                                                                                                                                                                                                                                                            _G.ColorSequence = ColorSequence
                                                                                                                                                                                                                                                            _G.ColorSequenceKeypoint = ColorSequenceKeypoint
                                                                                                                                                                                                                                                            _G.PhysicalProperties = PhysicalProperties
                                                                                                                                                                                                                                                            _G.Font = Font
                                                                                                                                                                                                                                                            _G.RaycastParams = RaycastParams
                                                                                                                                                                                                                                                            _G.OverlapParams = OverlapParams
                                                                                                                                                                                                                                                            _G.PathWaypoint = PathWaypoint
                                                                                                                                                                                                                                                            _G.Axes = Axes
                                                                                                                                                                                                                                                            _G.Faces = Faces
                                                                                                                                                                                                                                                            _G.Vector3int16 = Vector3int16
                                                                                                                                                                                                                                                            _G.Vector2int16 = Vector2int16
                                                                                                                                                                                                                                                            _G.CatalogSearchParams = CatalogSearchParams
                                                                                                                                                                                                                                                            _G.DateTime = DateTime
                                                                                                                                                                                                                                                            getmetatable = function(var_Event_148)
                                                                                                                                                                                                                                                                if fn_Event_359(var_Event_148) then
                                                                                                                                                                                                                                                                    return \\"The metatable is locked\\"
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return var_HTTP_344(var_Event_148)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            _G.getmetatable = getmetatable
                                                                                                                                                                                                                                                            type = function(var_Event_148)
                                                                                                                                                                                                                                                                if fn_Event_591(var_Event_148) then
                                                                                                                                                                                                                                                                    return \\"number\\"
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                if fn_Event_359(var_Event_148) then
                                                                                                                                                                                                                                                                    return \\"userdata\\"
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return var_HTTP_095(var_Event_148)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            _G.type = type
                                                                                                                                                                                                                                                            typeof = function(var_Event_148)
                                                                                                                                                                                                                                                                if fn_Event_591(var_Event_148) then
                                                                                                                                                                                                                                                                    return \\"number\\"
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                if fn_Event_359(var_Event_148) then
                                                                                                                                                                                                                                                                    local var_Unknown_5245 = var_HTTP_773.registry[var_Event_148]
                                                                                                                                                                                                                                                                    if var_Unknown_5245 then
                                                                                                                                                                                                                                                                        if var_Unknown_5245:match(\\"Vector3\\") then
                                                                                                                                                                                                                                                                            return \\"Vector3\\"
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        if var_Unknown_5245:match(\\"CFrame\\") then
                                                                                                                                                                                                                                                                            return \\"CFrame\\"
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        if var_Unknown_5245:match(\\"Color3\\") then
                                                                                                                                                                                                                                                                            return \\"Color3\\"
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        if var_Unknown_5245:match(\\"UDim\\") then
                                                                                                                                                                                                                                                                            return \\"UDim2\\"
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        if var_Unknown_5245:match(\\"Enum\\") then
                                                                                                                                                                                                                                                                            return \\"EnumItem\\"
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                    return \\"Instance\\"
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return var_HTTP_095(var_Event_148) == \\"table\\" and \\"table\\" or var_HTTP_095(var_Event_148)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            _G.typeof = typeof
                                                                                                                                                                                                                                                            tonumber = function(var_Event_148, es)
                                                                                                                                                                                                                                                                if fn_Event_591(var_Event_148) then
                                                                                                                                                                                                                                                                    return 123456789
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return var_Event_793(var_Event_148, es)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            _G.tonumber = tonumber
                                                                                                                                                                                                                                                            rawequal = function(var_Event_715, var_Unknown_4594)
                                                                                                                                                                                                                                                                return var_HTTP_001(var_Event_715, var_Unknown_4594)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            _G.rawequal = rawequal
                                                                                                                                                                                                                                                            tostring = function(var_Event_148)
                                                                                                                                                                                                                                                                if fn_Event_359(var_Event_148) then
                                                                                                                                                                                                                                                                    local var_Instance_876 = var_HTTP_773.registry[var_Event_148]
                                                                                                                                                                                                                                                                    return var_Instance_876 or \\"Instance\\"
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return var_Event_192(var_Event_148)
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            _G.tostring = tostring
                                                                                                                                                                                                                                                            var_HTTP_773.last_http_url = nil
                                                                                                                                                                                                                                                            loadstring = function(var_Event_336, eu)
                                                                                                                                                                                                                                                                if var_HTTP_095(var_Event_336) ~= \\"string\\" then
                                                                                                                                                                                                                                                                    return function()
                                                                                                                                                                                                                                                                        return bj(\\"loaded\\", false)
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                local var_HTTP_119 = var_HTTP_773.last_http_url or var_Event_336
                                                                                                                                                                                                                                                                var_HTTP_773.last_http_url = nil
                                                                                                                                                                                                                                                                local var_HTTP_828 = nil
                                                                                                                                                                                                                                                                local var_String_986 = var_HTTP_119:lower()
                                                                                                                                                                                                                                                                local var_String_562 = {
                                                                                                                                                                                                                                                                {pattern = \\"rayfield\\", name = \\"Rayfield\\"},
                                                                                                                                                                                                                                                                {pattern = \\"orion\\", name = \\"OrionLib\\"},
                                                                                                                                                                                                                                                                {pattern = \\"kavo\\", name = \\"Kavo\\"},
                                                                                                                                                                                                                                                                {pattern = \\"venyx\\", name = \\"Venyx\\"},
                                                                                                                                                                                                                                                                {pattern = \\"sirius\\", name = \\"Sirius\\"},
                                                                                                                                                                                                                                                                {pattern = \\"linoria\\", name = \\"Linoria\\"},
                                                                                                                                                                                                                                                                {pattern = \\"wally\\", name = \\"Wally\\"},
                                                                                                                                                                                                                                                                {pattern = \\"dex\\", name = \\"Dex\\"},
                                                                                                                                                                                                                                                                {pattern = \\"infinite\\", name = \\"InfiniteYield\\"},
                                                                                                                                                                                                                                                                {pattern = \\"hydroxide\\", name = \\"Hydroxide\\"},
                                                                                                                                                                                                                                                                {pattern = \\"simplespy\\", name = \\"SimpleSpy\\"},
                                                                                                                                                                                                                                                                {pattern = \\"remotespy\\", name = \\"RemoteSpy\\"}
                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                for W, ey in ipairs(var_String_562) do
                                                                                                                                                                                                                                                                    if var_String_986:find(ey.pattern) then
                                                                                                                                                                                                                                                                        var_HTTP_828 = ey.name
                                                                                                                                                                                                                                                                        break
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                if var_HTTP_828 then
                                                                                                                                                                                                                                                                    local var_Unknown_0408 = bj(var_HTTP_828, false)
                                                                                                                                                                                                                                                                    var_HTTP_773.registry[var_Unknown_0408] = var_HTTP_828
                                                                                                                                                                                                                                                                    var_HTTP_773.names_used[var_HTTP_828] = true
                                                                                                                                                                                                                                                                    if var_HTTP_119:match(\\"^https?://\\") then
                                                                                                                                                                                                                                                                        fn_Event_188(string.format('local %var_Temp_18 = loadstring(game:HttpGet(\\"%var_Temp_18\\"))()', var_HTTP_828, var_HTTP_119))
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        return function()
                                                                                                                                                                                                                                                                            return var_Unknown_0408
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                    if var_HTTP_119:match(\\"^https?://\\") then
                                                                                                                                                                                                                                                                        local var_Unknown_0408 = bj(\\"Library\\", false)
                                                                                                                                                                                                                                                                        fn_Event_188(string.format('local PenguEnvLoader = loadstring(game:HttpGet(\\"%var_Temp_18\\"))()', var_HTTP_119))
                                                                                                                                                                                                                                                                            return function()
                                                                                                                                                                                                                                                                                return var_Unknown_0408
                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        if type(var_Event_336) == \\"string\\" then
                                                                                                                                                                                                                                                                            var_Event_336 = fn_HTTP_705(var_Event_336)
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        local var_Event_838, var_String_767 = var_Data_859(var_Event_336)
                                                                                                                                                                                                                                                                        if var_Event_838 then
                                                                                                                                                                                                                                                                            return var_Event_838
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        local var_Unknown_0408 = bj(\\"LoadedChunk\\", false)
                                                                                                                                                                                                                                                                        return function()
                                                                                                                                                                                                                                                                            return var_Unknown_0408
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                    load = loadstring
                                                                                                                                                                                                                                                                    _G.loadstring = loadstring
                                                                                                                                                                                                                                                                    _G.load = loadstring
                                                                                                                                                                                                                                                                    require = function(eA)
                                                                                                                                                                                                                                                                        local var_UI_037 = var_HTTP_773.registry[eA] or fn_Event_554(eA)
                                                                                                                                                                                                                                                                        local var_Temp_25 = bj(\\"RequiredModule\\", false)
                                                                                                                                                                                                                                                                        local var_Private_589 = fn_Event_471(var_Temp_25, \\"module\\")
                                                                                                                                                                                                                                                                        fn_Event_188(string.format(\\"local %var_Temp_18 = require(%var_Temp_18)\\", var_Private_589, var_UI_037))
                                                                                                                                                                                                                                                                            return var_Temp_25
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        _G.require = require
                                                                                                                                                                                                                                                                        print = function(...)
                                                                                                                                                                                                                                                                            local var_Remote_865 = {...}
                                                                                                                                                                                                                                                                            local var_Unknown_6525 = {}
                                                                                                                                                                                                                                                                            for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                                                                                                                                                                                                                table.insert(var_Unknown_6525, fn_Event_554(var_Table_535))
                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                            fn_Event_188(string.format(\\"print(%var_Temp_18)\\", table.concat(var_Unknown_6525, \\", \\")))
                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                            _G.print = print
                                                                                                                                                                                                                                                                            warn = function(...)
                                                                                                                                                                                                                                                                                local var_Remote_865 = {...}
                                                                                                                                                                                                                                                                                local var_Unknown_6525 = {}
                                                                                                                                                                                                                                                                                for W, var_Table_535 in ipairs(var_Remote_865) do
                                                                                                                                                                                                                                                                                    table.insert(var_Unknown_6525, fn_Event_554(var_Table_535))
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                fn_Event_188(string.format(\\"warn(%var_Temp_18)\\", table.concat(var_Unknown_6525, \\", \\")))
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                _G.warn = warn
                                                                                                                                                                                                                                                                                shared = bj(\\"shared\\", true)
                                                                                                                                                                                                                                                                                _G.shared = shared
                                                                                                                                                                                                                                                                                local var_Script_784 = _G
                                                                                                                                                                                                                                                                                local var_Table_512 =
                                                                                                                                                                                                                                                                                setmetatable(
                                                                                                                                                                                                                                                                                {},
                                                                                                                                                                                                                                                                                {__index = function(var_Unknown_3392, var_Unknown_5926)
                                                                                                                                                                                                                                                                                    local var_Event_356 = rawget(var_Script_784, var_Unknown_5926)
                                                                                                                                                                                                                                                                                    if var_Event_356 == nil then
                                                                                                                                                                                                                                                                                        var_Event_356 = rawget(_G, var_Unknown_5926)
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                    return var_Event_356
                                                                                                                                                                                                                                                                                end, __newindex = function(var_Unknown_3392, var_Unknown_5926, var_Table_535)
                                                                                                                                                                                                                                                                                    rawset(var_Script_784, var_Unknown_5926, var_Table_535)
                                                                                                                                                                                                                                                                                end}
                                                                                                                                                                                                                                                                                )
                                                                                                                                                                                                                                                                                _G._G = var_Table_512
                                                                                                                                                                                                                                                                                function PenguEnv.reset()
                                                                                                                                                                                                                                                                                    var_HTTP_773 = {
                                                                                                                                                                                                                                                                                    output = {},
                                                                                                                                                                                                                                                                                    indent = 0,
                                                                                                                                                                                                                                                                                    registry = {},
                                                                                                                                                                                                                                                                                    reverse_registry = {},
                                                                                                                                                                                                                                                                                    names_used = {},
                                                                                                                                                                                                                                                                                    parent_map = {},
                                                                                                                                                                                                                                                                                    property_store = {},
                                                                                                                                                                                                                                                                                    call_graph = {},
                                                                                                                                                                                                                                                                                    variable_types = {},
                                                                                                                                                                                                                                                                                    string_refs = {},
                                                                                                                                                                                                                                                                                    proxy_id = 0,
                                                                                                                                                                                                                                                                                    callback_depth = 0,
                                                                                                                                                                                                                                                                                    pending_iterator = false,
                                                                                                                                                                                                                                                                                    last_http_url = nil,
                                                                                                                                                                                                                                                                                    last_emitted_line = nil,
                                                                                                                                                                                                                                                                                    repetition_count = 0,
                                                                                                                                                                                                                                                                                    current_size = 0,
                                                                                                                                                                                                                                                                                    limit_reached = false,
                                                                                                                                                                                                                                                                                    pen_counter = 0,
                                                                                                                                                                                                                                                                                    captured_constants = {}
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                    var_Event_612 = {}
                                                                                                                                                                                                                                                                                    game = bj(\\"game\\", true)
                                                                                                                                                                                                                                                                                    workspace = bj(\\"workspace\\", true)
                                                                                                                                                                                                                                                                                    script = bj(\\"script\\", true)
                                                                                                                                                                                                                                                                                    Enum = bj(\\"Enum\\", true)
                                                                                                                                                                                                                                                                                    shared = bj(\\"shared\\", true)
                                                                                                                                                                                                                                                                                    var_HTTP_773.property_store[game] = {PlaceId = var_Event_411, GameId = var_Event_411, placeId = var_Event_411, gameId = var_Event_411}
                                                                                                                                                                                                                                                                                    _G.game = game
                                                                                                                                                                                                                                                                                    _G.Game = game
                                                                                                                                                                                                                                                                                    _G.workspace = workspace
                                                                                                                                                                                                                                                                                    _G.Workspace = workspace
                                                                                                                                                                                                                                                                                    _G.script = script
                                                                                                                                                                                                                                                                                    _G.Enum = Enum
                                                                                                                                                                                                                                                                                    _G.shared = shared
                                                                                                                                                                                                                                                                                    local var_HTTP_891 = var_Temp_00.getmetatable(Enum)
                                                                                                                                                                                                                                                                                    var_HTTP_891.__index = function(var_Unknown_3392, var_Unknown_5926)
                                                                                                                                                                                                                                                                                        if var_Unknown_5926 == var_Event_539 or var_Unknown_5926 == \\"__proxy_id\\" then
                                                                                                                                                                                                                                                                                            return rawset(var_Unknown_3392, var_Unknown_5926)
                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                        local var_Unknown_1976 = bj(\\"Enum.\\" .. fn_Event_958(var_Unknown_5926), false)
                                                                                                                                                                                                                                                                                        var_HTTP_773.registry[var_Unknown_1976] = \\"Enum.\\" .. fn_Event_958(var_Unknown_5926)
                                                                                                                                                                                                                                                                                        return var_Unknown_1976
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                function PenguEnv.get_output()
                                                                                                                                                                                                                                                                                    return fn_Event_060()
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                function PenguEnv.save(var_Event_069)
                                                                                                                                                                                                                                                                                    return fn_Event_467(var_Event_069)
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                function PenguEnv.get_call_graph()
                                                                                                                                                                                                                                                                                    return var_HTTP_773.call_graph
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                function PenguEnv.get_string_refs()
                                                                                                                                                                                                                                                                                    return var_HTTP_773.string_refs
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                function PenguEnv.get_stats()
                                                                                                                                                                                                                                                                                    return {
                                                                                                                                                                                                                                                                                    total_lines = #var_HTTP_773.output,
                                                                                                                                                                                                                                                                                    remote_calls = #var_HTTP_773.call_graph,
                                                                                                                                                                                                                                                                                    suspicious_strings = #var_HTTP_773.string_refs,
                                                                                                                                                                                                                                                                                    proxies_created = var_HTTP_773.proxy_id
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                local var_Camel_379 = {
                                                                                                                                                                                                                                                                                callId = \\"PENGUENV_\\",
                                                                                                                                                                                                                                                                                binaryOperatorNames = {
                                                                                                                                                                                                                                                                                [\\"and\\"] = \\"AND\\",
                                                                                                                                                                                                                                                                                [\\"or\\"] = \\"OR\\",
                                                                                                                                                                                                                                                                                [\\">\\"] = \\"GT\\",
                                                                                                                                                                                                                                                                                [\\"<\\"] = \\"LT\\",
                                                                                                                                                                                                                                                                                [\\">=\\"] = \\"GE\\",
                                                                                                                                                                                                                                                                                [\\"<=\\"] = \\"LE\\",
                                                                                                                                                                                                                                                                                [\\"==\\"] = \\"EQ\\",
                                                                                                                                                                                                                                                                                [\\"~=\\"] = \\"NEQ\\",
                                                                                                                                                                                                                                                                                [\\"..\\"] = \\"CAT\\"
                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                function var_Camel_379:hook(var_Event_336)
                                                                                                                                                                                                                                                                                    return self.callId .. var_Event_336
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                function var_Camel_379:process_expr(eF)
                                                                                                                                                                                                                                                                                    if not eF then
                                                                                                                                                                                                                                                                                        return \\"nil\\"
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                    if type(eF) == \\"string\\" then
                                                                                                                                                                                                                                                                                        return eF
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                    local var_String_344 = eF.tag or eF.kind
                                                                                                                                                                                                                                                                                    if var_String_344 == \\"number\\" or var_String_344 == \\"string\\" then
                                                                                                                                                                                                                                                                                        local var_Event_356 = var_String_344 == \\"string\\" and string.format(\\"%q\\", eF.text) or (eF.value or eF.text)
                                                                                                                                                                                                                                                                                            if var_Temp_17.CONSTANT_COLLECTION then
                                                                                                                                                                                                                                                                                                return string.format(\\"%sGET(%var_Temp_18)\\", self.callId, var_Event_356)
                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                return var_Event_356
                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                            if var_String_344 == \\"local\\" or var_String_344 == \\"global\\" then
                                                                                                                                                                                                                                                                                                return (eF.name or eF.token).text
                                                                                                                                                                                                                                                                                            elseif var_String_344 == \\"boolean\\" or var_String_344 == \\"bool\\" then
                                                                                                                                                                                                                                                                                                return tostring(eF.value)
                                                                                                                                                                                                                                                                                            elseif var_String_344 == \\"binary\\" then
                                                                                                                                                                                                                                                                                                local var_Camel_801 = self:process_expr(eF.lhsoperand)
                                                                                                                                                                                                                                                                                                local var_UI_651 = self:process_expr(eF.rhsoperand)
                                                                                                                                                                                                                                                                                                local var_Event_385 = eF.operator.text
                                                                                                                                                                                                                                                                                                local var_UI_111 = self.binaryOperatorNames[var_Event_385]
                                                                                                                                                                                                                                                                                                if var_UI_111 then
                                                                                                                                                                                                                                                                                                    return string.format(\\"%var_Temp_18%var_Temp_18(%var_Temp_18, %var_Temp_18)\\", self.callId, var_UI_111, var_Camel_801, var_UI_651)
                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                    return string.format(\\"(%var_Temp_18 %var_Temp_18 %var_Temp_18)\\", var_Camel_801, var_Event_385, var_UI_651)
                                                                                                                                                                                                                                                                                                    elseif var_String_344 == \\"call\\" then
                                                                                                                                                                                                                                                                                                        local var_Unknown_7301 = self:process_expr(eF.func)
                                                                                                                                                                                                                                                                                                        local var_Remote_865 = {}
                                                                                                                                                                                                                                                                                                        for var_Unknown_8967, var_Table_535 in ipairs(eF.arguments) do
                                                                                                                                                                                                                                                                                                            var_Remote_865[var_Unknown_8967] = self:process_expr(var_Table_535.node or var_Table_535)
                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                        return string.format(\\"%sCALL(%var_Temp_18, %var_Temp_18)\\", self.callId, var_Unknown_7301, table.concat(var_Remote_865, \\", \\"))
                                                                                                                                                                                                                                                                                                        elseif var_String_344 == \\"indexname\\" or var_String_344 == \\"index\\" then
                                                                                                                                                                                                                                                                                                            local var_HTTP_524 = self:process_expr(eF.expression)
                                                                                                                                                                                                                                                                                                            local var_String_997 = var_String_344 == \\"indexname\\" and string.format(\\"%q\\", eF.index.text) or self:process_expr(eF.index)
                                                                                                                                                                                                                                                                                                                return string.format(\\"%sCHECKINDEX(%var_Temp_18, %var_Temp_18)\\", self.callId, var_HTTP_524, var_String_997)
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                return \\"nil\\"
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            function var_Camel_379:process_statement(eF)
                                                                                                                                                                                                                                                                                                                if not eF then
                                                                                                                                                                                                                                                                                                                    return \\"\\"
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                local var_String_344 = eF.tag
                                                                                                                                                                                                                                                                                                                if var_String_344 == \\"local\\" or var_String_344 == \\"assign\\" then
                                                                                                                                                                                                                                                                                                                    local eK, eL = {}, {}
                                                                                                                                                                                                                                                                                                                    for W, var_Table_535 in ipairs(eF.variables or {}) do
                                                                                                                                                                                                                                                                                                                        table.insert(eK, self:process_expr(var_Table_535.node or var_Table_535))
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    for W, var_Table_535 in ipairs(eF.values or {}) do
                                                                                                                                                                                                                                                                                                                        table.insert(eL, self:process_expr(var_Table_535.node or var_Table_535))
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    return (var_String_344 == \\"local\\" and \\"local \\" or \\"\\") .. table.concat(eK, \\", \\") .. \\" = \\" .. table.concat(eL, \\", \\")
                                                                                                                                                                                                                                                                                                                elseif var_String_344 == \\"block\\" then
                                                                                                                                                                                                                                                                                                                    local var_Unknown_6739 = {}
                                                                                                                                                                                                                                                                                                                    for W, eM in ipairs(eF.statements or {}) do
                                                                                                                                                                                                                                                                                                                        table.insert(var_Unknown_6739, self:process_statement(eM))
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    return table.concat(var_Unknown_6739, \\"; \\")
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                return self:process_expr(eF) or \\"\\"
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            function PenguEnv.dump_file(eN, eO)
                                                                                                                                                                                                                                                                                                                PenguEnv.reset()
                                                                                                                                                                                                                                                                                                                fn_Event_676(\\"this file is generated using PenguEnv V0.63\\")

                                                                                                                                                                                                                                                                                                                if eN and (eN:find(\\"%.%.\\") or eN:find(\\"/\\") or eN:find(\\"\\\\\\")) then
                                                                                                                                                                                                                                                                                                                    var_Data_652(\\"[PenguEnv Security] Invalid input path specified.\\")
                                                                                                                                                                                                                                                                                                                        return false
                                                                                                                                                                                                                                                                                                                    end

                                                                                                                                                                                                                                                                                                                    local var_NPC_210 = var_Event_379.open(eN, \\"rb\\")
                                                                                                                                                                                                                                                                                                                    if not var_NPC_210 then
                                                                                                                                                                                                                                                                                                                        return false
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    local var_Event_336 = var_NPC_210:read(\\"*var_Temp_00\\")
                                                                                                                                                                                                                                                                                                                    var_NPC_210:close()
                                                                                                                                                                                                                                                                                                                    var_Data_652(\\"[PenguEnv V0.63] Sanitizing Luau and Binary Literals...\\")
                                                                                                                                                                                                                                                                                                                    local var_Script_091 = fn_HTTP_705(var_Event_336)
                                                                                                                                                                                                                                                                                                                    local var_Event_838, eQ = var_Data_859(var_Script_091, \\"Obfuscated_Script\\")
                                                                                                                                                                                                                                                                                                                    if not var_Event_838 then
                                                                                                                                                                                                                                                                                                                        var_Data_652(\\"\\\\
[LUA_LOAD_FAIL] \\" .. var_Event_192(eQ))
                                                                                                                                                                                                                                                                                                                        fn_Event_676(\\"Error during execution: \\" .. var_Event_192(eQ))
                                                                                                                                                                                                                                                                                                                        PenguEnv.save(eO or var_Temp_17.OUTPUT_FILE)
                                                                                                                                                                                                                                                                                                                        return false
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    local var_Table_419 =
                                                                                                                                                                                                                                                                                                                    setmetatable(
                                                                                                                                                                                                                                                                                                                    {PenguEnvContinue = function()
                                                                                                                                                                                                                                                                                                                    end, script = script, game = game, workspace = workspace, PENGUENV_CHECKINDEX = function(var_Event_148, var_String_997)
                                                                                                                                                                                                                                                                                                                        local var_Event_356 = var_Event_148[var_String_997]
                                                                                                                                                                                                                                                                                                                        if var_HTTP_095(var_Event_356) == \\"table\\" and not var_HTTP_773.registry[var_Event_356] then
                                                                                                                                                                                                                                                                                                                            var_HTTP_773.pen_counter = var_HTTP_773.pen_counter + 1
                                                                                                                                                                                                                                                                                                                            var_HTTP_773.registry[var_Event_356] = \\"pengutab\\" .. var_HTTP_773.pen_counter
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                        return var_Event_356
                                                                                                                                                                                                                                                                                                                    end, PENGUENV_GET = function(var_Table_535)
                                                                                                                                                                                                                                                                                                                        return var_Table_535
                                                                                                                                                                                                                                                                                                                    end, PENGUENV_CALL = function(var_NPC_210, ...)
                                                                                                                                                                                                                                                                                                                        return var_NPC_210(...)
                                                                                                                                                                                                                                                                                                                    end, PENGUENV_NAMECALL = function(eS, var_Math_958, ...)
                                                                                                                                                                                                                                                                                                                        return eS[var_Math_958](eS, ...)
                                                                                                                                                                                                                                                                                                                    end, pcall = function(var_NPC_210, ...)
                                                                                                                                                                                                                                                                                                                        local var_NPC_589 = {var_Data_766(var_NPC_210, ...)}
                                                                                                                                                                                                                                                                                                                        if not var_NPC_589[1] and var_Event_192(var_NPC_589[2]):match(\\"TIMEOUT\\") then
                                                                                                                                                                                                                                                                                                                            var_Iterator_08(var_NPC_589[2], 0)
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                        return table.unpack(var_NPC_589)
                                                                                                                                                                                                                                                                                                                    end},
                                                                                                                                                                                                                                                                                                                    {__index = _G, __newindex = _G}
                                                                                                                                                                                                                                                                                                                    )
                                                                                                                                                                                                                                                                                                                    if setfenv then
                                                                                                                                                                                                                                                                                                                        setfenv(var_Event_838, var_Table_419)
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    var_Data_652(\\"[PenguEnv V0.63] Executing Protected VM...\\")
                                                                                                                                                                                                                                                                                                                    local var_Camel_274 = var_Temp_15.clock()
                                                                                                                                                                                                                                                                                                                    var_HTTP_262(
                                                                                                                                                                                                                                                                                                                    function()
                                                                                                                                                                                                                                                                                                                        if var_Temp_15.clock() - var_Camel_274 > var_Temp_17.TIMEOUT_SECONDS then
                                                                                                                                                                                                                                                                                                                            error(\\"TIMEOUT\\", 0)
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                    end,
                                                                                                                                                                                                                                                                                                                    \\"\\",
                                                                                                                                                                                                                                                                                                                    1000
                                                                                                                                                                                                                                                                                                                    )
                                                                                                                                                                                                                                                                                                                    local var_Unknown_8652, eU =
                                                                                                                                                                                                                                                                                                                    var_Temp_07(
                                                                                                                                                                                                                                                                                                                    function()
                                                                                                                                                                                                                                                                                                                        var_Event_838()
                                                                                                                                                                                                                                                                                                                    end,
                                                                                                                                                                                                                                                                                                                    function(var_Math_456)
                                                                                                                                                                                                                                                                                                                        fn_Event_676(\\"Runtime Error: \\" .. tostring(var_Math_456))
                                                                                                                                                                                                                                                                                                                        return tostring(var_Math_456)
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    )
                                                                                                                                                                                                                                                                                                                    var_HTTP_262()
                                                                                                                                                                                                                                                                                                                    if not var_Unknown_8652 then
                                                                                                                                                                                                                                                                                                                        fn_Event_676(\\"Terminated: \\" .. eU)
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    return PenguEnv.save(eO or var_Temp_17.OUTPUT_FILE)
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                function PenguEnv.dump_string(var_Event_336, eO)
                                                                                                                                                                                                                                                                                                                    PenguEnv.reset()
                                                                                                                                                                                                                                                                                                                    fn_Event_676(\\"this file is generated using PenguEnv V0.63\\")
                                                                                                                                                                                                                                                                                                                    fn_Event_030()
                                                                                                                                                                                                                                                                                                                    if var_Event_336 then
                                                                                                                                                                                                                                                                                                                        var_Event_336 = fn_HTTP_705(var_Event_336)
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    local var_Event_838, var_String_767 = var_Data_859(var_Event_336)
                                                                                                                                                                                                                                                                                                                    if not var_Event_838 then
                                                                                                                                                                                                                                                                                                                        fn_Event_676(\\"Load Error: \\" .. (var_String_767 or \\"unknown\\"))
                                                                                                                                                                                                                                                                                                                        return false, var_String_767
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    xpcall(
                                                                                                                                                                                                                                                                                                                    function()
                                                                                                                                                                                                                                                                                                                        var_Event_838()
                                                                                                                                                                                                                                                                                                                    end,
                                                                                                                                                                                                                                                                                                                    function(var_Data_859)
                                                                                                                                                                                                                                                                                                                        fn_Event_676(\\"Execution Error: \\" .. tostring(var_Data_859))
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    )
                                                                                                                                                                                                                                                                                                                    if eO then
                                                                                                                                                                                                                                                                                                                        return PenguEnv.save(eO)
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    return true, fn_Event_060()
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                if arg and arg[1] then
                                                                                                                                                                                                                                                                                                                    local var_Unknown_8652 = PenguEnv.dump_file(arg[1], arg[2])
                                                                                                                                                                                                                                                                                                                    if var_Unknown_8652 then
                                                                                                                                                                                                                                                                                                                        var_Data_652(\\"Saved to: \\" .. (arg[2] or var_Temp_17.OUTPUT_FILE))
                                                                                                                                                                                                                                                                                                                        local var_HTTP_292 = PenguEnv.get_stats()
                                                                                                                                                                                                                                                                                                                        var_Data_652(
                                                                                                                                                                                                                                                                                                                        string.format(
                                                                                                                                                                                                                                                                                                                            \\"Lines: %var_HTTP_060 | Remotes: %var_HTTP_060 | Strings: %var_HTTP_060\\",
                                                                                                                                                                                                                                                                                                                            var_HTTP_292.total_lines,
                                                                                                                                                                                                                                                                                                                            var_HTTP_292.remote_calls,
                                                                                                                                                                                                                                                                                                                            var_HTTP_292.suspicious_strings
                                                                                                                                                                                                                                                                                                                            )
                                                                                                                                                                                                                                                                                                                            )
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                    local var_NPC_210 = var_Event_379.open(\\"obfuscated.lua\\", \\"rb\\")
                                                                                                                                                                                                                                                                                                                    if var_NPC_210 then
                                                                                                                                                                                                                                                                                                                        var_NPC_210:close()
                                                                                                                                                                                                                                                                                                                        local var_Unknown_8652 = PenguEnv.dump_file(\\"obfuscated.lua\\")
                                                                                                                                                                                                                                                                                                                        if var_Unknown_8652 then
                                                                                                                                                                                                                                                                                                                            var_Data_652(\\"Saved to: \\" .. var_Temp_17.OUTPUT_FILE)
                                                                                                                                                                                                                                                                                                                            var_Data_652(PenguEnv.get_output())
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                    var_Data_652(\\"Usage: lua PenguEnv.lua <input> [output] [key]\\")
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            _G.PenguEnvContinue = function()
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            return PenguEnv
                                                                                                                                                                                                                                                                                                            ")