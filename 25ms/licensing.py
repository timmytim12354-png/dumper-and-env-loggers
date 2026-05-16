from json import loads,dumps
from util import *
from time import time
import asyncio
from collections import defaultdict
data=loads(open("licenses.json").read())


def save():
    open("licenses.json","w").write(dumps(data))
dump_id=1373857675497963601
guild=None
role=None
def init(client):
    global guild,role
    guild = client.get_guild(1306714913539887237)
    role = guild.get_role(dump_id)
whitelisted=defaultdict(int)
async def get_whitelisted():
    global whitelisted
    whitelisted=defaultdict(int)
    for license,info in data.items():
        if info["claimed"]:
            whitelisted[info["claimed"]]=True
def is_whitelisted(user):
    return whitelisted[user]
def get_roles(member):
    if member:
        return member.roles

async def claim(user,client,license=None,overwrite=False):
    global data
    new_key=randomstr(36)
    change_msg=f"`{license}` claimed by <@{user}>, previous owner <@{license in data and data[license]['claimed'] or "NONE"}>, new key `{new_key}`"
    if not overwrite:
        if not license in data:
            return "Invalid license key"
        info = data[license]
        if "available" in info and info["available"]>time():
            return f"Recovery license cant be claimed yet, it will be available in {seconds_to_str(round(info['available']-time()))}"
        else:
            member=guild.get_member(info["claimed"])
            if member:
                try:await member.remove_roles(role)
                except:pass
            if info["claimed"] and info["claimed"] in whitelisted:del whitelisted[info["claimed"]]
            del data[license]
    data[new_key]={
        "claimed": user,
        "available": round(time()+1209600)
    }
    save()
    try:
        await client.get_channel(1306718479076032625).send(change_msg)
    except:
        pass
    member = guild.get_member(user)
    channel=await member.create_dm()
    await member.add_roles(role)
    try:
        await channel.send(f"Your recovery license for dumper access is ||{new_key}||, it can be used in 2 weeks from now\n-# Save it somewhere safe in case you get termed, no refunds if you loose it :p")
    except:
        return "Failed to send dm. Use `.getrecovery` to view your recovery code."
    return "Success"
async def get_recovery(user):
    for license,info in data.items():
        if info["claimed"]==user.id:
            return license

async def regenerate_all():
    unsuccessful = []
    global data
    for license,info in data.copy().items():
        if info and "claimed" in info and info["claimed"]:
            member = guild.get_member(info["claimed"])
            if member and any(role.id==dump_id for role in get_roles(member)):
                continue
            new_key=randomstr(36)
            data[new_key]=info
            if not member:
                unsuccessful.append(f"Could not find <@{info["claimed"]}> -> {license}")
            else:
                channel=await member.create_dm()
                try:await member.add_roles(role)
                except:pass
                try:
                    print(await channel.send(f"Your recovery license for dumper access is ||{new_key}||\n-# Save it somewhere safe in case you get termed, no refunds if you loose it :p"))
                except:
                    unsuccessful.append(f"Couldnt send dm to <@{info["claimed"]}> -> {license}")
        print(f"Deleted {license}")
        del data[license]
    save()
    return "hi :p"+"\n".join(unsuccessful)

def generate(amount=1):
    global data
    keys = []
    for _ in range(amount):
        key = False
        while not key:
            trykey=randomstr(36)
            if trykey not in data:
                key = trykey
        keys.append(key)
        data[key] = {
            "claimed": False
        }
    save()
    return keys

async def revoke(user,client):
    global data
    for license,info in data.items():
        if info and info["claimed"]==user:
            member=guild.get_member(user)
            if member:
                try:await member.remove_roles(role)
                except:pass
            if info["claimed"] and info["claimed"] in whitelisted:del whitelisted[info["claimed"]]
            del data[license]
            save()
            return "Success"
    return "No license found"

asyncio.run(get_whitelisted())