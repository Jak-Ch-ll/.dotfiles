-- Documentation:
-- htps://github.com/terrortylor/nvim-comment
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

require 'nvim-treesitter.configs'.setup {
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    }
}
require('nvim_comment').setup {
    marker_padding = false,
    hook = function()
        require("ts_context_commentstring.internal").update_commentstring()
    end,
}
