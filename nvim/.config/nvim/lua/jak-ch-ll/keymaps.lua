-- leader
vim.g.mapleader = " "

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
vmap("J", ":m '>+1<CR>gv=gv", "[J] Move selected lines down")
vmap("K", ":m '<-2<CR>gv=gv", "[K] Move selected lines down")

-- close current buffer
nmap("<A-w>", ":bd<CR>", "[A-w] Close current buffer")
-- cycle through buffers
nmap("<Tab>", ":bnext<CR>:redraw<CR>:ls<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>:redraw<CR>:ls<CR>")

-- tmux-session
nmap("<C-s>", ":silent !tmux neww tmux-session-switcher<CR>")
nmap("<A-s>", ":silent !tmux neww tmux-session-creator<CR>")

-- re-source configs
nmap('<leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

nmap('gx', ':!open <cWORD><CR>', '[A-w] (Override) Open url')

nmap("J", "mzJ`z", '[J] (Override) Lets cursor stay when using J')

map('x', 'p', '"_dP')


-- vim.keymap.set('n', '<C-j>', ':cnext<CR>')
-- vim.keymap.set('n', '<C-k>', ':cprev<CR>')
