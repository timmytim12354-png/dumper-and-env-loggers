# from rscriptslib import *
from scriptbloxlib import *
from util import *
import regex,asyncio
import re
import aiohttp
async def securerun(luafile, filename,timeout=20):
    command = (
        ['lune', 'run', f'./{luafile}', filename]
    )
    process = await asyncio.create_subprocess_exec(
        *command,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE
    )
    try:
        stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=timeout)
        process.stdout = stdout.decode("utf-8")
        process.stderr = stderr.decode("utf-8")
        if not "success" in process.stdout:
            return False, "Unsuccessful"
        else:
            return True, "Success"
    except asyncio.TimeoutError:
        process.kill()
        await process.communicate()
        return False, "Timeout"
    except Exception as e:
        print(e)
        return False, "Error"   
    
dumpers_regex = {
    r"return [A-z0-9_]+\([0-9A-z_]+\(\),[A-z0-9,_\{\}\)\(]+\)": "ib2likedump.lua",
}
dumpers_nonregex = {
    "newproxy,setmetatable,getmetatable,select,{...})end)(...)":"httplog2.lua",
    "[[This file was protected with MoonSec V3": "unpack_dumper.lua",
    "local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7":"badluaobf.lua"
}

def identify(src):
    for pattern, filename in dumpers_nonregex.items():
        if pattern in src:
            return filename
    for pattern, filename in dumpers_regex.items():
        try:
            if regex.search(pattern, src, timeout=2):
                return filename
        except:
            continue
    return False
def getmainscript(script,iter=0):
    if iter>5:
        return script
    if "loadstring" in script and "http" in script and ("game:HttpGet" in script or "request" in script):
        try:
            url="https://"+("https://" in script.split("loadstring")[1] and script.split("loadstring")[1] or script).split("https://")[1].split("'")[0].split('"')[0]
            return getmainscript(getraw(url),iter+1)
        except Exception as er:
            print("Error when splititng vro",er)
            return script
    return script

malicious_texts = {
    "robuxstealer": [
        ["httprbxapiservice", "postasync"],  # it has to match all of these to be considered robuxstealer
        ["httprbxapiservice", "requestasync"], 
        ["marketplaceservice", "performpurchase"],  # or all of these
    ],
    "rat": [
        ["scriptcontext", "savescriptprofilingdata"],
        ["linkingservice", "openurl"],
    ],
    "generic item stealer": [
        ["tobi437a"],
        ["darkscripts.space"],
        ["egorikusa.space"],
        ["your robux just got stolen by tobi's stealer"],
        ["pls donate stealer by tobi."],
        ["stealer by tobi"],
        ["stealer_link"],
        ["min_value","discuser"],
        ["engaging-secondly-buck.ngrok-free.app"],
        ["/surelyco"],["SharkyScriptz/"],["/reasonrekt/"],["spacescripthub"],["/lelel22f"],["/reasonrektl"]
    ],
    "trade-stealer": [
        ["tradestealer"],
        ["trade-stealer"],
    ],
    "mail-stealer": [
        ["mailstealer"],
        ["mail-stealer"],
    ],
    "token grabber": [
        ["httpservice", "requestinternal"],
        ["httpservice", "requestasync"],
        ["browserservice", "executejavascript"],
        ["browserservice", "sendcommand"],
        ["browserservice", "returntojavascript"],
        ["accountservice","getdeviceaccesstoken"],
        ["accountservice","getcredentialsheaders"],
        ["accountservice","getdeviceintegritytoken"],
    ],
    "generic malicious (im not sure)": [
        ["omnirecommendationsservice","makerequest"],
        ["\"victim name"],
    ],
}

domain_blacklist = ["discord.com","discord.gg","luarmor.net","roblox.com","keyguardian.org","dsc.gg","discordapp.com","ipwho.is","loot-link.com","lootdest.org","controlc.com","ip-api.com","discordapp.net","rekonise.com","youtu.be",
                    "platoboost.net","platoboost.com","linkvertise","lootlink","sirius.menu","stealer.to","direct-link.net","127.0.0.1","link-target.net","ipify.org","youtube.com","amazonaws.com","keyrblx.com","link-hub.net",
                    "google.com","skibidi.christmas",":","link-center.net","ident.me","example.co","bit.ly","unluau","openai.com","work.ink","cloudflare.com",
                    ]
uri_blacklist=["dawid-scripts","/s/","edgeiy/infiniteyield","scripts/Dex%20Explorer.txt"]

