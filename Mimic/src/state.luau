local State = {}
State.__index = State

function State.new()
	local self = setmetatable({}, State)
	self.output = {}
	self.registry = {}
	self.typeHints = {}
	self.indent = 0
	self.counter = 0
	return self
end

function State.addLine(self: any, line: string)
	table.insert(self.output, self:pad() .. line)
end

function State.pad(self: any): string
	return string.rep("    ", self.indent)
end

function State.push(self: any)
	self.indent += 1
end

function State.pop(self: any)
	if self.indent > 0 then
		self.indent -= 1
	end
end

function State.freshVar(self: any, prefix: string): string
	self.counter += 1
	return prefix .. "_" .. self.counter
end

function State.register(self: any, proxy: any, name: string, typeHint: string?)
	self.registry[proxy] = name
	if typeHint then
		self.typeHints[proxy] = typeHint
	end
end

function State.lookup(self: any, proxy: any): string?
	return self.registry[proxy]
end

function State.getTypeHint(self: any, proxy: any): string?
	return self.typeHints[proxy]
end

function State.getOutput(self: any): string
	return table.concat(self.output, "\n")
end

function State.reset(self: any)
	table.clear(self.output)
	table.clear(self.registry)
	table.clear(self.typeHints)
	self.indent = 0
	self.counter = 0
end

return State