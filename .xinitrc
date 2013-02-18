#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# start GNU screen session "gg"
#if screen -ls gg | grep "gg"
#then
#  echo "Screen \"gg\" already running!"
#else
#  screen -d -m -S gg
#fi

# start tmux session "gg"
if tmux list-sessions | grep "^gg"
then
  echo "tmux \"gg\" already running!"
else
  tmux new -d -s gg
fi

#while true; do sinac -w 600 && slock; done &
setxkbmap -option ctrl:nocaps
xset +fp /usr/share/fonts/local
xset fp rehash
export PATH="/home/gerry/bin:$PATH:/usr/local/bin:/usr/bin/vendor_perl"
feh  --bg-center '/home/gerry/.g/wallpaper'
watch-mail.sh &
dunst &
unclutter -noevents &
autocutsel &
mpd &
follow-mpd.sh &

# screen powersave
#xset +dpms
#xset dpms 0 0 300

## TouchPad tweaks
# 3 simultaneous taps to middle click
synclient TapButton2=3
# 2 simultaneous taps to right click
synclient TapButton3=2
# Scrolling options
synclient HorizTwoFingerScroll=1
synclient VertTwoFingerScroll=1
#synclient CircularScrolling=1
#synclient CircScrollTrigger=1
synclient PalmDetect=1

urxvt -e tmux attach &

DEFAULT_SESSION="dwm"

case $1 in

kde)
        exec startkde
	;;
stumpwm)

        exec  \
        sbcl--eval "(ql:quickload 'stumpwm)"\
            --eval "(stumpwm:stumpwm)"\
            --eval "(quit)"
	;;
*)
        conky -c ~/.g/conkyrc-dwm | while read -r; do xsetroot -name "$(echo -e "$REPLY")"; done &
        compton -f -D 2 &
        (xchainkeys -f ~/.g/xck-dwm | while read LINE; do notify-send -u low -t 3000 "$LINE"; done) &
        exec dwm
        #exec "$DEFAULT_SESSION"
    ;;
esac
