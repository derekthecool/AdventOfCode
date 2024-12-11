local M = {}

M.from = function(year, day, as_number_arrays, as_raw_text)
    print(year, day, as_number_arrays)
    HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
    local file = string.format("%s/AdventOfCode/inputs/%d/%d.txt", HOME, year, day)
    print(file)
    io.input(file)

    if as_raw_text then
        return io.read("a")
    end

    local output = {}

    for line in io.lines() do
        if as_number_arrays then
            -- Add line as a number array
            local number_array = {}
            for num in line:gmatch("%d+") do
                table.insert(number_array, tonumber(num))
            end
            table.insert(output, number_array)
        else
            -- Add line as a string
            table.insert(output, line)
        end
    end

    return output
end

M.lib = {
    ---This function takes a table and splits it into pairs
    ---@param t table
    ---@return table
    pairs = function(t)
        local output = {}
        for i = 1, #t - 1 do
            table.insert(output, { t[i], t[i + 1] })
        end
        return output
    end,
}

return M
