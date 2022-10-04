vim.o.relativenumber = true
vim.o.number = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.wrap = false

--vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 10
vim.o.smartindent = 10
vim.o.hidden = true
vim.o.errorbells = false
vim.o.exrc = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.lazyredraw = true
vim.o.termguicolors = true

vim.o.spell = true
vim.o.cmdheight = 0

-- split window
vim.o.laststatus = 3
vim.cmd("highlight WinSeparator guibg=None")

-- clipboard on windows
vim.o.clipboard = "unnamedplus"

-- netrw Explorer
vim.g.netrw_dirhistmax = 0
