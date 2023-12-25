function ColorMyPencils(color)
	color = color or 'tokyonight'
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			style = 'night',
			transparent = true,
			styles = {
				sidebars = 'transparent',
				floats = 'transparent',
				comments = { italic = true },
				keywords = { italic = false }
			}
		},
		init = function()
			-- vim.g.tokyonight_transparent_sidebar = true
			vim.cmd([[colorscheme tokyonight]])
		end
	},

	{
		'ayu-theme/ayu-vim',
		config = function()
			vim.g.ayucolor = 'dark' -- alt: mirage
		end
	},

	{
		'olimorris/onedarkpro.nvim',
		config = function()
			local onedarkpro = require("onedarkpro")
			require("onedarkpro").setup({
				styles = {
					comments = "italic",
					keywords = "bold"
				},
				options = {
					undercurl = true,
					transparency = true
				}
			})
			onedarkpro.load()
		end
	}
}
