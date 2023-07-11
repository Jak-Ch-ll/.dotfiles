-- resources
-- repo: https://github.com/jose-elias-alvarez/null-ls.nvim
-- builtins: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

return {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    event = 'VeryLazy',
    config = function()

        local null_ls = require('null-ls')

        require('mason-null-ls').setup({
            handlers = {
                ["eslint_d"] = function()
                    local eslint_config = {
                        condition = function(utils)
                            return utils.root_has_file({ ".eslintrc.cjs", ".eslintrc.json" })
                        end,
                    }
                    null_ls.register(
                        null_ls.builtins.diagnostics.eslint_d.with(eslint_config))
                    null_ls.register(
                        null_ls.builtins.code_actions.eslint_d.with(eslint_config)
                    )
                end,
                prettier = function()
                    null_ls.register(
                        null_ls.builtins.formatting.prettier.with({
                            extra_filetypes = { "xml" }
                        })
                    )
                end
            }
        })

        null_ls.setup()
    end
}
