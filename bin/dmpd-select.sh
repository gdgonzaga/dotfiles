#!/bin/bash
#
# This script was meant to replicate the the mpd module from stumpwm,
# but in a WM agnostic way. It's meant to be used with xchainkeys.
#
# Depends on: mpc, dmenu and compton
#
# Exit codes:
#       1 Incorrect usage
#       2 add: Track already in playlist
#
# TODO: delete playlist
# TODO: catch errors

function show_usage {
    echo  "Usage: dmpd-select.sh <command>
Commands:
       song       Select track to play
       artist     Add artist to current playlist
       cartist    Clear current playlist first
       album      Add album to current playlist
       calbum     Clear current playlist first
       playlist   Add the contents of playlist to current playlist
       cplaylist  Clear current playlist first
       save       Saves the current playlist
       add        Add current song to playlist
       all        Clear current playlist and add all songs"

    exit 1
}

PLAYLIST_DIR="$HOME/.mpd/playlists"

# dmenu-specific
FONT="-*-dina-medium-r-normal-*-*-*-*-*-*-*-*-*"
N_LIST_ITEMS=20
DMENU_QUERY="dmenu -fn $FONT -i -l $N_LIST_ITEMS"

# Transparency options
SLEEP_DELAY=0.1
OPACITY=90

# Make dmenu transparent. Run just before invoking dmenu.
# Usage:   transparent
function transparent {
    (sleep $SLEEP_DELAY; compton-trans -w $(xwininfo -root -children | grep "has no name" | head -1 | cut -d' ' -f6) $OPACITY) &
}

# Use dmenu to list all songs in the current playlist and play whichever
# is chosen.
function select_song {
    MPC_FORMAT="%artist% (%album%) - [%title%]|[%file%]"
    transparent
    SONG_NUMBER=$(mpc playlist -f "$MPC_FORMAT" |
                  nl -s ")  " |
                  $DMENU_QUERY -p "Search song" |
                  cut -d")" -f1)
    [ -n "$SONG_NUMBER" ] && mpc play $SONG_NUMBER
}

# Accessory function. Returns the item chosen from dmenu.
# Usage:   query tag [prompt]
# Example: query artist "Enter artist name"
function query {
    TAG="$1"
    [ -n "$2" ] && PROMPT="$2"
    transparent
    echo -n $(mpc list "$TAG" | sort | $DMENU_QUERY -p "$PROMPT")
}

# Accessory function. Add songs that match the tag-query pair to the
# current playlist
# Usage:   add tag string
# Example: add artist "Pearl Jam"
function add {
    TYPE=$1
    QUERY="$2"
    mpc search $TYPE "$QUERY" | mpc add
}

# Ask the user for [tag] and add all matching tracks to the current
# playlist.
# Usage:   query_add tag
# Example: query_add artist
function query_add {
   add $1 "$(query $1 "Add $1")"
}

# Like query_add, but clears the current playlist first.
# Usage:   clear_query_add tag
# Example: clear_query_add artist
function clear_query_add {
    TERM=$(query "$1" "Load $1")
    [ -n "$TERM" ] && mpc clear && add $1 "$TERM"
}

# Add the contents of [playlist] to the current playlist.
# Usage:   load_playlist
function load_playlist {
    transparent
    mpc lsplaylists | $DMENU_QUERY -p "Load playlist" | mpc load
}

# Like load_playlist, but clear the current playlist first.
# Usage:   clear_load_playlist
function clear_load_playlist {
    transparent
    PLAYLIST="$(mpc lsplaylists | $DMENU_QUERY -p "Load playlist")"
    [ -n "$PLAYLIST" ] && mpc clear && mpc load "$PLAYLIST"
}

# Save the current [playlist]. Uses dmenu to get the [playlist].
# Usage:   save_playlist
function save_playlist {
    transparent
    FILE="$(mpc lsplaylists | $DMENU_QUERY -p "Save playlist")"
    [ -n "$FILE" ] && mpc save "$FILE"
}

# Add the current song to [playlist]. Uses dmenu to get the [playlist].
# Usage:   current_to_playlist
function current_to_playlist {
    transparent
    PLAYLIST_NAME="$(ls "$PLAYLIST_DIR" | sed 's/\.m3u$//' |
                   $DMENU_QUERY -p "Add current song to playlist")"
    PLAYLIST_FILE="$PLAYLIST_DIR/$PLAYLIST_NAME.m3u"

    [ -z PLAYLIST_NAME ] && exit

    if [ -n "$(cat "$PLAYLIST_FILE" | grep "$(mpc -f %file% current)")" ]; then
        echo "[already in playlist!]"
        exit 2
    else
        echo "$(mpc -f "%file%" current)" >> "$PLAYLIST_FILE"
        echo "[added to $PLAYLIST_NAME]"
    fi
}

case $1 in
    song) select_song
        ;;
    artist) query_add artist
        ;;
    cartist) clear_query_add artist
        ;;
    album) query_add album
        ;;
    calbum) clear_query_add album
        ;;
    playlist) load_playlist
        ;;
    cplaylist) clear_load_playlist
        ;;
    save) save_playlist
        ;;
    add) current_to_playlist
        ;;
    all) mpc clear; mpc listall | mpc add && echo "[all songs loaded]"
        ;;
    *) show_usage
esac
