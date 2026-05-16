-- This Script is Part of the Prometheus Obfuscator by Levno_710
--
-- namegenerators/ad.lua
--
-- This Script provides a function for generation of confusing variable names

local util = require("prometheus.util");
local chararray = util.chararray;

local varNames = {
    "_25ms",
    "wowMyPingIsBelow25ms",
    "_33ms",
    "frostluaIsBadAtCoding",
    "frost",
    "frosties",
    "frostlua",
    "cracklua",
    "fbi",
    "CeaseAndDesist",
    "dmca",
    "batIsSilly",
    "madbuckscripts",
    "SynergyHub",
    "Pelinda",
    "PandaAuth",
    "Key",
    "HWID",
    "gethwid",
    "blazinglyfast",
    "KITTYY",
    "sonic",
    "youreTooSlow",
    "youreToooSlow",
    "discord",
    "rScriptsIsBad",
    "filebrute",
    "tmp4",
    "PlayboiCarti",
    "crackpls",
    "CanCrackLumorPls",
    "luarmor",
    "johanna",
    "Bacon",
    "BaconBoss",
    "Beecon",
    "xro",
    "cum",
    "Script",
    "loadstring",
    "base64",
    "JSONEncode",
    "HttpService",
    "hookmetamethod",
    "hookfunction",
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
    "term",
    "freeterm",
    "Il",
    "lI",
    "l1",
    "I1",
    "game",
    "ted",
    "red",
    "blue",
    "DotGGSlash25ms",
    "nokey",
    "scriptblox",
    "crackle",
    "sponsor",
    "infinix",
    "PutAKeySysOnDex",
    "keylessIsBetter",
    "Pennies",
    "nordvpn",
    "shakespear",
    "shakesspear",
    "shakepear",
    "solor",
    "soloro",
    "solora",
    "getinfo",
    "info",
    "gg25ms",
    "discordgg25ms",
    "a","b","c","d","e","f","g","h","I","y","j","k","l",
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
