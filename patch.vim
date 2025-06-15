diff --git a/runtime/colors/torte.vim b/runtime/colors/torte.vim
index 752610902..763d691da 100644
--- a/runtime/colors/torte.vim
+++ b/runtime/colors/torte.vim
@@ -50,12 +50,12 @@ hi SignColumn guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
 hi FoldColumn guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
 hi ColorColumn guifg=#cccccc guibg=#8b0000 gui=NONE cterm=NONE
 hi Conceal guifg=#666666 guibg=NONE gui=NONE cterm=NONE
-hi Cursor guifg=#000000 guibg=#00ff00 gui=bold cterm=NONE
+hi Cursor guifg=#000000 guibg=#cccccc gui=bold cterm=NONE
 hi lCursor guifg=#000000 guibg=#e5e5e5 gui=NONE cterm=NONE
 hi CursorIM guifg=NONE guibg=fg gui=NONE cterm=NONE
 hi Title guifg=#ff00ff guibg=NONE gui=bold cterm=bold
 hi Directory guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
-hi Search guifg=#ff0000 guibg=#000000 gui=reverse cterm=reverse
+hi Search guifg=DarkMagenta guibg=#000000 gui=reverse cterm=reverse
 hi IncSearch guifg=#00cd00 guibg=#000000 gui=reverse cterm=reverse
 hi NonText guifg=#0000ff guibg=NONE gui=bold cterm=NONE
 hi EndOfBuffer guifg=#0000ff guibg=NONE gui=bold cterm=NONE
@@ -74,8 +74,8 @@ hi SpellBad guifg=#ff0000 guibg=NONE guisp=#ff0000 gui=undercurl cterm=underline
 hi SpellCap guifg=#5c5cff guibg=NONE guisp=#5c5cff gui=undercurl cterm=underline
 hi SpellLocal guifg=#ff00ff guibg=NONE guisp=#ff00ff gui=undercurl cterm=underline
 hi SpellRare guifg=#00ffff guibg=NONE guisp=#00ffff gui=undercurl cterm=underline
-hi StatusLine guifg=#ffffff guibg=#0000ee gui=bold cterm=bold
-hi StatusLineNC guifg=#000000 guibg=#e5e5e5 gui=NONE cterm=NONE
+hi StatusLine guifg=#000000 guibg=#cccccc gui=bold cterm=bold
+hi StatusLineNC guifg=#000000 guibg=#cccccc gui=bold cterm=bold
 hi VertSplit guifg=#000000 guibg=#e5e5e5 gui=NONE cterm=NONE
 hi TabLine guifg=#ffffff guibg=#7f7f7f gui=NONE cterm=NONE
 hi TabLineFill guifg=NONE guibg=#000000 gui=reverse cterm=reverse
diff --git a/src/Makefile b/src/Makefile
index cde2e5581..817c44326 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -440,7 +440,7 @@ CClink = $(CC)
 #CONF_OPT_PYTHON = --enable-pythoninterp=dynamic
 #CONF_OPT_PYTHON3 = --enable-python3interp
 #CONF_OPT_PYTHON3 = --enable-python3interp --with-python3-command=python3.6
-#CONF_OPT_PYTHON3 = --enable-python3interp=dynamic
+CONF_OPT_PYTHON3 = --enable-python3interp=dynamic
 
 # RUBY
 # Uncomment this when you want to include the Ruby interface.
