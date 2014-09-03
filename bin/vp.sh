#!/usr/bin/env bash
# Usage:
# dvp.sh <bookmarks | URL or search string> [session name]
# Depends on:
#   dmenu, compton, xorg-xwininfo

DMENU_FONT="-*-termsyn-medium-*-*-*-*-*-*-*-*-*-*-*"
DMENU_LIST_ITEMS=40
DMENU_OPACITY=90
TRANSPARENT_SLEEP_DELAY=1
BOOKMARK_FILE="$HOME/.config/vimprobable/bookmarks"
TABDIR="$TMPDIR/tabbed"

# dmenu_query <prompt> <options>
function dmenu_query {
  # Transparency
  #(sleep $TRANSPARENT_SLEEP_DELAY; compton-trans -w $(xwininfo -root -children | grep "has no name" | head -1 | cut -d' ' -f6) $DMENU_OPACITY) &

  PROMPT="$1"

  # Remove duplicate options and empty lines
  OPTIONS="$(echo -e "$2" | egrep -v "^\s*$" | uniq)"

  ANSWER="$(echo -e "$OPTIONS" |
            dmenu -fn $DMENU_FONT -i  -l $DMENU_LIST_ITEMS -p "$PROMPT")"

  if [ -z "$ANSWER" ]; then
    exit 2
  else
    echo "$ANSWER"
  fi
}

function get_bookmark_titles {
  cat "$BOOKMARK_FILE" | sed -r 's/[^ ]* //'
}

# get_bookmark_url <bookmark string>
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

function session_exists {
  [ -e "$TABDIR/$1" ] && return 0 || return 1
}

# open URL [session name]
function open {
  prune_sessions
  URL="$1"

  if [ -n "$2" ]; then
    # Use session name if it exists
    SESSION="$2"
  else # Ask
    SESSION="$(dmenu_query "Open \"$URL\" in session:" "default\n$(ls $TABDIR)")"

    # Exit if nothing was selected
    # TODO: null string checking sould be done in dmenu_query
    [ -z "$SESSION" ] && exit 2
  fi

  TABFILE="$TABDIR/$SESSION"
  # Create a new tabbed window if the session doesn't exist
  session_exists "$SESSION" || tabbed  -d  > "$TABFILE" 2> /dev/null
  # Launch vimprobable in the selected session
  vimprobable2 -e $(< "$TABFILE") "$URL" > /dev/null 2>&1
}

function search {
  QUERY="$(dmenu_query "Open or search" "google.com")"
  [ -z "$QUERY" ] && exit 0
  open "$QUERY"
}

## MAIN ##
# Make sure TABDIR  exists
if [ ! -d $TABDIR ]; then
  mkdir -p $TABDIR
fi

case $1 in
  '')         search
              ;;
  bookmarks)  manage_bookmarks
              ;;
  *)          open "$1" "$2"
esac
