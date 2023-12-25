return {
	'nvim-treesitter/nvim-treesitter',
	name = 'Treesitter',
	build = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
	dependencies = {
		-- {
		--
		--     'nvim-treesitter/playground',
		--     cmd = { 'TSPlaygroundToggle', 'TSNodeUnderCursor', 'TSHighlightCapturesUnderCursor' },
		-- },
		'nvim-treesitter/nvim-treesitter-context',
		'windwp/nvim-ts-autotag'
	},
	init = function()
		---@diagnostic disable-next-line: missing-fields
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

			auto_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true
			},

			autotag = {
				enable = true,
			},
		}

		-- io stuff
		local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
		parser_config.io = {
			install_info = {
				url = "~/repos/tree-sitter-io",
				files = { "src/parser.c" }
			}
		}
		parser_config.prolog = {
			install_info = {
				url = 'https://github.com/Rukiza/tree-sitter-prolog',
				files = { "src/parser.c" },
			},
			filetype = "pl"
		}

		vim.filetype.add({
			extension = {
				io = 'io',
				pl = 'prolog',
				mdx = 'markdown'
			}
		})
	end,
}
