HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, HOME)

require("luafun_global")

print(range(32)
	:filter(function(a)
		return a % 2 == 0
	end)
	:map(function(i)
		return i * i
	end)
	:totable())

local days = require("inputs")
print(days)

print(all(function(x)
	return x > 5
end, range(6, 20)))

local day2_code = require("day_2")

-- 502 was too high
-- 473 was too high
-- 296 was too low
--

local day2 = days.from(2024, 2, true)
print(day2)

local function safe_check_process(data)
	local safe = {}
	for key, value in ipairs(data) do
		print(key, value)
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
		print(item)
		table.insert(safe, item)
	end
	return safe
end

local example = {
	{ 7, 6, 4, 2, 1 },
	{ 1, 2, 7, 8, 9 },
	{ 9, 7, 6, 2, 1 },
	{ 1, 3, 2, 4, 5 },
	{ 8, 6, 4, 4, 1 },
	{ 1, 3, 6, 7, 9 },
}

-- local day2_check = safe_check_process(day2)
-- -- print(day2_check)
-- print(filter(function(a)
-- 	return a.full_safe
-- end, day2_check):length())

print(1)

local function drop_table(original)
	local dropped_table = {}
	for outer_key, outer_value in pairs(original) do
		local table_with_an_index_missing = {}
		for inner_key, inner_value in pairs(original) do
			if inner_key ~= outer_key then
				table.insert(table_with_an_index_missing, inner_value)
			end
		end
		table.insert(dropped_table, table_with_an_index_missing)
	end
	return dropped_table
end

local nums = range(5):totable()
print(nums)

local dropped = drop_table(nums)
print(dropped)
