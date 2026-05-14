local State = require("../state")
local Codegen = require("../codegen")
local Serialize = require("../serialize/value")
local Proxy = require("../proxy")
local Handlers = require("../handlers/dispatch")
local Globals = require("./globals")
local TaskLib = require("./task")
local Spoofs = require("./spoofs")
local Constants = require("../constants")

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

	for _, root in Constants.PROXY_ROOTS do
		env[root.name] = createProxy(root.name, true, root.typeHint)
	end

	Globals.apply(env, state, codegen, serialize, createProxy)

	env.task = TaskLib.build(state, codegen, serialize)

	Spoofs.apply(env, state, createProxy)

	return env, state, codegen
end

return Sandbox