local tbl_to_s
function tbl_to_s(tbl, indent)
    indent = indent or 0
    local to_string = function(value)
        if type(value) == "table" and indent<10 then
            return tbl_to_s(value, indent + 2)
        elseif type(value) == "string" then
            return string.format("%q", value)
        else
            return tostring(value)
        end
    end

    local result = "{\n"
    local spacing = string.rep(" ", indent + 2)
    for k, v in pairs(tbl) do
        local key = type(k) == "string" and string.format("%q", k) or "[" .. tostring(k) .. "]"
        result = result .. spacing .. key .. " = " .. to_string(v) .. ",\n"
    end
    result = result .. string.rep(" ", indent) .. "}"
    return result
end
local _print=print
print=function(...)
    local args=table.pack(...)
    for i=1,args.n do
        local v=args[i]
        if type(v)=="table" then
            args[i]=tbl_to_s(v)
        else
            args[i]=tostring(v)
        end
    end
    -- _print(unpack(args))
end
local function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*[/%\\])")
end
package.path = script_path() .. "?.lua;" .. package.path;
local parser=require("prometheus/parser"):new{
    LuaVersion="LuaU"
}
local unparser=require("prometheus/unparser"):new{
    LuaVersion="LuaU"
}

local function lines_from(file)
    local lines = {}
    for line in io.lines(file) do
      lines[#lines + 1] = line
    end
    return lines
  end
local filename="hook_op/file_cache/"..arg[1]
local result=(unparser:unparse(parser:parse(table.concat(lines_from(filename),"\n"))))
local handle = io.open(filename, "w");
handle:write(result);
handle:close();
