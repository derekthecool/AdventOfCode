local M = {}

M.from = function(year, day)
    local file = string.format('%s/AdventOfCode/inputs/%d/%d.txt', os.getenv('HOME'), year, day)
    io.input(file)

    local output = {}

    for line in io.lines() do
        table.insert(output, line)
    end

    return output
end

return M
