local M = {}

function M.merge(table1, table2)
    local merged_table = {}

    if (table1) then
        for key, value in pairs(table1) do
            merged_table[key] = value
        end
    end

    if (table2) then
        for key, value in pairs(table2) do
            merged_table[key] = value
        end
    end

    return merged_table
end

local function test()
    local table = {
        foo = 'FOO',
        bar = 'WRONGBAR',
    }

    local result = M.merge(table, {
        bar = 'BAR',
        baz = 'BAZ',
    })

    for key, value in pairs(result) do
        if (key == 'foo') then
            assert(value == 'FOO')
        elseif (key == 'bar') then
            assert(value == 'BAR')
        elseif (key == 'baz') then
            assert(value == 'BAZ')
        else
            assert(false)
        end
    end
end

test()

return M
