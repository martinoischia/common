setl formatprg=dart\ format
" augroup formatonSave
" 	autocmd!
" 	autocmd! BufWritePost *.dart {
" 		setl autoread
" 		!dart format %
" 		set autoread<
" 	}
" augroup END
