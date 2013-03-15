#!/bin/bash
# TODO: Add session management

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

function dmenu_query {
  transparent &
  dmenu -fn $DMENU_FONT -i -l $DMENU_LIST_ITEMS -p "$1"
}

function get_bookmark_titles {
  cat "$BOOKMARK_FILE" | sed -r 's/[^ ]* //'
}

function get_bookmark_url {
  QUERY="$(echo "$1" | sed 's/\[/\\[/')"
  cat "$BOOKMARK_FILE"  | grep "$QUERY" | cut -d' ' -f1
}

function manage_bookmarks {
  QUERY="$(echo "$(get_bookmark_titles)" | dmenu_query "Select bookmark:")"
  # Exit if no bookmark is selected
  [ -z "$QUERY" ] && exit

  ACTION="$(echo -e "Open\nDelete" | dmenu_query "Action:")"

  case $ACTION in
    Open)   vp.sh "$(get_bookmark_url "$QUERY")"
            ;;
    Delete) # Escape open brackets for grep
            GREP_Q="$(echo "$QUERY" | sed 's/\[/\\[/')"
            TMP=$(cat "$BOOKMARK_FILE" | grep -v "$GREP_Q")
            echo "$TMP" > "$BOOKMARK_FILE"
            ;;
    *)      exit 0
  esac
}

function open {
  [ -n "$1" ] && URL="$1" || URL="google.com"

  if  [ `ls -A $TABDIR` ] ; then
    TABFILE="$TABDIR/`ls $TABDIR | tail -1`"
    vimprobable2 -e $(echo $(($(cat $TABFILE)))) "$URL" >/dev/null 2>&1 &
  else
    TABFILE="$TABDIR/`date +%Y%m%d%H%M%S`"
    (tabbed vimprobable2 "$URL" -e  > $TABFILE) >/dev/null 2>&1 &
    wait $!
    rm $TABFILE
  fi
}

function prompt_open {
  QUERY="$(echo -e "google.com" | dmenu_query "Open or search")"
  [ -z "$QUERY" ] && exit 0
  open "$QUERY"
}

## MAIN PROGRAM STARTS HERE
# Make sure tabdir exists
if [ ! -d $TABDIR ]; then
  mkdir $TABDIR
fi

case $1 in
  open) prompt_open
      ;;
  bma) manage_bookmarks
      ;;
  *) exit 1
esac
