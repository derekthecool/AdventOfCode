local M = {}

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
    return iter(items)
        :zip(iter(items):drop(1))
        :map(function(a, b)
            return a - b
        end)
        :totable()
end

M.drop_table = function(original)
    return iter(original)
        :enumerate()
        :map(function(outer_key, _)
            -- Create a sub-table by filtering out `outer_key`
            return iter(original)
                :enumerate()
                :filter(function(inner_key, _)
                    return inner_key ~= outer_key
                end)
                :map(function(_, inner_value)
                    return inner_value
                end)
                :totable()
        end)
        :totable()
end

M.problem_fixer = function(value)
    return any(function(item)
        local result = M.is_safe(item)
        return result.full_safe
    end, M.drop_table(value))
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
    return map(function(data_item)
        local item = M.is_safe(data_item)
        if not item.full_safe then
            item.safe_after_fix = M.problem_fixer(item.data)
        end
        return item
    end, data):totable()
end

M.part_1 = function(data)
    return filter(function(a)
        return a.full_safe
    end, M.safe_check_process(data)):length()
end

M.part_2 = function(data)
    return filter(function(a)
        return a.safe_after_fix or a.full_safe
    end, M.safe_check_process(data)):length()
end

return M
