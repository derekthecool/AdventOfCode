package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, os.getenv("HOME"))

describe("2024 day 1", function()
	it("Make sure test rig works", function()
		assert.are.same(1, 1)
	end)

	it("Data file exists", function()
		assert.truthy(io.input(os.getenv("HOME") .. "/AdventOfCode/inputs/2024/1.txt"))
	end)

	it("Input helper can be sourced", function()
		assert.has_no_errors(function()
			require("inputs")
		end)
	end)

	it("Input helper returns a non-empty table", function()
		local day_1 = require("inputs").from(2024, 1)
		assert.is.same(type(day_1), "table")
	end)

	it("Day 1 can be sourced", function()
		assert.has_no_errors(function()
			require("day_1")
		end)
	end)

	it("Day 1 line 1 input matches", function()
		assert.are.same("41226   69190", require("inputs").from(2024, 1)[1])
	end)

	it("Processing input returns 2 tables", function()
		local text = { "3   4", "4   3", "2   5", "1   3", "3   9", "3   3" }
		local t1, t2 = require("day_1").parse(text)
		assert.are.same(type(t1), "table")
		assert.are.same(type(t2), "table")
		assert.are.same(#t1, #text)
		assert.are.same(#t2, #text)
	end)

	it("Processing input returns 2 sorted tables", function()
		local text = { "3   4", "4   3", "2   5", "1   3", "3   9", "3   3" }
		local t1, t2 = require("day_1").parse(text)
		assert.are.same({ 1, 2, 3, 3, 3, 4 }, t1)
		assert.are.same({ 3, 3, 3, 4, 5, 9 }, t2)
	end)

	it("Caluculate the distance array for simple example", function()
		local text = { "3   4", "4   3", "2   5", "1   3", "3   9", "3   3" }
		local t1, t2 = require("day_1").parse(text)
		local distance_array = require("day_1").distance(t1, t2)

		assert.are.same({ 2, 1, 0, 1, 2, 5 }, distance_array)
	end)

    it('Calculate the total distance for simple example', function()
		local text = { "3   4", "4   3", "2   5", "1   3", "3   9", "3   3" }
		local t1, t2 = require("day_1").parse(text)
		local distance_array = require("day_1").distance(t1, t2)
        local total_distance = require("day_1").total_distance(distance_array)

		assert.are.same(11, total_distance)
    end)

    it('Day 1 part 1 solution', function()
		local day_1 = require("inputs").from(2024, 1)
		local t1, t2 = require("day_1").parse(day_1)
		local distance_array = require("day_1").distance(t1, t2)
        local total_distance = require("day_1").total_distance(distance_array)

		assert.are.same(3574690, total_distance)
    end)
end)
