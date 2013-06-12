#!/usr/bin/bash
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

sleep_delay=5

# Initialize the data variable using the configuration below
function init_tags {
     while read line; do
         # Proceed if line is not empty and not a comment
         if [[ -n "$line" && -z "$(echo "$line" | grep "^#")" ]]; then
             data[${#data[@]}]="$line"
         fi
     done
 }

# Count new mail
function count {
    index=3
    while [[ $index -lt ${#data[@]} ]]; do
        # Bind the lines of the current block to temporary variables
        query="${data[$index]}"
        file="${data[$(($index - 1))]}"
        notify="${data[$(($index - 2))]}"
        name="${data[$(($index - 3))]}"

        count=$(notmuch search $query and tag:unread | wc -l)

        # Update index to point at the last line of the next block
        index=$((index + 4))

        notify "$name" "$count" "$file" "$notify"
    done
}

# Send notification and echo to file
# Called by count
function notify {
  name="$1"
  count="$2"
  file="$3"
  notify="$4"

  [ -f "$file" ] && old="$(cat "$file")"

  # Determine the number of new emails from the last sync
  if [ -n "$old" ] && [[ $count -gt $old ]]; then
     new=$(($count - $old))
  else
     new="$count"
  fi

  # DEBUG:
  echo "NOTIFY: $name: count: $count old: $old new: $new"

  # If there is new mail, do a notify-send
  if [[ "$new" -gt 0 ]]; then
      notify-send -u "$notify" "New $name: $new"
  fi

  # If there is new mail, update the notification file
  if [[ "$new" -gt 0 ]]; then
      echo -n "$count" > "$file"

  # Remove the notification file if it exists and there are no unread emails
  elif [ -f "$file" ] && [[ "$count" -eq 0 ]]; then
      rm $file
  fi

}

#### CONFIGURE HERE
maildir=~/Mail
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
normal
/home/gerry/tmp/mail-bt
tag:bt

EOF
)

while true; do
  notmuch-postsync.sh
  count
  inotifywait $maildir -e create -e delete -e move -r -q --exclude ".notmuch" > /dev/null
  sleep $sleep_delay;
done
