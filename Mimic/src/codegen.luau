local Constants = require("./constants")

local Codegen = {}
Codegen.__index = Codegen

function Codegen.new(state: any)
	local self = setmetatable({}, Codegen)
	self._state = state
	return self
end

function Codegen.emitLine(self: any, line: string)
	self._state:addLine(line)
end

function Codegen.declareLocal(self: any, name: string, expr: string): string
	return "local " .. name .. " = " .. expr
end

function Codegen.methodCall(self: any, parent: string, method: string, argStrs: {string}): string
	local sep = "."
	if Constants.COLON_METHODS[method] then
		sep = ":"
	end
	return parent .. sep .. method .. "(" .. table.concat(argStrs, ", ") .. ")"
end

function Codegen.funcCall(self: any, name: string, argStrs: {string}): string
	return name .. "(" .. table.concat(argStrs, ", ") .. ")"
end

function Codegen.assign(self: any, path: string, value: string): string
	return path .. " = " .. value
end

function Codegen.openBlock(self: any, header: string)
	self._state:addLine(header)
	self._state:push()
end

function Codegen.closeBlock(self: any, footer: string?)
	self._state:pop()
	self._state:addLine(footer or "end")
end

function Codegen.comment(self: any, text: string): string
	return "-- " .. text
end

function Codegen.emitDeclareCall(self: any, prefix: string, parent: string, method: string, argStrs: {string}): string
	local varName = self._state:freshVar(prefix)
	local call = self:methodCall(parent, method, argStrs)
	local line = self:declareLocal(varName, call)
	self._state:addLine(line)
	return varName
end

function Codegen.emitBareCall(self: any, parent: string, method: string, argStrs: {string})
	local call = self:methodCall(parent, method, argStrs)
	self._state:addLine(call)
end

return Codegen