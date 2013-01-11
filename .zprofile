#( tmux-status-helpers.sh > /dev/null &> /dev/null )&

eval $(keychain --eval --timeout 30 -q id_rsa)

#SSH_AGENT_CACHE=$TMPDIR/SSH_AGENT_CACHE
### Start ssh-aent
#if [[ -z $(pgrep ssh-agent | grep $(cat "$SSH_AGENT_CACHE") 2>/dev/null) ]]; then
    #echo "$(pgrep ssh-agent)"
    #eval $(ssh-agent -t 30m)
    #echo "$SSH_AGENT_PID" > "$SSH_AGENT_CACHE"
    #ssh-add ~/.ssh/id_rsa
#fi

## Start gpg-agent
#envfile="${HOME}/.gnupg/gpg-agent.env"
#if test -f "$envfile" && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
    #eval "$(cat "$envfile")"
    #export GPG_AGENT_INFO
#else
    #eval "$(gpg-agent --daemon --write-env-file "$envfile")"
#fi

  ## the env file does not contain the export statementeval $(ssh-agent)

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
