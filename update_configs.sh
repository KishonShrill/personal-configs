#!/bin/bash

# Get the absolute path of the directory where the script is located
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="$HOME"

# Declare an associative array: ["Repo_Path"]="Destination_Path"
declare -A CONFIG_MAP=(
    ["nvim"]=".config/nvim"                               # Folder
    ["git"]=".config/git"                                 # Folder
    ["copyparty/foobar.conf"]=".config/copyparty/foobar.conf" # File
    ["tmux/.tmux.conf"]=".tmux.conf"                      # File
    ["bash/.bash_aliases"]=".bash_aliases"                # File
    ["bash/.bash_profile"]=".bash_profile"                # File
    ["bash/.bashrc"]=".bashrc"                            # File
)

# Loop through the keys (source paths) in the map
for src_path in "${!CONFIG_MAP[@]}"; do
    dest_path="${CONFIG_MAP[$src_path]}"
    
    SRC="$SOURCE_DIR/$src_path"
    DEST="$DEST_DIR/$dest_path"

    if [ -e "$SRC" ]; then
        # Ensure the destination's parent directory exists (e.g., ~/.config/copyparty)
        mkdir -p "$(dirname "$DEST")"

        # Remove existing file/symlink/folder at the destination
        if [ -e "$DEST" ] || [ -L "$DEST" ]; then
            echo "Removing existing $DEST"
            rm -rf "$DEST"
        fi

        # Create the symbolic link (works for both files and folders)
        ln -s "$SRC" "$DEST"
        echo "Created symlink: $DEST -> $SRC"
    else
        echo "Source not found: $SRC"
    fi
done

echo "Configuration update finished."
