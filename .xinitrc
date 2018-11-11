#!/bin/sh # # ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#if [ -d /etc/X11/xinit/xinitrc.d ]; then
  #for f in /etc/X11/xinit/xinitrc.d/*; do
    #[ -x "$f" ] && . "$f"
  #done
  #unset f
#fi

# https://wiki.archlinux.org/index.php/PRIME
#xrandr --setprovideroffloadsink 0x55 0x7d

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
export QT_QPA_PLATFORMTHEME='gtk2' in ~/.xinitrc

xcompmgr &

# start backgrounded programs/scripts
#wicd-gtk &
#watch-mail.sh &
unclutter -noevents &
autocutsel &
mpd &
tilda &
#seafile-applet &
#parcellite &
numlockx &
#pactl unload-module module-role-cork

#urxvt -e tmux attach &
redshift -l 15.133691:120.581854 &
#compton &
#(wait 5000; tilda) &
#feh  --bg-fill '/home/gerry/.g/wallpaper'
#(while true; do pnmixer; done) &
#follow-mpd.sh &
conky -c ~/.g/conkyrc-desktop &
#conky -c ~/.g/conkyrc-dwm | while read -r; do xsetroot -name "$(echo -e "$REPLY")"; done &
(xchainkeys -f ~/.g/xck | while read LINE; do notify-send -u low -t 3000 "$LINE"; done) &
#dunst &
exec startxfce4
