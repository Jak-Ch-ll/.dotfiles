return {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
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
    end
}
