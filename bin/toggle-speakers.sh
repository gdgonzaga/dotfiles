#!/usr/bin/env bash
STATUS_FILE=$TMPDIR/speaker-status

amixer -D hw:0 set Speaker toggle

if amixer -D hw:0 | grep Speaker -A5 | grep '\[on\]'
then
  STATUS_STRING='S'
  sleep 0.1
  amixer -D default set Master unmute
else
  STATUS_STRING=''
fi

echo "$STATUS_STRING" > $STATUS_FILE
