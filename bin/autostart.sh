#!/bin/sh

export PATH="/home/gerry/bin:$PATH:/usr/local/bin:/usr/bin/vendor_perl"
export QT_QPA_PLATFORMTHEME=gtk2
xcompmgr &
.screenlayout/single-goma.sh &
#pacmd load-module module-remap-sink sink_name=mono master=alsa_output.pci-0000_08_00.4.analog-stereo channels=2 channel_map=mono,mono

# start backgrounded programs/scripts
unclutter -noevents &
autocutsel &
mpd &
#tilda &
numlockx &
#nextcloud &
/home/gerry/bin-local/duplicati-gerry.sh &
dunst &
qtpad &
kdocker -q thunderbird &
#xfce4-power-manager &
pacmd load-module module-remap-sink sink_name=mono master=alsa_output.pci-0000_08_00.4.analog-stereo channels=2 channel_map=mono,mono &

#redshift -l 15.133691:120.581854 &
conky -c ~/.g/.conkyrc &
#conky -c ~/.g/.conkyrc-cal &

setxkbmap -option ctrl:nocaps
(xchainkeys -f ~/.g/xck | while read LINE; do notify-send -u low -t 3000 "$LINE"; done) &
#exec startxfce4
