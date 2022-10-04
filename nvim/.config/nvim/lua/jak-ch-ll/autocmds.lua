local augroup = vim.api.nvim_create_augroup("general", { clear = true })

-- autosource config files
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        group = augroup,
        pattern = "*.lua",
        command = "source <afile>"
    }
)

-- remove search highlight
vim.api.nvim_create_autocmd(
    "CmdlineEnter",
    {
        group = augroup,
        pattern = '/,?',
        command = ':set hlsearch'
    }
)
vim.api.nvim_create_autocmd(
    "CmdlineLeave",
    {
        group   = augroup,
        pattern = '/,?',
        command = ':set nohlsearch'
    }
)
