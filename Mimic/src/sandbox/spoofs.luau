local Constants = require("../constants")

local Spoofs = {}

function Spoofs.apply(env: {[string]: any}, state: any, createProxy: any)
	env._VERSION = "Luau"

	local realType = type
	local realTostring = tostring

	env.typeof = function(v)
		if realType(v) == "userdata" then
			local hint = state:getTypeHint(v)
			if hint then
				return hint
			end
			local name = state:lookup(v)
			if name then
				for prefix, typeName in Constants.TYPEOF_MAP do
					if name == prefix or name:sub(1, #prefix + 1) == prefix .. "_" then
						return typeName
					end
				end
				return "Instance"
			end
		end
		if realType(v) == "number" then
			return "number"
		end
		if realType(v) == "string" then
			return "string"
		end
		if realType(v) == "boolean" then
			return "boolean"
		end
		if realType(v) == "nil" then
			return "nil"
		end
		if realType(v) == "table" then
			return "table"
		end
		if realType(v) == "function" then
			return "function"
		end
		if realType(v) == "thread" then
			return "thread"
		end
		return realType(v)
	end

	env.type = function(v)
		return realType(v)
	end

	env.tostring = function(v)
		return realTostring(v)
	end

	env.tonumber = tonumber
	env.select = select
	env.unpack = unpack or table.unpack
	env.pcall = pcall
	env.xpcall = xpcall
	env.error = env.error
	env.pairs = pairs
	env.ipairs = ipairs
	env.next = next
	env.rawlen = rawlen

	env.setmetatable = setmetatable
	env.getmetatable = function(v)
		if realType(v) == "userdata" and state:lookup(v) then
			return "The metatable is locked"
		end
		return getmetatable(v)
	end

	env.string = string
	env.math = math
	env.table = table
	env.coroutine = coroutine
	env.bit32 = bit32
	env.utf8 = utf8
	env.buffer = buffer

	env.os = {
		clock = os.clock,
		time = os.time,
		difftime = os.difftime,
		date = os.date,
	}

	env.tick = function()
		return 0
	end

	env.time = function()
		return 0
	end

	env.gcinfo = function()
		return 0
	end

	env.debug = nil
	env.io = nil
	env.loadfile = nil
	env.dofile = nil
	env.getfenv = nil
	env.setfenv = nil
	env.module = nil

	env["string.dump"] = nil
end

return Spoofs