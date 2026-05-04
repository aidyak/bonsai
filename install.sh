#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/bonsai"

backup_and_link() {
    src="$1"
    dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        mv "$dest" "$dest.backup"
    fi

    ln -sfn "$src" "$dest"
}

# ==============================
# link dotfiles
# ==============================

echo "Linking dotfiles..."

backup_and_link "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"

mkdir -p "$HOME/.config"
backup_and_link "$DOTFILES_DIR/nvim-nightly" "$HOME/.config/nvim-nightly"
backup_and_link "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"

# ==============================
# install tools
# ==============================

echo "Installing tools..."

"$DOTFILES_DIR/scripts/install_nvim_nightly.sh"

echo "Setup complete!"