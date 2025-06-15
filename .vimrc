vim9script
# Recommended plugins:
# 	linediff
# 	tabulous
# 	fugitive
# 	gundo (need with-python compilation) -> p for preview diff with current
# 	cmdlinecomplete
# 	surround
# 	? for C, C++ clang_complete, for python jedi_vim

set textwidth=79
if has("win32")
	set shell=\"C:\Program\ Files\Git\bin\sh.exe\"
	set isfname-=:
endif

if has('eval')
	# always remove trailing whitespace at file write (questionable, maybe)
	def RemoveWhiteSpaceIf()
		if !exists('g:IWantWhiteSpace')
			:%s/\s\+$//e
		endif
	enddef
	autocmd BufWritePre * RemoveWhiteSpaceIf()
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
# # statusline affects scroll?
# set scroll=5
# autocmd WinResized * set scroll=5
# autocmd VimResized * set scroll=5

if has('eval')
	def Check_git_plugin()
		if &rtp =~ 'vim-fugitive'
			set statusline=[%n]%<%f\ %h%m%r%y%{FugitiveStatusline()}%=%-14.(%l,%c%)\ %P

			def g:SetGGrep()
				if  !empty(g:FugitiveExtractGitDir(getcwd()))
					set grepprg=git\ grep\ -n
				else
					set grepprg&
				endif
			enddef

			call g:SetGGrep()
			autocmd DirChanged * call g:SetGGrep()
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


	command -nargs=? MTemporary call SaveToTemp(<f-args>)
	command -nargs=? Mtemporary call SaveToTemp(<f-args>)
	command -nargs=? MkTemporary call SaveToTemp(<f-args>)
	command -nargs=? MKTemporary call SaveToTemp(<f-args>)
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
set shiftwidth=4
set tabstop=4
set shortmess-=S

if has('eval')
	packadd! comment
	packadd! matchit
endif
filetype plugin indent on
if has('syntax')
	syntax on
endif
if has('wildmenu')
  set wildmenu
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
	function g:ToggleCursor()
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
setlocal path=.,,
set backspace=indent,eol,start
set splitright
set splitbelow
set formatoptions+=j

if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit %% | :0d _ | diffthis
		  \ | wincmd p | diffthis
endif

noremap <S-Tab> <C-I>
noremap <Tab> <C-O>
noremap <BS> <C-6>
noremap <S-BS> <C-6>
noremap Y y$
noremap H K
noremap K <C-]>
noremap L <C-T>
# this is one are more because how I have setup my glove80
noremap <Enter> 5j
noremap <C-D> 5j
noremap <C-F> 5k
noremap <S-Enter> <PageDown>
noremap <C-S-F> <PageUp>
noremap <C-S-D> <PageDown>
inoremap <C-V> <C-X><C-O>
inoremap <C-N> <C-P>
inoremap <C-P> <C-N>
# zz is easier to type
noremap zt zz
noremap zz zt
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
# Unfortunately, none of this stuff works from terminal vim.

if has("unix") #to debug on win
	noremap <c-s-r> <Cmd>call ToggleCursor()<CR>
endif
noremap <c-s-h> <Cmd>noh<CR>
noremap <c-a-f> <Cmd>enew<CR>
noremap <c-s-a-f> <Cmd>vnew<CR>
inoremap <c-s-y> <C-x><C-u>

# const pattern = '\m\([/*|=>]$|@\s+.*\)'
noremap <c-a-b> <Cmd>silent edit %:h <Bar> call search('^\V' .. expand("#:t") .. '\m\($\\|[/*\|=>]$\\|@\s+\)')<CR>
# symbolic links end in @  ---> ...

noremap <c-s-a-b> <Cmd>silent edit .<CR>
noremap <c-s-a> <C-w><
noremap <c-s-s> <C-w>>
# noremap <c-s-f> <C-w>+
# noremap <c-s-d> <C-w>-

# primary
noremap <c-a-p> "*p
inoremap <c-a-p> <Esc>"*pa
# clipboard
if has("win32")
	vnoremap <c-C> "+y
	noremap <c-a-t> "+p
endif
noremap <c-a-l> "+p
inoremap <c-a-l> <Esc>"+pa
############################################################################

au TerminalWinOpen * setlocal bufhidden=hide

tnoremap <Esc> <C-w>N

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
	command TerCur term ++curwin
	command TermCur term ++curwin
	command TerminalCur term ++curwin
endif
set exrc # excecute vimrc in current directory

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

command Vs vert split
command W write
command Wa wall
command WA wall
command Wq wq
command WQ wq
command -bang Q quit<bang>
command -bang Qa qall<bang>
command -bang QA qall<bang>
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

	g:netrw_sort_sequence = 'vim_todo,^[^.].*[\/]$,\<core\%(\.\d\+\)\=\>,\.h$,\.c$,\.cpp$,\~\=\*$,*,^\..*[\/]$,^\.,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$'
	g:netrw_list_hide = '^\./\?$,^\.\./\?$'
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
