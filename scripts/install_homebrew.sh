#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed. Skipping..."
    exit 0
fi

if [ "$OS" != "Darwin" ]; then
    echo "Homebrew installation is only managed on macOS. Skipping..."
    exit 0
fi

echo "Installing Homebrew..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Homebrew installed!"
