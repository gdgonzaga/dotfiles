#!/bin/bash
trim () { echo $1; }

if [[ -z "$1" ]]; then
    echo "Specify session name"
    exit
fi

if [[ "$1" == "ls" ]]; then
    tmux ls
    exit
fi

base_session="$1"
tmux_nb=$(trim `tmux ls | grep "^$base_session" | wc -l`)

if [[ "$tmux_nb" == "0" ]]; then
    echo "Launching tmux base session $base_session ..."
    tmux new-session -s base_session
else

    if [[ -z "$TMUX" ]]; then
        old_sessions=$(tmux ls 2>/dev/null | egrep "^[0-9]{14}.*[0-9]+\)$" | cut -f 1 -d:)

        for old_session_id in $old_sessions; do
            tmux kill-session -t $old_session_id
        done

        echo "Launching copy of base session $base_session ..."
        session_id=`date +%Y%m%d%H%M%S`
        tmux new-session -d -t $base_session -s $session_id
        tmux attach-session -t $session_id
        tmux kill-session -t $session_id
    fi
fi
