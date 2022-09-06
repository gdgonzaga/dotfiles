#!/bin/bash

if [ -d /cctv/zoneminder ]
then
    UNMOUNT_F="false"
else
    UNMOUNT_F="true"
    sshfs gerry@10.0.0.101:/cctv  /cctv
fi

python /home/gerry/act/cctv-snap-backup/cctv-snap-backup.py

[ $UNMOUNT_F = "true" ] && umount /cctv
