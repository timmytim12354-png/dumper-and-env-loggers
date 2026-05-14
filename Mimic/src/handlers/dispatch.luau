local Utils = require("../utils")
local Constructors = require("./constructors")
local Instance = require("./instance")
local Events = require("./events")
local Network = require("./network")
local Misc = require("./misc")

local Handlers = {}

function Handlers.new(state: any, codegen: any, serialize: any, createProxyCallback: any)
	local context = {
		state = state,
		codegen = codegen,
		serialize = serialize,
		createProxy = createProxyCallback,
	}

	local allHandlers = Utils.mergeMaps(
		Constructors.setup(context),
		Instance.setup(context),
		Events.setup(context),
		Network.setup(context),
		Misc.setup(context)
	)

	return function(parent: string, method: string, rawArgs: {any}, argStrs: {string}): any
		local handler = allHandlers[method]
		if handler then
			return handler(parent, rawArgs, argStrs)
		end

		local Constants = require("../constants")
		local prefix = Constants.VAR_PREFIXES[method] or "result"
		local varName = codegen:emitDeclareCall(prefix, parent, method, argStrs)
		local proxy = createProxyCallback(varName)
		return proxy
	end
end

return Handlers