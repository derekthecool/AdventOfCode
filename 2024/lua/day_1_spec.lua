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

    it('Day 1 line 1 input matches', function()
        assert.are.same('41226   69190', require('inputs').from(2024, 1)[1])
    end)
end)
