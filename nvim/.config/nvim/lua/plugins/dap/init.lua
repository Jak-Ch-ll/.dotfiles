---@module 'lazy'
---@type LazySpec
return {
	'https://github.com/mfussenegger/nvim-dap',
	enabled = true,
	dependencies = {
		{
			'https://github.com/theHamsta/nvim-dap-virtual-text',
			config = true,
		},
		{
			-- Docs: https://igorlfs.github.io/nvim-dap-view
			'https://github.com/igorlfs/nvim-dap-view',
			version = '1.*',

			---@module 'dap-view'
			---@type dapview.Config
			opts = {
				auto_toggle = true,

				windows = {
					position = 'right',
					size = 0.5,
					terminal = {
						position = 'below',
					},
				},

				winbar = {
					controls = {
						enabled = true,
					},
				},
			},
		},
	},

	keys = {
		{
			'<F5>',
			function()
				require('dap').continue()
			end,
			desc = '[F5] Continue',
		},
		{
			'<F1>',
			function()
				require('dap').step_into()
			end,
			desc = '[F1] Step Into',
		},
		{
			'<F2>',
			function()
				require('dap').step_over()
			end,
			desc = '[F2] Step Over',
		},
		{
			'<F3>',
			function()
				require('dap').step_out()
			end,
			desc = '[F3] Step Out',
		},
		{
			'<leader>tb',
			function()
				require('dap').toggle_breakpoint()
			end,
			desc = 'Toggle Breakpoint',
		},
		{
			'<leader>tB',
			function()
				require('dap').set_breakpoint(
					vim.fn.input('Breakpoint condition: ')
				)
			end,
			desc = 'Set Breakpoint with Condition',
		},
		{
			'<leader>lp',
			function()
				require('dap').set_breakpoint(
					vim.fn.input('Log point message: ')
				)
			end,
			desc = 'Set Log Point',
		},
	},

	config = function()
		vim.fn.sign_define({
			{
				name = 'DapBreakpoint',
				text = '',
				texthl = 'Title',
			},
			{
				name = 'DapBreakpointCondition',
				text = '',
				texthl = 'Title',
			},
			{
				name = 'DapLogPoint',
				text = '',
				texthl = 'Title',
			},
			{
				name = 'DapBreakpointRejected',
				text = '',
				texthl = 'ErrorMsg',
			},
		})
	end,
}
