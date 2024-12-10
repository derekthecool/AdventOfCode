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

-- -- local asdf = safe_check_process(day_2)
-- local example_check = safe_check_process(example)
-- print(example_check)
-- print(filter(function(a) return a.full_safe end, example_check):length())

local day2_check = safe_check_process(day2)
-- print(day2_check)
print(filter(function(a)
	return a.full_safe
end, day2_check):length())

print(1)

-- local function count_safe_levels(table_of_tables)
--     local output = {}
--     for _, value in pairs(table_of_tables) do
--         local temp = {}
--         for _, item in ipairs(days.lib.pairs(value)) do
--             table.insert(temp, day2_code.safe_level_check(item))
--         end
--         -- table.insert(output, all(function(x) return x == 1 end, temp) or all(function(x) return x == -1 end, temp))
--         -- table.insert(output, sum(temp)/#temp)
--         table.insert(output, math.abs(sum(temp))/#temp)
--     end
--
--     -- return filter(function(x) return x == true end, output):length()
--     return output
-- end
--
-- local function count_safe_levels2(table_of_tables)
--     local output = {}
--
--     for _, value in pairs(table_of_tables) do
--         local temp = {}
--
--         -- Check each pair of consecutive numbers and apply the safe_level_check
--         for i = 1, #value - 1 do
--             local pair = {value[i], value[i + 1]}
--             table.insert(temp, day2_code.safe_level_check(pair))
--         end
--
--         -- Now check if all the values in `temp` are either 1 (increasing) or -1 (decreasing)
--         if all(function(x) return x == 1 end, temp) or all(function(x) return x == -1 end, temp) then
--             table.insert(output, 1)
--         else
--             table.insert(output, 0)
--         end
--     end
--
--     -- Return the count of tables where all pairs are either increasing or decreasing
--     return sum(output)
-- end
--
-- local function count_safe_levels3(table_of_tables)
--     local output = {}
--
--     for _, value in pairs(table_of_tables) do
--         local temp = {}
--
--         -- Check each pair of consecutive numbers and apply the safe_level_check
--         for i = 1, #value - 1 do
--             local pair = {value[i], value[i + 1]}
--             local result = day2_code.safe_level_check(pair)
--
--             -- Only include the result if it's 1 (increasing) or -1 (decreasing), not 0 (neutral)
--             if result ~= 0 then
--                 table.insert(temp, result)
--             end
--         end
--
--         -- Now check if all values in temp are either 1 (increasing) or -1 (decreasing)
--         -- A table is valid if all values in temp are either all 1 or all -1
--         if #temp > 0 and (all(function(x) return x == 1 end, temp) or all(function(x) return x == -1 end, temp)) then
--             table.insert(output, 1)
--         else
--             table.insert(output, 0)
--         end
--     end
--
--     -- Return the count of tables where all pairs are either increasing or decreasing
--     return sum(output)
-- end
--
--
--
-- local day2 = days.from(2024, 2, true)
-- print(#day2)
--
-- print(day2)
-- print(count_safe_levels(day2))
-- -- print(count_safe_levels2(day2))
-- print(count_safe_levels3(day2))
-- print(filter(function(x) return x == 1 end, count_safe_levels(day2)):length())
--
-- -- print(#count_safe_levels(day2))
-- -- print(apply_pairs(day2))
--
--
-- -- print(zip(day2,  drop(1, day2))
--
--
--
-- -- print(map(function(a)
-- --     -- Map over the inner table and double each value
-- --     return map(days.lib.pairs, a):totable()
-- -- end, day2):totable())
--
-- --  local result = iter(day2)
-- --         -- Create pairs of adjacent day2 using zip
-- --         :zip(iter(day2):drop(1))
-- --         -- -- Map each pair to the difference between them
-- --         :map(function(a, b) return b - a end)
-- --         -- -- Check if all differences are valid (between 1 and 3)
-- --         -- :all(function(diff) return math.abs(diff) >= 1 and math.abs(diff) <= 3 end)
-- --         -- -- Check if the sequence is consistently increasing
-- --         -- :and_(iter(day2):zip(iter(day2):drop(1)):map(function(a, b) return b - a end):all(function(diff) return diff > 0 end)))
-- --         -- -- Check if the sequence is consistently decreasing
-- --         -- :or_(iter(day2):zip(iter(day2):drop(1)):map(function(a, b) return b - a end):all(function(diff) return diff < 0 end)))
-- -- print(result)
--
--
--
-- -- print(map(function(a)
-- --     return map(function(x) return x * 2 end, a)
-- -- end, day2))
--
--
-- -- print(map(function(a)
-- --     return day2_code.safe_level_check(a[1], a[2])
-- -- end, p):totable())
--
-- -- print(map(
-- --     map(day2_code.safe_level_check, x
-- --     ), p):totable())
--
--
--
-- local function check_increasing_or_decreasing(levels)
--     -- Loop through each pair of consecutive numbers and check the difference
--     local is_increasing = true
--     local is_decreasing = true
--
--     for i = 1, #levels - 1 do
--         local diff = levels[i + 1] - levels[i]
--
--         -- Check if the difference is between 1 and 3 (inclusive)
--         if diff < 1 or diff > 3 then
--             return false  -- If the difference is out of bounds, return false
--         end
--
--         -- Check if the sequence is increasing or decreasing
--         if diff < 0 then
--             is_increasing = false  -- It's not increasing
--         elseif diff > 0 then
--             is_decreasing = false  -- It's not decreasing
--         end
--     end
--
--     -- Return true if the sequence is either strictly increasing or strictly decreasing
--     return is_increasing or is_decreasing
-- end
--
-- local function count_safe(table_of_tables)
--     local count = 0
--
--     -- Loop through each table of tables
--     for _, levels in ipairs(table_of_tables) do
--         if check_increasing_or_decreasing(levels) then
--             count = count + 1  -- Increment count if valid
--         end
--     end
--
--     return count
-- end
--
-- print(count_safe(day2))
--
