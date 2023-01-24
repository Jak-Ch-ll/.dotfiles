return {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
    dependencies = {
        'nvim-treesitter/playground'
    },
    init = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = {
                'lua',
                'rust',
                'typescript',
                'javascript',
                'css',
                'scss',
                'html',
                'svelte',
                'jsdoc',
            },
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
            },

            -- indent = {
            --     enable = true
            -- },

            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            }
        }
    end,
}
