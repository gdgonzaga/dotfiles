#!/bin/bash
# Go trough all args, move to DOTFILES_DIR, then create a symlink
# TODO: Allow the user to specify a different DOTFILES_DIR

DOTFILES_DIR="$HOME/dotfiles"

# Exit if user asks for help
# TODO: Learn how to parse arguments properly
[[ $1 == "-h" || $1 == "--help" ]] &&
    echo -e "Usage: dotfiles-move.sh <file1> <file2> ..." &&
    exit

# Exit with an error if there are no arguments
[ -z "$1" ] &&
    echo -e "Usage: dotfiles-move.sh <file1> <file2> ..." &&
    exit 1

echo -e "Using dotfile directory: $DOTFILES_DIR\n"

for i in $@; do
    # Remove trailing slashes
    # FIXME: Currently removes all "/".
    #        This should only remove the last "/"
    i=$(echo "$i" | tr -d "/")

    NEW_LOCATION="$DOTFILES_DIR/$i"

    # Skip files that already exist
    [ -e "$NEW_LOCATION" ] && echo "$i: ERROR: Already exists.  Skipping..." && continue

    # Skip symlinks
    [ -L "$i" ] && echo "$i: ERROR: File is a symlink. Skipping..." && continue

    # Skip non-existing files
    [ ! -e "$i" ] && echo "$i: ERROR: File does not exist. Skipping..." && continue

    # Move and create a symlink
    echo "$i:"
    mv "$i" "$DOTFILES_DIR" &&
        echo "    Copied to $DOTFILES_DIR" ||
        echo "    ERROR copying to $DOTFILES_DIR"
    ln -s "$NEW_LOCATION" "$i" &&
        echo "    Created symlink" ||
        echo "    ERROR creating symlink"
done
