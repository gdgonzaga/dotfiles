#!/bin/bash
# watch-mail.sh
#
# 1. Monitor maildir for created/deleted/moved files
# 2. Update notmuch DB with notmuch-postsync.sh
# 2. Count all new emails via notmuch search
# 3. Do a notify-send if there is new mail in the current iteration
# 4. Echo all unread mail count to a file for conky.
#
# Depends on:
#   notmuch
#   libnotify
#   inotify-tools
#   notmuch-postsync.sh (set tags for new emails)
#   conky (optional)
#
# TODO: Put all notification files in a single directory

SLEEP_DELAY=5

# Initialize the DATA variable using the configuration below
function init_tags {
     while read line; do
         # Proceed if line is not empty and not a comment
         if [[ -n "$line" && -z "$(echo "$line" | grep "^#")" ]]; then
             DATA[${#DATA[@]}]="$line"
         fi
     done
 }

# Count new mail
function count {
    INDEX=3
    while [[ $INDEX -lt ${#DATA[@]} ]]; do
        # Bind the lines of the current block to temporary variables
        QUERY="${DATA[$INDEX]}"
        FILE="${DATA[$(($INDEX - 1))]}"
        NOTIFY="${DATA[$(($INDEX - 2))]}"
        NAME="${DATA[$(($INDEX - 3))]}"

        COUNT=$(notmuch search $QUERY and tag:unread | wc -l)

        # Update INDEX to point at the last line of the next block
        INDEX=$((INDEX + 4))

        notify "$NAME" "$COUNT" "$FILE" "$NOTIFY"
    done
}

# Send notification and echo to file
# Called by count
function notify {
  NAME="$1"
  COUNT="$2"
  FILE="$3"
  NOTIFY="$4"

  if [ "$COUNT" -gt 0 ]; then
      if [[ -e "$FILE" && "$(cat "$FILE")" -lt $COUNT && "$NOTIFY" != "n" ]]; then
          notify-send -u "$NOTIFY" "New $NAME: $(($COUNT - $(cat "$FILE")))"
      fi
      echo -n "$COUNT" > "$FILE"
  elif [ -f "$FILE" ]; then
      rm $FILE
  fi
}

#### CONFIGURE HERE
MAILDIR=~/Mail
init_tags < <(cat << EOF
# Comments and empty lines are skipped
# Comments are lines that have '#' as the first character
#
# SYNTAX:
#  <block name>
#  <notify-send urgency: low|normal|critical|n (n = no notification)>
#  <notification file>
#  <notmuch search query>

Mail
normal
/home/gerry/tmp/mail-mail
NOT tag:ross NOT tag:bt NOT tag:rss NOT tag:archlinux NOT tag:jobs NOT tag:spam

RSS
low
/home/gerry/tmp/mail-rss
NOT tag:ross NOT tag:bt NOT tag:inbox NOT tag:spam

ROSS
critical
/home/gerry/tmp/mail-ross
tag:ross

BT
n
/home/gerry/tmp/mail-bt
tag:bt

EOF
)

while true; do
  notmuch-postsync.sh
  count
  inotifywait $MAILDIR -e create -e delete -e move -r -q --exclude ".notmuch" > /dev/null
  sleep $SLEEP_DELAY;
done
