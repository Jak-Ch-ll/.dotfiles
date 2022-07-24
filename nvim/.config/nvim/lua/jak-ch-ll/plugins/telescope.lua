return {
    'nvim-telescope/telescope.nvim',
    requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { "nvim-telescope/telescope-file-browser.nvim" }
    },
    config = function()
        require('telescope').setup{
            defaults = {
                mappings = {
                    -- mappings for insert mode in telescope view
                    i = {
                        -- example
                        -- ["<C-h>"] = "which_key",
                        ["<C-h>"] = function() print("Hello, world!") end
                    }
                }
            } 
        }
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('file_browser')

        vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
        vim.keymap.set('n', '<C-j>', ':cnext<CR>')
        vim.keymap.set('n', '<C-k>', ':cprev<CR>')
    end
}
