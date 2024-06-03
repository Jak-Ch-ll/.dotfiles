return {
	'nvim-treesitter/nvim-treesitter',
	name = 'Treesitter',
	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })()
	end,
	dependencies = {
		-- {
		--     'nvim-treesitter/playground',
		--     cmd = { 'TSPlaygroundToggle', 'TSNodeUnderCursor', 'TSHighlightCapturesUnderCursor' },
		-- },
		'nvim-treesitter/nvim-treesitter-context',
		{ 'windwp/nvim-ts-autotag', config = true },
	},
	init = function()
		---@diagnostic disable-next-line: missing-fields
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				-- come pre-installed with Neovim and might create issues if not
				-- installed with Treesitter as well
				'bash',
				'c',
				'lua',
				'markdown',
				'python',
				'vim',
				'query',
				'vimdoc',

				'go',
				'rust',

				'javascript',
				'typescript',
				'css',
				'vue',
			},

			auto_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},
		})

		-- io stuff
		local parser_config =
			require('nvim-treesitter.parsers').get_parser_configs()
		parser_config.io = {
			install_info = {
				url = '~/repos/tree-sitter-io',
				files = { 'src/parser.c' },
			},
		}
		parser_config.prolog = {
			install_info = {
				url = 'https://github.com/Rukiza/tree-sitter-prolog',
				files = { 'src/parser.c' },
			},
			filetype = 'pl',
		}

		vim.filetype.add({
			extension = {
				io = 'io',
				pl = 'prolog',
				mdx = 'markdown',
			},
		})
	end,
}
