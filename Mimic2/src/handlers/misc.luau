local Misc = {}

function Misc.setup(context: any)
	local state = context.state
	local codegen = context.codegen
	local serialize = context.serialize
	local createProxy = context.createProxy

	local handlers = {}

	handlers["Create"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("tween")
		local call = codegen:methodCall(parent, "Create", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Tween")
	end

	handlers["Play"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Play", {})
	end

	handlers["Stop"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Stop", {})
	end

	handlers["Cancel"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Cancel", {})
	end

	handlers["Pause"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Pause", {})
	end

	handlers["Resume"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Resume", {})
	end

	handlers["JSONEncode"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("json")
		local call = codegen:methodCall(parent, "JSONEncode", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["JSONDecode"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("decoded")
		local call = codegen:methodCall(parent, "JSONDecode", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["SetCore"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "SetCore", argStrs)
	end

	handlers["GetCore"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("core")
		local call = codegen:methodCall(parent, "GetCore", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName)
	end

	handlers["Raycast"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("rayResult")
		local call = codegen:methodCall(parent, "Raycast", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "RaycastResult")
	end

	handlers["Blockcast"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("castResult")
		local call = codegen:methodCall(parent, "Blockcast", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "RaycastResult")
	end

	handlers["Spherecast"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("castResult")
		local call = codegen:methodCall(parent, "Spherecast", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "RaycastResult")
	end

	handlers["AddItem"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "AddItem", argStrs)
	end

	handlers["PromptPurchase"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "PromptPurchase", argStrs)
	end

	handlers["PromptProductPurchase"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "PromptProductPurchase", argStrs)
	end

	handlers["PromptGamePassPurchase"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "PromptGamePassPurchase", argStrs)
	end

	handlers["UserOwnsGamePassAsync"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("owns")
		local call = codegen:methodCall(parent, "UserOwnsGamePassAsync", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "boolean")
	end

	handlers["PlayerOwnsAsset"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("owns")
		local call = codegen:methodCall(parent, "PlayerOwnsAsset", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "boolean")
	end

	handlers["GetProductInfo"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("info")
		local call = codegen:methodCall(parent, "GetProductInfo", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["LoadAnimation"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("anim")
		local call = codegen:methodCall(parent, "LoadAnimation", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["TakeDamage"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "TakeDamage", argStrs)
	end

	handlers["Kick"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Kick", argStrs)
	end

	handlers["GetRankInGroup"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("rank")
		local call = codegen:methodCall(parent, "GetRankInGroup", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "number")
	end

	handlers["GetRoleInGroup"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("role")
		local call = codegen:methodCall(parent, "GetRoleInGroup", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["IsInGroup"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("inGroup")
		local call = codegen:methodCall(parent, "IsInGroup", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "boolean")
	end

	handlers["GetNameFromUserIdAsync"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("name")
		local call = codegen:methodCall(parent, "GetNameFromUserIdAsync", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "string")
	end

	handlers["GetUserIdFromNameAsync"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("uid")
		local call = codegen:methodCall(parent, "GetUserIdFromNameAsync", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "number")
	end

	handlers["GetHumanoidDescriptionFromUserId"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("desc")
		local call = codegen:methodCall(parent, "GetHumanoidDescriptionFromUserId", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["ApplyDescription"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "ApplyDescription", argStrs)
	end

	handlers["LoadCharacter"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "LoadCharacter", {})
	end

	handlers["HasAppearanceLoaded"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("loaded")
		local call = codegen:methodCall(parent, "HasAppearanceLoaded", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "boolean")
	end

	handlers["GetFriendsAsync"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("friends")
		local call = codegen:methodCall(parent, "GetFriendsAsync", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Instance")
	end

	handlers["WorldToScreenPoint"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("screenPoint")
		local call = codegen:methodCall(parent, "WorldToScreenPoint", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Vector3")
	end

	handlers["ScreenPointToRay"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ray")
		local call = codegen:methodCall(parent, "ScreenPointToRay", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Ray")
	end

	handlers["WorldToViewportPoint"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("viewportPoint")
		local call = codegen:methodCall(parent, "WorldToViewportPoint", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Vector3")
	end

	handlers["ViewportPointToRay"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("ray")
		local call = codegen:methodCall(parent, "ViewportPointToRay", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Ray")
	end

	handlers["Lerp"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("lerped")
		local call = codegen:methodCall(parent, "Lerp", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName)
	end

	handlers["Inverse"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("inv")
		local call = codegen:methodCall(parent, "Inverse", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["ToWorldSpace"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("worldCF")
		local call = codegen:methodCall(parent, "ToWorldSpace", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["ToObjectSpace"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("objectCF")
		local call = codegen:methodCall(parent, "ToObjectSpace", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "CFrame")
	end

	handlers["PointToWorldSpace"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("worldPt")
		local call = codegen:methodCall(parent, "PointToWorldSpace", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Vector3")
	end

	handlers["PointToObjectSpace"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("objectPt")
		local call = codegen:methodCall(parent, "PointToObjectSpace", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Vector3")
	end

	handlers["VectorToWorldSpace"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("worldVec")
		local call = codegen:methodCall(parent, "VectorToWorldSpace", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Vector3")
	end

	handlers["VectorToObjectSpace"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("objectVec")
		local call = codegen:methodCall(parent, "VectorToObjectSpace", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Vector3")
	end

	handlers["Cross"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("crossed")
		local call = codegen:methodCall(parent, "Cross", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "Vector3")
	end

	handlers["Dot"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("dotProduct")
		local call = codegen:methodCall(parent, "Dot", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "number")
	end

	handlers["FuzzyEq"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("fuzzy")
		local call = codegen:methodCall(parent, "FuzzyEq", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "boolean")
	end

	handlers["Ban"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "Ban", argStrs)
	end

	handlers["GetPartBoundsInBox"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("parts")
		local call = codegen:methodCall(parent, "GetPartBoundsInBox", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["GetPartBoundsInRadius"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("parts")
		local call = codegen:methodCall(parent, "GetPartBoundsInRadius", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["GetPartsInPart"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("parts")
		local call = codegen:methodCall(parent, "GetPartsInPart", argStrs)
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "table")
	end

	handlers["ClearCharacterAppearance"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "ClearCharacterAppearance", {})
	end

	handlers["CaptureFocus"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "CaptureFocus", {})
	end

	handlers["ReleaseFocus"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		codegen:emitBareCall(parent, "ReleaseFocus", argStrs)
	end

	handlers["IsFocused"] = function(parent: string, rawArgs: {any}, argStrs: {string})
		local varName = state:freshVar("focused")
		local call = codegen:methodCall(parent, "IsFocused", {})
		codegen:emitLine(codegen:declareLocal(varName, call))
		return createProxy(varName, false, "boolean")
	end

	return handlers
end

return Misc