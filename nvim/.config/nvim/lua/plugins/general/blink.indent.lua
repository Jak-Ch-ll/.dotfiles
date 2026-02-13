---@module 'lazy'
---@type LazySpec
return {
	'saghen/blink.indent',
	event = 'VeryLazy',

	--- @module 'blink.indent'
	--- @type blink.indent.Config
	opts = {
		static = {
			char = '▏',
		},
		scope = {
			char = '▏',
			highlights = { 'BlinkIndentOrange' },
		},
	},
}
