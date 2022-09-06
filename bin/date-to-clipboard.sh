#!/bin/sh

f1=$(date +%Y-%m-%d)
f2=$(date +%d-%m-%Y)
f3=$(date +"%b %e, %Y")

date=$(echo -e "$f1\n$f2\n$f3" | dmenu -l 10)
echo "$date" | xclip
echo "$date" | xclip -sel c
