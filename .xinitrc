#!/bin/sh # # ~/.xinitrc
#
# Executed by startx (run your window manager from here)
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# https://wiki.archlinux.org/index.php/PRIME
xrandr --setprovideroffloadsink 0x55 0x7d

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

#guake &

#while true; do
    ##rem | tail -n +2 | sed -e 's|..../../.. ||g' -e 's|MSG ||g' |
    #rem | tail -n +2 | grep -ve "^$" |
    #while read; do notify-send "REMINDER: $REPLY" -u critical; done
    #sleep 300
#done &

#while true; do sinac -w 600 && slock; done &
setxkbmap -option ctrl:nocaps
xset +fp /usr/share/fonts/local
xset fp rehash
export PATH="/home/gerry/bin:$PATH:/usr/local/bin:/usr/bin/vendor_perl"

# start backgrounded programs/scripts
#wicd-gtk &
#watch-mail.sh &
unclutter -noevents &
autocutsel &
mpd &
#seafile-applet &
#parcellite &
numlockx &
pactl unload-module module-role-cork

#urxvt -e tmux attach &

DEFAULT_SESSION="dwm"

case $1 in

kde)
        xchainkeys -f ~/.g/xck &
        #conky -c ~/.g/conkyrc-kde &
        exec startkde
        ;;

*)
        #compton &
        xcompmgr &
        (wait 5000; tilda) &
        feh  --bg-fill '/home/gerry/.g/wallpaper'
        (while true; do pnmixer; done) &
        follow-mpd.sh &
        conky -c ~/.g/conkyrc-desktop &
        conky -c ~/.g/conkyrc-dwm | while read -r; do xsetroot -name "$(echo -e "$REPLY")"; done &
        (xchainkeys -f ~/.g/xck-dwm | while read LINE; do notify-send -u low -t 3000 "$LINE"; done) &
        dunst &
        exec dwm
        ;;

cinnamon)
        #(while true; do pnmixer; done) &
        follow-mpd.sh &
        conky -c ~/.g/conkyrc-desktop &
        #conky -c ~/.g/conkyrc-dwm | while read -r; do xsetroot -name "$(echo -e "$REPLY")"; done &
        #compton -f -D 2 --inactive-dim 0.3 --focus-exclude 'g:ei:Smplayer' &
        (xchainkeys -f ~/.g/xck | while read LINE; do notify-send -u low -t 3000 "$LINE"; done) &
        dunst &
        exec cinnamon-session
        ;;
esac
