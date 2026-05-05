#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

if [ "$OS" != "Darwin" ]; then
    echo "Raycast is only supported on macOS. Skipping..."
    exit 0
fi

if [ -d "/Applications/Raycast.app" ]; then
    echo "Raycast is already installed. Skipping..."
    exit 0
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required to install Raycast."
    echo "Install Homebrew first, then rerun this script."
    exit 1
fi

echo "Installing Raycast with Homebrew..."

brew install --cask raycast

echo "Raycast installed!"
