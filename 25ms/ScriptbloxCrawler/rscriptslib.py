from util import *
from json import dumps
from requests import post
def getpage(pagenum):
    data = get("https://rscripts.net/api/v2/scripts", params={
        "page": pagenum,
        "orderBy": "date",
        "sort": "desc"
    })
    print("Max Pages:", data['info']['maxPages'])
    print(len(data['scripts']))
    return data["scripts"]

def getscript(script):
    if not script["rawScript"]:
        return ""
    data = getraw(script["rawScript"]) # v2
    # data=getraw(f"https://rscripts.net/raw/{script["download"]}") # no v2
    return data

async def alert_malicious(script_name, script_name_normalized, type, layer,identified):
    
    files={}
    if os.path.exists(f"./dumps/dumped/scriptbloxcrawl/{script_name_normalized}.lua"): files["ORIGINAL_"+script_name_normalized]=open(f'dumps/original/scriptbloxcrawl/{script_name_normalized}.lua', 'rb')
    if layer: files["DETECTION_"+script_name_normalized]=open(f'dumps/{identified and "dumped" or "original"}/scriptbloxcrawl/{script_name_normalized}{layer}.lua', 'rb')
    result = post(
        "https://discord.com/api/webhooks/1321133053845966940/xUqE3K0TXyhzgWPRAJXqIM2gOkWwFMG0Qpij6BEJV5pi77Na-MmLT2ukq-_2qERHfZSp",
        data={"content": f"<@735518445327876147> Identified `{script_name}` as malicious of type `{type}`"},
        files=files
    )
    print("SENT ALERT", result)