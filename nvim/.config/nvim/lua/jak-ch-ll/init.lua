require "jak-ch-ll/plugins/packer"
require "jak-ch-ll/lsp"

local augroup = vim.api.nvim_create_augroup("general", { clear = true }),

-- autosource config files
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        command = "source <afile>",
        group = augroup,
        pattern = "*.lua"
    }
)

-- settings
vim.o.relativenumber = true
vim.o.number = true

vim.o.tabstop = 4
vim.o.softtabstop= 4
vim.o.shiftwidth= 4
vim.o.expandtab = true

vim.o.splitright = true
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

-- split window
vim.o.laststatus = 3
vim.cmd("highlight WinSeparator guibg=None")

vim.g.netrw_dirhistmax = 0

-- TODO fix clipboard on wsl
vim.o.clipboard = "unnamedplus"


-- keybinds
vim.g.mapleader = " "

-- open project files vertically
vim.keymap.set("n", "<leader>pv", ":Vex<CR>")
-- close current buffer
vim.keymap.set("n", "<A-w>", ":bd<CR>")
-- cycle through buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>:redraw<CR>:ls<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>:redraw<CR>:ls<CR>")

-- terminal - leave insert mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- TODO hightlight only on search
--[[
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]]

--[[
vim.api.nvim_create_autocmd(
    "CmdlineEnter",
    {
        group = augroup,
        command = ":set hlsearch"
    }
)
vim.api.nvim_create_autocmd(
    "CmdlineLeave",
    {
        group = augroup,
        command ":set nohlsearch"
    }
)
]]
