return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	},

	event = 'VeryLazy',

	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = { lsp = { enabled = true } },

		render_modes = { 'n', 'c', 't', 'i', 'v' },

		heading = {
			width = 'block',
		},

		code = {
			conceal_delimiters = false,
			border = 'thin',
			left_pad = 1,
			right_pad = 1,
			width = 'block',
		},

		-- disable latex warning
		latex = { enabled = false },
	},
}
