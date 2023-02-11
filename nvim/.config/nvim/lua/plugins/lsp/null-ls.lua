-- resources
-- repo: https://github.com/jose-elias-alvarez/null-ls.nvim
-- builtins: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
--
--

return {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    event = 'VeryLazy',
    config = function()

        local null_ls = require('null-ls')

        require('mason-null-ls').setup_handlers({
            require('mason-null-ls.automatic_setup'),
            eslint_d = function()
                null_ls.register(
                    null_ls.builtins.diagnostics.eslint_d.with({
                        condition = function(utils)
                            return utils.root_has_file({ ".eslintrc.cjs" })
                        end,
                    })
                )
            end
        })

        null_ls.setup({
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    local augroup = vim.api.nvim_create_augroup('on-save', { clear = true })
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                filter = function(formatting_client)
                                    return formatting_client.name == 'null-ls'
                                end,
                                bufnr = bufnr
                            })
                        end
                    })
                end
            end
        })
    end
}
