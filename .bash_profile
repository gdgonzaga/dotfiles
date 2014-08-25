export PATH="$HOME/bin:$HOME/bin-local:$PATH:/usr/local/bin:/home/gerry/.nvm/v0.10.30/bin:/home/gerry/.gem/ruby/1.9.1/bin"

export EDITOR="vim"
export BROWSER="firefox"
#export BROWSER="dwb"
export TMPDIR="/home/gerry/tmp"
export HISTIGNORE="&:ls:[bf]g:exit"

#remind -z -k'mail -s REMIND\ %s gerry </dev/null' ~/.reminders

#[[ -n $(pgrep remind) ]] && remind -z -k'mail -s REMIND\ -\ %s gerry </dev/null' ~/.reminders &

# run gpg-agent
#[ -z "$(pgrep gpg-agent)" ] && eval $(gpg-agent --daemon)

#( tmux-status-helpers.sh > /dev/null &> /dev/null )&
#eval $(keychain --eval --timeout 30 -q id_rsa)

#SSH_AGENT_CACHE=$TMPDIR/SSH_AGENT_CACHE
### Start ssh-aent if it isn't alredy running
#[ -z $(pgrep ssh-agent | grep $(cat "$SSH_AGENT_CACHE") 2>/dev/null) ] &&
    #echo "$(pgrep ssh-agent)" &&
    #eval $(ssh-agent -t 30m) &&
    #echo "$SSH_AGENT_PID" > "$SSH_AGENT_CACHE" &&
    #ssh-add ~/.ssh/id_rsa

## Start gpg-agent if it isn't already running
#envfile="${HOME}/.gnupg/gpg-agent.env"
#if test -f "$envfile" && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
    #eval "$(cat "$envfile")"
#else
    #eval "$(gpg-agent --daemon --write-env-file "$envfile")"
    #export GPG_AGENT_INFO  # the env file does not contain the export statement
#fi


. $HOME/.bashrc

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="/home/gerry/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" &> /dev/null # This loads nvm
