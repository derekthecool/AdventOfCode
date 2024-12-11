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

M.drop_table = function(original)
    local dropped_table = {}
    for outer_key, outer_value in pairs(original) do
        local table_with_an_index_missing = {}
        for inner_key, inner_value in pairs(original) do
            if inner_key ~= outer_key then
                table.insert(table_with_an_index_missing, inner_value)
            end
        end
        table.insert(dropped_table, table_with_an_index_missing)
    end
    return dropped_table
end

M.problem_fixer = function(value)
    local dropped = M.drop_table(value)
    for _, dropped_item in pairs(dropped) do
        local safe = M.is_safe(dropped_item)
        if safe.full_safe then
            return true
        end
    end
    return false
end

M.is_safe = function(value)
    local numbers = M.table_to_subtracted_pairs(value)
    local range_check = M.check_range(numbers)
    local same_sign_check = M.check_same_sign(numbers)
    local full_safe = range_check and same_sign_check

    return {
        data = value,
        difference = numbers,
        range_okay = range_check,
        same_sign = same_sign_check,
        full_safe = full_safe,
        safe_after_fix = false,
    }
end

M.safe_check_process = function(data)
    local safe = {}
    for _, value in ipairs(data) do
        local item = M.is_safe(value)
        if item.full_safe ~= true then
            item.safe_after_fix = M.problem_fixer(item.data)
        end
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
        return a.safe_after_fix == true or a.full_safe == true
    end, M.safe_check_process(data)):length()
end

return M
