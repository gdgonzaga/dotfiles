# Check for an interactive session
[ -z "$PS1" ] && return

_PS1='\[\033[38;5;185m\]\w \n\[\033[38;5;100m\]\$ \[\033[38;5;248m\]\[\033[0m\]'
RET_SUCC="\[\033[0;32m\]\342\234\223"
#RET_FAIL="\[\033[0;31m\]\342\234\227"
RET_FAIL="\[\033[0;31m\]"
PROMPT_COMMAND='RET=$?; if [[ $RET -eq 0 ]]; then export PS1="${RET_SUCC} ${_PS1}"; else export PS1="${RET_FAIL}$RET ${_PS1}"; fi'

export GPG_TTY=$(tty)

## gpg-agent
#[ -z "$(pidof gpg-agent)" ] && \
    #gpg-agent --daemon  --enable-ssh-support \
                  #--write-env-file "${HOME}/.gpg-agent-info"

 #if [ -f "${HOME}/.gpg-agent-info" ]; 
 #then
   #. "${HOME}/.gpg-agent-info"
   #export GPG_AGENT_INFO
   #export SSH_AUTH_SOCK
 #fi

# tmux
[ -n "$TMUX" ] && export TERM=screen-256color

#keychain --eval id_rsa 0FA7A876

# aliases
#alias kc='eval $(keychain --eval --agents ssh,gpg --timeout 30 -Q --quiet id_rsa)'
alias pacman='sudo pacman'
alias emacs='emacs -nw'
alias ls='ls --color=auto'
alias lssd='ls /dev | grep sd'
alias ll='ls -lh'
alias lt='ls -lth'
alias lr='ls -ltrh'
alias wicd-curses='wicd-curses; clear'
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'

alias vr='vim --servername gg --remote-tab'
alias vre='vim --servername gg --remote'
alias vrs='vim --servername gg'

function def { sdcv "$@" | less; }

function man {
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

# Source secure

. ~/secure/bashrc

# C-s fix
stty ixany

#set -o vi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
