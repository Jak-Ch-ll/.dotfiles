return {
    'kyazdani42/nvim-tree.lua',
    requires = {
        'kyazdani42/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup({
            disable_netrw = true,
            hijack_unnamed_buffer_when_opening = true,
            hijack_cursor = true,
            diagnostics = {
                enable = true
            },
            view = {
                width = '30%',
                side = 'right',
                number = true,
                relativenumber = true,
                mappings = {
                    list = {
                        { key = 'l', action = 'preview' },
                        { key = 'h', action = 'close_node' }
                    }
                },
            }
        })

        vim.o.splitright = false

        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')


        local augroup = vim.api.nvim_create_augroup("nvim-tree", { clear = true })

        -- autosource config files
        vim.api.nvim_create_autocmd(
            "BufDelete",
            {
                group = augroup,
                command = 'NvimTreeClose'
            }
        )
    end
}
