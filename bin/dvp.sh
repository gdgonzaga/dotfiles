#!/bin/bash
# Depends on:
#   dmenu, compton, xorg-xwininfo

DMENU_FONT="-*-dina-medium-r-normal-*-*-*-*-*-*-*-*-*"
DMENU_LIST_ITEMS=20
DMENU_OPACITY=90
TRANSPARENT_SLEEP_DELAY=0.1
BOOKMARK_FILE="/home/gerry/.config/vimprobable/bookmarks"
TABDIR="$HOME/tmp/tabbed"

function transparent {
    sleep $TRANSPARENT_SLEEP_DELAY
    compton-trans -w $(xwininfo -root -children | grep "has no name" | head -1 | cut -d' ' -f6) $DMENU_OPACITY
}

# Usage:
# dmenu_query <prompt> <options>
function dmenu_query {
  PROMPT="$1"
  OPTIONS="$2"
  transparent &
  ANSWER="$(echo -e "$OPTIONS" |
            dmenu -fn $DMENU_FONT -i -l $DMENU_LIST_ITEMS -p "$PROMPT")"

  [ -z "$ANSWER" ] && exit 2 && echo "Nothing selected"

  echo "$ANSWER"
}

function get_bookmark_titles {
  cat "$BOOKMARK_FILE" | sed -r 's/[^ ]* //'
}

function get_bookmark_url {
  # Escape open brackets for grep
  QUERY="$(echo "$1" | sed 's/\[/\\[/')"
  cat "$BOOKMARK_FILE"  | grep "$QUERY" | cut -d' ' -f1
}

function manage_bookmarks {
  QUERY="$(dmenu_query "Select bookmark:" "$(get_bookmark_titles)")"
  # Exit if no bookmark is selected
  [ -z "$QUERY" ] && exit

  ACTION="$(dmenu_query "Action:" "Open\nDelete")"

  case $ACTION in
    Open)   open "$(get_bookmark_url "$QUERY")"
            ;;
    Delete) # Escape open brackets for grep
            GREP_Q="$(echo "$QUERY" | sed 's/\[/\\[/')"
            TMP=$(cat "$BOOKMARK_FILE" | grep -v "$GREP_Q")
            echo "$TMP" > "$BOOKMARK_FILE"
            ;;
    *)      exit 0 # Exit if no action is selected
  esac
}

function prune_sessions {
  for file in $(ls -A "$TABDIR"); do
    if [ -z "$(xwininfo -root -children |
        grep $(cat "$TABDIR/$file"))" ]; then
      rm "$TABDIR/$file"
    fi
  done
}

function open_new_session {
  URL="$1"
  prune_sessions

  # Ask for new session name
  SESSION="$(dmenu_query "New session name:" "$(ls "$TABDIR")")"

  # Exit if nothing was entered
  [ -z "$SESSION" ] && echo "No session selected" && exit

  # Otherwise, open a new tabbed window
  # and store the XID
  TABFILE="$TABDIR/$SESSION"
  (tabbed vimprobable2 "$URL" -e  > $TABFILE) >/dev/null 2>&1 &
}

function prompt_session {
  URL="$1"
  prune_sessions

  # Ask which session to use
  SESSION="$(dmenu_query "Select session name:" "$(ls "$TABDIR")")"

  # Exit if no session was selected
  [ -z "$SESSION" ] && exit

  # Open vimprobable in the selected tabbed session
  TABFILE="$TABDIR/$SESSION"
  vimprobable2 -e $(echo $(($(cat $TABFILE)))) "$URL" >/dev/null 2>&1 &
}

function open {
  URL="$1"

  # Ask weather to open in existing session or new session
  # TODO: Open in first session
  ACTION="$(dmenu_query "Open with:" "Existing Session\nNew Session")"

  case $ACTION in
    "Existing Session")   prompt_session "$URL"
                          ;;
    "New Session")        open_new_session "$URL"
                          ;;

  esac
}

function prompt_open {
  QUERY="$(dmenu_query "Open or search" "google.com")"
  [ -z "$QUERY" ] && exit 0
  open "$QUERY"
}

## MAIN PROGRAM STARTS HERE
# Make sure tabdir exists
if [ ! -d $TABDIR ]; then
  mkdir $TABDIR
fi


case $1 in
  search)     prompt_open
              ;;
  bookmarks)  manage_bookmarks
              ;;
  '')         exit 1
              # Show usage here
              ;;
  *)          open "$1"
esac
