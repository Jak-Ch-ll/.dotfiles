vim.o.relativenumber = true
vim.o.number = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.splitbelow = true

vim.o.scrolloff = 10

vim.o.smartindent = true

vim.o.hidden = true

vim.o.errorbells = false

vim.o.signcolumn = "yes"

vim.o.termguicolors = true

-- split window
vim.o.laststatus = 3
vim.cmd("highlight WinSeparator guibg=None")

-- clipboard on windows
vim.o.clipboard = "unnamedplus"

-- netrw Explorer
vim.g.netrw_dirhistmax = 0

-- persist undo history
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'

-- only highlight search while searching
vim.o.hlsearch = false
vim.o.incsearch = true

-- commands
vim.o.ignorecase = true
vim.o.wildmode = 'list:longest'

-- complete
vim.opt.completeopt = { 'menuone', 'noinsert' }

vim.opt.conceallevel = 2

vim.o.textwidth = 80
