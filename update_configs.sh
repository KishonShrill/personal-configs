#!/bin/bash

# Get the absolute path of the directory where the script is located
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="$HOME"

# Colors for better visibility
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

declare -A CONFIG_MAP=(
    ["nvim"]=".config/nvim"
    ["git"]=".config/git"
    ["copyparty/.config"]=".config/copyparty/.config"
    ["tmux/.tmux.conf"]=".tmux.conf"
    ["kitty/kitty.conf"]=".config/kitty/kitty.conf"
    ["bash/.bash_aliases"]=".bash_aliases"
    ["bash/.bash_profile"]=".bash_profile"
    ["bash/.bashrc"]=".bashrc"
    ["zsh/.zshrc"]=".zshrc"
)

echo -e "${YELLOW}Starting dotfiles symlinking...${NC}\n"

for src_path in "${!CONFIG_MAP[@]}"; do
    dest_path="${CONFIG_MAP[$src_path]}"
    
    SRC="$SOURCE_DIR/$src_path"
    DEST="$DEST_DIR/$dest_path"

    # --- Interactive Prompt ---
    echo -n "Link $src_path to ~/$dest_path? [y/N]: "
    read -r response
    
    # Only proceed if response is 'y' or 'Y'
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        if [ -e "$SRC" ]; then
            # Ensure the destination's parent directory exists
            mkdir -p "$(dirname "$DEST")"

            # Remove existing file/symlink/folder at the destination
            if [ -e "$DEST" ] || [ -L "$DEST" ]; then
                echo "  Removing existing $DEST"
                rm -rf "$DEST"
            fi

            # Create the symbolic link
            ln -s "$SRC" "$DEST"
            echo -e "  ${GREEN}✓ Created symlink${NC}"
        else
            echo -e "  [!] Source not found: $SRC"
        fi
    else
        echo "  Skipping $src_path"
    fi
    echo "" # Newline for spacing
done

echo "Configuration update finished."
