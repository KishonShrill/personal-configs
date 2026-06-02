#!/usr/bin/env bash

# Get the current system color scheme
CURRENT=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT" == "'prefer-dark'" ]; then
    # Switch to light mode
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
else
    # Switch to dark mode
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
fi

# Note: If Noctalia has an IPC command for its own palette module, 
# you can just drop it at the bottom of this script later.
