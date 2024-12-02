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

M.similarity = function(first, second)
    local similarity_table = {}

    -- Transform the second table to a dictionary for value counts
    local second_as_dictionary = {}
    for _, value in pairs(second) do
        second_as_dictionary[value] = (second_as_dictionary[value] or 0) + 1
    end

    for _, value in pairs(first) do
        local similar_value = second_as_dictionary[value]
        if not similar_value then
            similar_value = 0
        end
        table.insert(similarity_table, similar_value * value)
    end
    return similarity_table
end

M.part_2 = function(input)
    local t1, t2 = M.parse(input)
    local similarity_array = M.similarity(t1, t2)
    return M.total_distance(similarity_array)
end

return M
