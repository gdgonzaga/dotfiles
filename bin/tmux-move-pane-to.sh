#!/bin/bash
# tmux-move-pane-to.sh
#
# Move the current pane to target window by calling
# join-pane:   if dst window has 1 or more panes
# move-window: if src window has 1 pane and
#                 dst window has 0 panes
# break-pane:  if src window has 2 or more panes
#                 dst window has 0 panes
#
#
# Usage:
# tmux-move-pane-to.sh <destination window>

function show_usage {
    echo "Usage: $0 <destination window>"
    exit 1
}

function grep_num_panes {
    n_panes=$(tmux list-windows |
              grep "$@" |
              sed -r 's/.*?([[:digit:]]) panes.*?/\1/')

    [ -n "$n_panes" ] && echo $n_panes || echo 0
}

### Main program starts here

# Check for proper usage
[ -z $@ ] && show_usage

src_n_panes=$(grep_num_panes "*")
dst_n_panes=$(grep_num_panes "^$1")

if [ $dst_n_panes -ge 1 ]; then
    tmux join-pane -t $1

elif [[ $src_n_panes -eq 1  && $dst_n_panes -eq 0 ]]; then
    tmux move-window -t $1

elif [[ $src_n_panes -ge 2 && $dst_n_panes -eq 0 ]]; then
    tmux break-pane
    tmux move-window -t $1
    tmux rename-window ""
fi
