local Network = {}

function Network.setup(context: any)
	local state = context.state
	local codegen = context.codegen
	local createProxy = context.createProxy

	local handlers = {}

	handlers["FireServer"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "FireServer", argStrs)
	end

	handlers["InvokeServer"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("result")
		local call = codegen:methodCall(parent, "InvokeServer", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["FireClient"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "FireClient", argStrs)
	end

	handlers["FireAllClients"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "FireAllClients", argStrs)
	end

	handlers["InvokeClient"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("result")
		local call = codegen:methodCall(parent, "InvokeClient", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["HttpGet"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("resp")
		local call = codegen:methodCall(parent, "HttpGet", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["HttpPost"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("resp")
		local call = codegen:methodCall(parent, "HttpPost", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["GetAsync"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("data")
		local call = codegen:methodCall(parent, "GetAsync", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["PostAsync"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("resp")
		local call = codegen:methodCall(parent, "PostAsync", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["RequestAsync"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("resp")
		local call = codegen:methodCall(parent, "RequestAsync", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	return handlers
end

return Network