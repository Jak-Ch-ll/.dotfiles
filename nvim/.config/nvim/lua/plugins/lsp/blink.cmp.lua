---@module 'lazy'
---@type LazySpec
return {
	'saghen/blink.cmp',
	event = 'InsertEnter',
	version = '1.*',

	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			['<Tab>'] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				'snippet_forward',
				'fallback',
			},
			['<S-Tab>'] = { 'snippet_backward', 'fallback' },
		},

		sources = {
			default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },

			providers = {
				-- completion source for require statements and module annotations
				lazydev = {
					name = 'LazyDev',
					module = 'lazydev.integrations.blink',
					score_offset = 100,
				},
			},
		},

		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 1000 },
			list = {
				selection = {
					preselect = false,
				},
			},
			menu = {
				draw = {
					columns = {
						{ 'kind_icon', 'label', 'label_description', gap = 1 },
						{
							'source',
							'kind',
							gap = 1,
						},
					},
					components = {
						-- custom component to show the language server name
						-- instead of LSP
						source = {
							text = function(ctx)
								local client_map = {
									lua_ls = 'Lua',
									volar = 'Vue',
									vue_ls = 'Vue',
									vtsls = 'TS',
								}
								local client_name = ctx.item.client_name

								return client_map[client_name]
									or client_name
									or ctx.source_name
							end,
						},
						kind_icon = {
							text = function(ctx)
								if
									vim.tbl_contains(
										{ 'Path' },
										ctx.source_name
									)
								then
									local dev_icon, _ = require(
										'nvim-web-devicons'
									).get_icon(ctx.label)
									if dev_icon then
										return dev_icon
									end
								end

								return ctx.kind_icon
							end,
						},
					},
				},
			},
		},
	},
}
