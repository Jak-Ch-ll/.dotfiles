-- https://github.com/RRethy/vim-illuminate

return {
	'RRethy/vim-illuminate',
	event = 'VeryLazy',
	config = function()
		require('illuminate').configure({
			delay = 500,
			filetypes_denylist = {
				'NvimTree',
			},
			modes_denylist = { 'i' },
		})
	end,
}
