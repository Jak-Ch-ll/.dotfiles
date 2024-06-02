local augroup = vim.api.nvim_create_augroup('general', { clear = true })

-- autosource config files
vim.api.nvim_create_autocmd('BufWritePost', {
	group = augroup,
	pattern = { '*/nvim/lua/*.lua', '*/nvim/init.lua' },
	command = 'source <afile>',
})
