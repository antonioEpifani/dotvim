"plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-dispatch'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'lilyball/vim-swift'
Plug 'lifepillar/vim-mucomplete'
Plug 'critiqjo/lldb.nvim'
call plug#end()

"we want syntax
"
syntax on
colorscheme onehalfdark

"global settings
set number
set tabstop=4
set smartindent
set shiftwidth=4
set ic
set incsearch
set hlsearch
set foldmethod=indent
set scroll=5
set noinfercase
set completeopt=longest,menuone,noinsert
let mapleader=" "


" plugins settings
"
let g:mucomplete#enable_auto_at_startup = 1
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 }}
let g:mucomplete#chains = { 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl'], 'vim' : ['path', 'cmd', 'keyn', 'keyp', 'defs', 'incl', 'c-n', 'c-p']}



"fzf mappings
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>w :Windows<cr>
nnoremap <leader>rw :Rg \b(<c-r><c-w>)\b<cr>
nnoremap <leader>lw :Lines '<c-r><c-w><cr>
nnoremap <leader>l :Lines <cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>sb :set scb!<cr>
nnoremap <leader>\| :set scb<cr>:vs<cr><c-w><c-w>:set scb!<cr>40<c-e>:set scb!<cr><c-w><c-w>
nnoremap <leader>tw :cex[]<cr> :tabdo vimgrepadd /<c-r><c-w>/j %<cr>
nnoremap <leader>e :e %:p:h<cr>
nnoremap <tab> :cn<cr>
nnoremap <s-tab> :cp<cr>
nnoremap <leader>m :Make<cr>
nnoremap gh gT
nnoremap gl gt

tnoremap <leader><Esc> <c-\><c-n>

filetype plugin indent on
"lsp client configuration

