require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'lua',
        'rust',
        'typescript',
        'javascript',
        'css',
        'html',
        'svelte'
    },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
    }
})
