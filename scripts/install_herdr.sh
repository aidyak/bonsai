#!/usr/bin/env bash
set -euo pipefail

if command -v herdr >/dev/null 2>&1; then
    echo "Herdr is already installed. Skipping..."
    exit 0
fi

echo "Installing Herdr..."

curl -fsSL https://herdr.dev/install.sh | sh

echo "Herdr installed!"
