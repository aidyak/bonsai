#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

if command -v sheldon >/dev/null 2>&1; then
    echo "Sheldon is already installed. Skipping..."
    exit 0
fi

if [ "$OS" = "Darwin" ]; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew is required to install Sheldon on macOS."
        echo "Install Homebrew first, then rerun this script."
        exit 1
    fi

    echo "Installing Sheldon with Homebrew..."
    brew install sheldon
    echo "Sheldon installed!"
    exit 0
fi

if [ "$OS" != "Linux" ]; then
    echo "Unsupported OS: $OS"
    exit 1
fi

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

echo "Installing Sheldon..."

curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to "$BIN_DIR"

echo "Sheldon installed!"
