return {
	{
		'echasnovski/mini.pairs',
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
		'echasnovski/mini.ai',
		version = '*',
		event = 'VeryLazy',
	},
}
