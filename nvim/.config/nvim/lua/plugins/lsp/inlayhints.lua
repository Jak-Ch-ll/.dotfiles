-- https://github.com/lvimuser/lsp-inlayhints.nvim#configuration
-- Alternative: https://github.com/simrat39/inlay-hints.nvim

return {
    'lvimuser/lsp-inlayhints.nvim',
    enabled = false,
    config = function()
        local ih = require('lsp-inlayhints')

        ih.setup({
            inlay_hints = {
                parameter_hints = {
                    prefix = ' ',
                },
                type_hints = {
                    separator = ' ',
                }
            }
        })

        vim.api.nvim_create_user_command(
            'ToggleInlayHints',
            ih.toggle,
            {}
        )
    end,
    init = function()
        local augroup = vim.api.nvim_create_augroup("Inlayhints", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = augroup,
            callback = function(args)
                if not (args.data and args.data.client_id) then
                    return
                end

                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                require("lsp-inlayhints").on_attach(client, bufnr)
            end,
        })
    end
}
