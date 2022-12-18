-- leader
vim.g.mapleader = " "

-- close current buffer
vim.keymap.set("n", "<A-w>", ":bd<CR>")
-- cycle through buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>:redraw<CR>:ls<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>:redraw<CR>:ls<CR>")

-- tmux-session
vim.keymap.set("n", "<C-s>", ":silent !tmux neww tmux-session-switcher<CR>")
vim.keymap.set("n", "<A-s>", ":silent !tmux neww tmux-session-creator<CR>")

-- resource configs
vim.keymap.set('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

-- open urls
vim.keymap.set('n', 'gx', ':!open <cWORD><CR>')
