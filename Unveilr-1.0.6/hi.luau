--!allah is lord;
--! BEFORE YOU READ, MAKE SURE YOU USE PASCALCASE, I DONT WANNA LOOK IN A RANDOM PLACE AND SEE varMtrms = 1

--* Work on adding addresses to functions and tables (instead of tostring(string) = "string", make it table: 0xsomething)
--* Fix moonsec constant protection not working (idk how) (i found how)
--* Fix luraph not working with hookop (use the juju.lol script)
--* Fix that one obfuscator not working
--* Fix unparser.lua making some scripts detected..? (jayfuscator.txt)
--* Add rawget(self, "V") in comparators (a < b, a > b)
--* Fix indenting
--* Make elseif also call CHECKIF
--* add HOOKEXP() which lets you hook a SPECIFIC expression
--* make "not not" get auto removed
--* fix too many operations preventing output from being sent
--* Maybe fix spy_exec_only by returning a safe env with getfenv() returning the spied env? idk (FIXED)
--* Fix debug.getinfo
--* Fix recursive tables (local a = {} a.b = a print(a))

--!TODO: Fix the scripts COMPLETELY breaking when hookop is on with luraph (its the for loops)
--!TODO: Make CHECKAND work
--!TODO: Fix unparser breaking scripts/nicuse.lua
--!TODO: Fix max operations thing not always working

--* LOCALIZATION:

local loadstring = require("@lune/luau").load
local fs = require("@lune/fs")

local Process = require("@lune/process")
task = require("@lune/task")

local Setmetatable = setmetatable
local Clock = os.clock
local Typeof, Tostring, Tonumber, Next, Unpack, RawEqual, RawGet = typeof, tostring, tonumber, next, unpack, rawequal, rawget
local Gsub, Rep, Format, Sub, Match, Split, Char, Byte, Lower, Upper = string.gsub, string.rep, string.format, string.sub, string.match, string.split, string.char, string.byte, string.lower, string.upper
local Find, Insert, Concat, Move, Pack, Remove = table.find, table.insert, table.concat, table.move, table.pack, table.remove
local Wrap, Yield = coroutine.wrap, coroutine.yield
local DebugInfo = debug.info

local Alphabet = Split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", "")

local next = next

local _print = print
print = function(...)
    local function Color(txt, code)
        return `\27[{code}m{txt}\27[0m`
    end

    local Line, Name = DebugInfo(2, "ln")
    local ColoredName = Color(Name == "" and "???" or Name, 32)
    local ColorLine = Color(`line {Line}`, 35)

    local FinalText = `[ {ColoredName} @ {ColorLine} ]:`

    _print(FinalText, ...)
end

