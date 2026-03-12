# Dotfiles

My development configuration managed with GNU Stow for easy deployment across machines.

> [!WARNING]
> This repository will overwrite your existing configuration files. A backup is created automatically during installation.

## Prerequisites

```bash
# macOS
xcode-select --install
brew install git stow neovim tmux starship node ripgrep \
             fzf fd eza zoxide bat yazi btop fastfetch tlrc lazygit
brew install --cask kitty ghostty font-jetbrains-mono-nerd-font

# Linux (Ubuntu/Debian)
sudo apt install git stow neovim tmux nodejs gcc make ripgrep fzf fd-find eza zoxide bat lazygit
curl -sS https://starship.rs/install.sh | sh
# Kitty:   https://sw.kovidgoyal.net/kitty/
# Ghostty: https://ghostty.org/download
# Font:    https://www.nerdfonts.com/font-downloads (JetBrainsMono Nerd Font)
```

> [!NOTE]
> `node`, `gcc`, `make`, and `ripgrep` are required for Neovim LSP servers and Telescope.

## Quick Install

```bash
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Manual Installation

```bash
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Backup existing configs
mkdir -p ~/dotfiles-backup
cp ~/.zshrc ~/.vimrc ~/.tmux.conf ~/dotfiles-backup/ 2>/dev/null
cp -r ~/.config/nvim ~/.config/kitty ~/.config/ghostty ~/dotfiles-backup/ 2>/dev/null
cp -r ~/.config/bat ~/.config/btop ~/.config/fastfetch ~/.config/yazi ~/dotfiles-backup/ 2>/dev/null
cp ~/.config/starship.toml ~/dotfiles-backup/ 2>/dev/null

# Remove originals
rm -rf ~/.config/nvim ~/.config/kitty ~/.config/ghostty \
       ~/.config/bat ~/.config/btop ~/.config/fastfetch ~/.config/yazi \
       ~/.tmux.conf ~/.zshrc ~/.vimrc ~/.config/starship.toml

# Create symlinks (*/ stows directories only, files are safe)
stow -vt ~ */

# Install TPM and tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
```

## What's Included

### Core

| Tool                                                         | Location                  | Description                                      |
| ------------------------------------------------------------ | ------------------------- | ------------------------------------------------ |
| [Neovim](https://github.com/neovim/neovim)                   | `~/.config/nvim`          | Text editor with LSP, treesitter, telescope, DAP |
| [Tmux](https://github.com/tmux/tmux)                         | `~/.tmux.conf`            | Terminal multiplexer                             |
| [Kitty](https://github.com/kovidgoyal/kitty)                 | `~/.config/kitty`         | GPU-accelerated terminal                         |
| [Ghostty](https://github.com/ghostty-org/ghostty)            | `~/.config/ghostty`       | Fast native terminal                             |
| [Vim](https://github.com/vim/vim)                            | `~/.vimrc`                | Basic Vim config with essential plugins          |
| [Zsh](https://www.zsh.org) + [Oh-My-Zsh](https://ohmyz.sh)   | `~/.zshrc`                | Shell with plugins                               |
| [Starship](https://github.com/starship/starship)             | `~/.config/starship.toml` | Cross-shell prompt                               |
| [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) | —                         | Colorscheme across all tools                     |
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)        | —                         | Monospace font with icons                        |
| [GNU Stow](https://www.gnu.org/software/stow/)               | `~/.dotfiles`             | Dotfiles manager                                 |

### CLI Tools

| Tool                                                    | Location              | Replaces | Description                           |
| ------------------------------------------------------- | --------------------- | -------- | ------------------------------------- |
| [eza](https://github.com/eza-community/eza)             | `~/.zshrc`            | `ls`     | Better ls with icons and git status   |
| [bat](https://github.com/sharkdp/bat)                   | `~/.config/bat`       | `cat`    | Better cat with syntax highlighting   |
| [zoxide](https://github.com/ajeetdsouza/zoxide)         | `~/.zshrc`            | `cd`     | Smart cd that learns your habits      |
| [fzf](https://github.com/junegunn/fzf)                  | `~/.zshrc`            | —        | Fuzzy finder for files, history, dirs |
| [fd](https://github.com/sharkdp/fd)                     | `~/.zshrc`            | `find`   | Better find                           |
| [ripgrep](https://github.com/BurntSushi/ripgrep)        | `~/.zshrc`            | `grep`   | Better grep                           |
| [tldr](https://github.com/dbrgn/tealdeer)               | `~/.zshrc`            | `man`    | Simplified man pages                  |
| [yazi](https://github.com/sxyazi/yazi)                  | `~/.config/yazi`      | —        | Terminal file manager                 |
| [btop](https://github.com/aristocratos/btop)            | `~/.config/btop`      | `top`    | System monitor                        |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | `~/.config/fastfetch` | —        | System info display                   |

## Post-Installation

- **Neovim**: Open `nvim` — plugins auto-install via lazy.nvim, then wait for Mason to finish
- **Tmux**: Plugins are installed automatically — if missing, press `Ctrl-s + I` inside tmux
- **Shell**: Restart your terminal or run `source ~/.zshrc`

## Managing Configs

```bash
stow -vt ~ nvim       # stow a package
stow -Dvt ~ nvim      # remove symlinks
ls -la ~/.config/nvim # verify: should point to ~/.dotfiles/nvim/.config/nvim
```

## License

MIT
