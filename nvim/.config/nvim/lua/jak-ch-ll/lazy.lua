-- bootstrap lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
	defaults = {
		lazy = true,
	},
	dev = {
		path = '~/projects',
	},
	lockfile = vim.fn.stdpath('config') .. '/lua/plugins/lazy-lock.json',
})
