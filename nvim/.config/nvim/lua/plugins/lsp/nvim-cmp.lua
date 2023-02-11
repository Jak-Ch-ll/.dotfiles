return {
    enabled = true,

    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',

    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp'
    },

    config = function()
        local cmp = require('cmp')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },

            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),

            sources = cmp.config.sources({
                { name = 'nvim_lsp' }
            }),

            sorting = {
                comparators = {
                    cmp.config.compare.order,
                }
            }
        })
    end
}
