-- Hack to be able to source local lua files
HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, HOME)
local lib = require("inputs").lib
require("luafun_global")
DAY_3_INPUT = require("inputs").from(2024, 3, false, true)
local DAY_3 = require("day_3")

describe("Examples", function()
    local example = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
    it("Example parse basic mul", function()
        local output = DAY_3.extract_mul_raw(example)
        assert.are.same(4, #output)
    end)

    it("Example parse numbered mul", function()
        local raw_output = DAY_3.extract_mul_raw(example)
        local numbered_output = DAY_3.raw_mul_to_table(raw_output)
        assert.are.same({ 2, 4 }, numbered_output[1][1])
    end)

    it("Example 1 answer", function()
        local output = DAY_3.part_1(example)
        assert.are.same(161, output)
    end)
end)

describe("Final answers", function()
    it("Part 1", function()
        local output = DAY_3.part_1(DAY_3_INPUT)
        assert.are.same(156388521, output)
    end)
end)
