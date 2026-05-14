-- Do not save this file
-- Always use the loadstring 
  _bsdata0={{1684976426,1767278170,88938},3352511568,785507,"\241\0\0\0","231E!-F33C-0A5B60H0A6F0D3CF3BA!521FEHF6CFF446EFD5ED!C5BD!C-F0F351426D65FD4A6EBH4AC3!EF36FD14--64FF5CBDA3F2F4H2D2!DC15F","0ae1e8aeac4fe5a6c0c0e2e44a9601cc29b0696c19985e300699d4b51bde5a313a3a6f52b01c45971bd7d78ecafbe7d15855a8f6f053fd2f632a06b4e43adbd1c866dc776d25c08a174e892f32de0cd8095fbc089cefbaccbdeb87897e32dae48cf98290c56324be24a64cc6b4a522026f817cee1ba80546721b4dde36398b92950df2f96774ef186c31d467de787dc68a225f65f9dd47115a0d22069a7ee9498ac881fd75f152129af24f6e33b1c5f6ff13f3a9a398df18c0bee65ccf094db756c81eddbcce38"};
local f,b,a="static_content_130525","7143b8f8ccc2caf4";pcall(function()a=readfile(f.."/init-"..b..".lua")end) if a and #a>2000 then a=loadstring(a) else a=nil; end;
if a then return a() else pcall(makefolder,f) a=game:HttpGet("https://cdn.luarmor.net/v4_init_may312.lua"..(_ca920af6193 or "")) writefile(f.."/init-"..b..".lua", a); 
pcall(function() for i,v in pairs(listfiles('./'..f)) do local m=v:match('(init[%w%-]*).lua$') if m and m~=('init-'..b) then pcall(delfile, f..'/'..m..'.lua') end end; end); return loadstring(a)() end
  