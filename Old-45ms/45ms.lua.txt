local process = require("@lune/process")
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local realprint = print

local d = {
        output = {},
        registry = {},
        unusedHttp = {},
        counter = 0,
        indent = 0,
}

local LOOP_THRESHOLD = 5
local MAX_BLOCK_SIZE = 20

local function pad() return string.rep("    ", d.indent) end
local function normalizeLine(str) return str:gsub("_[0-9]+", "_X") end

local function emit(line, log)
        if line then
                table.insert(d.output, pad() .. line)
                local n = #d.output
                if n >= LOOP_THRESHOLD then
                        for blockSize = 1, MAX_BLOCK_SIZE do
                                if n >= blockSize * LOOP_THRESHOLD then
                                        local isCycle = true
                                        for r = 1, LOOP_THRESHOLD - 1 do
                                                for i = 0, blockSize - 1 do
                                                        local currentLine = normalizeLine(d.output[n - i])
                                                        local previousLine = normalizeLine(d.output[n - i - (r * blockSize)])
                                                        if currentLine ~= previousLine then
                                                                isCycle = false
                                                                break
                                                        end
                                                end
                                                if not isCycle then break end
                                        end
                                        if isCycle then
                                                local block = {}
                                                for i = blockSize - 1, 0, -1 do table.insert(block, d.output[n - i]) end
                                                for _ = 1, blockSize * LOOP_THRESHOLD do table.remove(d.output) end
                                                table.insert(d.output, pad() .. "while true do")
                                                for _, l in ipairs(block) do table.insert(d.output, "    " .. l) end
                                                table.insert(d.output, pad() .. "end")
                                                error("LOOP_DETECTED", 0)
                                        end
                                end
                        end
                end
        end
        if log and line then realprint(d.output[#d.output]) end
end

local function serialize(v, ind, seen)
        ind = ind or 0
        seen = seen or {}
        local t = type(v)

        if t == "string" then
                return '"' .. v:gsub("\\", "\\\\"):gsub("\n", "\\n"):gsub("\r", "\\r"):gsub("\t", "\\t"):gsub('"', '\\"') .. '"'
        elseif t == "number" or t == "boolean" then
                return tostring(v)
        elseif t == "nil" then
                return "nil"
        elseif t == "function" then
                return "function(...) end"
        elseif t == "table" then
                if d.registry[v] then return d.registry[v] end
                if seen[v] then return "{...}" end
                seen[v] = true

                local isArray, maxKey = true, 0
                for k, _ in pairs(v) do
                        if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then isArray = false break end
                        if k > maxKey then maxKey = k end
                end

                if isArray then
                        local parts = {}
                        for i = 1, maxKey do table.insert(parts, serialize(v[i], ind, seen)) end
                        return "{" .. table.concat(parts, ", ") .. "}"
                else
                        local parts = {}
                        local innerPad = string.rep("    ", ind + 1)
                        local empty = true
                        for k, val in pairs(v) do
                                empty = false
                                local key = (type(k) == "string" and k:match("^[%a_][%w_]*$")) and k or ("[" .. serialize(k, 0, seen) .. "]")
                                local value = serialize(val, ind + 1, seen)
                                table.insert(parts, innerPad .. key .. " = " .. value)
                        end
                        if empty then return "{}" end
                        return "{\n" .. table.concat(parts, ",\n") .. "\n" .. string.rep("    ", ind) .. "}"
                end
        else
                return d.registry[v] or tostring(v)
        end
end

local function serializeArgs(args, start)
        local out = {}
        for i = start or 1, #args do table.insert(out, serialize(args[i], d.indent)) end
        return out
end

local function nextVar(prefix)
        d.counter += 1
        return (prefix or "var") .. "_" .. d.counter
end

local COLON_METHODS = {
        HttpGet = true, HttpGetAsync = true, WaitForChild = true, FindFirstChild = true,
        FindFirstChildOfClass = true, FindFirstChildWhichIsA = true, GetService = true,
        Connect = true, Once = true, Wait = true, Clone = true, Destroy = true, Create = true,
        Play = true, Stop = true, FireServer = true, InvokeServer = true, SetCore = true,
        GetCore = true, JSONEncode = true, JSONDecode = true, GetAsync = true, PostAsync = true,
        GetChildren = true, GetDescendants = true, IsA = true, SetAttribute = true,
        GetAttribute = true, ClearAllChildren = true, Remove = true, RequestAsync = true,
        Kick = true, Ban = true, Disconnect = true, Fire = true, Invoke = true,
        BindToRenderStep = true, UnbindFromRenderStep = true, CreateWindow = true, AddButton = true,
        AddToggle = true, AddSlider = true, AddDropdown = true, AddColorPicker = true, MakeWindow = true,
        AddTab = true, AddSection = true, AddLabel = true, AddTextbox = true, AddBind = true,
        AddKeybind = true, Init = true, Build = true, CreateSection = true, CreateTab = true,
        CreateSlider = true, CreateButton = true, CreateToggle = true, AddParagraph = true,
        MakeTab = true, MakeSection = true, GetPivot = true, GetBoundingBox = true,
        GetFullName = true, IsDescendantOf = true, FindFirstAncestor = true, FindFirstAncestorOfClass = true,
        GetPlayers = true, GetPlayerByUserId = true, SendKeyEvent = true, SendMouseButtonEvent = true,
        IsKeyDown = true, IsMouseButtonPressed = true
}

local VOID_METHODS = {
        Destroy = true, Play = true, Stop = true, FireServer = true, ClearAllChildren = true,
        Remove = true, Kick = true, Ban = true, Disconnect = true, SetAttribute = true, Fire = true,
        CaptureFocus = true, ReleaseFocus = true, SetPrimaryPartCFrame = true, BreakJoints = true,
        PivotTo = true, SendKeyEvent = true, SendMouseButtonEvent = true,
}

local CALLBACK_METHODS = {
        Connect = true, Once = true, Activated = true, MouseButton1Click = true, MouseButton2Click = true,
        MouseButton1Down = true, MouseButton1Up = true, MouseButton2Down = true, MouseButton2Up = true,
        FocusLost = true, TouchTap = true, InputBegan = true, InputEnded = true, InputChanged = true,
        MouseEnter = true, MouseLeave = true, Changed = true, OnClientEvent = true, OnServerEvent = true,
        RenderStepped = true, Heartbeat = true, Stepped = true, Idled = true
}

local DOTCALL_METHODS = {
        fromRGB = true, fromHSV = true, fromHex = true, lookAt = true, Angles = true,
        fromAxisAngle = true, fromOrientation = true,
}

local function makeProxy(name, register)
        local proxy = newproxy(true)
        local mt = getmetatable(proxy)
        if register then d.registry[proxy] = name end

        mt.__index = function(self, key)
                if type(key) == "number" then return nil end
                local path = d.registry[self] or name
                local keyStr = tostring(key)
                local newPath = path .. (COLON_METHODS[keyStr] and ":" or ".") .. keyStr
                local p = makeProxy(newPath, false)
                d.registry[p] = newPath
                return p
        end

        mt.__newindex = function(self, key, value)
                local path = d.registry[self] or name
                emit(path .. "." .. tostring(key) .. " = " .. serialize(value, d.indent), true)
        end

        mt.__call = function(self, ...)
                local fullPath = d.registry[self] or name
                local raw = { ... }
                local parent, method = fullPath:match("(.+)[%.:]([^%.:]+)$")
                local isColonCall = false
                if parent and type(raw[1]) == "userdata" and d.registry[raw[1]] == parent then isColonCall = true end

                local args = {}
                local startIdx = isColonCall and 2 or 1
                for i = startIdx, #raw do table.insert(args, raw[i]) end
                local argStrs = serializeArgs(args)

                for _, arg in ipairs(args) do
                        local argName = d.registry[arg]
                        if argName and d.unusedHttp[argName] then d.unusedHttp[argName] = nil end
                end

                if CALLBACK_METHODS[method] or CALLBACK_METHODS[fullPath:match("[^.:]+$")] then
                        local callback = raw[1] or args[1]
                        if type(callback) == "function" then
                                local var = nextVar("conn")
                                emit("local " .. var .. " = " .. fullPath .. "(function(...))", true)
                                d.indent += 1
                                local mockArgs = {}
                                for i = 1, 3 do table.insert(mockArgs, makeProxy(nextVar("arg"), false)) end
                                pcall(callback, unpack(mockArgs))
                                d.indent -= 1
                                emit("end)", true)
                                local p = makeProxy(var, false)
                                d.registry[p] = var
                                return p
                        end
                end

                if not parent then
                        local var = nextVar("result")
                        emit("local " .. var .. " = " .. fullPath .. "(" .. table.concat(serializeArgs(raw), ", ") .. ")", true)
                        local p = makeProxy(var, false)
                        d.registry[p] = var
                        return p
                end

                local sep = COLON_METHODS[method] and ":" or "."
                local call = parent .. sep .. method

                if method == "new" then
                        local var = nextVar("inst")
                        emit("local " .. var .. " = " .. parent .. ".new(" .. table.concat(argStrs, ", ") .. ")", true)
                        local p = makeProxy(var, false)
                        d.registry[p] = var
                        return p
                elseif DOTCALL_METHODS[method] then
                        local var = nextVar("val")
                        emit("local " .. var .. " = " .. parent .. "." .. method .. "(" .. table.concat(argStrs, ", ") .. ")", true)
                        local p = makeProxy(var, false)
                        d.registry[p] = var
                        return p
                elseif method == "GetService" then
                        local svc = args[1]
                        local var = nextVar(tostring(svc):sub(1, 4):lower())
                        emit("local " .. var .. " = " .. parent .. ":GetService(" .. serialize(svc, 0) .. ")", true)
                        local p = makeProxy(var, false)
                        d.registry[p] = var
                        return p
                elseif VOID_METHODS[method] then
                        emit(call .. "(" .. table.concat(argStrs, ", ") .. ")", true)
                else
                        local var = nextVar("r")
                        emit("local " .. var .. " = " .. call .. "(" .. table.concat(argStrs, ", ") .. ")", true)
                        if method == "HttpGet" or method == "HttpGetAsync" then d.unusedHttp[var] = true end

                        for _, arg in ipairs(args) do
                                if type(arg) == "table" and (arg.callback or arg.Callback) and type(arg.callback or arg.Callback) == "function" then
                                        local cb = arg.callback or arg.Callback
                                        d.indent += 1
                                        pcall(cb, true)
                                        d.indent -= 1
                                end
                        end

                        local p = makeProxy(var, false)
                        d.registry[p] = var
                        return p
                end
        end

        mt.__tostring = function(self) return d.registry[self] or name end
        mt.__concat = function(a, b) return tostring(a) .. tostring(b) end
        return proxy
end

local function mockProxy(name)
        return function(...)
                local argStrs = serializeArgs({...})
                local var = nextVar((name:match("[^%.]+$") or "proxy"):lower())
                emit("local " .. var .. " = " .. name .. "(" .. table.concat(argStrs, ", ") .. ")", true)
                local p = makeProxy(var, false)
                d.registry[p] = var
                return p
        end
end

local function mockVoid(name)
        return function(...)
                local argStrs = serializeArgs({...})
                emit(name .. "(" .. table.concat(argStrs, ", ") .. ")", true)
        end
end

local function mockReturn(name, val)
        return function(...)
                local argStrs = serializeArgs({...})
                if #argStrs > 0 then
                        emit("local _ = " .. name .. "(" .. table.concat(argStrs, ", ") .. ")", true)
                else
                        emit("local _ = " .. name .. "()", true)
                end
                return val
        end
end

local function makeLibrary(name, predefined)
        local lib = predefined or {}
        return setmetatable(lib, {
                __index = function(_, k) return mockProxy(name .. "." .. tostring(k)) end,
                __newindex = function(_, k, v) emit(name .. "." .. tostring(k) .. " = " .. serialize(v, d.indent), true) end
        })
end

local function buildEnv()
        local env = {}
        local robloxTypes = { "Instance", "CFrame", "Vector3", "Vector2", "UDim", "UDim2", "Color3", "Rect", "Ray", "NumberRange", "PhysicalProperties", "TweenInfo", "OverlapParams", "RaycastParams", "Font", "Enum", "Enums", "BrickColor", "Region3", "PathWaypoint" }
        local robloxGlobals = { "game", "workspace", "script", "plugin", "shared", "CoreGui", "Stats", "Lighting", "Players", "ReplicatedFirst", "ReplicatedStorage", "ServerScriptService", "ServerStorage", "StarterGui", "StarterPack", "StarterPlayer", "Teams", "SoundService", "Chat", "TextChatService" }

        for _, n in ipairs(robloxTypes) do env[n] = makeProxy(n, true) end
        for _, n in ipairs(robloxGlobals) do env[n] = makeProxy(n, true) end

        env.cache = makeLibrary("cache", { invalidate = mockVoid("cache.invalidate"), iscached = mockReturn("cache.iscached", true), replace = mockVoid("cache.replace") })

        env.crypt = makeLibrary("crypt", {
                base64encode = mockReturn("crypt.base64encode", "dW5j"),
                base64decode = mockReturn("crypt.base64decode", "unc"),
                encrypt = mockReturn("crypt.encrypt", "encrypted_data"),
                decrypt = mockReturn("crypt.decrypt", "decrypted_data"),
                generatebytes = mockReturn("crypt.generatebytes", "bytes"),
                generatekey = mockReturn("crypt.generatekey", "key"),
                hash = mockReturn("crypt.hash", "hash")
        })

        env.http = makeLibrary("http", { request = mockProxy("request") })

        local proxyFns = { "readfile", "getgc", "getinstances", "getnilinstances", "getscripts", "getconnections", "gethui", "getrawmetatable", "hookmetamethod", "hookfunction", "cloneref", "request", "getloadedmodules", "getreg", "getsenv", "getcallbackvalue", "getcustomasset", "gethiddenproperty", "getscripthash", "getcallstack", "getinputs", "getrunningscripts", "lz4compress", "lz4decompress", "listfiles", "getnamecallmethod", "rconsoleinput", "newcclosure", "loadfile", "getthreadidentity" }
        local voidFns = { "writefile", "appendfile", "makefolder", "setthreadidentity", "rconsoleprint", "mouse1click", "keypress", "setclipboard", "fireclickdetector", "setfflag", "sethiddenproperty", "setrawmetatable", "setnamecallmethod", "setreadonly", "delfolder", "delfile", "setfpscap", "setrbxclipboard", "fireproximityprompt", "firetouchinterest", "rconsoleinfo", "rconsolewarn", "rconsoleerr", "rconsoleclear", "rconsolename", "mouse1press", "mouse1release", "mouse2click", "mouse2press", "mouse2release", "mousescroll", "mousemoverel", "mousemoveabs", "keyrelease" }
        local trueFns = { "isfile", "isfolder", "checkcaller", "isrbxactive", "getfflag", "getfflags", "isfflagenabled", "checkclosure", "islclosure", "iscclosure", "isreadonly", "isnetworkowner", "compareinstances" }

        for _, name in ipairs(proxyFns) do env[name] = mockProxy(name) end
        for _, name in ipairs(voidFns) do env[name] = mockVoid(name) end
        for _, name in ipairs(trueFns) do env[name] = mockReturn(name, true) end

        env.identifyexecutor = function() emit("local exec_name, exec_ver = identifyexecutor()", true) return "MimicDumper", "2.0" end
        env.getgenv = function() return env end
        env.getrenv = function() return env end
        env._G = env
        env.print = function(...) emit("print(" .. table.concat(serializeArgs({...}), ", ") .. ")", true) end
        env.warn = function(...) emit("warn(" .. table.concat(serializeArgs({...}), ", ") .. ")", true) end

        env.task = makeLibrary("task", {
                wait = function(n) emit("task.wait(" .. serialize(n, 0) .. ")", true) return 0 end,
                spawn = function(f, ...) emit("task.spawn(function())", true) d.indent += 1 pcall(f, ...) d.indent -= 1 emit("end)", true) end,
                defer = function(f, ...) emit("task.defer(function())", true) d.indent += 1 pcall(f, ...) d.indent -= 1 emit("end)", true) end,
                delay = function(n, f, ...) emit("task.delay(" .. serialize(n, 0) .. ", function())", true) d.indent += 1 pcall(f, ...) d.indent -= 1 emit("end)", true) end
        })

        env.require = function(module)
                local var = nextVar("module")
                emit("local " .. var .. " = require(" .. serialize(module, 0) .. ")", true)
                local p = makeProxy(var, false)
                d.registry[p] = var
                return p
        end

        env.loadstring = function(src, chunkname)
                local argStr = d.registry[src]
                if argStr and d.unusedHttp[argStr] then d.unusedHttp[argStr] = nil end
                local var = nextVar("loaded")
                emit("local " .. var .. " = loadstring(" .. serialize(src, 0) .. (chunkname and (", " .. serialize(chunkname, 0)) or "") .. ")", true)
                return function(...)
                        local argStrs = serializeArgs({...})
                        local retVar = nextVar("chunk_res")
                        emit("local " .. retVar .. " = " .. var .. "(" .. table.concat(argStrs, ", ") .. ")", true)
                        local p = makeProxy(retVar, false)
                        d.registry[p] = retVar
                        return p
                end
        end

        setmetatable(env, {
                __newindex = function(t, k, v)
                        if type(v) == "function" then
                                emit("function " .. tostring(k) .. "(...)\nend", true)
                        else
                                emit(tostring(k) .. " = " .. serialize(v, d.indent), true)
                        end
                        rawset(t, k, v)
                end
        })

        return env
end

local function run(input, output)
        output = output or "output.lua"
        local ok, source = pcall(fs.readFile, input)
        if not ok then realprint("[!] Failed to read: " .. input) return false end
        d.output, d.registry, d.unusedHttp, d.counter, d.indent = {}, {}, {}, 0, 0
        emit("-- Generated by 45ms discord.gg/4H6wAW7mx7", false)
        local env = buildEnv()
        local fn, compileErr = luau.load(source, { environment = env })
        if not fn then realprint("[!] Compile error: " .. tostring(compileErr)) return false end
        pcall(fn)
        for httpVar, _ in pairs(d.unusedHttp) do emit("loadstring(" .. httpVar .. ")()", true) end
        fs.writeFile(output, table.concat(d.output, "\n"))
        realprint("[*] Saved to: " .. output)
end

local args = process.args
if #args >= 1 then run(args[1], args[2]) else realprint("Usage: lune run you <input> [output]") end
