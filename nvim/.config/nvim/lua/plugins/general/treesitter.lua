return {
	'nvim-treesitter/nvim-treesitter',
	name = 'Treesitter',
	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })()
	end,
	dependencies = {
		'nvim-treesitter/nvim-treesitter-context',
		{ 'windwp/nvim-ts-autotag', config = true },
	},
	main = 'nvim-treesitter.configs',
	opts = {
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
	},
	init = function()
		vim.filetype.add({
			extension = {
				mdx = 'markdown',
			},
		})
	end,
}
