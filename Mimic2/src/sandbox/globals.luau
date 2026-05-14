local stdio = require("@lune/stdio")

local Globals = {}

function Globals.apply(env: {[string]: any}, state: any, codegen: any, serialize: any, createProxy: any, luau: any)
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
		if not v then
			error(msg or "assertion failed!", 2)
		end
		return v
	end

	env.error = function(msg, level)
		error(msg, (level or 1) + 1)
	end

	env.require = function(module)
		local varName = state:freshVar("module")
		codegen:emitLine(codegen:declareLocal(varName, "require(" .. serialize(module) .. ")"))
		return createProxy(varName, false, "table")
	end

	env.loadstring = function(src, chunkname)
		if type(src) ~= "string" then
			return nil, "string expected"
		end

		local loadOk, fnOrErr = pcall(function()
			return luau.load(src, {environment = env})
		end)
		if loadOk and type(fnOrErr) == "function" then
			return fnOrErr
		end

		local compiled = nil
		local compileOk, compileErr = pcall(function()
			compiled = luau.compile(src, {
				optimizationLevel = 0,
				debugLevel = 2,
			})
		end)
		if not compileOk or not compiled then
			return nil, tostring(compileErr or compileOk)
		end

		local loadOk2, fnOrErr2 = pcall(function()
			return luau.load(compiled, {environment = env})
		end)
		if not loadOk2 then
			return nil, tostring(fnOrErr2)
		end
		return fnOrErr2
	end

	env.spawn = function(fn)
		codegen:emitLine("spawn(function()")
		state:push()
		if type(fn) == "function" then
			local ok, err = pcall(fn)
			if not ok then
				codegen:emitLine(codegen:comment("inner error: " .. tostring(err)))
			end
		end
		state:pop()
		codegen:emitLine("end)")
	end

	env.delay = function(t, fn)
		codegen:emitLine("delay(" .. serialize(t) .. ", function()")
		state:push()
		if type(fn) == "function" then
			local ok, err = pcall(fn)
			if not ok then
				codegen:emitLine(codegen:comment("inner error: " .. tostring(err)))
			end
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