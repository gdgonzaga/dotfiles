# Check for an interactive session
[ -z "$PS1" ] && return

#_PS1='\[\033[38;5;185m\]\w \n\[\033[38;5;100m\]\$ \[\033[38;5;248m\]\[\033[0m\]'
_PS1='\[\033[38;5;192m\]\u@\H \[\033[38;5;185m\]\w \n\[\033[38;5;100m\]\$ \[\033[38;5;248m\]\[\033[0m\]'
#RET_SUCC="\[\033[0;32m\]:)"
#RET_FAIL="\[\033[0;31m\]\342\234\227"
RET_FAIL="\[\033[0;31m\]"
PROMPT_COMMAND='RET=$?; if [[ $RET -eq 0 ]]; then export PS1="${_PS1}"; else export PS1="${RET_FAIL}$RET ${_PS1}"; fi'

export _JAVA_AWT_WM_NONREPARENTING=1
export GPG_TTY=$(tty)

# gpg-agent
[ -z "$(pidof gpg-agent)" ] && \
    gpg-agent --daemon  --enable-ssh-support \
                  --write-env-file "${HOME}/.gpg-agent-info"

 if [ -f "${HOME}/.gpg-agent-info" ]; 
 then
   . "${HOME}/.gpg-agent-info"
   export GPG_AGENT_INFO
   export SSH_AUTH_SOCK
 fi

## tmux
[ -n "$TMUX" ] && export TERM=screen-256color

# prevent wine from creating file associations
# export WINEDLLOVERRIDES='winemenubuilder.exe=d'

# aliases
alias tmux='TERM=xterm-256color tmux'
alias pacman='sudo pacman'
alias emacs='emacs -nw'
alias ls='ls --color=auto'
alias lssd='ls /dev | grep sd'
alias ll='ls -lh'
alias lt='ls -lth'
alias lr='ls -ltrh'
alias wicd-curses='wicd-curses; clear'
alias winep='WINEPREFIX=/media/store/winep '

alias vr='vim --servername gg --remote'
#alias vrs='vim --servername gg'
alias vnotes='cd ~/Documents/notes; vim +NERDTree; cd ~'

alias def='SDCV_PAGER=less  sdcv'

alias remouse-wireless="xinput set-prop 'pointer:2.4GHz 2way RF Receiver' 'Device Accel Constant Deceleration' 1.5"
alias evecfg="WINEPREFIX=/media/store/opt/eve winecfg"
alias everepair="WINEPREFIX=/media/store/opt/eve wine /media/store/opt/eve/drive_c/Program\ Files\ \(x86\)/CCP/EVE/repair.exe"

alias mnt-dotfiles="encfs ~/seafile/encfs-dotfiles ~/mnt/encfs-dotfiles"
alias mnt-store="encfs ~/seafile/encfs-store ~/mnt/encfs-store"
alias mnt-ccda="encfs /media/store/arc/ccda /home/gerry/mnt/ccda"
alias mnt-gim="sshfs gdgon.com:/ /media/remote/gim"

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

function ixp {
    curl -n -F 'f:1=<-' http://ix.io
}

function ixg {
    curl "http://ix.io/$@"
}

# C-s fix
stty ixany

#set -o vi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