local function GenerateId(len)
    local txt = ''
    for i = 1,len or 6 do
        txt ..= Alphabet[math.random(1, #Alphabet)]
    end
    return txt
end

local function RE_Safe(Str, FullChars)
    local Chars = (FullChars and "%()[].-+^*$?" or "%"):split("")
    for _, char in next, Chars do
        Str = Str:gsub("%" .. char, "%%" .. (char == "%" and "%" or "") .. char)
    end
    return Str
end

local function Strip(Str, IgnoreStart)
    local start_idx, end_idx = 1, #Str
    local Split = Str:split("")

    local Spaces = { [" "] = true, ["\t"] = true, ["\r"] = true, ["\n"] = true }

    if not IgnoreStart then for i = 1, #Split do if not Spaces[Split[i]] then start_idx = i break end end end
    for i = #Split, 1, -1 do if not Spaces[Split[i]] then end_idx = i break end end

    return Str:sub(start_idx, end_idx)
end

local TraceId = GenerateId(7)
--local Types = {}

local FileSystem = {
    read = fs.readFile,
    write = fs.writeFile
}

local Settings = {
    hookOpValue = "spy",
    hookOp = true,
    explore_funcs = true,
    spy_exec_only = true,
    minifier = true,
    varRenamer = false,
    raw = false, --> Loads stuff instantly
    max_ops = 10_500, -- the max number of operations the script can perform
    max_while_count = 100_000,
    saveFails = false,
    env_index = false
}

local function StrToValue(Str)
    if Str == "false" then return false
    elseif Str == "true" then return true
    elseif Str == "nil" then return nil
    elseif tonumber(Str) then return tonumber(Str)
    else return Str end
end

for index, arg in Process.args do
    local k, v = Match(arg, "--([%w_]+)=(.+)")

    local Arg = Sub(arg, 3) -- remove --

    if v then -- version=, outfile =
        Settings[k] = StrToValue(v)
    else
        Settings[Arg] = true
    end
end

local Top = {
    add_if_comment = false
}

local Version = "1.0.6"

local ExecEnv = {"game";"workspace";"script";"Instance";"Enum";"Vector3";"Vector2";"Vector3int16";"Vector2int16";"UDim";"UDim2";"CFrame";"Color3";"BrickColor";"Ray";"Axes";"Faces";"Region3";"Region3int16";"Rect";"NumberRange";"PhysicalProperties";"cache";"cloneref";"compareinstances";"checkcaller";"clonefunction";"getcallingscript";"getscriptclosure";"hookfunction";"iscclosure";"islclosure";"isexecutorclosure";"loadstring";"newcclosure";"rconsoleclear";"rconsolecreate";"rconsoledestroy";"rconsoleinput";"rconsoleprint";"rconsolesettitle";"crypt";"debug";"readfile";"listfiles";"writefile";"makefolder";"appendfile";"isfile";"isfolder";"delfolder";"delfile";"loadfile";"dofile";"isrbxactive";"mouse1click";"mouse1press";"mouse1release";"mouse2click";"mouse2press";"mouse2release";"mousemoveabs";"mousemoverel";"mousescroll";"fireclickdetector";"getcallbackvalue";"getconnections";"getcustomasset";"gethiddenproperty";"sethiddenproperty";"syn";"gethui";"getinstances";"getnilinstances";"isscriptable";"setscriptable";"setrbxclipboard";"getrawmetatable";"hookmetamethod";"getnamecallmethod";"isreadonly";"setrawmetatable";"setreadonly";"identifyexecutor";"lz4compress";"lz4decompress";"messagebox";"request";"setclipboard";"setfpscap";"getgc";"getgenv";"getloadedmodules";"getrenv";"getrunningscripts";"getscriptbytecode";"getscripthash";"getscripts";"getsenv";"getthreadidentity";"setthreadidentity";"Drawing";"isrenderobj";"getrenderproperty";"setrenderproperty";"cleardrawcache";"WebSocket";"getfenv";"coroutine";"math";"string";"table";"os";"utf8";"bit32";"buffer";"TweenInfo";"RaycastParams";"OverlapParams";"Random";"ColorSequence";"ColorSequenceKeypoint";"NumberSequenceKeypoint";"NumberSequence";"SharedTable";"shared";"Font";"elapsedTime";"settings";"tick";"time";"typeof";"UserSettings";"version","warn";"plugin";"shared";"assert";"error";"gcinfo";"getmetatable";"ipairs";"newproxy";"next";"pairs";"pcall";"print";"rawequal";"rawget";"rawlen";"rawset";"require";"select";"setmetatable";"tostring";"unpack";"xpcall";"_G";"_VERSION";"Game","Workspace";"gethwid";"delay"}

local newcclosure = function(Function)
    local a = Wrap(function(...)
        local b = {Yield()}
        while true do
            b = {Yield(Function(Unpack(b)))}
        end
    end)
    a()
    return a
end

local NewCClosure = newcclosure

local Internal, Addresses, ParamsUsed = {}, {}, {}

local Values = {}
local Output = {}
local Id, ExpressionId, ExpressionHooks = 0, 0, {}

local Success, T = pcall(function()
    return require("../Libraries/Types.luau")
end)

local Types = Success and T or require("./Libraries/Types.luau")

local function GetActualPath(Path)
    local Result = Path;

    while true do
        local Value = Values[Result]
        if not Value then break end
        Result = Value.Value
    end

    return Result
end

local function GetAddress(P, T)
    local Address = Addresses[P] or Format('%s0x%s', ((T == 'function' or T == 'table') and `{T}: ` or ''), Match(tostring(function()end), "0x([A-Fa-f0-9]+)"))

    Addresses[P] = Address
    return Address
end

local function GetType(Name)
    local OldType = Typeof(Name)
    if OldType ~= "string" then
        return OldType
    end

    for Type, List in next, Types do
        if Find(List, Name) then return Type end
    end
end

local function Main(Source, NestCount, CurrentIndent, Original)
    local OutFile = Settings.outfile or "out2.lua"

    CurrentIndent = CurrentIndent or 0
    NestCount = NestCount or 0

    local LoopCount, OpCount = 0, 0

    local function OpCountCheck()
        if OpCount >= Settings.max_ops then print('stopp') error("Too many operations.", 2) end
    end

    local Tab = Rep("    ", CurrentIndent)
    local ParamSuffix = NestCount == 0 and "" or `_{NestCount}`

    local function IsInternal(x)
        local i = Internal[x]
        if i then Use(i, "__tostring") end
        return i
    end

    local function GetVarID() Id += 1 return `var{Id}{ParamSuffix}` end
    local function Append(a)
        --print("Append", a)
        Output[#Output+1] = Tab .. a
        if Settings.saveFails and Original then task.spawn(fs.writeFile, OutFile, Concat(Output, "\n")) end --> might be VERY horrible but it gets the j#b done 
    end
    function Beautify(Data, Indent, Args)
        Indent = Indent or CurrentIndent

        Args = Typeof(Args) == "table" and Args or {}

        local FuncName = Args.FuncName
        local Minify = Args.Minify

        local function IsRecursive(t)
            local visited = {}

            local function check(tbl)
                if visited[tbl] then
                    return true
                end

                visited[tbl] = true

                for _, v in next, tbl do
                    if type(v) == "table" then
                        if check(v) then
                            return true
                        end
                    end
                end

                visited[tbl] = nil
                return false
            end

            return check(t)
        end

        local Types = {
            ["table"] = function() --> x:CreateWindow(args)
                --print("yo",debug.traceback())
                local Int = IsInternal(Data)
                if Int then return Int end

                if IsRecursive(Data) then return "{ \"recursive table\" }" end

                local Options = {Minify = true}

                local Result = "{"
                local NewLine, Tab = Minify and " " or "\n", Minify and "" or Rep("    ", Indent)
                local Count, Dict = 0

                for k, v in Next, Data do -- Next to bypass __iter
                    Count += 1
                    
                    local Base = `{NewLine}{Tab}`
                    local Fixed = IsWeird(k) and `[{Beautify(k, Indent, Options)}]` or k
                    local Key = Count == k and not Dict and Base or `{Base}{Fixed} = ` --> Support for arrays

                    if Count ~= k then Dict = true end

                    Result ..= `{Key}{Beautify(v, Indent + 1, {FromBeautify = true})},`
                end

                local End = Minify and " }" or `\n{Rep("    ", Indent - 1)}}`

                return Count == 0 and "{}" or Sub(Result, 1, -2) .. End
            end,
            ["string"] = function()
                local Replaced = Gsub(Data, "\\", "\\\\")

                Replaced = Gsub(Replaced, "[\n\b\t\v\f\"\r]", {
                    ["\n"] = "\\n", ["\b"] = "\\b", ["\t"] = "\\t", ["\v"] = "\\v", ["\f"] = "\\f", ["\""] = "\\\"", ["\r"] = "\\r"
                })

                if #Replaced > 1000 then
                    Replaced = Sub(Replaced, 1, 1000) .. `..( {#Replaced - 1000} bytes left)` --> heh
                end

                return ('"' .. Replaced .. '"')
            end,
            ["function"] = function()
                local S, N = DebugInfo(Data, "sn")
                N = FuncName or N

                if not Settings.explore_funcs then return `function()--[[enable explore funcs to view this function]]end`, N end
                if S == "[C]" then return N == "" and "(function()--[[cclosure]]end)" or N, N end

                --^^ ts is just for stuff like pcall, explore funcs and func names

                local Old, OldParams = Output, ParamsUsed
                Output, ParamsUsed = {}, {} --> so we can capture everything new the code runs
            
                local CallBody, Return = Main(Data, NestCount + 1, Indent)
                local FunctionIndent = Args.FromBeautify and Rep("    ", Indent) or Rep(" ", 4)

                local Sorted = {}
                for k in next, ParamsUsed do
                    table.insert(Sorted, k)
                end

                table.sort(Sorted, function(a, b)
                    return (Tonumber(Match(a, "arg(%d+)")) or math.huge) < (Tonumber(Match(b, "arg(%d+)")) or math.huge)
                end)

                local ParamList = {}
                for _, key in next, Sorted do
                    Insert(ParamList, ParamsUsed[key] and key or "_")
                end

                for i = #ParamList, 1, -1 do
                    if ParamList[i] == "_" then
                        Remove(ParamList, i)
                    else
                        break
                    end
                end

                local Params = Concat(ParamList, ", ")

                local Body = '';
                if FuncName then
                    if IsWeird(FuncName) then
                        Body ..= `{Index(FuncName)} = function`
                    else
                        Body ..= `function {FuncName}`
                    end
                else
                    Body ..= "function"
                end

                Body ..= `({Params})\n`

                if #CallBody > 0 then
                    Output = {}

                    for _, Line in next, Split(CallBody, "\n") do
                        Insert(Output, Line)
                    end
                end

                for _, v in next, Output do Body ..= FunctionIndent .. v .. "\n" end

                if Return then Body ..= FunctionIndent .. Return .. "\n" end --> return value

                Body, Output, ParamsUsed = Body .. (Indent > 1 and Rep("    ", Indent - 1) or "") .. "end", Old, OldParams --> this just works, i don't know why.

                return Body
            end,
            ["userdata"] = function() -- error i guess?
                local mt = getmetatable(Data)
                if mt then --> newproxy()
                    return `get_user_data({Beautify(mt, Indent + 1)})`
                end

                return Beautify(Tostring(Data))
            end,
            ["number"] = function()
                if Tonumber(Format("%.4f", Data)) ~= Data then Data = math.ceil(Data) end --> weird floats
                local str = Tostring(Data)
                return str == "-inf" and "-math.huge" or str == "inf" and "math.huge" or str
            end
        }

        local Value = Types[Typeof(Data)]
        local Return = Value and {Value()} or {Tostring(Data)}

        return Unpack(Return)
    end

    local function BeautifyTuple(...)
        local Out = ""
        local Args = Pack(...)
        
        for i = 1, Args.n do
            Out ..= `{Beautify(Args[i], CurrentIndent + 1)}, `
        end

        return Sub(Out, 1, -3)
    end

    function IsWeird(Key)
        return Key == "" or Match(Key, "[^_%w]") or Match(Key, "%d") == Sub(Key, 1, 1) --> Has non english character or starts with a number
    end

    function Index(Key, Path) --!TODO: Fix indexing with other vars
        local Beauty = IsInternal(Key)
        if Beauty then
            return Path and `{Path}[{Beauty}]` or Beauty --! a[b]
        end

        local IsWeirdo = IsWeird(Key)
        local IsVararg = Path == "..."

        if IsVararg then Path = "(...)" end

        return IsWeirdo and `{Path or "getfenv()"}[{Beautify(Key)}]` or `{Path and Path .. "." or ""}{Key}`
    end

    local Vars = {}

    local function GetVar(Idx)
        local Value = Vars[Idx] or 1

        Vars[Idx] = Value + 1
        return Value == 1 and "" or Value
    end

    local function SplitIDX(str) --> Returns the indexes of a string (a['b'], a.b, ...)
        str = tostring(str)

        local Result = {}
        for Part in str:gmatch("[^%.%[]+") do
            local Key = Part:match('^%s*(.-)%s*$')

            if Sub(Key, -1) == ']' then
                Key = Match(Key, '%[(.-)%]') or Key
                Key = Gsub(Key, '^["\'](.-)["\']$', '%1') -- remove quotes
            end
            Insert(Result, Key)
        end
        return Result
    end

    local function GenerateName(str, Method)
        while true do
            local Value = (Values[str] or {}).Value

            if Value then
                str = Value
            else break end
        end

        Method = Gsub(Method, "%A", "") == "" and (Method .. GetVar(Method) .. ParamSuffix) or Method

        if str == "GetService" then
            return Method .. Id
        elseif Method == "iter" then
            return str .. Id
        end

        return GetVarID()
    end

    local function Define(Var, Value, Tag)
        Values[Var] = {Value = Value, Tag = Tag, Line = #Output, Usage = 0}
    end

    function Use(Var, Tag, Increment, Val)
        local Value = Values[Var]
        if not Value then return Define(Var, Val, Tag) end
        if Value.Usage == 0 or Increment then Value.Usage = (Increment and Value.Usage or 0) + 1 end
    end

    local Spied = {}

    local function Spy(Path, Flags)
        if Spied[Path] then return Spied[Path] end

        Flags = Flags or {}

        local ISP = Flags.Param

        local function Arth(Symbol)
            return NewCClosure(function(a, b)
                local Value = `{Beautify(a)} {Symbol} {Beautify(b)}`
                local Var = GetVarID()

                -- add a uhhhh usage += 1 thing here
    
                Append(`local {Var} = {Value}`)
                Define(Var, Value, "__arth")
                return Spy(Var)
            end)
        end

        function Iter(_, Key)
            local Path = RawGet(_, "P")
            local Value = Values[Path] or {}
    
            local IterFunc = Path
    
            if not Key then
                if Value.Tag == "__call" and Value.Usage == 0 then
                    IterFunc = Value.Value
                    Output[Value.Line] = nil
                end
            else -- next, ipairs, whatever
                local Arg1 = Path;
                if Value.Usage == 0 then Arg1 = Value.Value or Path end
                IterFunc = Key == "next" and `next, {Arg1}` or `{Key}({Arg1})`
            end
    
            local Iv, Vv = GenerateName("k", "iter"), GenerateName("val", "iter")
    
            Append(`for {Iv}, {Vv} in {IterFunc} do`)
    
            local Called
            local Indent = CurrentIndent
            Tab = Rep("    ", Indent + 1)
                
            return function(_, k) --> if k and key == 'next' that means we're using next()
                if Called then Tab = Rep("    ", Indent) Append("end") return else Called = true end
    
                return Spy(Iv), Spy(Vv)
            end
        end

        local Mt = {
            __index = function(_, Key)
                --print("Indexed",Path,Key)

                if Path == "workspace" and Key == "subgmaallshaha" then return end --pristine antitamper

                local Var = GetVarID()
                local Value = Index(Key, Path) --> Variable index

                Use(Path, "__index", true)

                Append(`local {Var} = {Value}`)
                Define(Var, Value, "__index")
        
                return Spy(Var)
            end,
            __newindex = function(_, Key, Value)
                --print("newindex",Values[Path],Path,Key)

                local P = IsInternal(Value)
                    
                Use(Path, "__newindex", true)

                if Values[P] then Values[P].Usage -= 1 end --> TextLabel.Font = Enum.Font.GothamBold

                local InternalKey = IsInternal(Key)
                local Var = InternalKey and `{Path}[{InternalKey}]` or Index(Key, Path) --> Variable index

                Append(`{Var} = {Beautify(Value, CurrentIndent + 1)}`)

                Use(Var, "__newindex", true)
            end,
            __call = function(_, ...)
                Use(Path, "__call")

                local Path = Path == "..." and "(...)" or Path

                local Dots = SplitIDX(GetActualPath(Path))
                local Self = Concat(Move(Dots, 1, #Dots - 1, 1, {}), ".")

                local Args, Tuple, Var = Pack(...), {}

                for i = 1, Args.n do
                    local Arg = Args[i]
                    local b = Beautify(Arg, CurrentIndent + 1)
                    Insert(Tuple, b)
                end

                local FirstArg, SecondArg = Args[1], Args[2]

                if Beautify(FirstArg) == Self then -- Namecall
                    local Method = Dots[#Dots]
                    Path = `{Self}:{Method}`
                    Var = GenerateName(Method, Typeof(SecondArg) == "string" and SecondArg or "__call")

                    Remove(Tuple, 1)
                end

                Var = Var or GenerateName(Path, Typeof(FirstArg) == "string" and FirstArg or "__call")

                local Value = `{Path}({Concat(Tuple, ", ")})`

                Append(`local {Var} = {Value}`)
                Define(Var, Value, "__call")
                --Use(Var, "__call", true, Value)

                return Spy(Var)
            end,
            __add = Arth("+"), __sub = Arth("-"), __mul = Arth("*"), __div = Arth("/"), __idiv = Arth("//"), __pow = Arth("^"), __concat = Arth(".."), __mod = Arth("%"),
            __tostring = function(_)
                Use(Path, "__tostring"--[[, (Values[Path] or {}).Usage == 1]])

                return Path
            end,
            __unm = function(_)
                local Var = GenerateName(P, "unm")

                Append(`local {Var} = -{Path}`)
                return Spy(Var)
            end,
            __iter = Iter,
            __metatable = {}
        }

        for i, Method in Next, Mt do
            if Typeof(Method) ~= "function" then continue end

            Mt[i] = function(_, ...)
                OpCount += 1

                OpCountCheck()
                if ISP then ParamsUsed[Path] = true end

                return Method(_, ...)
            end
        end

        local Object = Setmetatable({P = Path, ISP = ISP}, Mt)
        Spied[Path] = Object

        if ISP then ParamsUsed[Path] = false end

        Internal[Object] = Path

        return Object
    end

    local function SpyParams(Amount)
        local Out = {}

        for i = 1, Amount do Out[#Out+1] = Spy(`arg{i}{ParamSuffix}`, {Param = true}) end

        return Unpack(Out)
    end

    local function CreateFunction(Callback, Path)
        Path = Path or "(function()end)"

        local Meta = Setmetatable({}, {
            __call = function(_, ...)
                return Callback(...)
            end,
            __tostring = function() return Path end
        })

        Internal[Meta] = Path

        return Meta
    end

    local IsFile = Typeof(Source) == "string"

    local function SafeWrap(f, path, isCore)
	    if Typeof(f) ~= "function" then return end

	    local name = DebugInfo(f, "n")

	    local function isDtc(v)
		    if Typeof(v) == "table" then
			    for k, val in next, v do
				    if isDtc(k) or isDtc(val) then
                        print("kv dtc",k,val)
					    return true
				    end
			    end
		    end

            local Internal = IsInternal(v)

		    return Internal and Internal ~= "getfenv()" and not Find({"string", "table", "os", "task", "coroutine", "debug"}, Internal) and not RawGet(v, "ISP")
	    end

	    local function helper(...)
			local var = GenerateName(name, "call")
			local value = `{path}({BeautifyTuple(...)})`

			Append(`local {var} = {value}`)
			Define(var, value, "__call")

			return Spy(var)
	    end

	    return CreateFunction(function(...)
		    local args = Pack(...)
	    	for i = 1, args.n do
    			local arg = args[i]

		    	if IsInternal(arg) and (not isCore or not RawGet(arg, "ISP")) then
                    local value = helper(...)
				    if value then return value end
				end
		    end

		    return f(...)
	    end, path)
    end

    local Locked;

    local function AddVar(Name1, Name2, Value, Tag)
        local Var = GenerateName(Name1, Name2)

        Append(`local {Var} = {Value}`)
        Define(Var, Value, Tag)

        return Var
    end

    local function Obfuscate(Code)
        local File = "temp/" .. GenerateId(6)

        fs.writeFile(File, Code)
        local t = Obf(File)
        fs.removeFile(File)
        return t
    end

    local function CreateLoader(Name)
        local Loader = Setmetatable({P=Name}, {
            __call = function(_, a, b)
                local IsString = Typeof(a) == "string"
                local IsWeird = b and Typeof(b) ~= "string" --> weird chunk names?

                local Value = `{Name}(`
                local Args = {a, b}
                Value ..= `{BeautifyTuple(Unpack(Args))})`

                if IsString and not IsWeird then
                    return Setmetatable({P=Value}, {
                        __call = function(_, ...)
                            Append(`{Value}({BeautifyTuple(...)})`)

                            local _a = a

                            if not Settings.raw then
                                local S, Obfuscated = pcall(Obfuscate, a) --! error is due to line checks hm.. how fix..?
                                if S then a = Obfuscated end
                            end

                            local Returned = {setfenv(loadstring(a, b), Locked)(...)}
                            local Message = Returned[2]
                            if not Returned[1] then Message = Sub(_a, 1, 1) == "\n" and Gsub(Message, ":1:", ":2:") or Message return false, Message end

                            return Unpack(Returned)
                        end,
                        __tostring = function() return Value end
                    })
                end

                return function(...)
                    local Vars = {}
                    local Str = "local "

                    for _ = 1, 3 do
                        local Var = GetVarID()
                        Str ..= Var .. ", "
                        
                        Insert(Vars, Spy(Var))
                    end

                    Append(`{Sub(Str, 1, -3)} = {Value}({BeautifyTuple(...)})`)

                    return Unpack(Vars)
                end
            end,
            __tostring = function() return Name end
        })
        Internal[Loader] = Name
        return Loader
    end

    local Loadstring = CreateLoader("loadstring")
    local Load = CreateLoader("load")

    local function FastComp(Symbol)
        return function(a, b)
            local A = IsInternal(a)
            local B = IsInternal(b)

            local v1, v2 = a, b;

            if A or B then
                if A then Use(A, "__comp", true) v1 = RawGet(a, "V") end
                if B then Use(B, "__comp", true) v2 = RawGet(b, "V") end

                return Spy(AddVar("Comp", Symbol, `{A or Beautify(a)} {Symbol} {B or Beautify(b)}`, "__comp"))
            end

            if Symbol == "<" then return v1 < v2
            elseif Symbol == ">" then return v1 > v2
            elseif Symbol == "<=" then return v1 <= v2
            elseif Symbol == ">=" then return v1 >= v2
            end
        end
    end

    local function FastEq(Symbol)
        return function(a, b)
            local A = IsInternal(a)
            local B = IsInternal(b)
                
            if A or B then
                local v1, v2;

                if A then Use(A, "__comp", true) v1 = RawGet(a, "V") end
                if B then Use(B, "__comp", true) v2 = RawGet(b, "V") end

                if v1 == nil then v1 = a end
                if v2 == nil then v2 = b end

                local Hook = ExpressionHooks[ExpressionId]
                local HookExists = Hook ~= nil

                local ValueOut;

                if HookExists then
                    if Hook ~= "nil" and Hook ~= "spy" then
                        ValueOut = Hook
                    else
                        HookExists = false
                    end
                end

                local Eq;
                
                if Symbol == "~=" then
                    Eq = v1 ~= v2
                else
                    Eq = v1 == v2
                end

                if HookExists then
                    Eq = ValueOut
                end

                local Var = AddVar("Equal", "", `{A or Beautify(a)} {Symbol} {B or Beautify(b)} --[[expr id {ExpressionId}, hooked: {HookExists}, value: {Eq}]]`, "__eq")
                ExpressionId += 1

                if HookExists then return Eq end

                local Value = Spy(Var); -- v is nil

                rawset(Value, "V", Eq)

                return Value
            end

            if Symbol == "~=" then return a ~= b else return a == b end
        end
    end

    local function Type(x, a)
        local p = IsInternal(a)
        if not p then return x == "type" and type(a) or typeof(a) end

        local S = Spy(`{x}({a})`)
        local Type = GetType(GetActualPath(p) or p)

        if p == "game" or p == "workspace" or p == "Workspace" or p == "Game" then --! hardcoded for now
            if x == "type" then
                Type = "userdata"
            else
                Type = "Instance"
            end
        end

        rawset(S, "V", Type)

        return S
    end

    local NextCalls = {}

    local Hooks = {
        hookexpr = function(id, val)
            ExpressionHooks[id] = val
        end,
        --[[rawget = function(a, b)

        end,]]
        next = function(tbl, ...)
            --print("next called",tbl,...)
            if IsInternal(tbl) then
                if NextCalls[tbl] then
                    return NextCalls[tbl](tbl, ...)
                end

                local Func = Iter(tbl, "next")
                NextCalls[tbl] = Func
                return Func(tbl, ...)
            else return next(tbl, ...) end
        end,
        getmetatable = function(tbl)
            if IsInternal(tbl) then return nil end

            local tp = Typeof(tbl)

            if tp ~= "table" and tp ~= "userdata" then error("invalid argument #1 to 'getmetatable', 'table' or 'userdata' expected got '" .. tp .. '') end
            return getmetatable(tbl)
        end,
        wait = function(a) return Spy(`wait({a})`) end,
        pcall = pcall--[[function(f, ...)
            local args = #({...})
            --Append(`pcall(function()--cannot spy, this call has {args} argend)`)
            return pcall(f, ...)
        end]],
        setfenv = function(a, b) --> prevent env wiping
            if getmetatable(b) then return end --> we don't wanna override, do we?
            setfenv(a, Setmetatable(b, Locked))
        end,
        islclosure = function(a)
            AddVar("IsLua", "_call", `islclosure({Beautify(a)})`, "__call")

            if IsInternal(a) then if Find(ExecEnv, a) then return false end end
            
            return DebugInfo(a, "s") ~= 'C'
        end,
        iscclosure = function(a)
            AddVar("IsC", "_call", `iscclosure({Beautify(a)})`, "__call")

            if IsInternal(a) then if Find(ExecEnv, a) then return true end end
            
            return DebugInfo(a, "s") == 'C'
        end,
        tostring = function(Str)
            if IsInternal(Str) then --> Hey get off my variable
                local Path = RawGet(Str, "P")
                local Type = GetType(Path)
                
                return GetAddress(Path, Type)
            end
            return Tostring(Str)
        end,
        CHECKIF = function(Condition)
            local Int = IsInternal(Condition)
            if Int then
                Top.add_if_comment = true

                local v = RawGet(Condition, "V")
                local Hook = ExpressionHooks[ExpressionId]
                local HookExists = Hook ~= nil

                if HookExists then
                    if Hook ~= "nil" and Hook ~= "spy" then
                        v = Hook
                    end
                end

                local DidRun = (v == nil or v) and "--[[ i ran ]]" or "--[[ i did not run ]]"
                
                Append(`if {Int} then {DidRun} end --[[expression id {ExpressionId} was hooked: {HookExists}]]\n`)

                ExpressionId += 1

                if v == nil then return Condition else return v end
            end

            return Condition
        end,
        CHECKWHILE = function(Condition)
            if Settings.max_while_count <= LoopCount then
                Append(`CHECKWHILE({Condition}) -- this was the last call before breaking out of a big while loop.`)
                return false
            end

            LoopCount += 1

            local Int = IsInternal(Condition)

            if Int then
                AddVar("While", "Condition", `CHECKWHILE({Int})`, "__while")
            end

            return Condition
        end,
        CHECKOR = function(a, b) --! isnt the issue..
            local A = IsInternal(a)
            local B = IsInternal(b)

            if A or B then
                local v1, v2;

                if A then
                    if A == "loadstring" then return Loadstring end --> ignore loadstring?
                    v1 = RawGet(a, "V")
                end
                if B then
                    if B == "loadstring" then return v1 or Loadstring end --^^
                    v2 = RawGet(b, "V")
                end

                if v1 == nil then v1 = a end
                if v2 == nil then v2 = b end

                if Tostring(v1 or v2) == "getfenv()" then return Locked end --> return the actual getfenv()

                local Var = Spy(AddVar("comp", "Or", `({A or Beautify(a)} or {B or Beautify(b)})`, "__comp"))
                rawset(Var, "V", v1 or v2)

                return Var
            end

            return a or b
        end,
        CHECKAND = function(a, b) --! Currently having issues with ts (Moonsec) its breaking a few things
            local A = IsInternal(a)
            local B = IsInternal(b)

            if A or B then
                local v1, v2;

                if A then Use(A, "__comp", true) v1 = RawGet(a, "V") end
                if B then Use(B, "__comp", true) v2 = RawGet(b, "V") end

                if v1 == nil then v1 = a end
                if v2 == nil then v2 = b end

                local Var = AddVar("Comp", "And", `{A or Beautify(a)} and {B or Beautify(b)}`, "__comp")

                if Settings.hookOpValue == "spy" then
                    local Return = Spy(Var)
                    rawset(Return, "V", v1 and v2)

                    return Return
                else
                    return v1 and v2
                end
            end

            return a and b
        end,
        CHECKNOT = function(a)
            local Path = IsInternal(a)
            if Path then
                if Path == "getconstants" then return true end
                if Path == "loadstring" then return false end --> not loadstring = false since loadstring exists

                local Var = GetVarID()
                local Value = `not {a}`
                Append(`local {Var} = {Value};`)
                Define(Var, Value, "__comp")

                if Settings.hookOpValue == "spy" then
                    local Return = Spy(Var)

                    local V = RawGet(a, "V")

                    if V == nil then V = true end

                    rawset(Return, "V", not V)

                    return Return
                end
            end
            return not a
        end,
        __NEQ = FastEq("~="),
        __EQ = FastEq("=="),
        CHECKLEN = function(a)
            local A = IsInternal(A)
            local Len = #a

            if A then
                Use(A, "__len", true)

                local Var = Spy(AddVar("Len", "len", `#{A}`, "__len"))
                rawset(Var, "V", Len)

                return Var
            end

            return Len
        end,
        COMPL = FastComp("<"),
        COMPG = FastComp(">"),
        COMPLE = FastComp("<="),
        COMPGE = FastComp(">="),
        getgc = function()
            return table.create(math.random(1000, 10_000), {})
        end
    }

    Hooks.type, Hooks.typeof = function(...)
        return Type("type", ...)
    end, function(...)
        return Type("typeof", ...)
    end
    
    local function Deglobal(Text) --> Prevents a string from being a global name (CFrame, math, ...)
        for _, Name in next, ExecEnv do
            if Text == Name then
                return Text .. GetVar(Text)
            end
        end
        return Text
    end

    local function HookLib(Lib, Extra)
        local l = getfenv()[Lib]
        local r = {P = Lib}

        for i, v in next, l do
            r[i] = SafeWrap(v, Index(i, Lib), true)
        end

        for i, v in next, Extra or {} do
            r[i] = v
        end

        local Meta = Setmetatable(r, {
            __tostring = function() return Lib end,
            __metatable = "This metatable is locked.",
            __iter = Iter
        })
        Internal[Meta] = Lib
        return Meta
    end

    Hooks.string, Hooks.table, Hooks.math = HookLib("string"), table, HookLib("math") --> maybe change table to Hooklib

    --[[Hooks.coroutine = HookLib("coroutine", {
        wrap = function(f)
            return coroutine.wrap(setfenv(f, Locked))
            --return Spy(AddVar("wrap", "coroutine", Beautify(f, CurrentIndent + 1), "__call"))
        end
    })]]
    Hooks.debug = Setmetatable({
        getinfo = function(thread)
            if typeof(thread) ~= "function" and typeof(thread) ~= "number" then return {numparams = 1, is_vararg = true, what = 'C', line = 1} end

            local line = debug.info(2, "l")

            local numparams, isvrg = DebugInfo(thread, 'a')
            return Setmetatable({
                ["line"] = line,
                ['numparams'] = numparams,
                ['is_vararg'] = isvrg and 1 or 0,
                ['what'] = DebugInfo(thread, 's') == '[C]' and 'C' or 'Lua'
            }, {
                __index = function(_, Key)
                    Append(`-- The script indexed debug.getinfo(...) with key '{Key}'.`)
                end
            })
        end,
        traceback = function(a)
            assert(not a or Typeof(a) == "string", "invalid argument #1 to 'traceback' (string expected got " .. Typeof(a) .. ")")

            local trace = debug.traceback(a)
            local lines = Split(trace, "\n")
            local out = {}

            for _, v in next, lines do
                if not Match(v, "%[string \".*hi\"%]") then
                    v = Gsub(v, "string \"luau%.load%(.-%)\"", TraceId)
                    Insert(out, v)
                end
            end --> covering my traces:)

            return Concat(out, "\n")
        end,
        setmetatable = Spy("debug.setmetatable"),
        P = "debug"
    }, {
        __index = function(_, Key)
            return debug[Key] and Spy(Index(Key, "debug")) or nil
        end,
        __tostring = function() return "debug" end,
        __newindex = function(_, k, v)
            if k == "P" then return end
            rawset(_, k, v)
        end,
        __iter = Iter
    })

    Internal[Hooks.debug] = "debug"

    local TrueEnv = getfenv(Main)
    TrueEnv.bit = bit32
    TrueEnv.ypcall = pcall

    local MoonSec = IsFile and Source:find("This file was protected with MoonSec V3")
    local MoonSecAntiTamper = MoonSec and Source:find("_ENV") --! since hookOp changes the original regex
    local MoonSecCP = MoonSec and Source:find("//") --> Constant Protection
    local Pristine;
    local Tasks = 0;

    local EnvValues = {_ENV = {}, bit = {bit32}}

    local IterFuncs = {"pairs", "ipairs"}
    local Funcs = {"newproxy", "select", "setmetatable", "assert", "rawget", "rawset", "xpcall", "unpack", "ypcall", "error", "spawn", "getmetatable"}
    local WrapFuncs = {"tonumber", "collectgarbage", "tostring", "pcall"}
    local Tables = {"bit", "bit32", "table", "coroutine"}

    local Env = {}

    for i, v in Next, Hooks do Env[i] = v end
    for _, i in Next, WrapFuncs do Env[i] = SafeWrap(TrueEnv[i], i) end
    for _, i in Next, Funcs do Env[i] = TrueEnv[i] end
    for _, i in Next, Tables do Env[i] = TrueEnv[i] end

    local Task = Setmetatable({}, {
        __index = function(_, Key)
            local Actual = task[Key]

            return Actual and (Pristine and function(...)
                Tasks += 1

                local Args = Pack(...)
                local Input = {}

                for i = 1, Args.n do
                    local Arg = Args[i]

                    if Typeof(Arg) == "function" then
                        Arg = setfenv(Arg, Locked)
                    end

                    Input[i] = Arg
                end

                return Pristine and Tasks <= 5 and Actual(Unpack(Input)) or Spy(AddVar("scheduled", "", `{Index(Key, "task")}({BeautifyTuple(Unpack(Input))})`, "__call"))
            end or function(...)
                local Indexed = Index(Key, "task")

                OpCount += 1
                OpCountCheck()

                return Spy(AddVar("", "", `{Indexed}({BeautifyTuple(...)})`, "__call"))
            end) or nil
        end
    })

    Internal[Task] = "task"

    Env.task = Task

    local Function = IsFile and loadstring(Source) or Source
    local SetfenvResult

    local ParamCount, Extra = DebugInfo(Function, "a")
    local Params = {SpyParams(ParamCount + 50)}

    if Extra then Insert(Params, Spy("...", { Param=true })) end

    if MoonSecAntiTamper then print("MoonSec anti tamper enabled") end
    if MoonSecCP then print("MoonSec constant protection enabled") end

    if MoonSecAntiTamper or MoonSecCP then --
        print("Script uses MoonSec AntiTamper / Constant Protection")

        local _fenv = getfenv() --> table.cloning ts breaks it so
        local _core = { tonumber = tonumber, select = select, unpack = unpack, tostring = tostring, pcall = pcall, setmetatable = setmetatable, rawget = rawget, assert = assert, os = os, type = type, bit32 = bit32 }

        for HookKey, Hook in next, Hooks do
            _core[HookKey] = _core[HookKey] or Hook
        end

        _core.wait = function() return 1 end

        local loads = 0;

        Locked = setmetatable(_core, {
            __index = function(_, Key)
                --print("[MSAT] Env Indexed",Key,#Key)

                if Key == "getconstants" or Key == "_ENV" then return end
                if Key == "getfenv" then return function() return Locked end end

                if #Key == 15 or Key == "type" or Key == "setfenv" then return _fenv[Key] end
                if Key == "loadstring" then
                    return Setmetatable({}, {
                        __call = function(_, Source, Chunk)
                            loads += 1
                            if Typeof(Source) == "table" and not IsInternal(Source) then error("no load") end --> {}

                            return function(...)
                                if Typeof(Source) == "string" then
                                    if loads <= 4 then
                                        if not Settings.raw then --> use hookOp and stuff yfm
                                            Source = Obfuscate(Source)

                                            return setfenv(loadstring(Source, Chunk), Locked)(...)
                                        end

                                        return loadstring(Source, Chunk)(...)
                                    end

                                    Append(Beautify(loadstring(Source)))
                                else
                                    local Var = GetVarID()
                                    Append(`local {Var} = loadstring({Beautify(Source)})({BeautifyTuple(...)})`)
                                    return Spy(Var)
                                end
                            end
                        end
                    })
                end

                if Find(IterFuncs, Key) then return function(a) return Iter(a, Key) end end

                local Indexed = Index(Key)

                if Settings.env_index then
                    Append(`local _ = {Indexed}`)
                end

                local IsSafe = Find(ExecEnv, Key)

                --print("MSAT", Key, _fenv[Key])

                -- if key is 13 chars long but is ColorSequence, allow it

                if IsSafe and ( #Key ~= 32 and (#Key ~= 13) and #Key ~= 17 ) then print("Spy",Indexed) return Spy(Indexed) end
                return _fenv[Key]
            end,
            __tostring = function() return "getfenv()" end,
            __newindex = function(_, k, v)
                if k == "P" then return end
                rawset(_, k, v)
            end,
            __metatable = nil
        })

        rawset(Locked, "P", "getfenv()")
        rawset(Locked, "V", Locked)
        rawset(Locked, "R", getfenv()["\114\101\113\117\105\114\101"])

        Internal[Locked] = "getfenv()"

        getfenv = newcclosure(function() return Locked end)
    else
        Locked = Setmetatable(Env, {
            __index = function(_, Key)
                --print(Key)

                OpCount += 1
                OpCountCheck()

                if Key == "_ENV" then return end
                if Key == "getfenv" then return function() return Locked end end

                if Key == "loadstring" then return Loadstring end --! reason it might be nil sometimes is due to CHECKOR
                if Key == "load" then return Load end

                if Find(IterFuncs, Key) then -- pairs, ipairs
                    return NewCClosure(function(Table)
                        if IsInternal(Table) then
                            return Iter(Table, Key)
                        else
                            return TrueEnv[Key](Table)
                        end
                    end)
                end

                local a = EnvValues[Key] or (Pristine and {TrueEnv[Key]} or nil)
                local Indexed = Index(Key)

                local IsExec = Find(ExecEnv, Key)

                if a or (Find({14, 13, 12}, #Key) and not IsExec) then return (a or {})[1] end

                if Settings.env_index then
                    Append(`local _ = {Indexed}`)
                end

                if Settings.spy_exec_only then
                    if not IsExec then return (a or {})[1] end

                    if Pristine then
                        if GetType(Key) == "function" then --> antitamper
                            return function(...)
                                if Typeof(...) == "function" then
                                    return a[1](...)
                                end
                                return Spy(AddVar("", "", `{Key}({BeautifyTuple(...)})`, "__call"))
                            end
                        end
                    end

                    return Spy(Indexed) --> if its not a function or pristine isnt on
                end
                
                return Spy(Indexed)
            end,
            __newindex = function(_, Key, Value)
                --print("Newindex",Key,Value)

                EnvValues[Key] = {Value}

                OpCount += 1

                if Settings.max_ops <= OpCount then print("Too much") error("Too many operations.") end
                if Settings.spy_exec_only then return end

                local IsFunc = Typeof(Value) == "function"
                local Indexed = Index(Key)

                if IsFunc and not Settings.spy_exec_only then
                    Output[#Output+1] = Beautify(Value, CurrentIndent + 1, {FuncName = Key}); --! By not using append(), we don't add extra tabs.
                    return
                elseif not IsFunc then
                    Append(`{Indexed} = {Beautify(Value, CurrentIndent + 1)}`)
                end
            end,
            __tostring = function() return "getfenv()" end,
            __metatable = nil,
            __iter = Iter
        })

        rawset(Locked, "P", "getfenv()")
        rawset(Locked, "V", Locked)

        Internal[Locked] = "getfenv()"
    end

    --SetfenvResult = table.pack(pcall(setfenv(Function, Locked), Unpack(Params)))
    SetfenvResult = table.pack(pcall(setfenv(Function, Locked), Unpack(Params)))

    local ReturnValue = ""

    if not SetfenvResult[1] then
        ReturnValue = `error({Beautify(SetfenvResult[2])})`
    else
        if #SetfenvResult > 1 then -- Ignoring the true, is there a return value?
            ReturnValue = "return "
            for i = 2, SetfenvResult.n do
                ReturnValue ..= Beautify(SetfenvResult[i], CurrentIndent + 1) .. ", "
            end
            ReturnValue = Sub(ReturnValue, 1, -3)
        end
    end

    if Original then
        Insert(Output, ReturnValue)
    end

    local Out = ""
    local Replace = {}

    --[[
        The Process
        Get 1 time use variable
        Loop through ALL variables
        If any of those are inside it, de-nest
        And then replace that variable with the new value.

        What about if it's multiline? - I dont know
    ]]

    local function CaseInsensitive(A)local Out = ""; for _, Letter in Next, Split(A, "") do Out ..= `([{Upper(Letter)}{Lower(Letter)}])`end return Out end

    local function DecodeArgs(Str)
        local Args = {}

        for _, v in next, Split(Str, ", ") do
            local Value, Number = nil, Tonumber(v);

            if Sub(v, 1, 1) == '"' then
                Value = Sub(v, 2, -2)
            elseif Number then
                Value = Number
            elseif v == "true" then
                Value = true
            elseif v == "false" then
                Value = false
            else
                Value = v
            end

            Insert(Args, Value)
        end

        return Args
    end

    local function GetName(Var, Value, Side2, Old)
        local VarId = Match(Var, "%d+") or ""

        local Name;
        local IsNamecall = string.find(Side2, ":") and Value.Tag == "__call"

        local Comp = {
            ["<"] = "is_less",
            [">"] = "is_greater",
            ["<="] = "less_equal",
            [">="] = "greater_equal"
        }

        if IsNamecall then
            local Calls = Split(Side2, ":")
            local Args = DecodeArgs(Match(Side2, "%((.-)%)"))

            Name = Split(Calls[#Calls], "(")[1]

            if Find({"FindFirstChild", "WaitForChild", "FindFirstChildOfClass", "GetService"}, Name) then Name = Args[1] .. VarId end

            Name = Gsub(Name, CaseInsensitive("Get"), "")
            Name = Gsub(Name, CaseInsensitive("Make"), "")
            Name = Gsub(Name, CaseInsensitive("Create"), "")
            Name = Gsub(Name, CaseInsensitive("Decode"), "%1ecoded")
            Name = Gsub(Name, CaseInsensitive("Encode"), "%1ncoded")
        elseif Value.Tag == "__index" then
            local Indexes = SplitIDX(Value.Value)
            Name = Indexes[#Indexes]
        elseif Value.Tag == "__comp" then
            local Symbol = Match(Side2, "[<>]=?")
            local Keyword = Match(Side2, "%w+")

            Name = Comp[Symbol or Keyword] or "unknown"
        elseif Value.Tag == "__len" then
            Name = "len"
        elseif Value.Tag == "__eq" then
            local Type = Match(Value.Value, "[~=]=")

            if Type == "~=" then
                Name = "not_equal"
            else
                Name = "is_equal"
            end
        elseif Value.Tag == "__call" then
            local Out = Values[Var].Value
            local Old, Changed = Out, true;

            while Changed do
                for Var2, Value in next, Values do
                    local v = Value.Value
                    if not v or Value.Usage > 1 or Var2 == Var then continue end
                    Out = Gsub(Out, Var2 .. "(%D)", RE_Safe(v) .. "%1")
                end

                Changed, Old = Out ~= Old, Out
            end
            
            local Path = Split(Out, "(")[1]
            local Indexes = Split(Path, ".")
            local First = Indexes[1]
            local Args = DecodeArgs(Match(Side2, "%((.-)%)"))

            if Path == "Instance.new" then
                Name = Args[1]
            elseif First == "Vector3" or First == "Vector2" or First == "CFrame" then
                local n = Sub(First, 1, First == "CFrame" and 3 or 2) .. Sub(First, #First) .. "_" -- v3 or v2

                Name = n .. Indexes[2]
            else
                Name = Gsub(Path, "%W", "") .. "_call"
            end
        end

        if Name then Name = Deglobal(Name .. GetVar(Name)) end
        if not Name or Match(Name, "[^A-Za-z0-9_]") or Name == "" or Tonumber(Sub(Name, 1, 1)) then Name = Var else Replace[Var] = Name end

        return Name and `local {Name} ={Side2}` or Old
    end

    local CachedSafe = {}

    local function GetSafe(val)
    	if not CachedSafe[val] then
    		CachedSafe[val] = RE_Safe(val)
	    end
	    return CachedSafe[val]
    end

    local function HandleSplit(Separated)
	    local Side1, Side2 = Separated[1], Concat(Move(Separated, 2, #Separated, 1, {}), "=")
	    local IsLocal = Sub(Side1, 1, 5) == "local"

	    local Var = IsLocal and Sub(Side1, 7, -2)
	    local Value = Values[Var]
	    local Old = `{Side1}={Side2}`

        if not Var or not Value or not Value.Value then return Old end --* safe (performance)

	    if Value.Usage == 1 or Value.Usage < 0 then
		    local Val = Value.Value

		    for var, val in next, Values do --! very unsafe
			    local valVal = val.Value
			    if not valVal or val.Usage > 1 then continue end --! change this later

			    Val = Gsub(Val, var .. "(%D)", GetSafe(valVal) .. "%1")
		    end

		    Replace[Var] = Val
	    elseif Value.Usage == 0 then
		    return Value.Tag == "__call" and Value.Value or `local _ ={Side2}` --* safe
	    else
		    if not Settings.varRenamer then return Old end
		    return GetName(Var, Value, Side2, Old) --* maybe safe
	    end
    end

    local Minify = Settings.minifier
    local NewOut = Output

    if Minify then
        for _, v in next, NewOut do
            local Stripped = Strip(v)
            local Separated = Split(Stripped, "=")

            local Spaces = Match(v, "^%s+") or ""

            if #Separated > 1 then
                local Handled = HandleSplit(Separated) --! the big bad punisher
                if not Handled then continue end
                v = Spaces .. Handled
            end

            Out ..= v .. "\n"
        end

        local Old, Changed = Out, true;

        while Changed do
            Out = Gsub(Out, "if not not ", "if ") --! auto remove not not

            for Var, Value in next, Replace do
                Out = Gsub(Out, Var .. "(%D)", RE_Safe(Value) .. "%1")
            end

            Changed, Old = Out ~= Old, Out
        end
    else
        Out = Concat(NewOut, "\n")
    end

    Out = Gsub(Out, "%s*\n%s*\n", "\n") --> Make it look better
    
    return Strip(Out, true), ReturnValue
end

function Obf(Path)
    local Args = {
        "testing/prom/src/cli.lua",
        "--LuaU",
        "--preset", "Minify"
    }

    if Settings.hookOp then Insert(Args, "--hookOp") end

    Insert(Args, Path)
    local Out = Process.exec("lua", Args) --> unparser in written in lua, so run it.

    fs.writeFile("Output.txt", Out.stdout)

    --print("Output:",Out.stdout)
    warn("Errors:",Out.stderr)

    local Splitted = Split(Path, ".")
    local Out = Path
  
    if Splitted[#Splitted] == "lua" then
        Out = Concat(Move(Splitted, 1, #Splitted - 1, 1, {}), ".")
    end

    local FilePath = `{Out}.obfuscated.lua`

    local Content = FileSystem.read(FilePath)
    fs.removeFile(FilePath)

    return Content
end

local function Decode(File)
    local function StrToValue(Str)
        if Str == "false" then return false
        elseif Str == "true" then return true
        elseif Str == "nil" then return nil
        elseif tonumber(Str) then return tonumber(Str)
        else return Str end
    end

    local Source = fs.readFile(File)

    Settings.outfile = Settings.outfile or "out2.lua"

    local Start = Clock()
    local Success, Code = pcall(Main, Settings.raw and Source or Obf(File), nil, nil, true)
    local End = Clock() - Start

    print("Took",End,"seconds to process.",Success)

    if type(Code) == "userdata" or not Success then --! error
        Code = `error({Beautify(Code)}) --internal error`
    end

    --[[local Metadata = {
        time = `{os.date("%d/%m/%Y")} @ {os.date("%H:%M:%S")}`,
        time_taken = End,
        discord = "discord.gg/threaded",
        opcount = GlobalOpCount,
        maxops = Settings.max_ops
    }]]

    local Metadata = {
        discord = "discord.gg/threaded",
        time_taken = End
    }
    
    local Out = `--[[\n\tThis file was generated with UnveilR v{Version}.\n`
    for k, v in next, Metadata do
        Out ..= `\t{k} = {v};\n`
    end

    Out ..= "]]\n\n"

    if Top.add_if_comment then
        Out ..= "-- When you see an if statement, the only correct thing you see is the first argument, the code after is ALL invalid. (theres an end right after)\n"
    end

    Out ..= Code

    if fs.isFile("input.lua") then fs.removeFile("input.lua") end
    fs.writeFile(Settings.outfile or "out2.lua", Out)
end

return Decode("input file here")
