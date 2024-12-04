local lib = require("inputs").lib
local fun = require("fun")

local M = {}

M.safe_level_check = function(pair)
	local left, right = pair[1], pair[2]
	local difference = math.abs(left - right)
	return difference >= 1 and difference <= 3
end

M.reduce_row_to_boolean = function(row)
	-- return fun.map(row, lib.pairs):totable()
	-- local output = {}
	-- for key, value in ipairs(row) do
	-- 	table.insert(output, lib.pairs(value))
	-- end
	--    -- fun.map(
	-- return output
	return fun.map(row, function(a)
		return 7
	end):totable()
end

M.part_1 = function()
	return 1233
end

M.part_2 = function()
	return 1233
end

return M
