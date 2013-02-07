#!/bin/bash
# TODO: delete playlist
# TODO: catch errors

FONT="-*-dina-medium-r-normal-*-*-*-*-*-*-*-*-*"
N_LIST_ITEMS=20
DMENU_QUERY="dmenu -fn $FONT -i -l $N_LIST_ITEMS"

function select_song {
    MPC_FORMAT="%artist% (%album%) - [%title%]|[%file%]"
    SONG_NUMBER=$(mpc playlist -f "$MPC_FORMAT" |
                  nl -s ")  " |
                  $DMENU_QUERY |
                  cut -d")" -f1)

    [ -n "$SONG_NUMBER" ] && mpc play $SONG_NUMBER
}

function query {
    echo -n $(mpc list "$1" | sort | $DMENU_QUERY)
}

function add {
    TYPE=$1
    QUERY="$2"
    mpc search $TYPE "$QUERY" | mpc add
}

function query_add {
   add $1 "$(query $1)"
}

function clear_query_add {
    TERM=$(query "$1")
    [ -n "$TERM" ] && mpc clear && add $1 "$TERM"
}

function load_playlist {
    mpc lsplaylists | $DMENU_QUERY | mpc load
}

function clear_load_playlist {
    PLAYLIST="$(mpc lsplaylists | $DMENU_QUERY)"
    [ -n "$PLAYLIST" ] && mpc clear && mpc load "$PLAYLIST"
}

function save_playlist {
    FILE="$(mpc lsplaylists | $DMENU_QUERY)"
    [ -n "$FILE" ] && mpc save "$FILE"
}

function current_to_playlist {
}

case $1 in
    song) select_song
        ;;
    artist) artist
        ;;
    cartist) clear_query_add artist
        ;;
    album) album
        ;;
    calbum) clear_query_add album
        ;;
    playlist) load_playlist
        ;;
    cplaylist) clear_load_playlist
        ;;
    save) save_playlist
        ;;
esac
