print "required fib"
local M = {}

M.setup = function()
    vim.keymap.set('i', 'je', 'meow')
end

return M



function countspaces(line)
    local flag = false
    local i = 1
    while (string.byte(line, i) == 32) do
        i = i + 1
        flag = true
    end
    
    if not flag then
        i = 0
    end
    return i
end


local fib_memory = {}
function calc_fib(n, fib_memory)
    if (n == 1) then
        fib_memory[1] = 1
        return 1
    end
    if (n == 2) then
        fib_memory[2] = 1
        return 1
    end
    if (n == 3) then
        fib_memory[3] = 2
    end

    local cur_index = fib_memory[n]
    if (cur_index ~= nil) then
        return fib_memory[n]
    end

    local res = calc_fib(n - 1, fib_memory) + calc_fib(n - 2, fib_memory)
    fib_memory[n] = res
    return res
end

function reverse_fib(fib_n, fib_memory)
    if fib_n == 0 then
        return 1
    end
    if fib_n == 1 then
        return 2
    end

    for k, v in pairs(fib_memory) do
        if v == fib_n then
            return k
        end
    end
end
-- hacky but populate table with fib values, so we can linear search based off tables
calc_fib(60, fib_memory)

vim.keymap.set('i', '<tab>', function (k)
    local line = vim.api.nvim_get_current_line()
    local linespaces = countspaces(line)
    local retvar = " "

    if linespaces == 2 then
        return " "
    end
    if linepsaces ~= 0 then
        -- going into the expectation that the file is already fib'd
        local fib_iter = reverse_fib(linespaces, fib_memory)
        local repeats = calc_fib(fib_iter + 1, fib_memory) - linespaces

        retvar = string.rep(" ", repeats)
    end
    return retvar
end, { expr = true })
