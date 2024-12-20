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

    it("Check types of every item", function()
        for i, line in ipairs(DAY_2_INPUT) do
            if type(line) ~= "table" or #line == 0 or type(line[1]) ~= "number" then
                -- print("Invalid format at line:", i, "Content:", line)
                print(string.format("Invalid input from line: %d, with content: %s, length: %d", i, line, #line))
            end
            assert.are.same("table", type(line))
            assert.truthy(#line > 0)
            assert.are.same("number", type(line[1]))
        end
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

    it("Example input should have safe count of 2", function()
        local safe_count = DAY_2.part_1(example)
        assert.are.same(2, safe_count)
    end)

    it("drop_table should create a table of tables with one item dropped", function()
        local dropped = DAY_2.drop_table(example[5])

        -- examples[5] = { 8, 6, 4, 4, 1 },
        local expected = {
            { 6, 4, 4, 1 },
            { 8, 4, 4, 1 },
            { 8, 6, 4, 1 },
            { 8, 6, 4, 1 },
            { 8, 6, 4, 4 },
        }
        assert.are.same(expected, dropped)
    end)

    it("Problem fixer should still return false case 1", function()
        local dropped = DAY_2.problem_fixer(example[2])
        assert.are.same(false, dropped)
    end)

    it("Problem fixer should still return false case 2", function()
        local dropped = DAY_2.problem_fixer(example[3])
        assert.are.same(false, dropped)
    end)

    it("Problem fixer should make this safe and return true case 1", function()
        local dropped = DAY_2.problem_fixer(example[4])
        assert.are.same(true, dropped)
    end)

    it("Problem fixer should make this safe and return true case 2", function()
        local dropped = DAY_2.problem_fixer(example[5])
        assert.are.same(true, dropped)
    end)

    it("Example input should have safe count of 4 after problem dampener", function()
        local safe_count = DAY_2.part_2(example)
        assert.are.same(4, safe_count)
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

    it("Part 2 answer should be greater than parse 1 answer", function()
        assert.truthy(DAY_2.part_2(DAY_2_INPUT) > DAY_2.part_1(DAY_2_INPUT))
    end)

    it("Part 2 answer should be lower than 559", function()
        assert.truthy(DAY_2.part_2(DAY_2_INPUT) < 559)
    end)

    it("Part 2", function()
        assert.are.same(520, DAY_2.part_2(DAY_2_INPUT))
    end)
end)
