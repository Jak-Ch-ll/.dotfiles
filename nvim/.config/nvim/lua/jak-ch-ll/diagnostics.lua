vim.diagnostic.config({
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
	float = {
		border = 'rounded',
		header = '',
		suffix = function(diagnostic)
			local suffix = ' ' .. diagnostic.source

			if diagnostic.code then
				suffix = suffix .. ' (' .. diagnostic.code .. ')'
			end

			---@diagnostic disable-next-line: missing-return-value
			return suffix
		end,
	},
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				-- https://github.com/neovim/neovim/discussions/35281
				focus = false,
			})
		end,
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
	{
		'<leader>dh',
		function()
			vim.diagnostic.open_float({ scope = 'cursor' })
		end,
		desc = '[H]over information',
	},
	{
		'<leader>dl',
		function()
			require('telescope.builtin').diagnostics()
		end,
		'[L]ist',
	},
	{
		'<leader>db',
		function()
			vim.diagnostic.open_float({ scope = 'buffer' })
		end,
		'[B]uffer',
	},
}, { prefix = '[D]iagnostics ' })
