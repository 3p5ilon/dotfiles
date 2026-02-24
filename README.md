# Dotfiles

My development configuration managed with GNU Stow for easy deployment across machines.

> [!WARNING]
> This repository will overwrite your existing configuration files and may affect your current environment.
>
> A backup is created automatically during installation.

## Prerequisites

Install the required tools:

```bash
# macOS
brew install git stow neovim tmux starship kitty ghostty

# Linux (Ubuntu/Debian)
sudo apt install git stow neovim tmux
# Starship: curl -sS https://starship.rs/install.sh | sh
# Kitty: https://sw.kovidgoyal.net/kitty/
# Ghostty: https://ghostty.org/download
```

## Quick Install

```bash
# Clone the repository
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installer
./install.sh
```

The installer will:

- Create a timestamped backup of your existing configs.
- Remove originals and create symlinks using GNU Stow.
- Automatically clone [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager).

## Manual Installation

If you prefer to install manually:

```bash
# Clone the repo to your home directory
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Backup existing configs
mkdir -p ~/dotfiles-backup
cp ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.gitconfig ~/dotfiles-backup/ 2>/dev/null
cp -r ~/.config/nvim ~/.config/kitty ~/.config/ghostty ~/dotfiles-backup/ 2>/dev/null
cp ~/.config/starship.toml ~/dotfiles-backup/ 2>/dev/null

# Remove originals
rm -rf ~/.config/nvim ~/.config/kitty ~/.config/ghostty \
       ~/.tmux.conf ~/.zshrc ~/.vimrc ~/.gitconfig \
       ~/.config/starship.toml

# Create symlinks
stow -vt ~ */

# Install TPM (plugin manager):
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## What's Included

| Configuration                                     | Location                  | Description                                             |
| ------------------------------------------------- | ------------------------- | ------------------------------------------------------- |
| [Neovim](https://github.com/neovim/neovim)        | `~/.config/nvim`          | Lua-based editor config with LSP, treesitter, telescope |
| [Vim](https://github.com/vim/vim)                 | `~/.vimrc`                | Basic Vim config with essential plugins                 |
| Zsh                                               | `~/.zshrc`                | Shell aliases, history settings, and starship prompt    |
| [Tmux](https://github.com/tmux/tmux)              | `~/.tmux.conf`            | Terminal multiplexer with vim-tmux-navigator            |
| [Kitty](https://github.com/kovidgoyal/kitty)      | `~/.config/kitty`         | Terminal emulator configuration                         |
| [Ghostty](https://github.com/ghostty-org/ghostty) | `~/.config/ghostty`       | Terminal emulator configuration                         |
| [Starship](https://github.com/starship/starship)  | `~/.config/starship.toml` | Cross-shell prompt                                      |

## Post-Installation

- **Neovim**: Open `nvim` – plugins will auto-install via lazy.nvim
- **Tmux**: Start tmux and press `Ctrl-s + I` to install plugins
- **Shell**: Restart your terminal or run `source ~/.zshrc`

## Managing Configs

```bash
# Install a specific package
stow -vt ~ nvim

# Remove symlinks for a package
stow -Dvt ~ nvim

# Verify symlinks
ls -la .
# or a specific package
ls -la ~/.vimrc
# Expected output: ~/.vimrc -> ~/.dotfiles/vimrc/.vimrc
```

## License

MIT
