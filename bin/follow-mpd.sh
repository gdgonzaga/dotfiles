#!/bin/bash
mpc idleloop player |
while read line; do
        mpc current
done |
while read song; do
        notify-send -u low -t 3000 "$song"
done
