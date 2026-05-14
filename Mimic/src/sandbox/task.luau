local TaskLib = {}

function TaskLib.build(state: any, codegen: any, serialize: any)
	local task = {}

	task.wait = function(t)
		if t ~= nil then
			codegen:emitLine("task.wait(" .. serialize(t) .. ")")
		else
			codegen:emitLine("task.wait()")
		end
		return 0
	end

	task.spawn = function(fn, ...)
		local extra = {...}
		local serialized = {}
		for _, v in extra do
			table.insert(serialized, serialize(v))
		end

		if #serialized > 0 then
			codegen:emitLine("task.spawn(function(" .. table.concat(serialized, ", ") .. ")")
		else
			codegen:emitLine("task.spawn(function()")
		end

		state:push()

		if type(fn) == "function" then
			pcall(fn, table.unpack(extra))
		end

		state:pop()
		codegen:emitLine("end)")
	end

	task.defer = function(fn, ...)
		local extra = {...}
		local serialized = {}
		for _, v in extra do
			table.insert(serialized, serialize(v))
		end

		if #serialized > 0 then
			codegen:emitLine("task.defer(function(" .. table.concat(serialized, ", ") .. ")")
		else
			codegen:emitLine("task.defer(function()")
		end

		state:push()

		if type(fn) == "function" then
			pcall(fn, table.unpack(extra))
		end

		state:pop()
		codegen:emitLine("end)")
	end

	task.delay = function(t, fn, ...)
		local extra = {...}
		local serialized = {}
		for _, v in extra do
			table.insert(serialized, serialize(v))
		end

		if #serialized > 0 then
			codegen:emitLine("task.delay(" .. serialize(t) .. ", function(" .. table.concat(serialized, ", ") .. ")")
		else
			codegen:emitLine("task.delay(" .. serialize(t) .. ", function()")
		end

		state:push()

		if type(fn) == "function" then
			pcall(fn, table.unpack(extra))
		end

		state:pop()
		codegen:emitLine("end)")
	end

	task.cancel = function(thread)
		codegen:emitLine("task.cancel(" .. serialize(thread) .. ")")
	end

	task.desynchronize = function()
		codegen:emitLine("task.desynchronize()")
	end

	task.synchronize = function()
		codegen:emitLine("task.synchronize()")
	end

	return task
end

return TaskLib