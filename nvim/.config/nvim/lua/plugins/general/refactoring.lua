local function add_prefix(desc)
    return 'Refactoring: ' .. desc
end

return {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = true,
    keys = {
        {
            mode = 'v',
            '<leader>rr',
            function() require('refactoring').select_refactor() end,
            desc = add_prefix('Select'),
        },
    },
}
