#!/bin/bash

# Define directories
SOURCE_DIR=$(pwd)
TARGET_DIR="$HOME/.config/nvim"

echo "Starting Neovim configuration install..."

# 1. Install System Dependencies
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Installing dependencies via apt..."
    sudo apt update
    sudo apt install -y git curl build-essential unzip ripgrep fd-find nodejs npm
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing dependencies via brew..."
    brew install git curl gcc unzip ripgrep fd node
fi

# 2. Cleanup and Backup
if [ -d "$TARGET_DIR" ]; then
    echo "Existing configuration found. Moving to $TARGET_DIR.bak"
    rm -rf "$TARGET_DIR.bak"
    mv "$TARGET_DIR" "$TARGET_DIR.bak"
fi

# Clear Neovim data and cache to ensure a clean state
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.cache/nvim"

# 3. Create Symlink
# This makes the git directory the active config directory
echo "Creating symlink: $SOURCE_DIR -> $TARGET_DIR"
mkdir -p "$HOME/.config"
ln -s "$SOURCE_DIR" "$TARGET_DIR"

echo "Installation complete. Run 'nvim' to initialize plugins."
