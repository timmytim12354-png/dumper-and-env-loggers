print(25,"starting the dummppP!!! Made by 25ms, join discord.gg/25ms",25)
local require, getmetatable, getfenv
    = require, getmetatable, getfenv
getfenv().require=function()end
local clock=os.clock
local startt=clock()
local commercial=false
local inpath=commercial and "" or "dumps\\original\\"
local outpath=commercial and "" or "dumps\\dumped\\"

local fs = fs or require("@25msrequireluvsu/fs")
local process = process or require("@25msrequireluvsu/process")
local luau = luau or require("@25msrequireluvsu/luau")
local roblox=not commercial and require("@25msrequireluvsu/roblox") or {}
local task=require("@25msrequireluvsu/task")
local targetfilename=process.args[1]
if not targetfilename then
    print("lol you didnt put a filename or luarmor link")
    return
end
local LRMPath=targetfilename:find("https://api.luarmor.net/files/v3/") and targetfilename:gsub("https://api.luarmor.net/files/v3/loaders/",""):gsub("https://api.luarmor.net/files/v3/l/","")
if not (LRMPath or fs.isFile(inpath..targetfilename)) then
    print("lol that file doesnt exist")
    return
end
local request=(net or require("@25msrequireluvsu/net")).request
local input = LRMPath and (function()
    local cont=request({url=targetfilename:gsub("loaders","l"),method ="GET",headers={["User-Agent"]="Xeno/RobloxApp/V1.0.9"}}).body
    targetfilename=LRMPath
    fs.writeFile(inpath..LRMPath,cont)
    return cont
end)()
or fs.readFile(inpath..targetfilename)

local methods={
    {
        expressions={"(%a%a?%[%a%a?%[%w[%w_]*%]%]%s*%.%.%s*%a%a?%[%a%a?%[%w[%w_]*%]%])"},
        replace="_25ms(%1)"
    },
    {
        expressions={
            "(local function [%a%d_]+%([%a%d_]+,%s?[%a%d_]+%).-)(local [%a%d_]+,[%a%d_]+,[%a%d_]+,[%a%d_]+.-%]%)?;)(.-[%a%d_]+%s?=%s?%(?function%(%.%.%.)",
            "([%a%d_]+=%(function%([%a%d_]+,%s?[%a%d_]+%).-)(local [%a%d_]+,[%a%d_]+,[%a%d_]+,[%a%d_]+.-%]%)?;)(.-[%a%d_]+%s?=%s?%(?function%(%.%.%.)"
        },
        -- replace=function(pre,interest,post)
        --     local var1=interest:split(",")[4]
        --     local var2=interest:split(",")[5]
        --     local balls=[[local _realvar=%s;%s=setmetatable({},{__index=function(o,J)local V=_realvar[J]_25ms(V)return V end})]]
        --     local injection=balls:format(var1,var1)..balls:format(var2,var2)
        --     print(pre,"\n",interest,"\n",injection,"\n",post)
        --     return pre..interest..injection..post
        -- end
        replace=function(pre,interest,post)
            local balls=[[local _realvar=%s;%s=setmetatable({},{__index=function(o,J)local V=_realvar[J]_25ms(V)return V end})]]
            local injection=""
            for i,v in interest:split(",") do
                v=v:gsub("local ","")
                if #v == 1 then
                    print(i,v)
                    injection=injection..balls:format(v,v)..";"
                end
            end
            -- print(pre,"\n",interest,"\n",injection,"\n",post)
            return pre..interest..injection..post
        end
    },
}
local function applymethods(input)
    local done=false
    for _,method in methods do
        for _,expression in method.expressions do
            if input:find(expression) then
                input=input:gsub(expression,method.replace)
                done=true
                break
            end
        end
        if done then break end
    end
    return input
