-- https://wezfurlong.org/wezterm/config/lua/config/index.html
local wezterm = require('wezterm')

local config = wezterm.config_builder()

require('fonts').apply(config)

config.color_scheme = 'Tokyo Night'
config.underline_position = '300%'
config.default_cursor_style = 'SteadyBar'
config.background = {
	{
		source = {
			File = wezterm.config_dir .. '/images/spiral.jpg',
		},
		hsb = { brightness = 0.1 },
	},
}
config.hide_tab_bar_if_only_one_tab = true

config.default_prog = { 'fish', '-l' }

config.window_padding = {
	left = 16,
	right = 16,
}

config.warn_about_missing_glyphs = false

config.alternate_buffer_wheel_scroll_speed = 1

return config
