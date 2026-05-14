local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local original_type = type
local original_tostring = tostring
local original_tonumber = tonumber
local original_pairs = pairs
local original_ipairs = ipairs
local original_next = next
local original_select = select
local original_unpack = table.unpack or unpack
local original_pack = table.pack or function(...) return {n = select("#", ...), ...} end
local original_getmetatable = getmetatable
local original_setmetatable = setmetatable
local original_rawget = rawget
local original_rawset = rawset
local original_rawequal = rawequal
local original_pcall = pcall
local original_xpcall = xpcall
local original_error = error
local original_load = load
local original_loadstring = loadstring or load
local original_setfenv = setfenv
local original_getfenv = getfenv

local debug = debug or {}
local original_getinfo = debug.getinfo
local original_traceback = debug.traceback
local original_sethook = debug.sethook

local function safe_read_binary(path)
    local success, data = original_pcall(function()
        return fs.readFile(path)
    end)
    
    if not success then
        return nil, "Could not read file"
    end
    
    if type(data) ~= "string" then
        local bytes = {}
        for i = 1, #data do
            table.insert(bytes, string.char(data[i]))
        end
        data = table.concat(bytes)
    end
    
    return data
end

local CONFIG = {
    MAX_DEPTH = 15,
    MAX_TABLE_ITEMS = 150,
    OUTPUT_FILE = "dumped_output.lua",
    VERBOSE = false,
    TRACE_CALLBACKS = true,
    TIMEOUT_SECONDS = 30,
    MAX_REPEATED_LINES = 6,
    MIN_DEOBF_LENGTH = 150,
    MAX_OUTPUT_SIZE = 10 * 1024 * 1024,
    CAPTURE_STRINGS = true,
    CAPTURE_VM_OPS = true,
    CAPTURE_CONTROL_FLOW = true,
    BYPASS_KEYSYSTEM = true,
}

local args = process.args
local AutoInputKey = args[3] or "BYPASSED_KEY_LARRY"
local TargetPlaceId = tonumber(args[4]) or tonumber(args[3]) or 123456789

local State = {
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
    lar_counter = 0,
    getdescendants_pending = nil,
    limit_reached = false,
    loop_counter = 0,
    captured_constants = {},
    captured_strings = {},
    sandbox = nil,
    vm_detected = nil,
    start_time = 0,
    control_flow_depth = 0,
    in_callback = false,
    callback_stack = {},
    global_assignments = {},
    keysystem_detected = false,
    keysystem_bypassed = false,
}

local PROXY_MARKER = {}
local UNIVERSAL_ID_MARKER = {}

local function is_proxy(obj)
    if original_type(obj) ~= "table" then return false end
    local ok, result = original_pcall(function() return rawget(obj, PROXY_MARKER) == true end)
    return ok and result
end

local function get_proxy_id(obj)
    if not is_proxy(obj) then return nil end
    return rawget(obj, "__proxy_id")
end

local function is_universal_id(obj)
    if original_type(obj) ~= "table" then return false end
    local ok, result = original_pcall(function() return rawget(obj, UNIVERSAL_ID_MARKER) == true end)
    return ok and result
end

local function SanitizePath(text)
    if original_type(text) ~= "string" then return text end
    
    if text:find("stack traceback:") or text:find("during definition of") then
        return ""
    end

    local env = process.env or {}
    local cwd = process.cwd or ""
    
    local targets = {
        { from = cwd, to = "root" },
        { from = env.USERPROFILE, to = "user" },
        { from = env.HOME, to = "user" },
        { from = "main.luau", to = "file" },
        { from = "main.lua", to = "file" }
    }

    local function clean_pattern(s)
        if not s then return "" end
        return s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    end

    for _, item in original_pairs(targets) do
        if item.from and #item.from > 0 then
            text = text:gsub(clean_pattern(item.from), item.to)
            local swapped = item.from:gsub("\\", "/")
            if swapped ~= item.from then
                text = text:gsub(clean_pattern(swapped), item.to)
            end
        end
    end

    text = text:gsub("[^%s\"]+%.luau:%d+:", "")
    text = text:gsub("[^%s\"]+%.lua:%d+:", "")
    text = text:gsub("Isolates/.*:%d+:", "")

    return text
end

local function emit(str, force_no_indent)
    if State.limit_reached then return end
    if str == nil or str == "" then return end

    local clean_str = SanitizePath(original_tostring(str))
    if clean_str == "" then return end

    local prefix = force_no_indent and "" or string.rep("    ", State.indent)
    local line = prefix .. clean_str
    local line_len = #line + 1

    if State.current_size + line_len > CONFIG.MAX_OUTPUT_SIZE then
        State.limit_reached = true
        local msg = "-- [CRITICAL] Dump stopped: File size exceeded limit."
        table.insert(State.output, msg)
        State.current_size = State.current_size + #msg
        original_error("DUMP_LIMIT_EXCEEDED")
    end

    if line == State.last_emitted_line then
        State.repetition_count = State.repetition_count + 1
        if State.repetition_count <= CONFIG.MAX_REPEATED_LINES then
            table.insert(State.output, line)
            State.current_size = State.current_size + line_len
        elseif State.repetition_count == CONFIG.MAX_REPEATED_LINES + 1 then
            local msg = prefix .. "-- [Repeated lines suppressed...]"
            table.insert(State.output, msg)
            State.current_size = State.current_size + #msg
        end
    else
        State.last_emitted_line = line
        State.repetition_count = 0
        table.insert(State.output, line)
        State.current_size = State.current_size + line_len
    end

    if CONFIG.VERBOSE and State.repetition_count <= 1 then
        print(line)
    end
end

local function emit_comment(str)
    emit("-- " .. original_tostring(str or ""))
end

local function emit_blank()
    State.last_emitted_line = nil
    table.insert(State.output, "")
end

local function get_output()
    return table.concat(State.output, "\n")
end

local function save_output(filename)
    local raw_output = get_output()
    local clean_output = SanitizePath(raw_output)
    local success = original_pcall(function()
        fs.writeFile(filename or CONFIG.OUTPUT_FILE, clean_output)
    end)
    return success
end

local function safe_string(val)
    if val == nil then return "nil" end
    if original_type(val) == "string" then return val end
    if original_type(val) == "number" or original_type(val) == "boolean" then return original_tostring(val) end
    if original_type(val) == "table" then
        if State.registry[val] then return State.registry[val] end
        if is_proxy(val) then
            local id = get_proxy_id(val)
            return id and ("proxy_" .. id) or "proxy"
        end
    end
    local ok, str = original_pcall(original_tostring, val)
    return ok and str or "unknown"
end

local function safe_quote(val)
    local str = safe_string(val)
    local escaped = str:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n'):gsub('\r', '\\r'):gsub('\t', '\\t')
    return '"' .. escaped .. '"'
end

local type_counters = {}

local function get_next_counter(type_name)
    type_counters[type_name] = (type_counters[type_name] or 0) + 1
    return type_counters[type_name]
end

local function make_var(obj, hint, type_hint, method_name)
    if State.registry[obj] then return State.registry[obj] end
    
    State.lar_counter = (State.lar_counter or 0) + 1
    local name = "larry" .. State.lar_counter

    State.names_used[name] = true
    State.registry[obj] = name
    State.reverse_registry[name] = obj
    State.variable_types[name] = type_hint or original_type(obj)
    return name
end

