#!/bin/bash
# Usage: dotfiles-restore.sh <dotfiles dir> <backup dir>
#
# EXIT CODES:
#   1   Incorrect usage
#   2   Can't create backup dir
#   3   Backup dir already exists
#   4   Error restoring files

function show_abs_path {
    cd "$1"
    pwd
}

DOTFILES_DIR="$1"
BACKUP_DIR="$2"
MAIN_EXIT_CODE=0


function show_usage {
    echo "Usage: dotfiles-restore.sh <dotfiles dir> <backup dir>"
}

function usage_error {
    show_usage
    exit 1
}

function create_backup_dir {
    # Create $BACKUP_DIR if it doesn't exist.
    # Exit otherwise
    if [ ! -e "$BACKUP_DIR" ]; then
        echo "Creating $BACKUP_DIR"
        mkdir $BACKUP_DIR
    else
        echo "ERROR: directory \"$BACKUP_DIR\" already exists"
        exit 3
    fi

    # Make sure that $BACKUP_DIR has been created
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Error creating $BACKUP_DIR"
        exit 2
    fi

    # Transform BACKUP_DIR to an absolute path
    BACKUP_DIR="$(show_abs_path "$BACKUP_DIR")"
}

#### MAIN
# Show help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_usage
    exit 0
fi

# Check if 2 arguments were passed
[[ $# -ne "2" ]] && usage_error

create_backup_dir

echo -e "Using dotfile directory: $(show_abs_path "$DOTFILES_DIR")"
echo -e "Using backup directory: $BACKUP_DIR"

# !! Change directory to $DOTFILES_DIR !!
cd "$DOTFILES_DIR"

# Skip  ". .. .git"
for i in $(ls -a1 | egrep -v '^\.$|^\.\.$|\.git$'); do
    echo "$i:"

    # Backup the current file/direcory if it already exist in $HOME
    if [ -e "$HOME/$i" ]; then
        echo "    File/directory already exists in $HOME"
        echo "    Moving to $BACKUP_DIR..."
        mv -n "$HOME/$i" "$BACKUP_DIR";

        # Make sure that the file has really been moved
        # i.e. it exists in the backup dir and not in $HOME
        if [[ -e "$BACKUP_DIR/$i" && ! -e "$HOME/$i" ]]; then
            echo "    Done"
        else
            echo "    ERROR moving file"
            MAIN_EXIT_CODE=4
            continue
        fi
    fi

    # Do the actual copying
    cp -r "$i" "$HOME"

    # Make sure it has been copied
    if [ -e "$HOME/$i" ]; then
        echo "    SUCCESS: $i copied to $HOME"
    else
        echo "    ERROR copying $i to $HOME"
        MAIN_EXIT_CODE=4
    fi
done

exit $MAIN_EXIT_CODE
