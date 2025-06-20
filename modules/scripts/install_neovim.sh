#!/bin/sh
set -eu

if command -v git >/dev/null 2>&1; then
	echo "Git is installed, continuing the process.." 
else
    echo "Git is not in system packages. Add it and then run this script again"
    exit 1
fi

NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [ -f "$NVIM_CONFIG/init.lua" ]; then
    echo "Neovim config found. Updating it..."
    cd "$NVIM_CONFIG"
    git pull
else
    echo "Installing Neovim config..."
    git clone https://github.com/randomdude16671/neovim-config.git "$NVIM_CONFIG"
    echo "Done."
fi

