local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

local nmap = function(keys, func, desc)
    if desc then
        desc = 'Harpoon: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

nmap('<leader>ha', mark.add_file, '[A]dd current file')
nmap('<leader>hh', ui.toggle_quick_menu, 'open [H]arpoon')

nmap('<leader>1', function() ui.nav_file(1) end, 'Switch to file [1]')
nmap('<leader>2', function() ui.nav_file(2) end, 'Switch to file [2]')
nmap('<leader>3', function() ui.nav_file(3) end, 'Switch to file [3]')
nmap('<leader>4', function() ui.nav_file(4) end, 'Switch to file [4]')
