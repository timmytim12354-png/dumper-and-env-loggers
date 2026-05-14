local TableSerializer = {}

function TableSerializer.new(state: any, serializePrimitive: (any) -> string)
	local function serializeTable(tbl: {[any]: any}, depth: number, visited: {[any]: true}): string
		local registered = state:lookup(tbl)
		if registered then
			return registered
		end

		if depth > 4 then
			return "{...}"
		end

		if visited[tbl] then
			return "{--[[circular]]}"
		end

		visited[tbl] = true

		local sequential = {}
		local nonSequential = {}
		local seqLen = 0

		local rawLen = #tbl
		for i = 1, rawLen do
			if tbl[i] == nil then
				break
			end
			seqLen = i
		end

		for i = 1, seqLen do
			local v = tbl[i]
			if type(v) == "table" then
				table.insert(sequential, serializeTable(v, depth + 1, visited))
			else
				table.insert(sequential, serializePrimitive(v))
			end
		end

		local stringKeys = {}
		local otherKeys = {}

		for k, v in tbl do
			if type(k) == "number" and k >= 1 and k <= seqLen and k == math.floor(k) then
				continue
			end
			if type(k) == "string" then
				table.insert(stringKeys, k)
			else
				table.insert(otherKeys, k)
			end
		end

		table.sort(stringKeys)

		local parts = {}

		for _, v in sequential do
			table.insert(parts, v)
		end

		for _, k in stringKeys do
			local v = tbl[k]
			local serializedValue
			if type(v) == "table" then
				serializedValue = serializeTable(v, depth + 1, visited)
			else
				serializedValue = serializePrimitive(v)
			end

			local Utils = require("../utils")
			if Utils.isIdentifier(k) then
				table.insert(parts, k .. " = " .. serializedValue)
			else
				table.insert(parts, "[" .. serializePrimitive(k) .. "] = " .. serializedValue)
			end
		end

		for _, k in otherKeys do
			local v = tbl[k]
			local serializedValue
			if type(v) == "table" then
				serializedValue = serializeTable(v, depth + 1, visited)
			else
				serializedValue = serializePrimitive(v)
			end
			table.insert(parts, "[" .. serializePrimitive(k) .. "] = " .. serializedValue)
		end

		visited[tbl] = nil

		if #parts == 0 then
			return "{}"
		end

		return "{" .. table.concat(parts, ", ") .. "}"
	end

	return function(tbl: {[any]: any}, depth: number?): string
		return serializeTable(tbl, depth or 0, {})
	end
end

return TableSerializer