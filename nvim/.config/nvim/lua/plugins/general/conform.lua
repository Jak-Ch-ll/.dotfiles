---@module 'lazy'
---@module 'conform'

---@type conform.FiletypeFormatterInternal
local js_formatting = {
	'prettierd',
	'eslint_d',
	stop_after_first = true,
	lsp_format = 'fallback',
}

---@type LazySpec
return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },

	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			javascript = js_formatting,
			typescript = js_formatting,
			typescriptreact = js_formatting,
			vue = js_formatting,

			html = js_formatting,
			css = js_formatting,
			scss = js_formatting,

			xml = js_formatting,
			yaml = js_formatting,
			json = js_formatting,
			jsonc = js_formatting,
			markdown = js_formatting,

			nix = { 'nixfmt' },

			lua = { 'stylua' },
		},
		formatters = {
			prettierd = {
				condition = function()
					local root_dir = vim.fn.getcwd()

					-- check if any file name in root_dir contains 'prettier'
					local files = vim.fn.readdir(root_dir)
					for _, file in ipairs(files) do
						if string.find(file, 'prettier') then
							return true
						end
					end

					return false
				end,
			},
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
