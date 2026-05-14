local Instance = {}

function Instance.setup(context: any)
	local state = context.state
	local codegen = context.codegen
	local createProxy = context.createProxy

	local handlers = {}

	handlers["GetService"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("svc")
		local call = codegen:methodCall(parent, "GetService", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["WaitForChild"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("wfc")
		local call = codegen:methodCall(parent, "WaitForChild", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["FindFirstChild"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ffc")
		local call = codegen:methodCall(parent, "FindFirstChild", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["FindFirstChildOfClass"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ffc")
		local call = codegen:methodCall(parent, "FindFirstChildOfClass", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["FindFirstChildWhichIsA"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ffc")
		local call = codegen:methodCall(parent, "FindFirstChildWhichIsA", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["FindFirstAncestor"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ffc")
		local call = codegen:methodCall(parent, "FindFirstAncestor", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["FindFirstAncestorOfClass"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ffc")
		local call = codegen:methodCall(parent, "FindFirstAncestorOfClass", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["FindFirstAncestorWhichIsA"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ffc")
		local call = codegen:methodCall(parent, "FindFirstAncestorWhichIsA", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["Clone"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("clone")
		local call = codegen:methodCall(parent, "Clone", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["Destroy"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Destroy", {})
	end

	handlers["ClearAllChildren"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "ClearAllChildren", {})
	end

	handlers["GetChildren"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:openBlock("for _, child in " .. codegen:methodCall(parent, "GetChildren", {}) .. " do")
		return {}
	end

	handlers["GetDescendants"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:openBlock("for _, desc in " .. codegen:methodCall(parent, "GetDescendants", {}) .. " do")
		return {}
	end

	handlers["IsA"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		return true
	end

	handlers["IsDescendantOf"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		return true
	end

	handlers["IsAncestorOf"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		return false
	end

	handlers["GetFullName"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("name")
		local call = codegen:methodCall(parent, "GetFullName", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["SetAttribute"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "SetAttribute", argStrs)
	end

	handlers["GetAttribute"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("attr")
		local call = codegen:methodCall(parent, "GetAttribute", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName)
	end

	handlers["GetAttributes"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("attrs")
		local call = codegen:methodCall(parent, "GetAttributes", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["SetPrimaryPartCFrame"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "SetPrimaryPartCFrame", argStrs)
	end

	handlers["MoveTo"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "MoveTo", argStrs)
	end

	handlers["GetBoundingBox"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("bb")
		local call = codegen:methodCall(parent, "GetBoundingBox", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["BreakJoints"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "BreakJoints", {})
	end

	handlers["MakeJoints"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "MakeJoints", {})
	end

	handlers["GetMass"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("mass")
		local call = codegen:methodCall(parent, "GetMass", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "number")
	end

	handlers["GetTouchingParts"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("parts")
		local call = codegen:methodCall(parent, "GetTouchingParts", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["GetConnectedParts"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("parts")
		local call = codegen:methodCall(parent, "GetConnectedParts", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["GetJoints"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("joints")
		local call = codegen:methodCall(parent, "GetJoints", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["GetMouse"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("mouse")
		local call = codegen:methodCall(parent, "GetMouse", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["GetNetworkOwner"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("owner")
		local call = codegen:methodCall(parent, "GetNetworkOwner", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["SetNetworkOwner"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "SetNetworkOwner", argStrs)
	end

	return handlers
end

return Instance