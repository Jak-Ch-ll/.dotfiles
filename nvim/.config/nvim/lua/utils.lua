local utils = {}

function utils.plug(name, options)
    vim.cmd([[
        call plug#begin('~/.vim/plugged')
            Plug ']] .. name .. "', " .. options .. [[
        call plug#end()
    ]])
end

return utils
