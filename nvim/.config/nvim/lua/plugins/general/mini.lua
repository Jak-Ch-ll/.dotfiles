return {
	'echasnovski/mini.nvim',
	event = 'VeryLazy',
	-- lazy = false,
	-- enabled = false,
	version = '*',
	dependencies = {
		-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
		{
			'JoosepAlviste/nvim-ts-context-commentstring',
			config = {
				enable_autocmd = false
			}
		}
	},
	config = function()
		-- require('mini.surround').setup()
		require('mini.comment').setup({
			options = {
				custom_commentstring = function()
					return require('ts_context_commentstring').calculate_commentstring()
				end,
			},
		})

		require('mini.pairs').setup({
			mappings = {
				-- Add < and & for Rust lifetimes
				["'"] = { neigh_pattern = '[^%a\\&<].' }
			}
		})

		require('mini.ai').setup()
	end,
}
