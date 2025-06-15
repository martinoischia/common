# Vim source: to update should suffice:
# - sudo make uninstall
# - make distclean
# - ./configure --with-features=huge --enable-gui=auto --enable-python3interp=dynamic --prefix=/usr/local
# - make
# - sudo make install
git clone git@github.com:sjl/gundo.vim.git                ./pack/gundo/start/gundo
git clone https://github.com/xavierd/clang_complete.git   ./pack/completion/start/clang_complete
git clone git@github.com:vim-scripts/CmdlineComplete.git  ./pack/cmdlinecomplete/start/cmdlinecomplete
git clone https://github.com/webdevel/tabulous.git        ./pack/tabulous/start/tabulous
git clone https://github.com/tpope/vim-fugitive.git       ./pack/tpope/start/vim-fugitive
git clone git@github.com:AndrewRadev/linediff.vim.git     ./pack/linediff/start/linediff
git clone https://tpope.io/vim/surround.git               ./pack/tpope/start/surround
git clone https://github.com/davidhalter/jedi-vim.git     ./pack/jedi-vim/start/jedi-vim
vim -u NONE -c "helptags ./pack/gundo/start/gundo/doc" -c q
vim -u NONE -c "helptags ./pack/completion/start/clang_complete/doc" -c q
vim -u NONE -c "helptags ./pack/cmdlinecomplete/start/cmdlinecompletefugitive/doc" -c q
vim -u NONE -c "helptags ./pack/tabulous/start/tabulous/doc" -c q
vim -u NONE -c "helptags ./pack/tpope/start/vim-fugitive/doc" -c q
vim -u NONE -c "helptags ./pack/linediff/start/linediff/doc" -c q
vim -u NONE -c "helptags ./pack/tpope/start/surround/doc" -c q
vim -u NONE -c "helptags ./pack/jedi-vim/start/jedi-vim/doc" -c q
