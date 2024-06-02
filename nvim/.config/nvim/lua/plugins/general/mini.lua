return {
	'echasnovski/mini.nvim',
	event = 'VeryLazy',
	-- lazy = false,
	-- enabled = false,
	version = '*',
	config = function()
		require('mini.pairs').setup({
			mappings = {
				-- Add < and & for Rust lifetimes
				["'"] = { neigh_pattern = '[^%a\\&<].' },
			},
		})

		require('mini.ai').setup()
	end,
}
