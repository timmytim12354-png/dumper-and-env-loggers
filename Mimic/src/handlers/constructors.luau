local Constants = require("../constants")

local Constructors = {}

function Constructors.setup(context: any)
	local state = context.state
	local codegen = context.codegen
	local serialize = context.serialize
	local createProxy = context.createProxy

	local handlers = {}

	handlers["new"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local prefix = "inst"
		local typeHint = parent

		if parent == "Instance" then
			prefix = "inst"
			typeHint = "Instance"
		elseif parent == "Random" then
			prefix = "rng"
			typeHint = "Random"
		elseif Constants.VALUE_TYPES[parent] then
			prefix = "val"
			typeHint = parent
		else
			prefix = "obj"
			typeHint = parent
		end

		local varName = state:freshVar(prefix)
		local call = codegen:methodCall(parent, "new", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		local proxy = createProxy(varName, false, typeHint)
		return proxy
	end

	handlers["fromRGB"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("color")
		local call = codegen:methodCall("Color3", "fromRGB", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Color3")
	end

	handlers["fromHSV"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("color")
		local call = codegen:methodCall("Color3", "fromHSV", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Color3")
	end

	handlers["fromHex"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("color")
		local call = codegen:methodCall("Color3", "fromHex", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Color3")
	end

	handlers["fromOrientation"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("cf")
		local call = codegen:methodCall(parent, "fromOrientation", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["fromEulerAnglesXYZ"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("cf")
		local call = codegen:methodCall(parent, "fromEulerAnglesXYZ", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["fromEulerAnglesYXZ"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("cf")
		local call = codegen:methodCall(parent, "fromEulerAnglesYXZ", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["fromAxisAngle"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("cf")
		local call = codegen:methodCall(parent, "fromAxisAngle", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["fromMatrix"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("cf")
		local call = codegen:methodCall(parent, "fromMatrix", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["lookAt"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("cf")
		local call = codegen:methodCall(parent, "lookAt", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["Angles"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("cf")
		local call = codegen:methodCall(parent, "Angles", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	return handlers
end

return Constructors