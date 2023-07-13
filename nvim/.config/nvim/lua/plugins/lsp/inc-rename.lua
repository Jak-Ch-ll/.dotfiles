return {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    event = 'VeryLazy',
    keys = {
        {
            '<leader>r',
            function()
                return ':IncRename ' .. vim.fn.expand('<cword>')
            end,
            expr = true,
            desc = '[R]ename'
        }
    },
    config = true,
}
