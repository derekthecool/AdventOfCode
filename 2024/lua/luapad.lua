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

local day3 = days.from(2024, 3, false, true)

-- local function better_day3_part2_replacement(text)
--     local do_table = {}
--     local dont_table = {}
--
--     -- local text = "don't don't don't don't don't don't do do do to don't don't don't don't"
--
--     -- Match do() or don't()
--     local pattern = "don?'?t?%(%)"
--
--     local start_pos = 1 -- Start position for the search
--
--     for word in text:gmatch(pattern) do
--         -- Find the position of the match starting from the current position
--         local s, e = text:find(word, start_pos)
--         if word == "do()" then
--             table.insert(do_table, { s, e })
--         elseif word == "don't" then
--             table.insert(dont_table, { s, e })
--         end
--
--         -- Ensure the start position is updated to after the previous match
--         start_pos = e + 1
--
--         print("Matched word: '" .. word .. "', position: " .. s .. " to " .. e)
--     end
--
--     return {
--         do_table,
--         dont_table,
--     }
-- end

-- local function better_day3_part2_replacement(text)
--     -- Regex pattern to match "don't" and "do()"
--     local pattern = "do....." -- Regex for both "don't" and "do()"
--     -- local pattern = "don%(%).*?%(%).*?%((%" .. "."%))" -- Regex for both “don’t(%)” Text's proper combination .
--     local start_pos = 1
--     local output = ""
--
--     -- Find all the positions of "don't" and "do()"
--     for word in text:gmatch(pattern) do
--         print(word)
--         local s, e = text:find(word, start_pos)
--         if s and e then
--             print(s,e)
--             
--             if word:sub(1, 3):match("do%(%)") then
--                 output = output .. string.format("[%d,%d]",s,e)
--             elseif word == "don't" then
--                 output = output .. string.format("{%d,%d}", s, e)
--             end
--             start_pos = e + 1
--         end
--     end
--
--     return output
-- end

local function better_day3_part2_replacement(text)
    local start_pos = 1
    local result = ""

    while true do
        -- Find the first "don't()" match from the current position
        local dont_start, dont_end = text:find("don't%(%)", start_pos)
        if not dont_start then
            break -- Exit if no more "don't()" matches
        end

        -- Find the next "do()" match after the "don't()" match
        local do_start, do_end = text:find("do%(%)", dont_end + 1)
        if not do_start then
            break -- Exit if no "do()" match is found after "don't()"
        end

        -- Extract and save the text between "don't()" and "do()"
        result = text:sub(dont_end + 1, do_start - 1)

        -- Update start_pos to continue searching after the "do()" match
        start_pos = do_end + 1
    end

    return result:match("^%s*(.-)%s*$") -- Trim leading and trailing whitespace
end

print(day3)
print(#day3)

-- print(better_day3_part2_replacement(day3))
-- print(#better_day3_part2_replacement(day3))

local test_text = "do() hello don't() world don't() do() WORLD don't()"
print(better_day3_part2_replacement(test_text))
print(test_text == better_day3_part2_replacement(test_text))
