HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, HOME)
local fun = require("fun")
print(vim.inspect(fun))
print(fun)

local days = require("inputs")
print(vim.inspect(days))

print(days.from(2024, 1, true))

local day2 = days.from(2024, 2, true)
print(day2)
print(fun.range(5):totable())

print(days.lib.pairs(day2[1]))
local day2_code = require('day_2')
print(day2_code.reduce_row_to_boolean(day2))
