local augroup = vim.api.nvim_create_augroup('format-on-save', { clear = true })

local function enable_format_on_save(client)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(f_client)
                        return f_client.name ~= "tsserver"
                    end
                })
            end
        })
    end
end

local function shared_on_attach(client, bufnr)
    local function nmap(keys, fn, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gh', vim.lsp.buf.hover, '[G]oto [H]over documentation')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap(
        'gr',
        function()
            require('telescope.builtin').lsp_references()
        end,
        '[G]oto [R]eferences'
    )

    nmap('<leader>dn', vim.diagnostic.goto_next, '[D]iagnostics [N]ext')
    nmap('<leader>dp', vim.diagnostic.goto_prev, '[D]iagnostics [P]revious')
    nmap('<leader>dh', vim.diagnostic.open_float, '[D]iagnostics [H]over information')
    nmap(
        '<leader>dl',
        function() require('telescope.builtin').diagnostics() end,
        '[D]iagnostics [L]ist'
    )

    nmap(
        '<leader>sds',
        function() require('telescope.builtin').lsp_document_symbols() end,
        '[S]earch [D]ocument [S]ymbols'
    )
    nmap(
        '<leader>sws',
        function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
        '[S]earch [W]orkspace [S]ymbols'
    )


    enable_format_on_save(client)
end

return shared_on_attach
