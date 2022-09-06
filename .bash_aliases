# aliases
alias tmux='TERM=xterm-256color tmux'
alias pacman='sudo pacman'
alias emacs='emacs -nw'
alias ls='ls --color=auto'
alias lssd='ls /dev | grep sd'
alias ll='ls -lh'
alias lt='ls -lth'
alias lr='ls -ltrh'
alias wicd-curses='wicd-curses; clear'


alias vr='vim --servername gg --remote'
#alias vrs='vim --servername gg'
alias vnotes='cd ~/Documents/notes; vim +NERDTree; cd ~'

alias def='SDCV_PAGER=less  sdcv'

alias remouse-wireless="xinput set-prop 'pointer:2.4GHz 2way RF Receiver' 'Device Accel Constant Deceleration' 1.5"
#alias evecfg="WINEPREFIX=/media/store/opt/eve winecfg"
#alias everepair="WINEPREFIX=/media/store/opt/eve wine /media/store/opt/eve/drive_c/Program\ Files\ \(x86\)/CCP/EVE/repair.exe"

alias mnt-dotfiles="encfs ~/seafile/encfs-dotfiles ~/mnt/encfs-dotfiles"
alias mnt-store="encfs ~/seafile/encfs-store ~/mnt/encfs-store"
alias mnt-ccda="encfs /store/ccda-encfs /home/gerry/mnt/ccda"
alias mnt-gim="sshfs gdgon.com:/ /media/remote/gim"
alias mnt-encd="encfs ~/Nextcloud/encd/ ~/mnt/encd"
alias mnt-s3="s3fs gdgon ~/mnt/s3 -o passwd_file=~/mnt/encd/.s3cfg"


alias virtualenvwrapper-start="source /usr/bin/virtualenvwrapper.sh"
alias conda-start="[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh"
alias youtube-mp3='youtube-dl -x --audio-format mp3'