ip=getraw("https://api.ipify.org")
async def checkscript(identified,script_name_normalized,layer=0):
    print("layer",layer)
    if layer>15:
        return None,layer,identified
    success=True
    if identified: success,er=await securerun(identified, f"scriptbloxcrawl/{script_name_normalized}{layer or ""}.lua")
    print(identified,success)
    if success:
        dumped=False
        try:dumped=open(f"./dumps/{identified and "dumped" or "original"}/scriptbloxcrawl/{script_name_normalized}{layer or ""}.lua","rb").read().decode('utf-8',errors="replace")
        except: pass
        if not dumped or "Security Analysis Summary" in dumped or "getLocalApiJson()" in dumped: return None,layer,identified
        sexwebhooks(dumped)
        for type,texts in malicious_texts.items():
            for variant in texts:
                if all(word.lower() in dumped.lower() for word in variant):
                    return type,layer,identified
        urlstried=0
        for split in dumped.split("http"):
            if not identified and layer!=0: break
            if urlstried>12-layer:
                break
            urlstried+=1
            url="http"+split.split("\n")[0].split("'")[0].split('"')[0]
            if "://" in url and "." in url and not any(word in "".join("".join(url.split("://")[1:]).split("/")[:1]) for word in domain_blacklist)and not any(word in "".join("".join(url.split("://")[1:]).split("/")[1:]) for word in uri_blacklist):
                print(url)
                src=""
                try:
                    src=getraw(url)
                except:
                    continue
                if ip in src:
                    print("ip 💔")
                    continue
                identified=identify(src)
                if not identified:
                    sexwebhooks(src)
                    identified="httplog2.lua"
                try:
                    open(f"./dumps/original/scriptbloxcrawl/{script_name_normalized}{layer+1}.lua","wb").write(src.encode('utf-8',errors="replace"))
                except:
                    continue
                layer=layer+1
                result,layer,newindentified = await checkscript(identified,script_name_normalized,layer)
                if result:
                    return result,layer,newindentified
    return None,layer,identified

async def main():
    for page in range(1,100): # 368
        print(page)
        for script in getpage(page):
            # src=getmainscript(getscript(script))
            src=getscript(script)
            identified=identify(src)
            script_name,script_name_normalized=getscriptname(script)
            ## rest is commented out because we no longer rely on getmainscript
            # if not identified: # add a function logger to run and log unidentified scripts.. function log, http log...
            #     print(f"Could not identify {script_name}")
                # continue
            # else:
            #     print(f"Identified {script_name} as {identified}")
            if os.path.isfile(f"./dumps/original/scriptbloxcrawl/{script_name_normalized}.lua"):
                print(f"Already checked {script_name_normalized}")
                continue
            with open(f"./dumps/original/scriptbloxcrawl/{script_name_normalized}.lua", "wb") as f:
                f.write(src.encode('utf-8',errors="replace"))
            maltype,layer,identified=await checkscript(identified,script_name_normalized)
            if maltype:
                print(f"!!!\n\nMalicious text found in {script_name},type: {maltype}\n\n!!!")
                await alert_malicious(script_name,script_name_normalized, maltype,layer,identified)

async def asyncpost(url, json_body,params=None, headers=None,returnResponseJson=True):
    async with aiohttp.ClientSession() as session:
        async with session.post(url, json=json_body, headers=headers,params=params) as response:
            if returnResponseJson: return await response.json()

webhook_pres=[
  "https://discord.com/api/webhooks/",
  "https://discordapp.com/api/webhooks/",
  "https://canary.discord.com/api/webhooks/",
  "https://ptb.discord.com/api/webhooks/",
  "https://webhook.lewisakura.moe/api/webhooks/",
  "https://stealer.to/",
  "https://discord-stealer.de/",
  "https://webhook.lewisakura.moe",
  "https://webhook-protect.vercel.app/",
  "https://dcwh.my/",
  "https://webhook-protector-worker.sharkyscripts.workers.dev/",
  "https://sharky-on-top.script-config-protector.workers.dev/",
  "https://webhook-protect-2.vercel.app/",
]
def send_webhawk(url):
    print(url)
    if not ("discord.com" in url or "discordapp.com" in url):
        url="https://webhook-post-proxy.benomat.workers.dev/"+url
    asyncio.create_task(asyncpost(url,{"content":"@everone 25ms was here, your webhook isnt safe! Use our free obfuscation or buy luarmor today to be more protected! Also join discord.gg/25ms if you wanna be able to do amazing stuff like this!"},headers={"Content-Type":"application/json"},returnResponseJson=False))
def sexwebhooks(content):
    pattern = '|'.join(re.escape(pre) for pre in webhook_pres)
    webhooks_uncleaned = re.findall(rf'(?:{pattern})\S*?(?=\s|\n|\"|\'|\\)', content)

    webhooks = []
    for webhook in list(dict.fromkeys(webhooks_uncleaned)):
        while webhooks and webhook.startswith(webhooks[-1]) and len(webhook) == len(webhooks[-1]) + 1:
            webhooks.pop()
        webhooks.append(webhook)
    for url in webhooks:
        send_webhawk(url)
    return webhooks and "\n".join(webhooks) or None
if __name__ == "__main__":
    asyncio.run(main())