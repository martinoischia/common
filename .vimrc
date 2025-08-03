vim9script
# Recommended plugins:
# 	linediff
# 	tabulous
# 	fugitive
# 	gundo (need with-python compilation) -> p for preview diff with current
# 	cmdlinecomplete
# 	surround
# 	? for C, C++ clang_complete, for python jedi_vim


# Current language: "LC_CTYPE=en_US.UTF-8;LC_NUMERIC=C;LC_TIME=it_IT.UTF-8;LC_COLLATE=en_US.UTF-8;LC_MONETARY=it_IT.UTF-8;LC_MESSAGES=en_US.UTF-8;LC_PAPER=it_IT.UTF-8;LC_NAME=en_US.UTF-8;LC_ADDRESS=en_US.UTF-8;LC_TELEPHONE=en_US.UTF-8;LC_MEASUREMENT=it_IT.UTF-8;LC_IDENTIFICATION=en_US.UTF-8"

set textwidth=79
if has("win32")
	set shell=\"C:\Program\ Files\Git\bin\sh.exe\"
	set isfname-=:
	autocmd GUIEnter * call test_mswin_event('set_keycode_trans_strategy', { 'strategy': 'experimental'})
endif

if has('eval')
	augroup whitespace
		autocmd!
		autocmd BufWritePre * :%s/\s\+$//e
	augroup END
endif

# Disable completing keywords in included files (e.g., #include in C).  When
# configured properly, this can result in the slow, recursive scanning of
# hundreds of files of dubious relevance.
set complete-=i
set spelllang=it

set sidescroll=1
set sidescrolloff=1

if (argc() == 0)
	silent edit ~/
endif

set laststatus=2
set statusline=[%n]%<%f\ %h%m%r%y%=%-14.(%l,%c%)\ %P
if v:vim_did_enter && has('eval') && &rtp =~ 'vim-fugitive'
	set statusline=[%n]%<%f\ %h%m%r%y%{FugitiveStatusline()}%=%-14.(%l,%c%)\ %P
endif

# # statusline affects scroll?
# set scroll=5
# autocmd WinResized * set scroll=5
# autocmd VimResized * set scroll=5

if has('eval')
	def g:SetGGrep()
		if  !empty(g:FugitiveExtractGitDir(getcwd()))
			set grepprg=git\ grep\ -n
		else
			set grepprg&
		endif
	enddef
	def Check_git_plugin()
		if &rtp =~ 'vim-fugitive'
			set statusline=[%n]%<%f\ %h%m%r%y%{FugitiveStatusline()}%=%-14.(%l,%c%)\ %P
			call g:SetGGrep()
			augroup grepping
				autocmd!
				autocmd DirChanged * call g:SetGGrep()
			augroup END
		endif
	enddef
	# To postepone the thing after plugins have loaded - I suppose
	autocmd VimEnter * call Check_git_plugin()


	def SaveToTemp(suffix: string = '')
		var tmpfile: string
		if suffix == ''
			tmpfile = system('mktemp')
		else
			tmpfile = system('mktemp --suffix .' .. suffix)
		endif
		tmpfile = substitute(tmpfile, "\n", '', '') # Remove trailing newline

		execute 'edit ' .. fnameescape(tmpfile)
	enddef


	command! -nargs=? MTemporary call SaveToTemp(<f-args>)
	command! -nargs=? Mtemporary call SaveToTemp(<f-args>)
	command! -nargs=? MkTemporary call SaveToTemp(<f-args>)
	command! -nargs=? MKTemporary call SaveToTemp(<f-args>)
endif

set nonumber
set ignorecase
set smartcase
set hlsearch
set incsearch
set history=1000

set so=5 # scrolloff
set nowrap
set nowrapscan

set smartindent
set autoindent
set shiftwidth=4
set tabstop=4
set shortmess-=S

if has('eval')
	silent! packadd! comment
	silent! packadd! matchit
endif
filetype plugin indent on
if has('syntax')
	syntax on
endif
if has('wildmenu')
  set wildmenu
  set wildoptions=pum
endif
set conceallevel=3

if has("win32")
	set guifont=Roboto_Mono:h14:cANSI:qDRAFT
else
	set guifont=Roboto\ Mono\ 14
endif
set guioptions-=m # normal alt menu
set guioptions-=T # toolbar like save button
set guioptions-=L # vertical split scrollbar left
set guioptions-=r # vertical scrollbar right
set mousemodel=popup

# using legacy function, just coz let-& seems not supported in vim9
if has('eval')
	function! g:ToggleCursor()
		const default = 'n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175'
		"
		" white_except_insert
		" const modified = 'n-v-c:Normal,ve:ver35-Normal,o:hor50-Normal,i-ci:ver25-block-Cursor,r-cr:hor20-Normal,sm:Normal-blinkwait175-blinkoff0-blinkon175'
		"
		" visual (grey)
		const modified = 'n-v-c:Visual,ve:ver35-Visual,o:hor50-Visual,i-ci:ver25-block-Cursor,r-cr:hor20-Visual,sm:Visual,a:blinkon0'

		if (&guicursor == default)
			let &guicursor = modified
			set so=999
		else
			set guicursor&
			set so=5
		endif
	endfunction
