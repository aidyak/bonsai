#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

if command -v nvim >/dev/null 2>&1; then
    echo "Neovim is already installed. Skipping..."
    exit 0
fi

if [ "$OS" = "Darwin" ]; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew is required to install Neovim on macOS."
        echo "Install Homebrew first, then rerun this script."
        exit 1
    fi

    echo "Installing Neovim with Homebrew..."
    brew install neovim
    echo "Neovim installed!"
    exit 0
fi

if [ "$OS" != "Linux" ]; then
    echo "Unsupported OS: $OS"
    exit 1
fi

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
