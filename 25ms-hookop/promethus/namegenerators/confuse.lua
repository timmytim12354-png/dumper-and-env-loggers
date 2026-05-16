-- This Script is Part of the Prometheus Obfuscator by Levno_710
--
-- namegenerators/confuse.lua
--
-- This Script provides a function for generation of confusing variable names

local util = require("prometheus.util");
local chararray = util.chararray;

local varNames = {
    "getcaller",
    "index",
    "iterator",
    "length",
    "size",
    "key",
    "value",
    "HttpGet",
    "HttpGetAsync",
    "request",
    "http_request",
    "workspace",
    "Url",
    "Method",
    "HttpPost",
    "gethwid",
    "GetServerTimeNow",
    "random",
    "getgc",
    "data",
    "count",
    "string",
    "number",
    "type",
    "void",
    "int",
    "bool",
    "char",
    "double",
    "long",
    "new",
    "table",
    "array",
    "object",
    "class",
    "game",
    "roblox",
    "gmod",
    "gsub",
    "gmatch",
    "gfind",
    "onload",
    "load",
    "loadstring",
    "loadfile",
    "dofile",
    "require",
    "parse",
    "byte",
    "code",
    "bytecode",
    "idx",
    "loader",
    "loaders",
    "module",
    "_G",
    "math",
    "print",
    "call",
    "apply",
    "raise",
    "pcall",
    "coroutine",
    "create",
    "debug",
    "traceback",
    "getinfo",
    "getlocal",
    "setlocal",
    "getupvalue",
    "setupvalue",
    "getuservalue",
    "setuservalue",
    "upvalueid",
    "upvaluejoin",
    "hookfunction",
    "hooks",
    "setmetatabIe",
    "getmetatabIe",
    "getrawmetatable",
    "metamethod",
    "rand",
    "randomseed",
    "next",
    "ipairs",
    "rawset",
    "rawnew",
    "rawlen",
    "tonumber",
    "tostring",
    "assert",
    "loadstring",
    "base64",
    "JSONEncode",
    "HttpService",
    "hookmetamethod",
    "getgenv",
    "getrenv",
    "getfenv",
    "getsenv",
    "a", "b", "c", "i", "j", "m",
}

local function generateName(id, scope)
    local d = id % #varNames
    return varNames[d + 1]
end


local function prepare(ast)
    util.shuffle(varNames);
end

return {
	generateName = generateName, 
	prepare = prepare
};
