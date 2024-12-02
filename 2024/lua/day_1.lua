local M = {}

M.parse = function(input)
    local first, second = {}, {}

    for _, value in pairs(input) do
        first_number, second_number = value:match("(%d+)%s+(%d+)")
        table.insert(first, tonumber(first_number))
        table.insert(second, tonumber(second_number))

        table.sort(first)
        table.sort(second)
    end

    return first, second
end

M.distance = function(first, second)
    local distance = {}

    for index, value in pairs(first) do
        table.insert(distance, math.abs(value - second[index]))
    end

    return distance
end

M.total_distance = function(distance_array)
    local sum = 0

    for _, distance in pairs(distance_array) do
        sum = sum + distance
    end

    return sum
end

return M
