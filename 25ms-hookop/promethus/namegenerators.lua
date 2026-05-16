local namegenerators = {
	Mangled = require("prometheus.namegenerators.mangled");
	MangledShuffled = require("prometheus.namegenerators.mangled_shuffled");
	Il = require("prometheus.namegenerators.Il");
	-- Number = require("prometheus.namegenerators.number");
	-- Confuse = require("prometheus.namegenerators.confuse");
	Ad = require("prometheus.namegenerators.ad");
}
-- Collect the keys into an array
local keys = {}
for key in pairs(namegenerators) do
    table.insert(keys, key)
end
return setmetatable({
	Random = namegenerators[keys[math.random(1, #keys)]]
}, { __index = namegenerators })