end
local _25msrobloxenv,_tbl=not commercial and require("fakegame.lua") or {}
local _pcall=pcall
-- if not input:find(expression) then
--     print("couldnt find anything to modify")
--     return
-- end
-- fs.writeFile("zzRun.lua",input)
local runcode = applymethods(input)
-- if runcode==input then
--     warn("regex bad :(")
-- end
if false then -- insert unminified
    local buffer={}
    local insert=table.insert
    local _25ms=function(s)
        insert(buffer,s)
        return s
    end
    local print,next,type,wait
        = print,next,type,wait or task.wait
    local log=function(s)
        print(s)
        -- appendfile("logs.txt",tostring(s).."\n")
    end
    local wait=task and task.wait or wait
    task.spawn(function()
        while wait(3) do
            for i,v in next,buffer do
                if type(v)=="string" and buffer[i-1] ~= v:sub(1,#v-1)then
                    log(v)
                end
                buffer[i-1] = nil
            end
        end
    end)
end
-- fs.writeFile("zzRun.lua",[[local h={}local g=table.insert local _25ms=function(P)g(h,P)return P end local l,O,A,B=print,next,type,wait or task.wait local d=function(h)l(h)end local m=task and task.wait or B task.spawn(function()while m(3)do for g,P in O,h do if A(P)=="string"and h[g-1]~=P:sub(1,#P-1)then d(P)end h[g-1]=nil end end end);]]..runcode)
local chunk, err = luau.load(runcode)
if err then
    warn("BAD OMGG"..err)
    return
end

local r={}
local c=0
local genv={}
local cenv = {}
for i,v in _25msrobloxenv do
    cenv[i] = v
end
for i,v in roblox do
    cenv[i] = v
end
local _game=not commercial and roblox.deserializePlace(fs.readFile("Baseplate.rbxl")) or {}
local whitelistedUrls={
    -- "https://pastebin.com",
    -- "https://raw.githubusercontent",
    "https://raw.githubusercontent.com/Ozzypig/repr/master/repr.lua",
    "https://eternalexploits.pythonanywhere.com/?get_games_info=1"
}
local tablefuncmt=setmetatable({},{
    index=function()return function()return _tbl end end})
local services={
    -- RunService=tablefuncmt,
}
cenv.require=function()return _tbl()end
cenv.game=setmetatable({
    HttpGet=function(_,Url)
        for _,v in whitelistedUrls do
            if Url:sub(1,#v) == v then
                print("returning real")
                return request{url=Url,method="GET"}.body
            end
        end
        return [[_LOL_Replace_25ms_]]
    end,
    IsLoaded=function()return true end,
    GetService=function(_,service)
        return services[service] or tablefuncmt
    end,
    PlaceId=14004668761
},{
    __index=function(_,key)
        -- if not _game[key] then
        --     return _tbl
        -- elseif type(_game[key])=="function" then
        --     return function(_,...)
        --         _game[key](_game,...)
        --     end
        -- end
        return _game[key] or _tbl
    end
})
local print=print
cenv._25ms=function(var)
    local vartype=type(var)
    if vartype=="string" then
        local wow="["..vartype.."]:"..var
        if not r[c] or r[c]~=wow:sub(1,#wow-1) then
            c=c+1
        end
        print(wow)
        r[c]=wow
    end
    return var
end
cenv.pcall=function(...)
    local res={_pcall(...)}
    if res[1] == false then
        res[2] = tostring(res[2])
    end
    return unpack(res)
end
cenv.error=function()end
cenv.wait=function()return 1 end
cenv.loadstring=function(src,b)
    if src:find("return(function(",1,true) then fs.writeFile("zzRun.lua",src) end
    if src=="_LOL_Replace_25ms_" then
        return function()print("YESSIRRR")return _tbl()end
    end
    local src=applymethods(src)
    print(src)
    local _func=luau.load(src,b)
    setfenv(_func,setmetatable(cenv,{__index=getfenv(2)}))
    return _func
end
cenv.ce_like_loadstring_fn=cenv.loadstring
cenv.script_key="c4ce76cd36f2afee4dcee7e87576e5fa"
cenv.getgenv=function()
    return genv
end
cenv.getfenv=function(lvl)
        local origlvl=lvl
        if type(lvl)=="number" and lvl<0 then return error("invalid argument #1 to 'getfenv' (level must be non-negative)") end
        lvl=lvl and (type(lvl)=="number" and lvl+1 or lvl) or 2
        local res=getfenv(table.find({"function","number"},type(lvl)) and lvl or nil)
        local res_mt=getmetatable(res)
        if rawget(res,"require")==require or (type(res_mt)=="table" and type(res_mt.__index)=="table" and res_mt.__index.require==require) or (res_mt~=nil and type(res_mt~="table"))then
            -- local varname=getnewvar()
            -- simplelog(varname,"getfenv",origlvl)
            -- return spytbl(varname)
            return fenv_mt
        end
        return res
    end
for i,v in cenv do
    genv[i] = v
end
cenv.print=function()end
cenv.warn=function()end
cenv.task=setmetatable({wait=function()return 1 end},{__index=task})
cenv.spawn=task.spawn
-- setfenv(chunk,setmetatable(cenv,{__index=getfenv(chunk)}))
local ogenv=getfenv(chunk)
local found={}
setfenv(chunk,setmetatable({},{__index=function(_,key)
    if not found[key] then
        found[key]=true
        print("found",key)
    end
    return cenv[key] or ogenv[key]
end}))
local success, er = _pcall(chunk)
if not success then
    print(er)
    c=c+1
    r[c]="-- The script errored here. Which means any string constants after this wont be captured in this dump.\n--[[\nError: "..tostring(er).."\n--]]"
end

local post=commercial and "_dump.lua" or ".lua"
local result=table.concat(r,"\n")
fs.writeFile(outpath..targetfilename:gsub(".lua","")..post,table.concat(r,"\n"))

local endt=clock()-startt
print("success in",endt,"seconds!\nWritten to "..outpath..targetfilename:gsub(".lua","")..post)
if result:find("LUARMOR") or result:find("Luarmor") or result:find("luarmor") then
    result = "Luarmor files are not supported. Buy luarmor @ https://luarmor.net/ "
end
print(result)
