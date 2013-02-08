#!/bin/bash
# TODO: delete playlist
# TODO: catch errors

FONT="-*-dina-medium-r-normal-*-*-*-*-*-*-*-*-*"
N_LIST_ITEMS=20
PLAYLIST_DIR="$HOME/.mpd/playlists"
DMENU_QUERY="dmenu -fn $FONT -i -l $N_LIST_ITEMS"

function transparent {
    sleep 0.1; compton-trans -w $(xwininfo -root -children | grep 1600x | head -1 | cut -d' ' -f6) 90
}

function select_song {
    MPC_FORMAT="%artist% (%album%) - [%title%]|[%file%]"
    transparent &
    SONG_NUMBER=$(mpc playlist -f "$MPC_FORMAT" |
                  nl -s ")  " |
                  $DMENU_QUERY -p "Search song" |
                  cut -d")" -f1)

    [ -n "$SONG_NUMBER" ] && mpc play $SONG_NUMBER
}

function query {
    TAG="$1"
    [ -n "$2" ] && PROMPT="$2"
    transparent &
    echo -n $(mpc list "$TAG" | sort | $DMENU_QUERY -p "$PROMPT")
}

function add {
    TYPE=$1
    QUERY="$2"
    mpc search $TYPE "$QUERY" | mpc add
}

function query_add {
   add $1 "$(query $1 "Add $1")"
}

function clear_query_add {
    TERM=$(query "$1" "Load $1")
    [ -n "$TERM" ] && mpc clear && add $1 "$TERM"
}

function load_playlist {
    mpc lsplaylists | $DMENU_QUERY -p "Load playlist" | mpc load
}

function clear_load_playlist {
    PLAYLIST="$(mpc lsplaylists | $DMENU_QUERY -p "Load playlist")"
    [ -n "$PLAYLIST" ] && mpc clear && mpc load "$PLAYLIST"
}

function save_playlist {
    FILE="$(mpc lsplaylists | $DMENU_QUERY -p "Save playlist")"
    [ -n "$FILE" ] && mpc save "$FILE"
}

function current_to_playlist {
    PLAYLIST_NAME="$(ls "$PLAYLIST_DIR" | sed 's/\.m3u$//' |
                   $DMENU_QUERY -p "Add current song to playlist")"
    PLAYLIST_FILE="$PLAYLIST_DIR/$PLAYLIST_NAME.m3u"

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
esac
