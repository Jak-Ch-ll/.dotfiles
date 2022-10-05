require('jak-ch-ll/lsp/mason')

local function enable_format_on_save(client)
    if client.supports_method('textDocument/formatting') then
        local augroup = vim.api.nvim_create_augroup('on-save', { clear = true })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            callback = function()
                vim.lsp.buf.format()
            end
        })
    end
end

local function shared_on_attach(client, bufnr)
    local bufopts = { buffer = bufnr }
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

    -- jump to error (diagnostics)
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", bufopts)
    vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, bufopts)

    -- rename (will make changes in other files, use :wa to save)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)

    enable_format_on_save(client)
end

local servers = {
    svelte = {
        config = {
            settings = {
                svelte = {
                    useNewTransformation = true
                }
            }
        }
    },
    html = {
        config = {
            filetypes = { 'html', 'svelte' }
        }
    },
    emmet_ls = {},
    cssls = {},
    jsonls = {
        config = {
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true }
                }
            }
        }
    },
    tailwindcss = {},
    gopls = {},
    dockerls = {},
    yamlls = {},
    sumneko_lua = {
        config = {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                    telemetry = {
                        enabled = false
                    }
                }
            }
        }
    },
}
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')

for server, server_settings in pairs(servers) do
    local config = {}

    if server_settings.config then
        config = server_settings.config
    end

    config.capabilities = capabilities
    config.on_attach = function(client, bufnr)
        shared_on_attach(client, bufnr)
    end

    lspconfig[server].setup(config)
end

-- rust
require('rust-tools').setup({
    server = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            shared_on_attach(client, bufnr)
        end,
    },
    tools = {
        inlay_hints = {
            parameter_hints_prefix = '<< ',
            other_hints_prefix = '>> '
        }
    }
})

-- typescript
require('typescript').setup({
    server = {
        capabilities = capabilities,
        on_attach = shared_on_attach
    }
})

-- inlay hints rust
--local lsp_extensions = require('lsp_extensions')
--vim.api.nvim_create_autocmd({
--    'CursorMoved',
--    'InsertLeave',
--    'BufEnter',
--    'BufWinEnter',
--    'TabEnter'
--}, {
--    pattern = '*.rs',
--    callback = function()
--        print("hello from cb")
--        lsp_extensions.inlay_hints{
--            enabled = { 'TypeHint', 'ChainingHint', 'ParameterHint'}
--        }
--    end
--})

-- Setup nvim-cmp.
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})
