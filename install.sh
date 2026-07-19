#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

load_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        return
    fi

    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        return
    fi

    if [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

backup_and_link() {
    src="$1"
    dest="$2"

    if [ ! -e "$src" ]; then
        echo "Skipping missing source: $src"
        return
    fi

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
backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
backup_and_link "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
backup_and_link "$DOTFILES_DIR/config/sheldon" "$HOME/.config/sheldon"
backup_and_link "$DOTFILES_DIR/config/starship/starship.toml" "$HOME/.config/starship.toml"
backup_and_link "$DOTFILES_DIR/config/zsh" "$HOME/.config/zsh"
mkdir -p "$HOME/.config/alacritty"
backup_and_link "$DOTFILES_DIR/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
backup_and_link "$DOTFILES_DIR/config/tmux/.tmux.conf" "$HOME/.tmux.conf"
backup_and_link "$DOTFILES_DIR/emacs" "$HOME/.config/emacs"
mkdir -p "$HOME/.config/herdr"
backup_and_link "$DOTFILES_DIR/config/herdr/config.toml" "$HOME/.config/herdr/config.toml"

# ==============================
# install tools
# ==============================

echo "Installing tools..."

"$DOTFILES_DIR/scripts/install_homebrew.sh"
load_homebrew
"$DOTFILES_DIR/scripts/install_nvim_nightly.sh"
"$DOTFILES_DIR/scripts/install_starship.sh"
"$DOTFILES_DIR/scripts/install_sheldon.sh"
"$DOTFILES_DIR/scripts/install_raycast.sh"
"$DOTFILES_DIR/scripts/install_eza.sh"
"$DOTFILES_DIR/scripts/install_herdr.sh"

echo "Setup complete!"
