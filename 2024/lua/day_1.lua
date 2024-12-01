local M = {}

M.parse = function(input)
    local first, second = {}, {}

    for _, value in pairs(input) do
        first_number, second_number = value:match('(%d+)%s+(%d+)')
        table.insert(first, tonumber(first_number))
        table.insert(second, tonumber(second_number))

        table.sort(first)
        table.sort(second)
    end

    return first, second
end

return M
