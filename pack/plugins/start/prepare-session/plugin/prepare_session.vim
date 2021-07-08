let current_branch = trim(system('git branch --show-current'))
let current_git_dir = trim(system('git rev-parse --show-toplevel'))
let g:session_name = current_git_dir . current_branch
let g:session_name = substitute(g:session_name, '/', '_', 'g')
let g:session_name = '/Users/antonioepifani/.vim/sessions/' . g:session_name

function! g:prepare_session#Prepare()
	let l:is_git_dir = system('git rev-parse --is-inside-work-tree')	
	if is_git_dir =~ 'true'

		if filereadable(expand(g:session_name))
			echom 'sourcing session'
			execute 'source' g:session_name
		else
			echom 'creating session'
			execute 'mksession' g:session_name
		endif
		command Mks :mksession! g:session_name
	endif
endfunction

echo g:session_name
nnoremap <leader>ps :call g:prepare_session#Prepare()<cr>
exec 'nnoremap <leader>ss :mks!' . g:session_name . '<cr>'


