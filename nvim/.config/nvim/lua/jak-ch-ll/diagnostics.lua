vim.diagnostic.config({
	virtual_lines = {
		severity = vim.diagnostic.severity.ERROR,
	},
	virtual_text = {
		severity = vim.diagnostic.severity.WARN,
	},
	float = {
		border = 'rounded',
		header = '',
		suffix = function(diagnostic)
			---@diagnostic disable-next-line: missing-return-value
			return ' ' .. diagnostic.source .. '(' .. diagnostic.code .. ')'
		end,
	},
	jump = {
		float = true,
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
})

require('jak-ch-ll.utils.set_keymaps')({

	{
		'<leader>dn',
		function()
			vim.diagnostic.jump({ count = 1 })
		end,
		desc = '[N]ext',
	},
	{
		'<leader>dp',
		function()
			vim.diagnostic.jump({ count = -1 })
		end,
		desc = '[P]revious',
	},
	{ '<leader>dh', vim.diagnostic.open_float, desc = '[H]over information' },
	{
		'<leader>dl',
		function()
			require('telescope.builtin').diagnostics()
		end,
		'[L]ist',
	},
}, { prefix = '[D]iagnostics ' })
