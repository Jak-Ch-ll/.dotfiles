set scrolloff=10
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set ignorecase

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
call plug#end()
" alternative to fzf in nvim: telescope

let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-rust-analyzer']

" color scheme
set termguicolors
let ayucolor="dark" "alt: mirage
colorscheme ayu
" alt color schemes: gruvbox, monokai, Dracula, purple

" remaps
let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" terminal - leave insert mode
tnoremap <Esc> <C-\><C-n>

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm(): :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
