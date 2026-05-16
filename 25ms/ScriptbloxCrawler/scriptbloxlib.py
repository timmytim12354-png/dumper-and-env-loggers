from util import *
import aiofiles
import aiohttp
from requests import post
def getpage(pagenum):
    return get("https://scriptblox.com/api/script/fetch",params={"page":pagenum})["result"]["scripts"]
def getscript(scriptinfo,method=1):
    if method==1:
        return getraw("https://rawscripts.net/raw/"+scriptinfo["slug"])
    elif method==2:
        return getraw("https://scriptblox.com/download/"+scriptinfo["id"])
async def alert_malicious(script_name, script_name_normalized, type, layer,identified):
    print("MEOWMEOW",identified)
    
    files={}
    if os.path.exists(f"./dumps/dumped/scriptbloxcrawl/{script_name_normalized}.lua"): files["ORIGINAL_"+script_name_normalized]=open(f'dumps/original/scriptbloxcrawl/{script_name_normalized}.lua', 'rb')
    if layer: files["DETECTION_"+script_name_normalized]=open(f'dumps/{identified and "dumped" or "original"}/scriptbloxcrawl/{script_name_normalized}{layer}.lua', 'rb')
    result = post(
        "https://discord.com/api/webhooks/1340025082176868494/i7TjMflFvgg2YC8SMlpMpgzz0EeDOs_ydhw8eMle131U08ooIsdtwZuOAm0WJbJR4Mms",
        data={"content": f"<@735518445327876147> Identified `{script_name}` as malicious of type `{type}`"},
        files=files
    )
    print("SENT ALERT", result)
