return {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = '*',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
        -- require('mini.surround').setup()
        require('mini.comment').setup({
            hooks = {
                pre = function()
                    require('ts_context_commentstring.internal').update_commentstring({})
                end,
            },
        })

        require('mini.pairs').setup({
            mappings = {
                -- Add < and & for Rust lifetimes
                ["'"] = { neigh_pattern = '[^%a\\&<].' }
            }
        })

        require('mini.ai').setup()
    end,
}
