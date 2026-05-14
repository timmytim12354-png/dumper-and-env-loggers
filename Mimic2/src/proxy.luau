local Utils = require("./utils")

local Proxy = {}

function Proxy.new(state: any, codegen: any, serialize: any, dispatch: any)
	local function createProxy(name: string, isRoot: boolean?, typeHint: string?): any
		local proxy = newproxy(true)
		local meta = getmetatable(proxy)

		if isRoot then
			state:register(proxy, name, typeHint)
		else
			state:register(proxy, name)
		end

		meta.__metatable = "The metatable is locked"

		meta.__index = function(self, key)
			local selfPath = state:lookup(self) or name
			local newPath
			if type(key) == "number" then
				newPath = selfPath .. "[" .. Utils.formatNumber(key) .. "]"
			else
				newPath = selfPath .. "." .. tostring(key)
			end
			local existing = nil
			for registeredProxy, registeredName in state.registry do
				if registeredName == newPath then
					existing = registeredProxy
					break
				end
			end
			if existing then
				return existing
			end
			local child = createProxy(newPath)
			return child
		end

		meta.__newindex = function(self, key, value)
			local selfPath = state:lookup(self) or name
			local path
			if type(key) == "number" then
				path = selfPath .. "[" .. Utils.formatNumber(key) .. "]"
			else
				path = selfPath .. "." .. tostring(key)
			end
			codegen:emitLine(codegen:assign(path, serialize(value)))
		end

		meta.__call = function(self, ...)
			local selfPath = state:lookup(self) or name
			local allArgs = {...}
			local rawArgs = {}

			if #allArgs > 0 and type(allArgs[1]) == "userdata" then
				local firstPath = state:lookup(allArgs[1])
				local parent = Utils.splitPath(selfPath)
				if firstPath and parent and firstPath == parent then
					for i = 2, #allArgs do
						table.insert(rawArgs, allArgs[i])
					end
				else
					for i = 1, #allArgs do
						table.insert(rawArgs, allArgs[i])
					end
				end
			else
				for i = 1, #allArgs do
					table.insert(rawArgs, allArgs[i])
				end
			end

			local argStrs = {}
			for _, arg in rawArgs do
				table.insert(argStrs, serialize(arg))
			end

			local parent, method = Utils.splitPath(selfPath)

			if parent and method then
				return dispatch(parent, method, rawArgs, argStrs)
			end

			local resultVar = state:freshVar("result")
			local call = codegen:funcCall(selfPath, argStrs)
			codegen:emitLine(codegen:declareLocal(resultVar, call))
			local resultProxy = createProxy(resultVar)
			return resultProxy
		end

		meta.__tostring = function(self)
			return state:lookup(self) or name
		end

		meta.__concat = function(a, b)
			return tostring(a) .. tostring(b)
		end

		meta.__len = function(self)
			return 0
		end

		meta.__unm = function(self)
			local selfPath = state:lookup(self) or name
			return createProxy("-" .. selfPath)
		end

		meta.__add = function(a, b)
			return createProxy("(" .. tostring(a) .. " + " .. tostring(b) .. ")")
		end

		meta.__sub = function(a, b)
			return createProxy("(" .. tostring(a) .. " - " .. tostring(b) .. ")")
		end

		meta.__mul = function(a, b)
			return createProxy("(" .. tostring(a) .. " * " .. tostring(b) .. ")")
		end

        meta.__pow = function(a, b)
	        return createProxy("(" .. tostring(a) .. " ^ " .. tostring(b) .. ")")
        end

		meta.__div = function(a, b)
			return createProxy("(" .. tostring(a) .. " / " .. tostring(b) .. ")")
		end

		meta.__mod = function(a, b)
			return createProxy("(" .. tostring(a) .. " % " .. tostring(b) .. ")")
		end

		meta.__eq = function(a, b)
			return false
		end

		meta.__lt = function(a, b)
			return false
		end

		meta.__le = function(a, b)
			return false
		end

		return proxy
	end

	return createProxy
end

return Proxy