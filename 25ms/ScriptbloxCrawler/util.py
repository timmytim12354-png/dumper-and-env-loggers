import aiohttp
import requests
import re
import os
def normalize_filename(filename):
    return re.sub(r'[^a-zA-Z0-9-_]', '_', filename)
def getscriptname(script): # yes this is the same for scriptblox and rscripts
    return script["slug"],normalize_filename(script["slug"])
async def asyncget(url,params=None,headers=None):
    async with aiohttp.ClientSession() as session:
        async with session.get(url,params=params,headers=headers) as response:
            return await response.json()
async def asyncpost(url,data=None,params=None,headers=None):
    async with aiohttp.ClientSession() as session:
        async with session.post(url,data=data,params=params,headers=headers) as response:
            return response.text
async def asyncgetraw(url,params=None,headers=None):
    async with aiohttp.ClientSession() as session:
        async with session.get(url,params=params,headers=headers) as response:
            return response.text
def get(url,params=None,headers={"User-Agent":"wow/5.0","whatami":"25ms script inspection"}):
    return requests.get(url,params=params,headers=headers).json()
def getraw(url):
    return requests.get(url).text