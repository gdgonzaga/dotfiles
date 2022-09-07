# Check for an interactive session
[ -z "$PS1" ] && return

#_PS1='\[\033[38;5;185m\]\w \n\[\033[38;5;100m\]\$ \[\033[38;5;248m\]\[\033[0m\]'
_PS1='\[\033[38;5;192m\]\u@\H \[\033[38;5;185m\]\w \n\[\033[38;5;100m\]\$ \[\033[38;5;248m\]\[\033[0m\]'
#RET_SUCC="\[\033[0;32m\]:)"
#RET_FAIL="\[\033[0;31m\]\342\234\227"
RET_FAIL="\[\033[0;31m\]"

PROMPT_COMMAND='
   RET=$?
   [[ -n "$VIRTUAL_ENV" ]] && VENV="(${VIRTUAL_ENV##*/}) virtualenv "
   [[ -n "$CONDA_PROMPT_MODIFIER" ]] && VENV="$CONDA_PROMPT_MODIFIER conda "

   [[ -z "$CONDA_PROMPT_MODIFIER" && -z "$VIRTUAL_ENV" ]] && VENV=""

   if [[ $RET -eq 0 ]]
       then export PS1="$VENV${_PS1}"
       else export PS1="$VENV${RET_FAIL}$RET ${_PS1}"
   fi'

export _JAVA_AWT_WM_NONREPARENTING=1
export GPG_TTY=$(tty)

# Disable XOFF
stty -ixon

## tmux
[ -n "$TMUX" ] && export TERM=screen-256color

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

HISTIGNORE="$HISTIGNORE:jrnl *"

source ~/.bash_aliases
