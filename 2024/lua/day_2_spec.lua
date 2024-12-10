-- Hack to be able to source local lua files
HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, HOME)
local lib = require("inputs").lib
DAY_2_INPUT = require("inputs").from(2024, 2, true)
local DAY_2 = require("day_2")

-- Check documentation here: https://luafun.github.io/
require("luafun_global")

describe("Input check", function()
	it("Input should be an array of number arrays", function()
		assert.are.same("table", type(DAY_2_INPUT))
		assert.are.same("table", type(DAY_2_INPUT[1]))
		assert.are.same("number", type(DAY_2_INPUT[1][1]))
	end)

	it("Line one should match this exactly", function()
		assert.are.same({ 8, 11, 14, 16, 15 }, DAY_2_INPUT[1])
	end)
end)

describe("Day 2 examples", function()
	local example = {
		{ 7, 6, 4, 2, 1 },
		{ 1, 2, 7, 8, 9 },
		{ 9, 7, 6, 2, 1 },
		{ 1, 3, 2, 4, 5 },
		{ 8, 6, 4, 4, 1 },
		{ 1, 3, 6, 7, 9 },
	}

	it("Pairs function works", function()
		assert.are.same(lib.pairs(example[1]), {
			{ 7, 6 },
			{ 6, 4 },
			{ 4, 2 },
			{ 2, 1 },
		})
	end)

	it("Reduce a row to a boolean", function()
		local mapped_row = DAY_2.reduce_row_to_boolean(example[1])
		assert.are.same(false, mapped_row)
	end)

	it("Example input should have safe count of 2", function()
		local safe_count = DAY_2.part_1(example)
		assert.are.same(2, safe_count)
	end)

	-- it("Single safe level check", function()
	-- 	local safe = DAY_2.safe_level_check(lib.pairs(example[1])[1])
	-- 	assert.True(safe)
	-- end)

	-- it("Single unsafe level check", function()
	-- 	local unsafe = DAY_2.safe_level_check(lib.pairs(example[2])[2])
	-- 	assert.False(unsafe)
	-- end)

	it("Test full safe function", function()
		local safe = DAY_2.safe_check_process(DAY_2_INPUT)
		assert.are.same(400, safe)
	end)
end)

describe("Solutions", function()
	it("Part 1 answer should be lower than 502", function()
		-- 502 was too high
		-- 473 was too high
		-- 296 was too low
		local answer = DAY_2.part_1(DAY_2_INPUT)
		assert.truthy(answer < 502)
	end)

	it("Part 1 answer should be lower than 473", function()
		-- 473 was too high
		local answer = DAY_2.part_1(DAY_2_INPUT)
		assert.truthy(answer < 473)
	end)

	it("Part 1 answer should be higher than 296", function()
		-- 296 was too low
		local answer = DAY_2.part_1(DAY_2_INPUT)
		assert.truthy(answer > 296)
	end)

	it("Part 1", function()
		assert.are.same(472, DAY_2.part_1(DAY_2_INPUT))
	end)

	it("Part 2", function()
		assert.are.same(1234, DAY_2.part_2())
	end)
end)
