-- Add prefix
function ap(desc)
    return 'Harpoon: ' .. desc
end

return {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },

    keys = {
        {
            '<leader>ha',
            function() require('harpoon.mark').add_file() end,
            desc = ap('[A]dd current file')
        },
        {
            '<leader>hh',
            function() require('harpoon.ui').toggle_quick_menu() end,
            desc = ap('open [H]arpoon')
        },

        {
            '<leader>1',
            function() require('harpoon.ui').nav_file(1) end,
            desc = ap('Switch to file [1]'),
        },
        {
            '<leader>2',
            function() require('harpoon.ui').nav_file(2) end,
            desc = ap('Switch to file [2]'),
        },
        {
            '<leader>3',
            function() require('harpoon.ui').nav_file(3) end,
            desc = ap('Switch to file [3]'),
        },
        {
            '<leader>4',
            function() require('harpoon.ui').nav_file(4) end,
            desc = ap('Switch to file [4]'),
        },
    },
}
