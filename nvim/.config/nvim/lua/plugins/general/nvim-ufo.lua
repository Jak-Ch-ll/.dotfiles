-- https://github.com/kevinhwang91/nvim-ufo

return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        'Treesitter',
        {
            -- https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1512772530
            "luukvbaal/statuscol.nvim",
            event = 'VeryLazy',
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
                        { text = { "%s" },                  click = "v:lua.ScSa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    },
                })
            end,
        }
    },

    event = 'VeryLazy',

    config = {
        provider_selector = function(bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
        end
    },
    init = function()
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- https://github.com/kevinhwang91/nvim-ufo/issues/19
        vim.g.indent_blankline_char_priority = 12
    end
}
