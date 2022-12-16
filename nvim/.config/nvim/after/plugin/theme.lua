-- COLORSCHEME tokyonight
require('tokyonight').setup({
    style = 'night',
    transparent = true,
    styles = {
        sidebars = 'transparent',
        comments = { italic = true }
    }
})
-- vim.g.tokyonight_transparent_sidebar = true


-- COLORSCHEME: ayu
vim.g.ayucolor = 'dark' -- alt: mirage


-- COLORSCHEME: onedarkpro
local onedarkpro = require("onedarkpro")
require("onedarkpro").setup({
    dark_theme = "onedark_dark",
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


function ColorMyPencils(color)
    color = color or 'tokyonight'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
