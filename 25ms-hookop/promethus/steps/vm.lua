local Step = require("prometheus.step");
local vm = require("prometheus.25msVM.main");

local _25msVM = Step:extend();
_25msVM.Description = "This Step will actually Compile your script into a fully-custom (not a half custom like other lua obfuscators) Bytecode Format and emit a vm for executing it.";
_25msVM.Name = "VM";

_25msVM.SettingsDescriptor = {
}

function _25msVM:init(settings)
	
end

function _25msVM:apply(ast)
	local vm = vm:new();
    return vm:build(ast);
end

return _25msVM;