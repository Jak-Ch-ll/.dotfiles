local wezterm = require('wezterm')

local M = {}

local harfbuzz_features = {
	-- Contextual Alternates
	'calt',
	-- Standard Ligatures
	'liga',
	-- Discretionary Ligatures
	'dlig',
	-- stylistic sets
	'ss01',
	'ss02',
	'ss03',
	'ss04',
	'ss05',
	'ss06',
	'ss07',
	'ss08',
	'ss09',
	'ss10',
}

function M.apply(config)
	config.font = wezterm.font({
		family = 'Monaspace Neon',
		harfbuzz_features = harfbuzz_features,
	})

	config.font_rules = {
		-- Italic
		{
			italic = true,
			font = wezterm.font({
				family = 'Monaspace Radon',
				harfbuzz_features = harfbuzz_features,
			}),
		},
	}
end

return M
