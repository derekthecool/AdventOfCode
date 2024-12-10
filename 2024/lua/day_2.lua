local M = {}

M.safe_level_check = function(pair)
    local left, right = pair[1], pair[2]
    local difference = left - right
    if difference == 0 then
        return 0
    elseif difference < 0 then
        -- Increasing numbers
        return 1
    else
        -- Decreasing numbers
        return -1
    end
end

M.reduce_row_to_boolean = function(row)
    return all(function(a)
        return a == row[1]
    end, row)
end

M.check_range = function(items)
    return all(function(a)
        return math.abs(a) >= 1 and math.abs(a) <= 3
    end, items)
end

M.check_same_sign = function(items)
    return all(function(a)
        return a < 0
    end, items) or all(function(a)
        return a > 0
    end, items)
end

M.table_to_subtracted_pairs = function(items)
    local numbers = {}
    for i = 1, #items - 1 do
        table.insert(numbers, items[i] - items[i + 1])
    end
    return numbers
end

M.safe_check_process = function(data)
    local safe = {}
    for key, value in ipairs(data) do
        -- print(key, value)
        local numbers = M.table_to_subtracted_pairs(value)

        local range_check = M.check_range(numbers)
        local same_sign_check = M.check_same_sign(numbers)

        local full_safe = range_check and same_sign_check

        -- print(range_check)
        -- print(same_sign_check)
        -- print(full_safe)

        local item = {
            data = value,
            difference = numbers,
            range_okay = range_check,
            same_sign = same_sign_check,
            full_safe = full_safe,
        }
        -- print(item)
        table.insert(safe, item)
    end
    return safe
end

M.part_1 = function(data)
    return filter(function(a)
        return a.full_safe
    end, M.safe_check_process(data)):length()
end

M.part_2 = function(data)
    return filter(function(a)
        return a.full_safe
    end, M.safe_check_process(data)):length()
end

return M
