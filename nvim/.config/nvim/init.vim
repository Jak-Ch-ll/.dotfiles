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
set splitright

"experimental
set ignorecase
set smartcase
set noshowmode
set signcolumn=yes

"split window
set laststatus=3
highlight WinSeparator guibg=None



call plug#begin('~/.vim/plugged')
    "Themes
    Plug 'ayu-theme/ayu-vim'
    Plug 'olimorris/onedarkpro.nvim'

    Plug 'tpope/vim-surround'
    Plug 'Raimondi/delimitMate'
    Plug 'Yggdroot/indentLine'

    "lualine
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lualine/lualine.nvim'

    "telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-file-browser.nvim'

    "lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'simrat39/rust-tools.nvim'
call plug#end()

"load config files from ./lua/
lua require("telescope_config")
lua require("lsp_config")
lua require("devicons_config")
lua require("lualine_config")

"IndentLine
let g:indentLine_char = '│'

" color scheme
set termguicolors
let ayucolor="dark" "alt: mirage
" colorscheme ayu
" alt color schemes: gruvbox, monokai, Dracula, purple
"
lua << EOF
local onedarkpro = require("onedarkpro")
onedarkpro.setup({
    dark_theme = "onedark_dark",
    styles = {
        comments = "italic",
        keywords = "bold"
    },
    options = {
        undercurl = true,
        transparency = true
    }
})
onedarkpro.load()
EOF

" remaps
let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <A-w> :bd<CR>
nnoremap <Tab> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <S-Tab> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <C-p> :Telescope find_files<CR>

" terminal - leave insert mode
tnoremap <Esc> <C-\><C-n>

augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
