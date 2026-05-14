local State = require("../state")
local Codegen = require("../codegen")
local Serialize = require("../serialize/value")
local Proxy = require("../proxy")
local Handlers = require("../handlers/dispatch")
local Globals = require("./globals")
local TaskLib = require("./task")
local Spoofs = require("./spoofs")
local Constants = require("../constants")
local luau = require("@lune/luau")

local Sandbox = {}

function Sandbox.build()
	local state = State.new()
	local serialize = Serialize.new(state)
	local codegen = Codegen.new(state)

	local createProxy

	local dispatch = Handlers.new(state, codegen, serialize, function(name, isRoot, typeHint)
		return createProxy(name, isRoot, typeHint)
	end)

	createProxy = Proxy.new(state, codegen, serialize, dispatch)

	local env = {}

	env.pcall = pcall
	env.xpcall = xpcall
	env.error = error
	env.type = type
	env.typeof = type
	env.tostring = tostring
	env.tonumber = tonumber
	env.select = select
	env.unpack = unpack or table.unpack
	env.pairs = pairs
	env.ipairs = ipairs
	env.next = next
	env.rawget = rawget
	env.rawset = rawset
	env.rawequal = rawequal
	env.rawlen = rawlen
	env.setmetatable = setmetatable
	env.getmetatable = getmetatable
	env.newproxy = newproxy
	env.string = string
	env.math = math
	env.table = table
	env.coroutine = coroutine
	env.bit32 = bit32
	env.utf8 = utf8
	env.buffer = buffer
	env.os = os
	env._VERSION = "Luau"

	for _, root in Constants.PROXY_ROOTS do
		env[root.name] = createProxy(root.name, true, root.typeHint)
	end

	Globals.apply(env, state, codegen, serialize, createProxy, luau)

	env.task = TaskLib.build(state, codegen, serialize)

	Spoofs.apply(env, state, createProxy)

	return env, state, codegen
end

return Sandbox