endif

set shiftround # just when type >> when you already have 2 spaces it just adds 2
set path+=src/**,lib/**
set backspace=indent,eol,start
set splitright
set splitbelow
set formatoptions+=j

if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit %% | :0d _ | diffthis
		  \ | wincmd p | diffthis
endif

nnoremap <Left> <Cmd>cprevious<CR>
nnoremap <Right> <Cmd>cnext<CR>
noremap <S-Tab> <C-I>
noremap <Tab> <C-O>
noremap <BS> <C-6>
noremap <S-BS> <C-6>
nnoremap Y y$
noremap H K
noremap K <C-]>
nnoremap L <C-T>

noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

noremap <Leader>t <Cmd>colorscheme torte<CR>
noremap <Leader>e <Cmd>colorscheme evening<CR>
noremap <Leader>s <Cmd>colorscheme slate<CR>
noremap <Leader>l <Cmd>set background=dark <Bar> colorscheme lunaperche<CR>
noremap <Leader>d <Cmd>colorscheme default<CR>

############################################################################
# these might look weird but they are in synthony with how I have reprogrammed
# my Glove80 keyboard (try look for "Setup for Vim with ext num keypad" by
# mischia on their website)
# Unfortunately, most of this stuff does not work from terminal vim.

augroup quickfix_binding
  def If_qf()
	  if (&buftype == 'quickfix')
		  noremap <buffer> <Enter> <Enter>
  	  endif
  enddef
  autocmd!
  autocmd BufWinEnter * If_qf()
augroup END

noremap <Enter> 5j
noremap <C-D> 5j
noremap <C-F> 5k
noremap <Space> 5k
noremap <S-Enter> <PageDown>
noremap <S-Space> <PageUp>
noremap <C-S-F> <PageUp>
noremap <C-S-D> <PageDown>
inoremap <C-V> <C-X><C-O>
if has("unix") #to debug on win
	noremap <c-s-r> <Cmd>call ToggleCursor()<CR>
endif
noremap <c-s-h> <Cmd>noh<CR>
noremap <c-a-f> <Cmd>vert split<CR>
# mm see pattern below
noremap <c-s-a-f> <Cmd>vert split %:h<CR>
noremap  <c-s-e> :find<Space>*
inoremap <c-s-e> <Esc>:find<Space>*
cnoremap <c-s-e> <Esc>:find<Space>*
noremap  <c-e> :buffer<Space>
inoremap <c-e> <Esc>:buffer<Space>
cnoremap <c-e> <Esc>:buffer<Space>
noremap <a-f> gf
noremap <a-s-f> gF
inoremap <c-s-y> <C-x><C-u>
inoremap <c-a-;> <Cmd>write<CR>
noremap <c-a-;> <Cmd>write<CR>
inoremap <c-s-i> <Cmd>tabnext<CR>
noremap <c-s-i> <Cmd>tabnext<CR>
inoremap <c-s-u> <Cmd>tabprevious<CR>
noremap <c-s-u> <Cmd>tabprevious<CR>

# const pattern = '\m\([/*|=>]$|@\s+.*\)'
noremap <c-a-b> <Cmd>silent edit %:h <Bar> call search('^\V' .. expand("#:t") .. '\m\($\\|[/*\|=>]$\\|@\s+\)')<CR>
# symbolic links end in @  ---> ...

noremap <c-s-a-b> <Cmd>silent edit .<CR>

# clipboard.. you probably should reread in the doc of win32 says something about ctrlc ctrl v
# primary
noremap <c-p> "*p
vnoremap <c-c> "+y

noremap <c-n> "+p
############################################################################

augroup term
	autocmd!
	autocmd TerminalWinOpen * setlocal bufhidden=hide
augroup END

tnoremap <Esc> <C-w>N
tnoremap <C-PageUp> <cmd>tabprevious<CR>
tnoremap <C-PageDown> <cmd>tabnext<CR>

#inoremap <c-w><c-w> <esc><c-w><c-w>gi
#inoremap <c-w>j <esc><c-w>jgi
#inoremap <c-w>k <esc><c-w>kgi
#inoremap <c-w>h <esc><c-w>hgi
#inoremap <c-w>l <esc><c-w>lgi

inoremap <c-z> <esc><c-z>

# Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
# remove this?
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

if has("win32")
	command! TerCur term ++curwin
	command! TermCur term ++curwin
	command! TerminalCur term ++curwin
endif

augroup exrc # fuck 'exrc'
	autocmd!
	autocmd DirChanged * if filereadable(".vimrc") | source .vimrc | endif
	autocmd DirChanged global if filereadable(".vimrc") | source .vimrc | endif
	autocmd DirChanged tabpage if filereadable(".vimrc") | source .vimrc | endif
	autocmd DirChanged window if filereadable(".vimrc") | source .vimrc | endif
augroup END

# In TUI Vim, <C-S-letter> is indistinguishable from <C-letter>. You should change them to more portable combos.
# nnoremap <C-j> <C-w>p<C-e><C-w>p
# nnoremap <C-k> <C-w>p<C-y><C-w>p
# inoremap <C-j> <Esc><C-w>p<C-e><C-w>pi
# inoremap <C-k> <Esc><C-w>p<C-y><C-w>pi
# tnoremap <C-j> <Esc><C-w>p<C-e><C-w>pi
# tnoremap <C-k> <Esc><C-w>p<C-y><C-w>pi

# Ignore warning of GCC in quickfix list
set errorformat^=%-G%f:%l:\ warning:%m

set diffopt+=vertical,hiddenoff

# Auto close brackets
# most usable
#inoremap ( ()<left>
#inoremap [ []<left>
#inoremap { {}<left>

#inoremap " ""<left>
#inoremap ' ''<left>
#inoremap {<CR> {<CR>}<ESC>O
#inoremap {;<CR> {<CR>};<ESC>O
#0 zero vs O0o (nel terminale non si vede bene in poche parole)

set gdefault

# Conveniency

# zz is easier to type
nnoremap <Up> <c-y>
nnoremap <Down> <c-e>
nnoremap zt zz
nnoremap zz zt
cabbrev cw bo cw
command! Vs vert split
command! W write
command! Wa wall
command! WA wall
command! Wq wq
command! WQ wq
command! -bang Q quit<bang>
command! -bang Qa qall<bang>
command! -bang QA qall<bang>
nnoremap <C-w>a <Cmd>qall<CR>

if has("unix")
	noremap <D-r> <Cmd>terminal<CR>
	noremap <D-t> <Cmd>terminal ++curwin<CR>
endif

# dont like this characters but you could customize this
#   :set list
#   set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
set listchars=  # set listchars& to reset





# ----------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------|||
# -----------------------------------------------------------------------------------------------------------|||||
#                                                                                                            |||||
#                                                                                                            |||||
#                                         PLUGINS                                                            |||||
#                                                                                                            |||||
#                                                                                                            |||||

if has('eval')
	g:netrw_preview   = 1
	#g:netrw_liststyle = 3
	g:netrw_winsize   = 30

	g:netrw_sort_sequence = 'vim_todo,^[^.].*[\/]$,\<core\%(\.\d\+\)\=\>,\.h$,\.c$,\.cpp$,\~\=\*$,*,^\..*[\/]$,^\.,node_modules[\/],\.o$,\.obj$,\.info$,\.bak$,\~$'
	g:netrw_list_hide = '^\./\?$,^\.\./\?$,\.swp$,\.swo$'
	if has("win32")
		g:netrw_localmovecmd = 'C:\Program Files\Git\usr\bin\mv.exe'
		g:netrw_localmovecmdopt = ''
	endif

	# does not work wtf. g:netrw_rmdir_cmd = 'rm -r'                                                             |||||
	#                                                                                                            |||||
	#g:ale_fixers = {'python': ['autopep8']}                                                                     |||||
	#g:ale_linters_ignore = {'python': ['flake8', 'mypy', 'pyright', 'ruff']}                                    |||||
	#g:ale_linters_ignore = {'vim': ['ale_custom_linting_rules', 'vint', 'vimls']}                               |||||
	#g:ale_fix_on_save = 1






	#  autocmd BufWritePost *.py call flake8#Flake8()                            .                               |||||
	#                                                                                                            |||||
	#

	g:gundo_prefer_python3 = 1
	g:gundo_right = 1
	g:gundo_help = 1
	g:gundo_close_on_revert = 1

	#                                                                                                            |||||
	#                                                                                                            |||||
	g:jedi#environment_path = "/home/martino/.venv/"
	# g:jedi#completions_command = "<C-N>"
	g:jedi#goto_command = "<leader><leader>"
	g:jedi#popup_on_dot = 0

	g:jedi#auto_vim_configuration = 0
	set completeopt-=preview
	set completeopt+=popup
	set completeopt-=menu
	set completeopt+=menuone

	#                                                                                                            |||||
	#                                                                                                            |||||
	g:surround_42 = "/* \r */"  # multiline comment not supported in vim comment package
	# this makes * after S become /* */
	#                                                                                                            |||||
	#                                                                                                            |||||
	#                                                                                                            |||||
	#                                                                                                            |||||


	g:clang_auto_select = 2 # insert the entry automatically
	g:clang_complete_auto = 0 # on ., ->...
	g:clang_library_path = '/usr/lib/llvm-19/lib/libclang-19.so.19'
	g:clang_jumpto_declaration_key = "<C-N>"

endif

#                                                                                                            |||||
#                                                                                                            |||||
#                                            END                                                             |||||
#
#
#
#
#
#
#                                       Debug plugins?
#
# breakadd file 1 /usr/local/share/vim/vim91/plugin/manpager.vim
# set verbose=2  # this tells me which files are sourced to get some idiotic command
#
