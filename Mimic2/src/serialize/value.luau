local Utils = require("../utils")
local TableSerializer = require("./table")

local Serialize = {}

function Serialize.new(state: any)
	local serializeTable

	local function serialize(v: any): string
		local t = type(v)

		if t == "string" then
			return '"' .. Utils.escapeString(v) .. '"'
		end

		if t == "number" then
			return Utils.formatNumber(v)
		end

		if t == "boolean" then
			return tostring(v)
		end

		if t == "nil" then
			return "nil"
		end

		if t == "table" then
			return serializeTable(v, 0)
		end

		if t == "userdata" then
			local name = state:lookup(v)
			if name then
				return name
			end
			return tostring(v)
		end

		if t == "function" then
			local name = state:lookup(v)
			if name then
				return name
			end
			return "function() end"
		end

		return tostring(v)
	end

	serializeTable = TableSerializer.new(state, serialize)

	return serialize
end

return Serialize