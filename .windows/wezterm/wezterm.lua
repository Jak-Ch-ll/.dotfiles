-- https://wezfurlong.org/wezterm/config/lua/config/index.html

local wezterm = require 'wezterm'
local wsl_domains = wezterm.default_wsl_domains()

for _, dom in ipairs(wsl_domains) do
    dom.default_cwd = "~"
end

return {
    wsl_domains = wsl_domains,
    default_prog = { "wsl" },
    default_domain = 'WSL:Ubuntu-20.04',
    font = wezterm.font 'FiraCode NF',
    underline_position = "300%",
    default_cursor_style = 'SteadyBar',
    background = {
        {
            source = {
                File = "C:/Users/J.c/Desktop/Background-Images/Spiral.jpg",
            },
            hsb = { brightness = 0.1 }
        },
    },

    hide_tab_bar_if_only_one_tab = true
}
