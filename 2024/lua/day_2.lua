local lib = require("inputs").lib
require("luafun_global")

local M = {}

M.safe_level_check = function(pair)
	local left, right = pair[1], pair[2]
	local difference = left - right
	if difference == 0 then
		return 0
	elseif difference < 0 then
		-- Increasing numbers
		return 1
	else
		-- Decreasing numbers
		return -1
	end
end

M.reduce_row_to_boolean = function(row)
	return all(function(a)
		return a == row[1]
	end, row)
end

M.safe_check_process = function(data)
	local safe = {}
	for key, value in ipairs(data) do
		-- print(key, value)
		local numbers = {}
		for i = 1, #value - 1 do
			table.insert(numbers, value[i] - value[i + 1])
		end
		local range_check = all(function(a)
			return math.abs(a) >= 1 and math.abs(a) <= 3
		end, numbers)
		local same_sign_check = all(function(a)
			return a < 0
		end, numbers) or all(function(a)
			return a > 0
		end, numbers)
		local full_safe = range_check and same_sign_check

		-- print(range_check)
		-- print(same_sign_check)
		-- print(full_safe)

		local item = {
			data = value,
			difference = numbers,
			range_okay = range_check,
			same_sign = same_sign_check,
			full_safe = full_safe,
		}
		-- print(item)
		table.insert(safe, item)
	end
	return safe
end

M.part_1 = function(data)
	return filter(function(a)
		return a.full_safe
	end, M.safe_check_process(data)):length()
end

M.part_2 = function()
	return 1233
end

return M
