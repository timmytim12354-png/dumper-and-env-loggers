local Globals = {}

function Globals.apply(env: {[string]: any}, state: any, codegen: any, serialize: any, createProxy: any)
	env.print = function(...)
		local args = {...}
		local serialized = {}
		for _, v in args do
			table.insert(serialized, serialize(v))
		end
		codegen:emitLine("print(" .. table.concat(serialized, ", ") .. ")")
	end

	env.warn = function(...)
		local args = {...}
		local serialized = {}
		for _, v in args do
			table.insert(serialized, serialize(v))
		end
		codegen:emitLine("warn(" .. table.concat(serialized, ", ") .. ")")
	end

	env.assert = function(v, msg)
		if msg ~= nil then
			codegen:emitLine("assert(" .. serialize(v) .. ", " .. serialize(msg) .. ")")
		else
			codegen:emitLine("assert(" .. serialize(v) .. ")")
		end
		return v
	end

	env.error = function(msg, level)
	    error(msg, level)
    end

	env.require = function(module)
		local varName = state:freshVar("module")
		codegen:emitLine(codegen:declareLocal(varName, "require(" .. serialize(module) .. ")"))
		return createProxy(varName, false, "table")
	end

	env.loadstring = function(src)
		local varName = state:freshVar("loaded")
		codegen:emitLine(codegen:declareLocal(varName, "loadstring(" .. serialize(src) .. ")"))
		local fnProxy = createProxy(varName, false, "function")
		return function(...)
			local callArgs = {...}
			local serialized = {}
			for _, v in callArgs do
				table.insert(serialized, serialize(v))
			end
			local resultVar = state:freshVar("loadResult")
			codegen:emitLine(codegen:declareLocal(resultVar, varName .. "(" .. table.concat(serialized, ", ") .. ")"))
			return createProxy(resultVar)
		end
	end

	env.spawn = function(fn)
		codegen:emitLine("spawn(function()")
		state:push()
		if type(fn) == "function" then
			pcall(fn)
		end
		state:pop()
		codegen:emitLine("end)")
	end

	env.delay = function(t, fn)
		codegen:emitLine("delay(" .. serialize(t) .. ", function()")
		state:push()
		if type(fn) == "function" then
			pcall(fn)
		end
		state:pop()
		codegen:emitLine("end)")
	end

	env.wait = function(t)
		if t ~= nil then
			codegen:emitLine("wait(" .. serialize(t) .. ")")
		else
			codegen:emitLine("wait()")
		end
		return 0, 0
	end

	env.typeof = nil

	env.rawget = function(t, k)
		if type(t) == "userdata" then
			return t[k]
		end
		return rawget(t, k)
	end

	env.rawset = function(t, k, v)
		if type(t) == "userdata" then
			t[k] = v
			return t
		end
		return rawset(t, k, v)
	end

	env.rawequal = rawequal

	env.newproxy = newproxy
end

return Globals