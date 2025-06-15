# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

__git_ps1_venv() {
  # Some local storage to not clutter the environment
  local pre=$1
  local post=$2

  # Let's only check for a virtual environment if the VIRTUAL_ENV variable is
  # set. This should eek out a little more performance when we're not in one
  # since we won't need to call basename.
  if [ -n "${VIRTUAL_ENV}" ] && [ -z "${VIRTUAL_ENV_DISABLE_PROMPT:-}" ]; then

    # There's no need to set _OLD_VIRTUAL_PS1 since it's used to replace PS1 on
    # a deactivate call. And since we're using PROMPT_COMMAND, PS1 isn't used.
    #
    #_OLD_VIRTUAL_PS1="${pre:-}"

    # The python venv module hard-codes the name of the virtual environment into
    # the activate script for my configuration, so we need to pull it out of
    # VIRTUAL_ENV to have an appropriate prefix. If we're doing that, might has
    # well comment out the hard-coded part and rely on the else in the
    # if-statement that follows it.
    #
    #if [ "x(env) " != x ] ; then
    #  PS1="(env) ${PS1:-}"
    #else

    # This is the else of the if-statement with PS1 replaced with pre.
    # Otherwise, no changes.
    if [ "`basename \"${VIRTUAL_ENV}\"`" = "__" ] ; then
      # special case for Aspen magic directories
      # see http://www.zetadev.com/software/aspen/
      pre="\e[31m[`basename \`dirname \"${VIRTUAL_ENV}\"\``]\e[0m ${pre}"
    else
      pre="\e[31m(`basename \"${VIRTUAL_ENV}\"`)\e[0m ${pre}"
    fi
  fi

  # Call the actual __git_ps1 function with the modified arguments
  __git_ps1 "${pre}" "${post}"
}

PS1='\u:\w'

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND='__git_ps1_venv "${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\t\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]" "\$ "'
else
    PROMPT_COMMAND='__git_ps1_venv "${debian_chroot:+($debian_chroot)}\t:\w" "\$ "'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PROMPT_COMMAND="${PROMPT_COMMAND:0:16}\[\e]0;\u: \w\a\]${PROMPT_COMMAND:16}"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias gits='git status'
alias short='less -X'
alias ggrep='git grep'
alias cc='cd -P ~/current'
alias cc1='cd -P ~/current1'
alias cc2='cd -P ~/current2'
alias vi='view'
alias py='python3'
alias pyh='python3 -m pydoc'
alias simil='text_similarity.pl --type Text::Similarity::Overlaps'
ff(){ find -iname \*$1\* ; } # find fuzzy
fF(){ find -name \*$1\* ; } # find fuzzy
PROMPT_DIRTRIM=2
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_HIDE_IF_PWD_IGNORED=1
GIT_PS1_STATESEPARATOR=''
GIT_PS1_SHOWUPSTREAM="auto git"

export EDITOR=vim

# nodejs
export PATH="/usr/local/lib/nodejs/node-v20.11.1-linux-x64/bin:$PATH"
export DENO_INSTALL="/home/martino/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

#='__git_ps1 "\u:\w" "\\\$ "'

# export LC_COLLATE=C # I prefer sorting based also on spaces, but I'll just use vim built-in
shopt -s globstar
export LESS='-S -i -R -F -m'
export MANLESS='\$MAN_PN\ ?ltline\ %lt?L/%L..?e\ (END):?pB\ %pB\%..$ +Gg'

# if you wish, this couple of letters fix should be pushed to man man
#export MANPAGER='less +Gg'
