#!/bin/sh

FONT="dina:weight=medium:slant=right:pixelsize=10"
N_LIST_ITEMS=20
DMENU_QUERY="dmenu -fn $FONT -i -l $N_LIST_ITEMS"

blob_file="/home/gerry/blob-note"

# Get search string
search_string=$(echo "" | $DMENU_QUERY -p "Enter search string: ")

# Search with grep -n
# Show results
# Get line number
line_number=$(grep -n "$search_string" "$blob_file" |\
              $DMENU_QUERY |\
              cut -d":" -f1)


gvim +"$line_number" "$blob_file" -c 'normal zt'

# Open vim/gvim with line number
