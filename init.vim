"plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-dispatch'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'lilyball/vim-swift'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tpope/vim-fugitive'
call plug#end()

"we want syntax
"
syntax on
colorscheme onehalfdark
autocmd FileType swift setlocal omnifunc=lsp#complete
autocmd FileType swift set makeprg=../build.sh

"global settings
set number
set tabstop=4
set smartindent
set foldmethod=indent
set shiftwidth=4
set smartcase
set incsearch
set hlsearch
set nowrap
set scroll=5
set noinfercase
set completeopt=longest,menuone,noinsert
let mapleader=" "
set helpfile=/Users/antonioepifani/.vim/doc/help.txt


" plugins settings
"
:lua require('luastart')
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


let g:fzf_action = {
  \ 'ctrl-q': 'Ciao',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


" commands and functions 
function! GetBufferList()
    return filter(range(1,bufnr('$')), 'buflisted(v:val)')
endfunction

function! GetNonMatchingBuffers(pattern)
    return filter(GetBufferList(), 'bufname(v:val) !~ a:pattern')
endfunction

function! WipeNonMatchingBuffers(pattern)
    let l:matchList = GetNonMatchingBuffers(a:pattern)

    let l:count = len(l:matchList)
    if l:count < 1
        echo 'No buffers found matching pattern ' . a:pattern
        return
    endif

    if l:count == 1
        let l:suffix = ''
    else
        let l:suffix = 's'
    endif

    exec 'bw ' . join(l:matchList, ' ')

    echo 'Wiped ' . l:count . ' buffer' . l:suffix . '.'
endfunction

function! GetMatchingBuffers(pattern)
    return filter(GetBufferList(), 'bufname(v:val) =~ a:pattern')
endfunction

function! WipeMatchingBuffers(pattern)
    let l:matchList = GetMatchingBuffers(a:pattern)

    let l:count = len(l:matchList)
    if l:count < 1
        echo 'No buffers found matching pattern ' . a:pattern
        return
    endif

    if l:count == 1
        let l:suffix = ''
    else
        let l:suffix = 's'
    endif

    exec 'bw ' . join(l:matchList, ' ')

    echo 'Wiped ' . l:count . ' buffer' . l:suffix . '.'
endfunction

function! Ciao(lines)
  open
  echom "ecco gli argomenti"
  echom a:lines
endfunction

command! -nargs=1 BW call WipeMatchingBuffers('<args>')
command! -nargs=1 BNW call WipeNonMatchingBuffers('<args>')
command -nargs=1 Ciao :call Ciao(<q-args>)
command Break let @*="b --file ". expand('%') ." --line ". line('.')
"
" mappings
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

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
nnoremap ;p :cn<cr>
nnoremap ;n :cp<cr>
nnoremap <leader>m :Make<cr>
nnoremap gh gT
nnoremap gl gt

nnoremap ,b :Break<cr>
tnoremap <leader><Esc> <c-\><c-n>

autocmd FileType swift nnoremap <leader>sf :w<cr>:!swiftformat --swiftversion 5 %<cr>:e<cr>


filetype plugin indent on
