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

		codegen:emitLine("task.spawn(function()")
		state:push()

		if type(fn) == "function" then
			local ok, err = pcall(fn, table.unpack(extra))
			if not ok then
				codegen:emitLine(codegen:comment("inner error: " .. tostring(err)))
			end
		end

		state:pop()
		codegen:emitLine("end)")

		return coroutine.create(function() end)
	end

	task.defer = function(fn, ...)
		local extra = {...}

		codegen:emitLine("task.defer(function()")
		state:push()

		if type(fn) == "function" then
			local ok, err = pcall(fn, table.unpack(extra))
			if not ok then
				codegen:emitLine(codegen:comment("inner error: " .. tostring(err)))
			end
		end

		state:pop()
		codegen:emitLine("end)")

		return coroutine.create(function() end)
	end

	task.delay = function(t, fn, ...)
		local extra = {...}

		codegen:emitLine("task.delay(" .. serialize(t) .. ", function()")
		state:push()

		if type(fn) == "function" then
			local ok, err = pcall(fn, table.unpack(extra))
			if not ok then
				codegen:emitLine(codegen:comment("inner error: " .. tostring(err)))
			end
		end

		state:pop()
		codegen:emitLine("end)")

		return coroutine.create(function() end)
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