#!/bin/bash

echo -e '0\n50\n80\n100\n120\n150' | dmenu -fn '-*-termsyn-medium-*-*-*-*-*-*-*-*-*-*-*' -p 'Set volume:' | xargs ponymix set-volume | sed 's/^/[volume: /' | sed 's/$/]/'
