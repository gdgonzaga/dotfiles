#!/bin/sh

ffmpeg -fflags +genpts -threads auto -i "$1" -y -threads auto -c:v libx264 -preset ultrafast -c:a libmp3lame -b:a 192k -ar 44100 -ac 2 -map 0:0 -map 0:1 -sn -f flv "$1.flv"
