local Events = {}

function Events.setup(context: any)
	local state = context.state
	local codegen = context.codegen
	local createProxy = context.createProxy

	local function findCallback(rawArgs: {any}): ((...any) -> any)?
		for _, arg in rawArgs do
			if type(arg) == "function" then
				return arg
			end
		end
		return nil
	end

	local handlers = {}

	handlers["Connect"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("conn")
		local callback = findCallback(rawArgs)

		codegen:emitLine("local " .. varName .. " = " .. parent .. ":Connect(function(...)")
		state:push()

		if callback then
			pcall(callback)
		end

		state:pop()
		codegen:emitLine("end)")

		return createProxy(varName, false, "RBXScriptConnection")
	end

	handlers["Once"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("conn")
		local callback = findCallback(rawArgs)

		codegen:emitLine("local " .. varName .. " = " .. parent .. ":Once(function(...)")
		state:push()

		if callback then
			pcall(callback)
		end

		state:pop()
		codegen:emitLine("end)")

		return createProxy(varName, false, "RBXScriptConnection")
	end

	handlers["Wait"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("evt")
		local call = codegen:methodCall(parent, "Wait", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["Disconnect"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Disconnect", {})
	end

	handlers["GetPropertyChangedSignal"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("signal")
		local call = codegen:methodCall(parent, "GetPropertyChangedSignal", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "RBXScriptSignal")
	end

	return handlers
end

return Events