set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set scrolloff=10
set smartindent
set number
set relativenumber
set hidden
set noerrorbells
set exrc


" experimental
set nowrap
set ignorecase
set smartcase
set noshowmode
"set completeopt=menuone,noinsert,noselect,preview
set completeopt=menuone,noinsert,noselect
set signcolumn=number
set colorcolumn=80
set cmdheight=2


set laststatus=3
highlight WinSeparator guibg=None

call plug#begin('~/.vim/plugged')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'ayu-theme/ayu-vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'nvim-lua/completion-nvim'
    Plug 'tpope/vim-surround'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" luafile ./plugins/lsp_config.lua
" lsp
" lua require'lspconfig'.rust_analyzer.setup({})
lua require('rust-tools').setup{on_attach=completion_callback}
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
sign define LspDiagnosticsSignError text=🔴
sign define LspDiagnosticsSignWarning text=🟠
sign define LspDiagnosticsSignInformation text=🔵
sign define LspDiagnosticsSignHint text=🟢
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>

" color scheme
set termguicolors
let ayucolor="dark" "alt: mirage
colorscheme ayu
" alt color schemes: gruvbox, monokai, Dracula, purple


" remove search highlight after searching
augroup nohl-after-search
    autocmd!
    autocmd CmdlineLeave /,\? :nohl
augroup END

" remaps
let mapleader = " "
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <C-p> <cmd>Telescope find_files<cr>

