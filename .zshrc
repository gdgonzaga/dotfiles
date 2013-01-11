# Check for an interactive session
[ -z "$PS1" ] && return

## zsh config
autoload -U compinit promptinit
compinit
promptinit

setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt autocd
setopt correctall
setopt extendedglob

zstyle ':completion:*' menu select
setopt completealiases

# set prompt
export _PS1='%{[38;5;185m%}%~
%{[38;5;100m%}%# %{[38;5;248m%} %{[0m%}'
RET_SUCC="%{[0;32m%}✓"
RET_FAIL="%{[0;31m%}✗"
precmd () {
    RET=$?
    if [[ $RET -eq 0 ]]; then
        export PS1="${RET_SUCC} ${_PS1}"
    else
        export PS1="${RET_FAIL} ${_PS1}"
    fi
}
## end zsh config

export GPG_TTY=$(tty)

# tmux
[ -n "$TMUX" ] && export TERM=screen-256color

#keychain --eval id_rsa 0FA7A876

alias pacman='sudo pacman'
alias emacs='emacs -nw'
alias ls='ls --color=auto'
alias lssd='ls /dev | grep sd'
alias ll='ls -lh'
alias lt='ls -lth'
alias lr='ls -ltrh'
alias wicd-curses='wicd-curses; clear'
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

# C-s fix
stty ixany

#set -o vi

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
