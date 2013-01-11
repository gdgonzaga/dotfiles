#!/bin/bash

#TABDIR="$TMPDIR/tabbed"
TMPDIR="/tmp"
TABDIR="$HOME/tmp/tabbed"
URL="google.com"

if [ ! -d $TABDIR ]; then
  mkdir $TABDIR
fi

args=`getopt nt:i $*`

  if [ "$1" ]; then 
    URL="$1"
  fi


  if  [ `ls -A $TABDIR` ] ; then
    TABFILE="$TABDIR/`ls $TABDIR | tail -1`"
    vimprobable2 -e $(echo $(($(cat $TABFILE)))) "$URL" >/dev/null 2>&1 &
  else
    TABFILE="$TABDIR/`date +%Y%m%d%H%M%S`"
    (tabbed vimprobable2 "$URL" -e  > $TABFILE) >/dev/null 2>&1 &
    wait $!
    rm $TABFILE 
  fi
