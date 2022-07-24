-- alts: gruvbox, monokai, Dracula, purple

local tokyonight = {
    'folke/tokyonight.nvim',
    config = function()
        vim.g.tokyonight_transparent_sidebar = true
        vim.g.tokyonight_transparent = true
        vim.o.background = 'dark'
        vim.cmd("colorscheme tokyonight")
    end
}

local ayu = {
    'ayu-theme/ayu-cim',
    config = function()
        vim.g.ayucolor = 'dark', -- alt: mirage
        vim.cmd('colorscheme ayu')
    end
}

local onedarkpro = {
    'olimorris/onedarkpro.nvim',
    config = function()
        local onedarkpro = require("onedarkpro")
        onedarkpro.setup({
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
    end
}

return tokyonight
