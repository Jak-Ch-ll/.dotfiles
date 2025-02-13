local prettier = { 'prettierd' }

return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	opts = {
		formatters_by_ft = {
			javascript = prettier,
			typescript = prettier,
			typescriptreact = prettier,
			vue = prettier,

			html = prettier,
			css = prettier,
			scss = prettier,

			xml = prettier,
			yaml = prettier,
			json = prettier,
			jsonc = prettier,
			markdown = prettier,

			nix = { 'nixfmt' },

			lua = { 'stylua' },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return {
				lsp_fallback = true,
				timeout_ms = 1000,
			}
		end,
	},
	init = function()
		vim.api.nvim_create_user_command('ConformToggle', function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = not vim.b.disable_autoformat
			else
				vim.g.disable_autoformat = not vim.g.disable_autoformat
			end
		end, {
			desc = 'Toggle autoformat-on-save',
			bang = true,
		})
	end,
}
