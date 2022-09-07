#!/bin/sh

# ~/.xinitrc
# Executed by startx (run your window manager from here)
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export PATH="/home/gerry/bin:$PATH:/usr/local/bin:/usr/bin/vendor_perl"
export QT_QPA_PLATFORMTHEME=gtk2

# start tmux session "gg"
if tmux list-sessions | grep "^gg"
then
  echo "tmux \"gg\" already running!"
else
  tmux new -d -s gg
fi

#while true; do sinac -w 600 && slock; done &
xset +fp /usr/share/fonts/local
set fp rehash

xcompmgr &
#pacmd load-module module-remap-sink sink_name=mono master=alsa_output.pci-0000_08_00.4.analog-stereo channels=2 channel_map=mono,mono

# start backgrounded programs/scripts
unclutter -noevents &
autocutsel &
#mpd &
#tilda &
numlockx &
#nextcloud &
#/home/gerry/bin-local/duplicati-gerry.sh &
dunst &
kdocker -q thunderbird &
#xfce4-power-manager &
#pacmd load-module module-remap-sink sink_name=mono master=alsa_output.pci-0000_08_00.4.analog-stereo channels=2 channel_map=mono,mono &

#redshift -l 15.133691:120.581854 &
conky -c ~/.g/.conkyrc &
#conky -c ~/.g/.conkyrc-cal &

setxkbmap -option ctrl:nocaps
#.screenlayout/single-goma.sh &
(xchainkeys -f ~/.g/xck | while read LINE; do notify-send -u low -t 3000 "$LINE"; done) &
exec startxfce4
