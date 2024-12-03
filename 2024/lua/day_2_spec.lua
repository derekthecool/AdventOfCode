-- Hack to be able to source local lua files
HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, HOME)
DAY_2_INPUT = require("inputs").from(2024, 2, true)
local DAY_2 = require("day_2")

-- Check documentation here: https://luafun.github.io/
-- local fun = require('luafun.fun')

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

    it("First", function()
        assert.are.same(1, 1)
    end)
end)

describe("Solutions", function()
    it("Part 1", function()
        assert.are.same(1234, DAY_2.part_1())
    end)

    it("Part 2", function()
        assert.are.same(1234, DAY_2.part_2())
    end)
end)
