-- leader
vim.g.mapleader = ' '

local function map(mode, keys, fn, desc)
	vim.keymap.set(mode, keys, fn, { desc = desc })
end

local function nmap(keys, fn, desc)
	map('n', keys, fn, desc)
end

local function vmap(keys, fn, desc)
	map('v', keys, fn, desc)
end

-- move lines
vmap('J', ":m '>+1<CR>gv=gv", '[J] Move selected lines down')
vmap('K', ":m '<-2<CR>gv=gv", '[K] Move selected lines down')

-- close current buffer
nmap('<A-w>', ':bd<CR>', '[A-w] Close current buffer')

-- toggle to last buffer
nmap('<Tab>', ':b#<CR>')
-- nmap("<Tab>", ":bnext<CR>:redraw<CR>:ls<CR>")
-- vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>:redraw<CR>:ls<CR>")

-- tmux-session
nmap('<C-s>', ':silent !tmux neww tmux-session-switcher<CR>')
nmap('<A-s>', ':silent !tmux neww tmux-session-creator<CR>')

-- re-source configs
nmap('<leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

nmap('gx', ':!wslview <cfile><CR>', '(Override) Open url')

nmap('J', 'mzJ`z', '[J] (Override) Lets cursor stay when using J')

map('x', 'p', '"_dP')

-- vim.keymap.set('n', '<C-j>', ':cnext<CR>')
-- vim.keymap.set('n', '<C-k>', ':cprev<CR>')

local set_keymaps = require('jak-ch-ll.utils.set_keymaps')

set_keymaps({
	{
		'gh',
		function()
			vim.print('gh')
			local bufnr, winid = vim.diagnostic.open_float()
			if bufnr then
				return
			end

			vim.lsp.buf.hover()
		end,
		'[G]oto [H]over diagnostics or documentation',
	},
})
