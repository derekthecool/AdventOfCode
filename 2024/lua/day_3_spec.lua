-- Hack to be able to source local lua files
HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, HOME)
local lib = require("inputs").lib
require("luafun_global")
DAY_3_INPUT = require("inputs").from(2024, 3, true)
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
end)