local function serialize(val, depth, seen, inline)
    depth = depth or 0
    seen = seen or {}
    if depth > CONFIG.MAX_DEPTH then return "{ --[[max depth]] }" end
    
    local t = original_type(val)
    
    if t == "nil" then
        return "nil"
    elseif t == "string" then
        if #val > 100 and val:match("^[A-Za-z0-9+/=]+$") then
            table.insert(State.string_refs, {value = val:sub(1, 50) .. "...", hint = "base64", full_length = #val})
        elseif val:match("https?://") then
            table.insert(State.string_refs, {value = val, hint = "URL"})
        elseif val:match("rbxasset://") or val:match("rbxassetid://") then
            table.insert(State.string_refs, {value = val, hint = "Asset"})
        end
        return string.format("%q", val)
    elseif t == "number" then
        if val ~= val then return "0/0" end
        if val == math.huge then return "math.huge" end
        if val == -math.huge then return "-math.huge" end
        if val == math.floor(val) then return original_tostring(math.floor(val)) end
        return string.format("%.6g", val)
    elseif t == "boolean" then
        return original_tostring(val)
    elseif t == "function" then
        if State.registry[val] then return State.registry[val] end
        return "function() end"
    elseif t == "table" then
        if is_proxy(val) then return State.registry[val] or "proxy" end
        if State.registry[val] then return State.registry[val] end
        if seen[val] then return "{ --[[circular]] }" end
        seen[val] = true
        
        local count = 0
        for k, v in original_pairs(val) do
            if k ~= PROXY_MARKER and k ~= "__proxy_id" then count = count + 1 end
        end
        if count == 0 then return "{}" end
        
        local is_array = true
        local max_idx = 0
        for k, v in original_pairs(val) do
            if k ~= PROXY_MARKER and k ~= "__proxy_id" then
                if original_type(k) ~= "number" or k < 1 or k ~= math.floor(k) then
                    is_array = false
                    break
                else
                    max_idx = math.max(max_idx, k)
                end
            end
        end
        is_array = is_array and max_idx == count
        
        if is_array and count <= 5 and inline ~= false then
            local parts = {}
            for i = 1, count do
                local v = val[i]
                if original_type(v) ~= "table" or is_proxy(v) then
                    table.insert(parts, serialize(v, depth + 1, seen, true))
                else
                    is_array = false
                    break
                end
            end
            if is_array and #parts == count then return "{" .. table.concat(parts, ", ") .. "}" end
        end
        
        local lines = {}
        local idx = 0
        local indent_str = string.rep("    ", State.indent + depth + 1)
        local close_indent = string.rep("    ", State.indent + depth)
        
        for k, v in original_pairs(val) do
            if k ~= PROXY_MARKER and k ~= "__proxy_id" then
                idx = idx + 1
                if idx > CONFIG.MAX_TABLE_ITEMS then
                    table.insert(lines, indent_str .. "-- ..." .. (count - idx + 1) .. " more")
                    break
                end
                local key_str
                if is_array then
                    key_str = nil
                elseif original_type(k) == "string" and k:match("^[%a_][%w_]*$") then
                    key_str = k
                else
                    key_str = "[" .. serialize(k, depth + 1, seen) .. "]"
                end
                local val_str = serialize(v, depth + 1, seen)
                if key_str then
                    table.insert(lines, indent_str .. key_str .. " = " .. val_str)
                else
                    table.insert(lines, indent_str .. val_str)
                end
            end
        end
        
        if #lines == 0 then return "{}" end
        return "{\n" .. table.concat(lines, ",\n") .. "\n" .. close_indent .. "}"
    elseif t == "userdata" then
        if State.registry[val] then return State.registry[val] end
        local ok, str = original_pcall(original_tostring, val)
        return ok and str or "userdata"
    elseif t == "thread" then
        return "coroutine.create(function() end)"
    else
        local ok, str = original_pcall(original_tostring, val)
        return ok and str or "nil"
    end
end

local bit_lib = {}

local function tobit(x)
    x = (x or 0) % 4294967296
    if x >= 2147483648 then x = x - 4294967296 end
    return math.floor(x)
end

local function tobitu(x)
    return (x or 0) % 4294967296
end

bit_lib.tobit = tobit
bit_lib.tohex = function(x, n) 
    return string.format("%0" .. (n or 8) .. "x", tobitu(x)) 
end

bit_lib.bnot = function(x)
    return tobit(bit32.bnot(tobitu(x)))
end

bit_lib.band = function(a, b, ...)
    local result = bit32.band(tobitu(a or 0), tobitu(b or 0))
    local args = {...}
    for i = 1, #args do
        result = bit32.band(result, tobitu(args[i] or 0))
    end
    return tobit(result)
end

bit_lib.bor = function(a, b, ...)
    local result = bit32.bor(tobitu(a or 0), tobitu(b or 0))
    local args = {...}
    for i = 1, #args do
        result = bit32.bor(result, tobitu(args[i] or 0))
    end
    return tobit(result)
end

bit_lib.bxor = function(a, b, ...)
    local result = bit32.bxor(tobitu(a or 0), tobitu(b or 0))
    local args = {...}
    for i = 1, #args do
        result = bit32.bxor(result, tobitu(args[i] or 0))
    end
    return tobit(result)
end

bit_lib.lshift = function(x, n)
    return tobit(bit32.lshift(tobitu(x or 0), (n or 0) % 32))
end

bit_lib.rshift = function(x, n)
    return tobit(bit32.rshift(tobitu(x or 0), (n or 0) % 32))
end

bit_lib.arshift = function(x, n)
    return tobit(bit32.arshift(tobitu(x or 0), (n or 0) % 32))
end

bit_lib.rol = function(x, n)
    return tobit(bit32.lrotate(tobitu(x or 0), (n or 0) % 32))
end

bit_lib.ror = function(x, n)
    return tobit(bit32.rrotate(tobitu(x or 0), (n or 0) % 32))
end

bit_lib.lrotate = bit_lib.rol
bit_lib.rrotate = bit_lib.ror

bit_lib.bswap = function(x)
    x = tobitu(x or 0)
    local a = bit32.band(bit32.rshift(x, 24), 0xFF)
    local b = bit32.band(bit32.rshift(x, 8), 0xFF00)
    local c = bit32.band(bit32.lshift(x, 8), 0xFF0000)
    local d = bit32.band(bit32.lshift(x, 24), 0xFF000000)
    return tobit(bit32.bor(a, b, c, d))
end

bit_lib.btest = function(a, b)
    return bit32.btest(tobitu(a or 0), tobitu(b or 0))
end

bit_lib.countlz = function(n)
    n = tobitu(n or 0)
    if n == 0 then return 32 end
    local count = 0
    if bit32.band(n, 0xFFFF0000) == 0 then count = count + 16; n = bit32.lshift(n, 16) end
    if bit32.band(n, 0xFF000000) == 0 then count = count + 8; n = bit32.lshift(n, 8) end
    if bit32.band(n, 0xF0000000) == 0 then count = count + 4; n = bit32.lshift(n, 4) end
    if bit32.band(n, 0xC0000000) == 0 then count = count + 2; n = bit32.lshift(n, 2) end
    if bit32.band(n, 0x80000000) == 0 then count = count + 1 end
    return count
end

bit_lib.countrz = function(n)
    n = tobitu(n or 0)
    if n == 0 then return 32 end
    local count = 0
    while bit32.band(n, 1) == 0 do
        n = bit32.rshift(n, 1)
        count = count + 1
    end
    return count
end

bit_lib.extract = function(n, field, width)
    width = width or 1
    return bit32.extract(tobitu(n or 0), field or 0, width)
end

bit_lib.replace = function(n, v, field, width)
    width = width or 1
    return tobit(bit32.replace(tobitu(n or 0), tobitu(v or 0), field or 0, width))
end

local original_string_char = string.char
local original_string_byte = string.byte
local original_string_sub = string.sub
local original_string_gsub = string.gsub
local original_string_unpack = string.unpack
local original_string_pack = string.pack
local original_string_rep = string.rep
local original_string_reverse = string.reverse
local original_string_match = string.match
local original_string_find = string.find
local original_string_format = string.format
local original_string_len = string.len
local original_string_lower = string.lower
local original_string_upper = string.upper
local original_table_concat = table.concat

local hooked_string = {}
for k, v in original_pairs(string) do
    hooked_string[k] = v
end

hooked_string.char = function(...)
    local args = {...}
    local ok, result = original_pcall(original_string_char, ...)
    if not ok then return "" end
    
    if #result >= 4 and CONFIG.CAPTURE_STRINGS then
        local printable_count = 0
        local check_len = math.min(#result, 100)
        for i = 1, check_len do
            local b = original_string_byte(result, i)
            if b and b >= 32 and b <= 126 then
                printable_count = printable_count + 1
            end
        end
        
        if printable_count / check_len > 0.6 then
            local preview = original_string_sub(result, 1, 200)
            if not State.captured_strings[preview] then
                State.captured_strings[preview] = true
            end
        end
    end
    
    return result
end

hooked_string.byte = original_string_byte
hooked_string.sub = original_string_sub
hooked_string.gsub = original_string_gsub
hooked_string.unpack = original_string_unpack
hooked_string.pack = original_string_pack
hooked_string.rep = original_string_rep
hooked_string.reverse = original_string_reverse
hooked_string.match = original_string_match
hooked_string.find = original_string_find
hooked_string.format = original_string_format
hooked_string.len = original_string_len
hooked_string.lower = original_string_lower
hooked_string.upper = original_string_upper

local hooked_table = {}
for k, v in original_pairs(table) do
    hooked_table[k] = v
end

hooked_table.concat = function(t, sep)
    local ok, result = original_pcall(original_table_concat, t, sep or "")
    if not ok then return "" end
    
    if original_type(result) == "string" then
        local result_len = #result
        
        if result_len > 1000 then
            local b91_chars = 0
            local check_len = math.min(result_len, 500)
            local b91_charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"' "
            
            for i = 1, check_len do
                local ch = result:sub(i, i)
                if b91_charset:find(ch, 1, true) then
                    b91_chars = b91_chars + 1
                end
            end
            
            if b91_chars / check_len > 0.8 then
                State.vm_detected = State.vm_detected or "junkie"
                
                local decode_ok, decoded = original_pcall(decode_base91, result)
                if decode_ok and decoded and #decoded > 100 then
                    local filename = "dumped_output.lua"
                    original_pcall(function()
                        fs.writeFile(filename, decoded)
                    end)
                    
                    if decoded:match("function") or decoded:match("local%s") then
                        emit_blank()
                        
                        local chunk = original_load(decoded, "base91_payload", "t", State.sandbox or _G)
                        if chunk then
                            State.indent = State.indent + 1
                            original_xpcall(chunk, function(e)
                                emit_comment("Error: " .. SanitizePath(tostring(e)))
                            end)
                            State.indent = State.indent - 1
                        end
                        emit_comment("=== END DECODED PAYLOAD ===")
                    end
                end
            end
        end
        
        if result_len > 100 then
            local code_patterns = {"function", "local%s", "return%s", "end[%s;)]", "if%s", "then%s", "for%s", "while%s", "repeat%s"}
            local is_code = false
            
            for _, pattern in original_ipairs(code_patterns) do
                if result:find(pattern) then
                    is_code = true
                    break
                end
            end
            
            if is_code then
                local filename = "dumped_output.lua"
                original_pcall(function()
                    fs.writeFile(filename, result)
                end)
                
                if result_len < 100000 and State.sandbox then
                    local chunk = original_load(result, "dynamic_payload", "t", State.sandbox)
                    if chunk then
                        State.indent = State.indent + 1
                        original_pcall(chunk)
                        State.indent = State.indent - 1
                    end
                end
            end
        end
    end
    
    return result
end

hooked_table.insert = table.insert
hooked_table.remove = table.remove
hooked_table.sort = table.sort
hooked_table.unpack = table.unpack
hooked_table.pack = table.pack
hooked_table.move = table.move
hooked_table.create = table.create or function(n, v)
    local t = {}
    if v ~= nil then for i = 1, n do t[i] = v end end
    return t
end
hooked_table.find = table.find or function(t, v, init)
    for i = init or 1, #t do
        if t[i] == v then return i end
    end
    return nil
end
hooked_table.clear = table.clear or function(t)
    for k in original_pairs(t) do t[k] = nil end
end
hooked_table.clone = table.clone or function(t)
    local new = {}
    for k, v in original_pairs(t) do new[k] = v end
    return new
end
hooked_table.freeze = table.freeze or function(t) return t end
hooked_table.isfrozen = table.isfrozen or function() return false end

local create_proxy
local create_method_proxy
local create_table_proxy

create_table_proxy = function()
    local proxy = {}
    local meta = {}
    original_setmetatable(proxy, meta)
    rawset(proxy, PROXY_MARKER, true)
    State.proxy_id = State.proxy_id + 1
    rawset(proxy, "__proxy_id", State.proxy_id)
    return proxy, meta
end

create_method_proxy = function(method_name, parent_proxy)
    local proxy, meta = create_table_proxy()
    local parent_name = State.registry[parent_proxy] or "object"
    local method_str = safe_string(method_name)
    State.registry[proxy] = parent_name .. "." .. method_str
    
    meta.__call = function(self, first_arg, ...)
        local args
        if first_arg == proxy or first_arg == parent_proxy or is_proxy(first_arg) then
            args = {...}
        else
            args = {first_arg, ...}
        end
        
        local result = create_proxy(method_str, false, parent_proxy)
        local var = make_var(result, method_str, nil, method_str)
        
        local serialized_args = {}
        for _, v in original_ipairs(args) do
            table.insert(serialized_args, serialize(v))
        end
        
        emit(string.format("local %s = %s:%s(%s)", var, parent_name, method_str, table.concat(serialized_args, ", ")))
        return result
    end
    
    meta.__index = function(t, k)
        if k == PROXY_MARKER or k == "__proxy_id" then return rawget(t, k) end
        return create_method_proxy(k, proxy)
    end
    
    meta.__tostring = function()
        return State.registry[proxy] or method_str or "Object"
    end
    
    return proxy
end

create_proxy = function(hint, is_root, parent_proxy)
    local proxy, meta = create_table_proxy()
    local hint_str = safe_string(hint)
    State.property_store[proxy] = {}
    
    if is_root then
        State.registry[proxy] = hint_str
        State.names_used[hint_str] = true
    end
    if parent_proxy then State.parent_map[proxy] = parent_proxy end
    
    local methods = {}
    
    methods.GetService = function(self, service_name)
        local svc_str = safe_string(service_name)
        local obj = create_proxy(svc_str, false, proxy)
        local var = make_var(obj, svc_str)
        local parent = State.registry[proxy] or "game"
        emit(string.format("local %s = %s:GetService(%s)", var, parent, safe_quote(svc_str)))
        return obj
    end
    
    methods.WaitForChild = function(self, child_name, timeout)
        local child_str = safe_string(child_name)
        local obj = create_proxy(child_str, false, proxy)
        local var = make_var(obj, child_str)
        local parent = State.registry[proxy] or "object"
        if timeout then
            emit(string.format("local %s = %s:WaitForChild(%s, %s)", var, parent, safe_quote(child_str), serialize(timeout)))
        else
            emit(string.format("local %s = %s:WaitForChild(%s)", var, parent, safe_quote(child_str)))
        end
        return obj
    end
    
    methods.FindFirstChild = function(self, child_name, recursive)
        local child_str = safe_string(child_name)
        local obj = create_proxy(child_str, false, proxy)
        local var = make_var(obj, child_str)
        local parent = State.registry[proxy] or "object"
        if recursive then
            emit(string.format("local %s = %s:FindFirstChild(%s, true)", var, parent, safe_quote(child_str)))
        else
            emit(string.format("local %s = %s:FindFirstChild(%s)", var, parent, safe_quote(child_str)))
        end
        return obj
    end
    
    methods.FindFirstChildOfClass = function(self, class_name)
        local class_str = safe_string(class_name)
        local obj = create_proxy(class_str, false, proxy)
        local var = make_var(obj, class_str)
        local parent = State.registry[proxy] or "object"
        emit(string.format("local %s = %s:FindFirstChildOfClass(%s)", var, parent, safe_quote(class_str)))
        return obj
    end
    
    methods.FindFirstChildWhichIsA = function(self, class_name)
        local class_str = safe_string(class_name)
        local obj = create_proxy(class_str, false, proxy)
        local var = make_var(obj, class_str)
        local parent = State.registry[proxy] or "object"
        emit(string.format("local %s = %s:FindFirstChildWhichIsA(%s)", var, parent, safe_quote(class_str)))
        return obj
    end
    
    methods.GetChildren = function(self)
        local parent = State.registry[proxy] or "object"
        emit(string.format("for _, child in %s:GetChildren() do", parent))
        State.indent = State.indent + 1
        State.pending_iterator = true
        return {}
    end
    
    methods.GetDescendants = function(self)
        local parent = State.registry[proxy] or "object"
        local descendants = {}
        for i = 1, 5 do
            local mock = create_proxy("Descendant", false, proxy)
            table.insert(descendants, mock)
        end
        State.getdescendants_pending = { parent = parent, objects = descendants }
        return descendants
    end
    
    methods.Clone = function(self)
        local parent = State.registry[proxy] or "object"
        local obj = create_proxy((hint_str or "object") .. "Clone", false)
        local var = make_var(obj, (hint_str or "object") .. "Clone")
        emit(string.format("local %s = %s:Clone()", var, parent))
        return obj
    end
    
    methods.Destroy = function(self)
        local parent = State.registry[proxy] or "object"
        emit(string.format("%s:Destroy()", parent))
    end
    
    methods.Connect = function(self, callback)
        local parent = State.registry[proxy] or "signal"
        local conn = create_proxy("connection", false)
        local conn_var = make_var(conn, "conn")
        local event_name = parent:match("%.([^%.]+)$") or parent
        
        local arg_names = {"..."}
        if event_name:match("InputBegan") or event_name:match("InputEnded") then
            arg_names = {"input", "gameProcessed"}
        elseif event_name:match("CharacterAdded") then
            arg_names = {"character"}
        elseif event_name:match("PlayerAdded") then
            arg_names = {"player"}
        elseif event_name:match("Touched") then
            arg_names = {"hit"}
        elseif event_name:match("Heartbeat") or event_name:match("RenderStepped") then
            arg_names = {"deltaTime"}
        elseif event_name:match("Button1Click") or event_name:match("MouseButton1Click") or event_name:match("Activated") then
            arg_names = {}
        elseif event_name:match("FocusLost") then
            arg_names = {"enterPressed"}
        end
        
        emit(string.format("local %s = %s:Connect(function(%s)", conn_var, parent, table.concat(arg_names, ", ")))
        State.indent = State.indent + 1
        State.in_callback = true
        table.insert(State.callback_stack, {name = event_name, depth = State.indent})
        
        if original_type(callback) == "function" then
            local old_depth = State.control_flow_depth
            State.control_flow_depth = 0
            original_xpcall(function()
                callback(original_unpack(arg_names))
            end, function(err)
            end)
            State.control_flow_depth = old_depth
        end
        
        while State.pending_iterator do
            State.indent = State.indent - 1
            emit("end")
            State.pending_iterator = false
        end
        
        while State.control_flow_depth > 0 do
            State.indent = State.indent - 1
            emit("end")
            State.control_flow_depth = State.control_flow_depth - 1
        end
        
        State.indent = State.indent - 1
        emit("end)")
        State.in_callback = false
        table.remove(State.callback_stack)
        return conn
    end
    
    methods.FireServer = function(self, ...)
        local parent = State.registry[proxy] or "remote"
        local args = {...}
        local serialized = {}
        for _, v in original_ipairs(args) do table.insert(serialized, serialize(v)) end
        emit(string.format("%s:FireServer(%s)", parent, table.concat(serialized, ", ")))
        table.insert(State.call_graph, {type = "RemoteEvent", name = parent, args = args})
    end
    
    methods.InvokeServer = function(self, ...)
        local parent = State.registry[proxy] or "remote"
        local args = {...}
        local serialized = {}
        for _, v in original_ipairs(args) do table.insert(serialized, serialize(v)) end
        local result = create_proxy("invokeResult", false)
        local var = make_var(result, "result")
        emit(string.format("local %s = %s:InvokeServer(%s)", var, parent, table.concat(serialized, ", ")))
        table.insert(State.call_graph, {type = "RemoteFunction", name = parent, args = args})
        return result
    end
    
    methods.IsA = function(self, class_name) return true end
    methods.IsDescendantOf = function(self, ancestor) return true end
    methods.GetAttribute = function(self, attr_name)
        return create_proxy("Attribute_" .. safe_string(attr_name), false, proxy)
    end
    methods.SetAttribute = function(self, attr_name, value)
        local parent = State.registry[proxy] or "instance"
        emit(string.format("%s:SetAttribute(%s, %s)", parent, safe_quote(attr_name), serialize(value)))
    end
    methods.GetFullName = function(self) return State.registry[proxy] or "Instance" end
    
    meta.__index = function(t, k)
        if k == PROXY_MARKER or k == "__proxy_id" then return rawget(t, k) end
        
        if k == "PlaceId" or k == "GameId" then return TargetPlaceId end
        
        local parent = State.registry[proxy] or hint_str or "object"
        local k_str = safe_string(k)
        
        if State.property_store[proxy] and State.property_store[proxy][k] ~= nil then
            return State.property_store[proxy][k]
        end
        
        if methods[k_str] then
            local method_wrapper, method_meta = create_table_proxy()
            State.registry[method_wrapper] = parent .. "." .. k_str
            method_meta.__call = function(_, ...)
                local args = {...}
                if args[1] == proxy or (is_proxy(args[1]) and args[1] ~= method_wrapper) then
                    table.remove(args, 1)
                end
                return methods[k_str](proxy, original_unpack(args))
            end
            method_meta.__index = function(_, sub_k)
                return create_proxy(sub_k, false, method_wrapper)
            end
            return method_wrapper
        end
        
        if k == "Parent" then return State.parent_map[proxy] or create_proxy("Parent", false) end
        if k == "Name" then return hint_str or "Object" end
        if k == "ClassName" then return hint_str or "Instance" end
        
        if k == "LocalPlayer" then
            local lp = create_proxy("LocalPlayer", false, proxy)
            local var = make_var(lp, "LocalPlayer")
            emit(string.format("local %s = %s.LocalPlayer", var, parent))
            return lp
        end
        
        if k == "Character" then return create_proxy("Character", false, proxy) end
        if k == "Humanoid" then
            local humanoid = create_proxy("Humanoid", false, proxy)
            State.property_store[humanoid] = {Health = 100, MaxHealth = 100, WalkSpeed = 16, JumpPower = 50}
            return humanoid
        end
        if k == "HumanoidRootPart" then
            local hrp = create_proxy("HumanoidRootPart", false, proxy)
            State.property_store[hrp] = {Position = Vector3.new(0, 5, 0), CFrame = CFrame.new(0, 5, 0)}
            return hrp
        end
        
        local num_props = {Health = 100, MaxHealth = 100, WalkSpeed = 16, Value = 0, Transparency = 0}
        if num_props[k] then return num_props[k] end
        
        local bool_props = {Visible = true, Enabled = true, Anchored = false, CanCollide = true}
        if bool_props[k] ~= nil then return bool_props[k] end
        
        local events = {"Changed", "ChildAdded", "Touched", "InputBegan", "InputEnded", "MouseButton1Click", 
                        "Heartbeat", "RenderStepped", "CharacterAdded", "PlayerAdded", "OnClientEvent", "OnServerEvent",
                        "MouseButton1Down", "MouseButton2Click", "Activated", "FocusLost"}
        for _, event in original_ipairs(events) do
            if k == event then
                local signal = create_proxy(parent .. "." .. k, false, proxy)
                State.registry[signal] = parent .. "." .. k
                return signal
            end
        end
        
        if parent:match("^Enum") then
            local enum_path = parent .. "." .. k_str
            local enum_val = create_proxy(enum_path, false)
            State.registry[enum_val] = enum_path
            return enum_val
        end
        
        return create_method_proxy(k_str, proxy)
    end
    
    meta.__newindex = function(t, k, v)
        if k == PROXY_MARKER or k == "__proxy_id" then rawset(t, k, v) return end
        local parent = State.registry[proxy] or hint_str or "object"
        local k_str = safe_string(k)
        State.property_store[proxy] = State.property_store[proxy] or {}
        State.property_store[proxy][k] = v
        if k == "Parent" and is_proxy(v) then State.parent_map[proxy] = v end
        emit(string.format("%s.%s = %s", parent, k_str, serialize(v)))
    end
    
    meta.__call = function(t, ...)
        local parent = State.registry[proxy] or hint_str or "func"
        if parent == "fenv" or parent == "getgenv" or parent:match("env") then return proxy end
        local args = {...}
        local serialized = {}
        for _, v in original_ipairs(args) do table.insert(serialized, serialize(v)) end
        local result = create_proxy("result", false)
        local var = make_var(result, "result")
        emit(string.format("local %s = %s(%s)", var, parent, table.concat(serialized, ", ")))
        return result
    end
    
    local function make_arith_op(op_symbol)
        return function(a, b)
            local proxy_res, meta_res = create_table_proxy()
            local str_a = (State.registry[a] or serialize(a))
            local str_b = (State.registry[b] or serialize(b))
            local result_str = "(" .. str_a .. " " .. op_symbol .. " " .. str_b .. ")"
            State.registry[proxy_res] = result_str
            meta_res.__tostring = function() return result_str end
            meta_res.__index = meta.__index
            meta_res.__add = make_arith_op("+")
            meta_res.__sub = make_arith_op("-")
            meta_res.__mul = make_arith_op("*")
            meta_res.__div = make_arith_op("/")
            return proxy_res
        end
    end
    
    meta.__add = make_arith_op("+")
    meta.__sub = make_arith_op("-")
    meta.__mul = make_arith_op("*")
    meta.__div = make_arith_op("/")
    meta.__mod = make_arith_op("%")
    meta.__pow = make_arith_op("^")
    meta.__concat = make_arith_op("..")
    
    meta.__eq = function() return false end
    meta.__lt = function() return false end
    meta.__le = function() return false end
    meta.__unm = function(a)
        local result, result_meta = create_table_proxy()
        State.registry[result] = "(-" .. (State.registry[a] or serialize(a)) .. ")"
        return result
    end
    meta.__len = function() return 0 end
    meta.__tostring = function() return State.registry[proxy] or hint_str or "Object" end
    meta.__pairs = function() return function() return nil end, proxy, nil end
    meta.__ipairs = meta.__pairs
    
    return proxy
end

local function make_type_constructor(name)
    local ctor = {}
    local mt = {}
    
    local function create_type_instance(str_rep)
        local proxy, pmeta = create_table_proxy()
        State.registry[proxy] = str_rep
        
        pmeta.__tostring = function() return str_rep end
        
        pmeta.__index = function(t, k)
            if k == PROXY_MARKER or k == "__proxy_id" then return rawget(t, k) end
            if k == "X" or k == "Y" or k == "Z" or k == "W" then return 0 end
            if k == "R" or k == "G" or k == "B" then return 1 end
            if k == "Magnitude" then return 10 end
            
            local prop_map = {Position = ".Position", Unit = ".Unit", LookVector = ".LookVector"}
            if prop_map[k] then
                return create_type_instance("(" .. str_rep .. prop_map[k] .. ")")
            end
            
            local method_proxy, method_meta = create_table_proxy()
            method_meta.__call = function(_, ...)
                local args = {...}
                if args[1] == method_proxy or args[1] == proxy then table.remove(args, 1) end
                local arg_strs = {}
                for _, v in original_ipairs(args) do
                    table.insert(arg_strs, State.registry[v] or serialize(v))
                end
                return create_type_instance(str_rep .. ":" .. safe_string(k) .. "(" .. table.concat(arg_strs, ", ") .. ")")
            end
            return method_proxy
        end
        
        local function type_arith(op)
            return function(a, b)
                local s_a = State.registry[a] or serialize(a)
                local s_b = State.registry[b] or serialize(b)
                return create_type_instance("(" .. s_a .. " " .. op .. " " .. s_b .. ")")
            end
        end
        
        pmeta.__add = type_arith("+")
        pmeta.__sub = type_arith("-")
        pmeta.__mul = type_arith("*")
        pmeta.__div = type_arith("/")
        pmeta.__unm = function(a) return create_type_instance("(-" .. (State.registry[a] or serialize(a)) .. ")") end
        pmeta.__eq = function() return false end
        
        return proxy
    end
    
    mt.__index = function(t, k)
        return function(...)
            local args = {...}
            local serialized = {}
            for _, v in original_ipairs(args) do table.insert(serialized, serialize(v)) end
            local args_str = #serialized > 0 and table.concat(serialized, ", ") or ""
            return create_type_instance(name .. "." .. k .. "(" .. args_str .. ")")
        end
    end
    
    mt.__call = function(t, ...)
        return t.new(...)
    end
    
    return original_setmetatable(ctor, mt)
end

Vector3 = make_type_constructor("Vector3")
Vector2 = make_type_constructor("Vector2")
CFrame = make_type_constructor("CFrame")
Color3 = make_type_constructor("Color3")
BrickColor = make_type_constructor("BrickColor")
UDim = make_type_constructor("UDim")
UDim2 = make_type_constructor("UDim2")
TweenInfo = make_type_constructor("TweenInfo")
Ray = make_type_constructor("Ray")
Rect = make_type_constructor("Rect")
Region3 = make_type_constructor("Region3")
NumberRange = make_type_constructor("NumberRange")
NumberSequence = make_type_constructor("NumberSequence")
ColorSequence = make_type_constructor("ColorSequence")
PhysicalProperties = make_type_constructor("PhysicalProperties")
RaycastParams = make_type_constructor("RaycastParams")
OverlapParams = make_type_constructor("OverlapParams")
DateTime = make_type_constructor("DateTime")

Random = {
    new = function(seed)
        local obj = {}
        function obj:NextNumber(min, max) return (min or 0) + 0.5 * ((max or 1) - (min or 0)) end
        function obj:NextInteger(min, max) return math.floor((min or 1) + 0.5 * ((max or 100) - (min or 1))) end
        return obj
    end
}
original_setmetatable(Random, {__call = function(t, seed) return t.new(seed) end})

Enum = create_proxy("Enum", true)

Instance = {
    new = function(class_name, parent)
        local class_str = safe_string(class_name)
        local obj = create_proxy(class_str, false)
        local var = make_var(obj, class_str)
        if parent then
            local parent_str = State.registry[parent] or serialize(parent)
            emit(string.format("local %s = Instance.new(%s, %s)", var, safe_quote(class_str), parent_str))
            State.parent_map[obj] = parent
        else
            emit(string.format("local %s = Instance.new(%s)", var, safe_quote(class_str)))
        end
        return obj
    end
}

game = create_proxy("game", true)
workspace = create_proxy("workspace", true)
script = create_proxy("script", true)

State.property_store[game] = {
    PlaceId = TargetPlaceId,
    GameId = TargetPlaceId
}

task = {
    wait = function(duration)
        State.loop_counter = (State.loop_counter or 0) + 1
        if State.loop_counter > 500 then
            original_error("TIMEOUT_FORCED_BY_DUMPER")
        end
        if duration then
            emit(string.format("task.wait(%s)", serialize(duration)))
        else
            emit("task.wait()")
        end
        return duration or 0.03, os.clock()
    end,
    
    spawn = function(func, ...)
        local args = {...}
        emit("task.spawn(function()")
        State.indent = State.indent + 1
        State.in_callback = true
        if original_type(func) == "function" then
            local old_depth = State.control_flow_depth
            State.control_flow_depth = 0
            original_xpcall(function() func(original_unpack(args)) end, function() end)
            State.control_flow_depth = old_depth
        end
        while State.control_flow_depth > 0 do
            State.indent = State.indent - 1
            emit("end")
            State.control_flow_depth = State.control_flow_depth - 1
        end
        State.indent = State.indent - 1
        emit("end)")
        State.in_callback = false
    end,
    
    delay = function(duration, func, ...)
        local args = {...}
        emit(string.format("task.delay(%s, function()", serialize(duration or 0)))
        State.indent = State.indent + 1
        State.in_callback = true
        if original_type(func) == "function" then
            local old_depth = State.control_flow_depth
            State.control_flow_depth = 0
            original_xpcall(function() func(original_unpack(args)) end, function() end)
            State.control_flow_depth = old_depth
        end
        while State.control_flow_depth > 0 do
            State.indent = State.indent - 1
            emit("end")
            State.control_flow_depth = State.control_flow_depth - 1
        end
        State.indent = State.indent - 1
        emit("end)")
        State.in_callback = false
    end,
    
    defer = function(func, ...)
        local args = {...}
        emit("task.defer(function()")
        State.indent = State.indent + 1
        State.in_callback = true
        if original_type(func) == "function" then
            local old_depth = State.control_flow_depth
            State.control_flow_depth = 0
            original_xpcall(function() func(original_unpack(args)) end, function() end)
            State.control_flow_depth = old_depth
        end
        while State.control_flow_depth > 0 do
            State.indent = State.indent - 1
            emit("end")
            State.control_flow_depth = State.control_flow_depth - 1
        end
        State.indent = State.indent - 1
        emit("end)")
        State.in_callback = false
    end,
    
    cancel = function() emit("task.cancel(thread)") end,
    synchronize = function() emit("task.synchronize()") end,
    desynchronize = function() emit("task.desynchronize()") end
}

wait = function(duration)
    if duration then emit(string.format("wait(%s)", serialize(duration))) else emit("wait()") end
    return duration or 0.03, os.clock()
end

delay = function(duration, func)
    emit(string.format("delay(%s, function()", serialize(duration or 0)))
    State.indent = State.indent + 1
    State.in_callback = true
    if original_type(func) == "function" then
        local old_depth = State.control_flow_depth
        State.control_flow_depth = 0
        original_xpcall(func, function() end)
        State.control_flow_depth = old_depth
    end
    while State.control_flow_depth > 0 do
        State.indent = State.indent - 1
        emit("end")
        State.control_flow_depth = State.control_flow_depth - 1
    end
    State.indent = State.indent - 1
    emit("end)")
    State.in_callback = false
end

spawn = function(func)
    emit("spawn(function()")
    State.indent = State.indent + 1
    State.in_callback = true
    if original_type(func) == "function" then
        local old_depth = State.control_flow_depth
        State.control_flow_depth = 0
        original_xpcall(func, function() end)
        State.control_flow_depth = old_depth
    end
    while State.control_flow_depth > 0 do
        State.indent = State.indent - 1
        emit("end")
        State.control_flow_depth = State.control_flow_depth - 1
    end
    State.indent = State.indent - 1
    emit("end)")
    State.in_callback = false
end

tick = function() return os.time() end
time = function() return os.clock() end
elapsedTime = function() return os.clock() end

local current_identity = 7

local exploit_funcs = {
    getgenv = function()
        local genv = State.sandbox or _G
        local genv_proxy = {}
        local genv_meta = {
            __index = function(t, k)
                return rawget(genv, k)
            end,
            __newindex = function(t, k, v)
                State.global_assignments[k] = v
                emit(string.format("getgenv().%s = %s", safe_string(k), serialize(v)))
                rawset(genv, k, v)
            end
        }
        return original_setmetatable(genv_proxy, genv_meta)
    end,
    
    getrenv = function()
        return create_proxy("getrenv()", false)
    end,
    
    getfenv = function(level)
        return State.sandbox or _G
    end,
    
    setfenv = function(fn, env)
        if original_type(fn) == "function" and original_setfenv then
            original_setmetatable(env, {__index = State.sandbox or _G})
            return original_setfenv(fn, env)
        end
        State.sandbox = env
        return env
    end,
    
    hookfunction = function(old, new)
        emit(string.format("hookfunction(%s, %s)", serialize(old), serialize(new)))
        return old
    end,
    
    hookmetamethod = function(obj, method, hook)
        emit(string.format("hookmetamethod(%s, %s, %s)", serialize(obj), safe_quote(method), serialize(hook)))
        return function() end
    end,
    
    getrawmetatable = function(obj)
        emit(string.format("getrawmetatable(%s)", serialize(obj)))
        if is_proxy(obj) then
            return original_getmetatable(obj)
        end
        return original_getmetatable(obj) or {}
    end,
    
    setrawmetatable = function(obj, mt) return obj end,
    getnamecallmethod = function() return "__namecall" end,
    checkcaller = function() return true end,
    islclosure = function(func) return original_type(func) == "function" end,
    iscclosure = function(func) return false end,
    newcclosure = function(func) return func end,
    clonefunction = function(func) return func end,
    isexecutorclosure = function(func) return original_type(func) == "function" end,
    
    request = function(options)
        emit(string.format("request(%s)", serialize(options)))
        return {Body = "{}", StatusCode = 200, StatusMessage = "OK", Headers = {}, Success = true}
    end,
    
    setclipboard = function(data) emit(string.format("setclipboard(%s)", serialize(data))) end,
    getclipboard = function() return "" end,
    identifyexecutor = function() return "Dumper", "3.0" end,
    
    gethui = function()
        local hui = create_proxy("HiddenUI", false)
        make_var(hui, "HiddenUI")
        emit(string.format("local %s = gethui()", State.registry[hui]))
        return hui
    end,
    
    getgc = function(include_tables)
        return {{}, function() end, _G, State.sandbox or _G}
    end,
    
    getinstances = function()
        emit("getinstances()")
        local instances = {}
        for i = 1, 5 do
            table.insert(instances, create_proxy("Instance" .. i, false))
        end
        return instances
    end,
    
    getnilinstances = function() return {} end,
    getscripts = function() return {create_proxy("LocalScript", false)} end,
    getrunningscripts = function() return {create_proxy("LocalScript", false)} end,
    getloadedmodules = function() return {create_proxy("ModuleScript", false)} end,
    getcallingscript = function() return script end,
    
    readfile = function(path) emit(string.format("readfile(%s)", safe_quote(path))) return "" end,
    writefile = function(path, content) emit(string.format("writefile(%s, %s)", safe_quote(path), serialize(content))) end,
    appendfile = function(path, content) emit(string.format("appendfile(%s, %s)", safe_quote(path), serialize(content))) end,
    loadfile = function(path) return function() return create_proxy("loaded_file", false) end end,
    listfiles = function(folder) return {} end,
    isfile = function(path) return false end,
    isfolder = function(path) return false end,
    makefolder = function(path) emit(string.format("makefolder(%s)", safe_quote(path))) end,
    delfolder = function(path) emit(string.format("delfolder(%s)", safe_quote(path))) end,
    delfile = function(path) emit(string.format("delfile(%s)", safe_quote(path))) end,
    
    Drawing = {
        new = function(type_name)
            local type_str = safe_string(type_name)
            local obj = create_proxy("Drawing_" .. type_str, false)
            local var = make_var(obj, type_str)
            emit(string.format("local %s = Drawing.new(%s)", var, safe_quote(type_str)))
            return obj
        end,
        Fonts = create_proxy("Drawing.Fonts", false)
    },
    
    crypt = {
        base64encode = function(data) return data end,
        base64decode = function(data) return data end,
        encrypt = function(data, key) return data end,
        decrypt = function(data, key) return data end,
        hash = function(data) return "hash" end,
        generatekey = function(size) return string.rep("0", size or 32) end,
    },
    
    setreadonly = function(t, readonly) emit(string.format("setreadonly(%s, %s)", serialize(t), serialize(readonly))) end,
    isreadonly = function(t) return false end,
    
    getthreadidentity = function() return current_identity end,
    setthreadidentity = function(id) current_identity = id end,
    getidentity = function() return current_identity end,
    setidentity = function(id) current_identity = id end,
    
    getcustomasset = function(path)
        emit(string.format("getcustomasset(%s)", safe_quote(path)))
        return "rbxasset://temp/" .. safe_string(path):gsub("[^%w_.]", "_")
    end,
    
    debug = {
        getinfo = function(f, ...)
            return {source = "=[C]", short_src = "[C]", what = "C", name = "", currentline = -1, nups = 0}
        end,
        getupvalue = function() return nil end,
        setupvalue = function() end,
        getmetatable = original_getmetatable,
        setmetatable = original_setmetatable,
        traceback = function() return "" end,
        getconstants = function() return {} end,
        getprotos = function() return {} end,
        getstack = function() return {} end,
        setstack = function() end,
        sethook = function() end,
    },
    
    queue_on_teleport = function(code) emit(string.format("queue_on_teleport(%s)", serialize(code))) end,
    queueonteleport = function(code) emit(string.format("queueonteleport(%s)", serialize(code))) end,
    setfpscap = function(fps) emit(string.format("setfpscap(%s)", serialize(fps))) end,
    getfpscap = function() return 60 end,
}

exploit_funcs.syn = {request = exploit_funcs.request}
exploit_funcs.http = {request = exploit_funcs.request}
exploit_funcs.http_request = exploit_funcs.request

for k, v in original_pairs(exploit_funcs) do
    _G[k] = v
end

pairs = function(t)
    if original_type(t) == "table" and not is_proxy(t) then
        return original_pairs(t)
    end
    
    if State.getdescendants_pending then
        local data = State.getdescendants_pending
        State.getdescendants_pending = nil
        emit(string.format("for _, descendant in pairs(%s:GetDescendants()) do", data.parent))
        State.indent = State.indent + 1
        State.pending_iterator = true
        local i = 0
        return function()
            i = i + 1
            if i <= #data.objects then
                return i, data.objects[i]
            end
        end, data.objects, nil
    end
    
    return function() return nil end, t, nil
end

ipairs = function(t)
    if original_type(t) == "table" and not is_proxy(t) then
        return original_ipairs(t)
    end
    return function() return nil end, t, 0
end

type = function(obj)
    if is_universal_id(obj) then return "number" end
    if is_proxy(obj) then
        if State.registry[obj] == "_VERSION" then return "string" end
        return "userdata"
    end
    return original_type(obj)
end

typeof = function(obj)
    if is_universal_id(obj) then return "number" end
    if is_proxy(obj) then
        local reg = State.registry[obj]
        if reg then
            if reg:match("Vector3") then return "Vector3" end
            if reg:match("Vector2") then return "Vector2" end
            if reg:match("CFrame") then return "CFrame" end
            if reg:match("Color3") then return "Color3" end
        end
        return "Instance"
    end
    return original_type(obj) == "table" and "table" or original_type(obj)
end

tostring = function(obj)
    if is_proxy(obj) then
        return State.registry[obj] or "Instance"
    end
    return original_tostring(obj)
end

tonumber = function(obj, base)
    if is_universal_id(obj) then return 123456789 end
    return original_tonumber(obj, base)
end

getmetatable = function(obj)
    if is_proxy(obj) then
        local proxy_mt = create_proxy("LockedMetatable", false)
        local mt_meta = original_getmetatable(proxy_mt)
        mt_meta.__tostring = function() return "The metatable is locked" end
        return proxy_mt
    end
    return original_getmetatable(obj)
end

rawequal = original_rawequal

pcall = function(f, ...)
    local results = {original_pcall(f, ...)}
    if not results[1] then
        local err = results[2]
        if original_type(err) == "string" and (err:match("TIMEOUT") or err:match("DUMP_LIMIT")) then
            original_error(err)
        end
    end
    return original_unpack(results)
end

xpcall = function(f, msgh, ...)
    local function strict_msgh(err)
        if original_type(err) == "string" and (err:match("TIMEOUT") or err:match("DUMP_LIMIT")) then
            return err
        end
        if msgh then return msgh(err) end
        return err
    end
    local results = {original_xpcall(f, strict_msgh, ...)}
    if not results[1] then
        local err = results[2]
        if original_type(err) == "string" and (err:match("TIMEOUT") or err:match("DUMP_LIMIT")) then
            original_error(err)
        end
    end
    return original_unpack(results)
end

local function detect_keysystem(code)
    local patterns = {
        "key[%s_]*system",
        "enter[%s_]*key",
        "verify",
        "getkey",
        "hwid",
        "whitelist",
        "authentication",
        "license",
    }
    
    local code_lower = code:lower()
    for _, pattern in ipairs(patterns) do
        if code_lower:find(pattern) then
            return true
        end
    end
    return false
end

loadstring = function(code, chunkname)
    if original_type(code) ~= "string" then
        return function() return create_proxy("loaded", false) end
    end
    
    local code_len = #code
    
    if CONFIG.BYPASS_KEYSYSTEM and detect_keysystem(code) then
        State.keysystem_detected = true
        emit_blank()
        emit_comment("=== KEY SYSTEM DETECTED - BYPASSING ===")
        emit_blank()
    end
    
    if code_len > 500 and State.vm_detected == "junkie" then
        local filename = "dumped_output.lua"
        original_pcall(function()
            fs.writeFile(filename, code)
        end)
        
        if code:match("function") or code:match("local%s") or code:match("return%s") then
            emit_blank()
            emit_comment("=== DECODED JUNKIE CODE ===")
            
            local chunk, err = original_load(code, "junkie_decoded", "t", State.sandbox or _G)
            if chunk then
                State.indent = State.indent + 1
                original_xpcall(chunk, function(e)
                    emit_comment("Execution error: " .. SanitizePath(tostring(e)))
                end)
                State.indent = State.indent - 1
            else
                emit_comment("Load error: " .. tostring(err))
            end
            emit_comment("=== END DECODED CODE ===")
        end
        
        return function() return create_proxy("JunkiePayload", false) end
    end
    
    if code_len > 1000 then
        local printable = 0
        local check_len = math.min(code_len, 500)
        for i = 1, check_len do
            local b = original_string_byte(code, i)
            if b and b >= 32 and b <= 126 then
                printable = printable + 1
            end
        end
        
        if printable / check_len > 0.7 then
            if code:match("function") or code:match("local%s") then
                local filename = "dumped_output.lua"
                original_pcall(function()
                    fs.writeFile(filename, code)
                end)
            end
        end
    end
    
    local url = State.last_http_url or code
    State.last_http_url = nil
    
    local lib_patterns = {
        {pattern = "rayfield", name = "Rayfield"},
        {pattern = "orion", name = "OrionLib"},
        {pattern = "kavo", name = "Kavo"},
        {pattern = "venyx", name = "Venyx"},
        {pattern = "linoria", name = "Linoria"},
    }
    
    local url_lower = url:lower()
    for _, p in original_ipairs(lib_patterns) do
        if url_lower:find(p.pattern) then
            local lib = create_proxy(p.name, false)
            State.registry[lib] = p.name
            if url:match("^https?://") then
                emit(string.format('local %s = loadstring(game:HttpGet("%s"))()', p.name, url))
            end
            return function() return lib end
        end
    end
    
    if url:match("^https?://") then
        local lib = create_proxy("Library", false)
        emit(string.format('local library = loadstring(game:HttpGet("%s"))()', url))
        return function() return lib end
    end
    
    local env = State.sandbox or _G
    local chunk, err = original_load(code, chunkname, "t", env)
    if chunk then return chunk end
    
    local lib = create_proxy("LoadedChunk", false)
    return function() return lib end
end

load = loadstring
_G.loadstring = loadstring
_G.load = loadstring

require = function(module)
    local module_str = State.registry[module] or serialize(module)
    local result = create_proxy("RequiredModule", false)
    local var = make_var(result, "module")
    emit(string.format("local %s = require(%s)", var, module_str))
    return result
end

print = function(...)
    local args = {...}
    local parts = {}
    for _, v in original_ipairs(args) do table.insert(parts, serialize(v)) end
    emit(string.format("print(%s)", table.concat(parts, ", ")))
end

warn = function(...)
    local args = {...}
    local parts = {}
    for _, v in original_ipairs(args) do table.insert(parts, serialize(v)) end
    emit(string.format("warn(%s)", table.concat(parts, ", ")))
end

local original_coroutine = coroutine
local hooked_coroutine = {
    create = function(f)
        return original_coroutine.create(function(...)
            return f(...)
        end)
    end,
    wrap = function(f)
        return original_coroutine.wrap(function(...)
            return f(...)
        end)
    end,
    resume = function(co, ...)
        local results = {original_coroutine.resume(co, ...)}
        if not results[1] then
            local err = results[2]
            if original_type(err) == "string" and err:match("TIMEOUT") then
                original_error(err)
            end
        end
        return original_unpack(results)
    end,
    yield = original_coroutine.yield,
    status = original_coroutine.status,
    running = original_coroutine.running,
    isyieldable = original_coroutine.isyieldable or function() return true end,
    close = original_coroutine.close or function() return true end,
}

_G.bit = bit_lib
_G.bit32 = bit_lib
_G.string = hooked_string
_G.table = hooked_table
_G.coroutine = hooked_coroutine

_G.math = math
_G.os = {clock = os.clock, time = os.time, date = os.date, exit = function() emit("-- os.exit() blocked") end}
_G.utf8 = utf8
_G.debug = exploit_funcs.debug

_G.pairs = pairs
_G.ipairs = ipairs
_G.next = original_next
_G.tostring = tostring
_G.tonumber = tonumber
_G.getmetatable = getmetatable
_G.setmetatable = original_setmetatable
_G.pcall = pcall
_G.xpcall = xpcall
_G.error = original_error
_G.assert = assert
_G.select = original_select
_G.type = type
_G.typeof = typeof
_G.rawget = rawget
_G.rawset = rawset
_G.rawequal = rawequal
_G.rawlen = rawlen or function(t) return #t end
_G.unpack = original_unpack
_G.pack = original_pack

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
_G.Ray = Ray
_G.RaycastParams = RaycastParams

_G.loadstring = loadstring
_G.load = load
_G.require = require
_G.print = print
_G.warn = warn

_G.shared = create_proxy("shared", true)

local _G_proxy = {}
local _G_meta = {
    __index = function(t, k)
        return rawget(_G, k)
    end,
    __newindex = function(t, k, v)
        State.global_assignments[k] = v
        emit(string.format("_G.%s = %s", safe_string(k), serialize(v)))
        rawset(_G, k, v)
    end
}
_G._G = original_setmetatable(_G_proxy, _G_meta)

_G._VERSION = "Lua 5.1"

_G.newproxy = function(has_mt)
    local proxy = create_proxy("newproxy", false)
    return proxy
end
_G.settings = function() return create_proxy("Settings", false) end
_G.UserSettings = function() return create_proxy("UserSettings", false) end
_G.gcinfo = function() return 0, 0 end
_G.collectgarbage = function(opt, arg)
    if opt == "count" then return 0 end
    return 0
end

_G.buffer = {
    create = function(size) return {} end,
    fromstring = function(s) return {} end,
    tostring = function(b) return "" end,
    len = function(b) return 0 end,
    readi8 = function(b, o) return 0 end,
    readu8 = function(b, o) return 0 end,
    readi16 = function(b, o) return 0 end,
    readu16 = function(b, o) return 0 end,
    readi32 = function(b, o) return 0 end,
    readu32 = function(b, o) return 0 end,
    readf32 = function(b, o) return 0 end,
    readf64 = function(b, o) return 0 end,
    readstring = function(b, o, n) return "" end,
    writei8 = function() end,
    writeu8 = function() end,
    writei16 = function() end,
    writeu16 = function() end,
    writei32 = function() end,
    writeu32 = function() end,
    writef32 = function() end,
    writef64 = function() end,
    writestring = function() end,
    copy = function() end,
    fill = function() end,
}

_G.LuraphContinue = function() end

local function hook_control_flow()
    local original_if = _G["if"]
    
    local control_hook = {
        check_condition = function(cond)
            if CONFIG.CAPTURE_CONTROL_FLOW and State.in_callback then
                State.control_flow_depth = State.control_flow_depth + 1
                emit(string.format("if %s then", serialize(cond)))
                State.indent = State.indent + 1
            end
            return cond
        end,
        
        else_branch = function()
            if CONFIG.CAPTURE_CONTROL_FLOW and State.in_callback and State.control_flow_depth > 0 then
                State.indent = State.indent - 1
                emit("else")
                State.indent = State.indent + 1
            end
        end,
        
        elseif_branch = function(cond)
            if CONFIG.CAPTURE_CONTROL_FLOW and State.in_callback and State.control_flow_depth > 0 then
                State.indent = State.indent - 1
                emit(string.format("elseif %s then", serialize(cond)))
                State.indent = State.indent + 1
            end
            return cond
        end,
        
        end_if = function()
            if CONFIG.CAPTURE_CONTROL_FLOW and State.in_callback and State.control_flow_depth > 0 then
                State.indent = State.indent - 1
                emit("end")
                State.control_flow_depth = State.control_flow_depth - 1
            end
        end
    }
    
    return control_hook
end

local control_flow = hook_control_flow()

local Dumper = {}
Dumper.__index = Dumper

function Dumper.reset()
    State = {
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
        lar_counter = 0,
        limit_reached = false,
        loop_counter = 0,
        captured_constants = {},
        captured_strings = {},
        sandbox = nil,
        vm_detected = nil,
        start_time = os.clock(),
        control_flow_depth = 0,
        in_callback = false,
        callback_stack = {},
        global_assignments = {},
        keysystem_detected = false,
        keysystem_bypassed = false,
    }
    type_counters = {}
    
    game = create_proxy("game", true)
    workspace = create_proxy("workspace", true)
    script = create_proxy("script", true)
    Enum = create_proxy("Enum", true)
    
    State.property_store[game] = {
        PlaceId = TargetPlaceId,
        GameId = TargetPlaceId
    }
    
    _G.game = game
    _G.workspace = workspace
    _G.script = script
    _G.Enum = Enum
    _G.shared = create_proxy("shared", true)
end

function Dumper.get_output() return get_output() end
function Dumper.save(filename) return save_output(filename) end
function Dumper.get_call_graph() return State.call_graph end
function Dumper.get_string_refs() return State.string_refs end

function Dumper.get_stats()
    local captured_count = 0
    for _ in original_pairs(State.captured_strings) do
        captured_count = captured_count + 1
    end
    
    return {
        total_lines = #State.output,
        remote_calls = #State.call_graph,
        suspicious_strings = #State.string_refs,
        proxies_created = State.proxy_id,
        captured_strings = captured_count,
        global_assignments = State.global_assignments,
        keysystem_detected = State.keysystem_detected,
        keysystem_bypassed = State.keysystem_bypassed,
    }
end

local ironbrew_detected = false

local function detect_ironbrew_vm()
    if ironbrew_detected then return end
    ironbrew_detected = true
    
    emit_blank()
    emit_comment("=== IRONBREW VM DETECTED ===")
    emit_blank()
end

local original_select = select
_G.select = function(idx, ...)
    local args = {...}
    
    if #args > 20 and type(args[1]) == "function" then
        detect_ironbrew_vm()
    end
    
    return original_select(idx, ...)
end

local function decode_base91(encoded_str)
    local b91_charset = [=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~"' ]=]
    
    local dec = {}
    for i = 1, #b91_charset do
        dec[b91_charset:sub(i, i)] = i - 1
    end
    
    local out = {}
    local b = 0
    local n = 0
    local v = -1
    local pow = math.pow
    
    for i = 1, #encoded_str do
        local ch = encoded_str:sub(i, i)
        local val = dec[ch]
        
        if val ~= nil then
            if v == -1 then
                v = val
            else
                v = v + val * 91
                local lower13 = v % 8192
                local bits = (lower13 > 88) and 13 or 14
                b = b + v * pow(2, n)
                n = n + bits
                
                while n >= 8 do
                    table.insert(out, string.char(b % 256))
                    b = math.floor(b / 256)
                    n = n - 8
                end
                v = -1
            end
        end
    end
    
    if v ~= -1 then
        b = b + v * pow(2, n)
        n = n + 13
        while n >= 8 do
            table.insert(out, string.char(b % 256))
            b = math.floor(b / 256)
            n = n - 8
        end
    end
    
    return table.concat(out)
end

local function extract_junkie_payload(code)
    local table_content = {}
    
    for chunk in code:gmatch("%[=%[(.-)%]=%]") do
        table.insert(table_content, chunk)
    end
    
    if #table_content > 0 then
        local full_encoded = table.concat(table_content)
        local decoded = decode_base91(full_encoded)
        
        if decoded and #decoded > 50 then
            return decoded
        end
    end
    
    local b91_pattern = code:match("b91%s*=%s*%[=%[(.-)%]=%]")
    if b91_pattern then
    end
    
    local k_content = code:match("local%s+k%s*=%s*{(.-)};")
    if k_content then
        local chunks = {}
        for chunk in k_content:gmatch("%[=%[(.-)%]=%]") do
            table.insert(chunks, chunk)
        end
        if #chunks > 0 then
            return decode_base91(table.concat(chunks))
        end
    end
    
    return nil
end

local function bypass_keysystem(code)
    if not State.keysystem_detected then return code end
    
    local bypassed = code
    
    local patterns = {
        {pattern = "TextBox%.Text%s*==%s*['\"].-['\"]", replace = "true"},
        {pattern = "if%s+.-[Kk]ey.-then", replace = "if true then"},
        {pattern = "while%s+not%s+.-[Vv]erified.-do", replace = "while false do"},
        {pattern = "[Cc]heck[Kk]ey%s*%(.-%)%s*==%s*true", replace = "true"},
        {pattern = "[Vv]erify[Kk]ey%s*%(.-%)%s*==%s*true", replace = "true"},
        {pattern = "TextBox%.Text%s*~=%s*['\"].-['\"]", replace = "false"},
    }
    
    for _, p in ipairs(patterns) do
        bypassed = bypassed:gsub(p.pattern, p.replace)
    end
    
    if code ~= bypassed then
        State.keysystem_bypassed = true
        emit_comment("=== KEY SYSTEM BYPASSED ===")
        return bypassed
    end
    
    return code
end

function Dumper.dump_file(input_path, output_path)
    Dumper.reset()
    emit_comment("ts file generated using larry")
    
    local code, err = safe_read_binary(input_path)

    if not code then
        print("[ERROR] Could not read file: " .. input_path)
        print("[ERROR] " .. (err or "unknown error"))
        return false
    end

    if code:match("ironbrew") or code:match("return%(function%(") then
        State.vm_detected = "ironbrew"
    end
    
    if code:match("Junkie") or (code:match("b91") and code:match("loadstring%(d%(table%.concat")) then
        State.vm_detected = "junkie"
        
        local decode_success, decoded = original_pcall(extract_junkie_payload, code)
        
        if decode_success and decoded and #decoded > 100 then
            local decoded_file = "dumped_output.lua"
            original_pcall(function()
                fs.writeFile(decoded_file, decoded)
            end)
            
            code = decoded
            emit_comment("=== JUNKIE DECODED SUCCESSFULLY ===")
            emit_comment("Original was base91 encoded, now executing decoded payload")
            emit_blank()
        end
    end
    
    if CONFIG.BYPASS_KEYSYSTEM and detect_keysystem(code) then
        State.keysystem_detected = true
        code = bypass_keysystem(code)
    end
    
    local sandbox_env = {
        _G = _G,
        _VERSION = "Lua 5.1",
        
        type = type,
        typeof = typeof,
        tostring = tostring,
        tonumber = tonumber,
        
        pairs = pairs,
        ipairs = ipairs,
        next = original_next,
        select = original_select,
        decode_base91 = decode_base91,
        extract_junkie_payload = extract_junkie_payload,
        unpack = original_unpack,
        
        getmetatable = getmetatable,
        setmetatable = original_setmetatable,
        rawget = rawget,
        rawset = rawset,
        rawequal = rawequal,
        rawlen = rawlen or function(t) return #t end,
        
        pcall = pcall,
        xpcall = xpcall,
        error = original_error,
        assert = assert,
        
        math = math,
        string = hooked_string,
        table = hooked_table,
        coroutine = hooked_coroutine,
        os = _G.os,
        bit = bit_lib,
        bit32 = bit_lib,
        utf8 = utf8,
        debug = exploit_funcs.debug,
        buffer = _G.buffer,
        
        Vector3 = Vector3,
        Vector2 = Vector2,
        CFrame = CFrame,
        Color3 = Color3,
        BrickColor = BrickColor,
        UDim = UDim,
        UDim2 = UDim2,
        TweenInfo = TweenInfo,
        Ray = Ray,
        Rect = Rect,
        Region3 = Region3,
        NumberRange = NumberRange,
        NumberSequence = NumberSequence,
        ColorSequence = ColorSequence,
        PhysicalProperties = PhysicalProperties,
        RaycastParams = RaycastParams,
        Random = Random,
        DateTime = DateTime,
        OverlapParams = OverlapParams,
        
        game = game,
        Game = game,
        workspace = workspace,
        Workspace = workspace,
        script = script,
        Enum = Enum,
        Instance = Instance,
        shared = _G.shared,
        
        task = task,
        wait = wait,
        Wait = wait,
        delay = delay,
        Delay = delay,
        spawn = spawn,
        Spawn = spawn,
        tick = tick,
        time = time,
        elapsedTime = elapsedTime,
        
        print = print,
        warn = warn,
        loadstring = loadstring,
        load = load,
        require = require,
        newproxy = _G.newproxy,
        settings = _G.settings,
        UserSettings = _G.UserSettings,
        gcinfo = _G.gcinfo,
        collectgarbage = _G.collectgarbage,
        
        LuraphContinue = function() end,
        
        control_flow = control_flow,
    }
    
    for name, func in original_pairs(exploit_funcs) do
        sandbox_env[name] = func
    end
    
    local sandbox = original_setmetatable(sandbox_env, {
        __index = function(t, k)
            if sandbox_env[k] ~= nil then return sandbox_env[k] end
            if _G[k] ~= nil then return _G[k] end
            
            local proxy = create_proxy(k, true)
            rawset(t, k, proxy)
            return proxy
        end,
        __newindex = function(t, k, v)
            State.global_assignments[k] = v
            emit(string.format("_G.%s = %s", safe_string(k), serialize(v)))
            rawset(_G, k, v)
        end
    })
    
    State.sandbox = sandbox
    
    local chunk, load_err = original_loadstring(code, "Obfuscated_Script", "bt", sandbox)
    
    if not chunk then
        chunk, load_err = original_loadstring(code, "Obfuscated_Script", "t", sandbox)
    end
    
    if not chunk then
        emit_comment("Load Error: " .. (load_err or "unknown"))
        print("[ERROR] Failed to load script: " .. (load_err or "unknown"))
        
        original_pcall(function()
            fs.writeFile("DEBUG_LOAD_ERROR.txt", "Error: " .. (load_err or "unknown") .. "\n\nCode:\n" .. code:sub(1, 5000))
        end)
        
        return Dumper.save(output_path or CONFIG.OUTPUT_FILE)
    end
    
    State.start_time = os.clock()
    
    local success, runtime_err = original_xpcall(function()
        local co = original_coroutine.create(chunk)
        
        while original_coroutine.status(co) ~= "dead" do
            if os.clock() - State.start_time > CONFIG.TIMEOUT_SECONDS then
                emit_comment("TIMEOUT: Execution exceeded " .. CONFIG.TIMEOUT_SECONDS .. " seconds")
                break
            end
            
            local ok, err = original_coroutine.resume(co)
            if not ok then
                if original_type(err) == "string" then
                    if err:match("invalid utf%-8") or err:match("binary") then
                        break
                    elseif err:match("TIMEOUT") or err:match("DUMP_LIMIT") then
                        break
                    end
                end
                break
            end
        end
    end, function(e)
        local err_str = original_tostring(e)
        return SanitizePath(err_str)
    end)
    
    if not success then
        emit_comment("Terminated: " .. (runtime_err or "Unknown"))
    end
    
    local captured_count = 0
    for _ in original_pairs(State.captured_strings) do
        captured_count = captured_count + 1
    end
    
    if captured_count > 0 then
        emit_blank()
        emit_comment("Captured " .. captured_count .. " decrypted strings")
    end
    
    if #State.call_graph > 0 then
        emit_blank()
        emit_comment("Detected " .. #State.call_graph .. " remote calls")
    end
    
    for k, v in original_pairs(State.global_assignments) do
        emit_blank()
        emit(string.format("_G.%s = %s", safe_string(k), serialize(v)))
    end
    
    if State.keysystem_bypassed then
        emit_blank()
        emit_comment("=== KEY SYSTEM SUCCESSFULLY BYPASSED ===")
    end
    
    return Dumper.save(output_path or CONFIG.OUTPUT_FILE)
end

function Dumper.dump_string(code, output_path)
    Dumper.reset()
    
    local chunk, err = original_load(code, "string_input", "t", State.sandbox or _G)
    if not chunk then
        emit_comment("Load Error: " .. (err or "unknown"))
        return false, err
    end
    
    original_xpcall(function() chunk() end, function() end)
    
    if output_path then
        return Dumper.save(output_path)
    end
    return true, get_output()
end

local args = process.args

if args[1] then
    local input = args[1]
    local output = args[2] or CONFIG.OUTPUT_FILE
    
    print("=" .. string.rep("=", 50))
    print("=" .. string.rep("=", 50))
    print("Input:  " .. input)
    print("Output: " .. output)
    print("")
    
    local success = Dumper.dump_file(input, output)
    
    if success then
        print("")
        print("[SUCCESS] Saved to: " .. output)
        local stats = Dumper.get_stats()
        print(string.format("  Lines: %d | Remotes: %d | Proxies: %d", 
            stats.total_lines, stats.remote_calls, stats.proxies_created))
        
        if stats.keysystem_detected then
            print("  [!] Key system detected and bypassed")
        end
        
        if stats.captured_strings > 0 then
            print("  [!] Captured " .. stats.captured_strings .. " decrypted strings")
        end
        
        local global_count = 0
        for _ in original_pairs(stats.global_assignments) do
            global_count = global_count + 1
        end
        
        if global_count > 0 then
            print("  [!] Tracked " .. global_count .. " global assignments")
        end
    else
        print("[FAILED] Check error output")
    end
else
    local exists = original_pcall(function() return fs.readFile("obfuscated.lua") end)
    if exists then
        local success = Dumper.dump_file("obfuscated.lua")
        if success then
            print("Saved to: " .. CONFIG.OUTPUT_FILE)
        end
    else
        print("Usage: lune run dumper.luau <input> [output]")
        print("")
        print("Examples:")
        print("  lune run dumper.luau script.lua output.lua")
        print("  lune run dumper.luau obfuscated.lua")
        print("")
        print("Features:")
        print("  - Captures callbacks and control flow")
        print("  - Tracks _G and getgenv() assignments")
        print("  - Bypasses key systems automatically")
        print("  - Decodes Junkie base91 payloads")
        print("  - Detects IronBrew VMs")
        print("  - Captures all remote calls")
    end
end

return Dumper