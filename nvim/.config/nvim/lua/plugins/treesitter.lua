return {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
    dependencies = {
        'nvim-treesitter/playground'
    },
    opts = {
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
    }
}
