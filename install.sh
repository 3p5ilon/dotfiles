#!/bin/bash
# Dotfiles installer - creates symlinks and backs up existing configs

set -e  # Exit immediately if any command fails

echo "Setting up dotfiles..."

# Dependency checks - verify that required tools are installed
if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is required but not installed."
    echo "Install it with:"
    echo "  macOS: brew install stow"
    echo "  Linux: sudo apt install stow"
    exit 1
fi

warn_missing() {
    if ! command -v "$1" &> /dev/null; then
        echo "Warning: '$1' not found — install it before opening Neovim"
    fi
}

warn_missing "nvim"
warn_missing "git"
warn_missing "tmux"
warn_missing "starship"

# Create backup directory with timestamp
# This ensures multiple runs don't overwrite each other's backups
# Format: ~/dotfiles-backup-YYYYMMDD-HHMMSS/
BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "Creating backup at: $BACKUP_DIR"

# Backup existing configuration files (only if they exist)
# The [ -f ] and [ -d ] checks prevent errors if files don't exist
echo "Backing up current configs..."
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$BACKUP_DIR/"
[ -f "$HOME/.vimrc" ] && cp "$HOME/.vimrc" "$BACKUP_DIR/"
[ -f "$HOME/.tmux.conf" ] && cp "$HOME/.tmux.conf" "$BACKUP_DIR/"
[ -f "$HOME/.gitconfig" ] && cp "$HOME/.gitconfig" "$BACKUP_DIR/"
[ -f "$HOME/.config/starship.toml" ] && cp "$HOME/.config/starship.toml" "$BACKUP_DIR/"
[ -d "$HOME/.config/nvim" ] && cp -r "$HOME/.config/nvim" "$BACKUP_DIR/"
[ -d "$HOME/.config/kitty" ] && cp -r "$HOME/.config/kitty" "$BACKUP_DIR/"
[ -d "$HOME/.config/ghostty" ] && cp -r "$HOME/.config/ghostty" "$BACKUP_DIR/"

# Remove existing configs so stow can create symlinks
# rm -rf is safe - it won't error if files don't exist
echo "Removing existing configs..."
rm -rf "$HOME/.config/nvim" \
       "$HOME/.config/kitty" \
       "$HOME/.config/ghostty" \
       "$HOME/.tmux.conf" \
       "$HOME/.zshrc" \
       "$HOME/.vimrc" \
       "$HOME/.gitconfig" \
       "$HOME/.config/starship.toml"

# Create symlinks using stow
echo "Creating symlinks..."
cd "$HOME/.dotfiles"
stow -vt "$HOME" */

# Install Tmux Plugin Manager (TPM) if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already installed."
fi

# Done
echo "Dotfiles installation complete!"
echo "Backup saved at: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Neovim - plugins will install automatically"
echo "  3. Start tmux and press 'Ctrl-s + I' to install plugins"
