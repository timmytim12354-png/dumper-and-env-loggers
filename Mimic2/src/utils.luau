local Utils = {}

function Utils.splitPath(fullPath: string): (string?, string?)
	local parent, method = fullPath:match("(.+)%.([^%.]+)$")
	return parent, method
end

function Utils.isIdentifier(str: string): boolean
	return str:match("^[%a_][%w_]*$") ~= nil
end

function Utils.escapeString(str: string): string
	local buf = {}
	for i = 1, #str do
		local b = string.byte(str, i)
		if b == 92 then
			table.insert(buf, "\\\\")
		elseif b == 10 then
			table.insert(buf, "\\n")
		elseif b == 13 then
			table.insert(buf, "\\r")
		elseif b == 9 then
			table.insert(buf, "\\t")
		elseif b == 0 then
			table.insert(buf, "\\0")
		elseif b == 34 then
			table.insert(buf, '\\"')
		elseif b >= 0x20 and b <= 0x7E then
			table.insert(buf, string.char(b))
		else
			table.insert(buf, string.format("\\x%02X", b))
		end
	end
	return table.concat(buf)
end

function Utils.formatNumber(n: number): string
	if n ~= n then
		return "0/0"
	end
	if n == math.huge then
		return "math.huge"
	end
	if n == -math.huge then
		return "-math.huge"
	end
	if n == math.floor(n) and math.abs(n) < 2^53 then
		return string.format("%d", n)
	end
	return tostring(n)
end

function Utils.shallowCopy(t: {[any]: any}): {[any]: any}
	local copy = {}
	for k, v in t do
		copy[k] = v
	end
	return copy
end

function Utils.mergeMaps(...: {[string]: any}): {[string]: any}
	local result = {}
	for i = 1, select("#", ...) do
		local t = select(i, ...)
		if t then
			for k, v in t do
				result[k] = v
			end
		end
	end
	return result
end

return Utils