function ColorMyPencils(color)
	color = color or 'tokyonight'
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

---@module 'lazy'
---@type LazySpec
return {
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,

		---@module 'tokyonight'
		---@type tokyonight.Config
		opts = {
			style = 'night',
			transparent = true,
			styles = {
				sidebars = 'transparent',
				floats = 'transparent',
				comments = { italic = true },
				keywords = { italic = false },
			},
			on_highlights = function(highlights, colors)
				-- Replace undercurl with underline
				-- https://github.com/folke/tokyonight.nvim/discussions/303#discussioncomment-4808330
				highlights.DiagnosticUnderlineWarn.undercurl = nil
				highlights.DiagnosticUnderlineError.undercurl = nil
				highlights.DiagnosticUnderlineWarn.underline = true
				highlights.DiagnosticUnderlineError.underline = true

				highlights.cursorline = { bg = colors.bg_dark }

				highlights.debugPC = { bg = colors.bg_highlight }
			end,
		},
		init = function()
			-- vim.g.tokyonight_transparent_sidebar = true
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	{
		'ayu-theme/ayu-vim',
		config = function()
			vim.g.ayucolor = 'dark' -- alt: mirage
		end,
	},

	{
		'olimorris/onedarkpro.nvim',
		config = function()
			local onedarkpro = require('onedarkpro')
			require('onedarkpro').setup({
				styles = {
					comments = 'italic',
					keywords = 'bold',
				},
				options = {
					undercurl = true,
					transparency = true,
				},
			})
			onedarkpro.load()
		end,
	},
}
