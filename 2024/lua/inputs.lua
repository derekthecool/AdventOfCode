local M = {}

M.from = function(year, day, as_number_arrays)
    local file = string.format("%s/AdventOfCode/inputs/%d/%d.txt", HOME, year, day)
    io.input(file)

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

return M