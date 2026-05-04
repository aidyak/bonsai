#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/apps"
BIN_DIR="$HOME/.local/bin"
NVIM_APPIMAGE="$INSTALL_DIR/nvim-nightly"
NVIM_LINK="$BIN_DIR/nvim-nightly"

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

if [ -x "$NVIM_LINK" ]; then
    echo "Neovim nightly is already installed. Skipping..."
    exit 0
fi

echo "Installing Neovim nightly..."

cd "$INSTALL_DIR"

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage

chmod u+x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage "$NVIM_APPIMAGE"

ln -sfn "$NVIM_APPIMAGE" "$NVIM_LINK"

echo "Neovim nightly installed!"