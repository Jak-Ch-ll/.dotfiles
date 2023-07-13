return {
    'nvim-treesitter/nvim-treesitter',
    name = 'Treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
    dependencies = {
        {

            'nvim-treesitter/playground',
            cmd = { 'TSPlaygroundToggle', 'TSNodeUnderCursor', 'TSHighlightCapturesUnderCursor' },
        },
        {
            'nvim-treesitter/nvim-treesitter-context',
            event = 'VeryLazy'
        }
    },
    init = function()
        require 'nvim-treesitter.configs'.setup {
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true
            },

            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            }
        }
    end,
}
