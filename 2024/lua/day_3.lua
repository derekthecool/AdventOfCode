local M = {}

M.extract_mul_raw = function(text)
    local output = {}
    for item in text:gmatch("mul%(%d?%d?%d,%d?%d?%d%)") do
        table.insert(output, item)
    end
    return output
end

M.raw_mul_to_table = function(raw_mul)
    return map(function(item)
        local output = {}
        for first, second in item:gmatch("mul%((%d?%d?%d),(%d?%d?%d)%)") do
            table.insert(output, { tonumber(first), tonumber(second) })
        end
        return output
    end, raw_mul):totable()
end

return M
