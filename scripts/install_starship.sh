#!/usr/bin/env bash
set -euo pipefail

if command -v starship >/dev/null 2>&1; then
    echo "Starship is already installed. Skipping..."
    exit 0
fi

echo "Installing Starship..."

curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "Starship installed!"