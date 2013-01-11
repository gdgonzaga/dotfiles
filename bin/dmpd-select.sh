#!/bin/bash
# Choose a song from current playlist using dmenu

FONT="-*-dina-medium-r-normal-*-*-*-*-*-*-*-*-*"
LIST_ITEMS=20
MOC_FORMAT="%artist% (%album%) - [%title%]|[%file%]"
SONG_NUMBER=$(mpc playlist -f "$MOC_FORMAT" | nl -s ")  " | dmenu -fn "$FONT" -i -l $LIST_ITEMS | cut -d")" -f1)

[ -z $SONG_NUMBER ] && exit
mpc play $SONG_NUMBER
