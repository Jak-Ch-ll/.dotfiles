require('nvim-treesitter.configs').setup({
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
    }
})
