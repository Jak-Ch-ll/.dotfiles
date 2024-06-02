return {
	enabled = true,

	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',

	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-calc',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-emoji',

		'onsails/lspkind.nvim',

		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
	},

	config = function()
		local cmp = require('cmp')
		local luasnip = require('luasnip')

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				['<Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end,
				['<S-Tab>'] = function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end,
				['<C-Space>'] = cmp.mapping.complete(),
			}),

			sources = cmp.config.sources({
				{ name = 'luasnip' },
				{ name = 'calc' },
				{ name = 'nvim_lsp' },
				{ name = 'path' },
				{ name = 'nvim_lua' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'emoji' },
			}, {
				{ name = 'buffer' },
			}),

			sorting = {
				comparators = {
					cmp.config.compare.order,
				},
			},

			formatting = {
				format = require('lspkind').cmp_format({
					menu = {
						nvim_lua = '[nvim]',
						nvim_lsp = '[lsp]',
						path = '[path]',
						buffer = '[buffer]',
						calc = '[calc]',
					},
				}),
			},
		})

		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' },
			},
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' },
			}, {
				{ name = 'cmdline' },
			}),
		})
	end,
}
