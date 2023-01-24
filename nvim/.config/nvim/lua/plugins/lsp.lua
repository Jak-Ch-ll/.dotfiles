-- lsp
-- use { 'neovim/nvim-lspconfig',
--     requires = {
--         'hrsh7th/nvim-cmp',
--         'hrsh7th/cmp-nvim-lsp',
--         'hrsh7th/cmp-buffer',
--         'hrsh7th/cmp-path',
--         'saadparwaiz1/cmp_luasnip',
--         'L3MON4D3/LuaSnip',
--         'simrat39/rust-tools.nvim',
--         'williamboman/mason.nvim',
--         'williamboman/mason-lspconfig.nvim',
--         "b0o/schemastore.nvim",
--         'jose-elias-alvarez/typescript.nvim',
--         'lvimuser/lsp-inlayhints.nvim'
--     }
-- }

return {
    { import = 'plugins.lsp' },
    {
        'VonHeikemen/lsp-zero.nvim',
        event = 'VeryLazy',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Custom
            { 'lvimuser/lsp-inlayhints.nvim' },
            { "b0o/schemastore.nvim" },
        },
        config = function()

            local lsp = require('lsp-zero')

            lsp.preset('recommended')

            -- to work in lua config files
            lsp.nvim_workspace()

            -- CMP
            local cmp = require('cmp')
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<tab>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            })

            cmp_mappings['<CR>'] = nil

            lsp.setup_nvim_cmp({
                mapping = cmp_mappings
            })



            lsp.on_attach(function(client, bufnr)
                local function nmap(keys, fn, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end

                    vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = desc })
                end

                nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                nmap('gh', vim.lsp.buf.hover, 'Hover documtation')
                nmap('<leader>sds', require('telescope.builtin').lsp_document_symbols, '[S]earch [D]ocument [S]ymbols')
                nmap('<leader>sws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                    '[S]earch [W]orkspace [S]ymbols')
                nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                if client.supports_method('textDocument/formatting') then
                    local augroup = vim.api.nvim_create_augroup('on-save', { clear = true })
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = augroup,
                        callback = function()
                            vim.lsp.buf.format()
                        end
                    })
                end
            end)

            lsp.configure('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true }
                    },
                },
            })

            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true
            })
        end
    }
}
