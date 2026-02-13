return {
	{
		'nvim-mini/mini.pairs',
		version = '*',
		event = 'VeryLazy',
		opts = {
			mappings = {
				-- Add < and & for Rust lifetimes
				["'"] = { neigh_pattern = '[^%a\\&<].' },
			},
		},
	},

	{
		'nvim-mini/mini.ai',
		version = '*',
		event = 'VeryLazy',
	},
}
