#!/bin/bash
# Dotfiles installer — creates symlinks and backs up existing configs
set -e

echo "Setting up dotfiles..."

# Dependency checks
if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is required but not installed."
    echo "  macOS: brew install stow"
    echo "  Linux: sudo apt install stow"
    exit 1
fi

warn_missing() {
    if ! command -v "$1" &> /dev/null; then
        echo "Warning: '$1' not found — $2"
    fi
}

# Core
warn_missing "nvim"      "install neovim"
warn_missing "git"       "install git"
warn_missing "tmux"      "install tmux"
warn_missing "starship"  "install starship"
# Neovim dependencies
warn_missing "node"      "required for LSP servers (ts_ls, eslint, marksman)"
warn_missing "python3"   "required for pyright LSP and debugpy DAP"
warn_missing "make"      "required for telescope-fzf-native"
warn_missing "rg"        "required for telescope live_grep"
warn_missing "gcc"       "required for C/C++ compilation and clangd"
# CLI tools
warn_missing "fzf"       "install fzf"
warn_missing "fd"        "install fd"
warn_missing "eza"       "install eza"
warn_missing "zoxide"    "install zoxide"
warn_missing "bat"       "install bat"
warn_missing "yazi"      "install yazi"
warn_missing "btop"      "install btop"
warn_missing "fastfetch" "install fastfetch"
warn_missing "tldr"      "install tlrc"

# Backup
BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "Creating backup at: $BACKUP_DIR"

echo "Backing up current configs..."
[ -f "$HOME/.zshrc" ]                  && cp "$HOME/.zshrc" "$BACKUP_DIR/"
[ -f "$HOME/.vimrc" ]                  && cp "$HOME/.vimrc" "$BACKUP_DIR/"
[ -f "$HOME/.tmux.conf" ]              && cp "$HOME/.tmux.conf" "$BACKUP_DIR/"
[ -f "$HOME/.config/starship.toml" ]   && cp "$HOME/.config/starship.toml" "$BACKUP_DIR/"
[ -d "$HOME/.config/nvim" ]            && cp -r "$HOME/.config/nvim" "$BACKUP_DIR/"
[ -d "$HOME/.config/kitty" ]           && cp -r "$HOME/.config/kitty" "$BACKUP_DIR/"
[ -d "$HOME/.config/ghostty" ]         && cp -r "$HOME/.config/ghostty" "$BACKUP_DIR/"
[ -d "$HOME/.config/bat" ]             && cp -r "$HOME/.config/bat" "$BACKUP_DIR/"
[ -d "$HOME/.config/btop" ]            && cp -r "$HOME/.config/btop" "$BACKUP_DIR/"
[ -d "$HOME/.config/fastfetch" ]       && cp -r "$HOME/.config/fastfetch" "$BACKUP_DIR/"
[ -d "$HOME/.config/yazi" ]            && cp -r "$HOME/.config/yazi" "$BACKUP_DIR/"

echo "Removing existing configs..."
rm -rf "$HOME/.config/nvim" \
       "$HOME/.config/kitty" \
       "$HOME/.config/ghostty" \
       "$HOME/.config/bat" \
       "$HOME/.config/btop" \
       "$HOME/.config/fastfetch" \
       "$HOME/.config/yazi" \
       "$HOME/.tmux.conf" \
       "$HOME/.zshrc" \
       "$HOME/.vimrc" \
       "$HOME/.config/starship.toml"

echo "Creating symlinks..."
cd "$HOME/.dotfiles"
stow -vt "$HOME" */

# Install TPM
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already installed."
fi

echo "Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo ""
echo "Dotfiles installation complete!"
echo "Backup saved at: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Neovim — plugins and LSP servers will install automatically"
echo "  3. Wait for Mason to finish installing LSP servers"
