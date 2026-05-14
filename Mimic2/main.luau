local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")
local Runner = require("./src/runner")

local args = process.args

if #args < 1 then
	stdio.ewrite("[mimic] Usage: lune run main <input> [output]\n")
	process.exit(1)
end

local inputPath = args[1]
local outputPath = args[2] or "output.luau"

if not fs.isFile(inputPath) then
	stdio.ewrite("[mimic] File not found: " .. inputPath .. "\n")
	process.exit(1)
end

local source = fs.readFile(inputPath)

if #source == 0 then
	stdio.ewrite("[mimic] Input file is empty\n")
	process.exit(1)
end

stdio.write("[mimic] Analyzing " .. inputPath .. "...\n")

local success, output, err = Runner.execute(source)

fs.writeFile(outputPath, output)

local lineCount = 0
for _ in output:gmatch("[^\n]+") do
	lineCount += 1
end

if success then
	stdio.write("[mimic] Complete — " .. lineCount .. " lines written to " .. outputPath .. "\n")
	process.exit(0)
else
	stdio.write("[mimic] Partial output — " .. lineCount .. " lines written to " .. outputPath .. "\n")
	stdio.ewrite("[mimic] Execution error: " .. tostring(err) .. "\n")
	process.exit(1)
end