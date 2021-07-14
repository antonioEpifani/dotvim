"plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-dispatch'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'lilyball/vim-swift'
Plug 'critiqjo/lldb.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
call plug#end()

"we want syntax
"
syntax on
colorscheme onehalfdark
autocmd FileType swift setlocal omnifunc=lsp#complete
autocmd FileType swift set makeprg=../build.sh

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

"global settings
:lua require('luastart')
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
set helpfile=/Users/antonioepifani/.vim/doc/help.txt


" plugins settings
"
let g:mucomplete#enable_auto_at_startup = 1
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 }}
let g:completion_chain_complete_list = {
	\'default' : [
	\    {'complete_items': ['lsp']},
	\    {'complete_items': ['snippet']},
	\    {'mode': '<c-p>'},
	\    {'mode': '<c-n>'}
	\]
	\}
let g:completion_auto_change_source = 1

" fzf actions
function! Ciao(lines)
  open
  echom "ecco gli argomenti"
  echom a:lines
endfunction

command -nargs=1 Ciao :call Ciao(<q-args>)

let g:fzf_action = {
  \ 'ctrl-q': 'Ciao',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

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

