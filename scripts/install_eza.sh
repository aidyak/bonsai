#!/usr/bin/env bash
set -euo pipefail

if command -v eza >/dev/null 2>&1; then
    echo "eza is already installed. Skipping..."
    exit 0
fi

echo "Installing eza..."

brew install eza

echo "eza installed!"
