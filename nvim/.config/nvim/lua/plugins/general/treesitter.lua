return {
	'nvim-treesitter/nvim-treesitter',
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

			'rust',
			'go',

			'javascript',
			'typescript',
			'html',
			'css',
			'jsdoc',
			'vue',
			'svelte',

			'json',
			'yaml',
			'markdown',
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
