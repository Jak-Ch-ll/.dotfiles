-- Documentation:
-- htps://github.com/terrortylor/nvim-comment
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring


return {
    "terrortylor/nvim-comment",
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    enabled = false,
    keys = {
        "gcc",
        { "gc", mode = "v" }
    },
    init = function()
        require 'nvim-treesitter.configs'.setup {
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            }
        }
    end,
    config = function()
        require('nvim_comment').setup({
            marker_padding = false,
            hook = function()
                require("ts_context_commentstring.internal").update_commentstring()
            end,
        })
    end
}
