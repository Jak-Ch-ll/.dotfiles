---@module 'lazy'
---@type LazySpec
return {
	{
		'https://github.com/nvim-neotest/neotest',

		enabled = true,

		dependencies = {
			'https://github.com/nvim-neotest/nvim-nio',
			'https://github.com/nvim-lua/plenary.nvim',
			'https://github.com/antoinemadec/FixCursorHold.nvim',
			'https://github.com/nvim-treesitter/nvim-treesitter',

			'https://github.com/marilari88/neotest-vitest',
			'https://github.com/thenbe/neotest-playwright',
		},

		cmd = { 'Neotest' },

		init = function()
			local commands = {
				TestFile = function()
					local neotest = require('neotest')
					neotest.run.run(vim.fn.expand('%'))
					neotest.summary.open()
				end,
				TestWatchFile = function()
					local neotest = require('neotest')
					neotest.watch.watch(vim.fn.expand('%'))
					neotest.summary.open()
				end,
				TestSummary = function()
					require('neotest').summary.toggle()
				end,
			}

			for name, func in pairs(commands) do
				vim.api.nvim_create_user_command(name, func, {})
			end
		end,

		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('neotest').setup({
				adapters = {
					require('rustaceanvim.neotest'),
					require('neotest-vitest'),
					require('neotest-playwright').adapter(),
				},
			})

			vim.diagnostic.config({
				virtual_lines = true,
				virtual_text = false,

				-- stop diagnostic message from disappearing while typing
				update_in_insert = true,
			}, vim.api.nvim_create_namespace('neotest'))
		end,
	},
}
