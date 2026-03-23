# dotfiles

<div align="center">
  <img src="https://github.com/user-attachments/assets/4c805f83-15e9-44cd-b6ba-e254f5287c2a" alt="Neovim" width="100%"/>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/80f3a899-58b4-44a4-9800-1eace2dfe554" alt="Yazi" width="49%"/>
  <img src="https://github.com/user-attachments/assets/1e8f9b63-8c83-4a75-a785-6f256a8498a6" alt="CLI Tools" width="49%"/>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/9c00a654-b548-4391-83c4-559b4943c2cd" alt="Btop" width="49%"/>
  <img src="https://github.com/user-attachments/assets/ec18b47b-4bdd-4ea5-92c8-79521675d9c6" alt="fastfetch" width="49%"/>
</div>

## About

My development environment for macOS and Linux, managed with GNU Stow for easy deployment across machines.

> Feel free to use as inspiration, but make sure you understand what each config does before copying. When in doubt, Google it or ask AI.

## What's Included

### Core

| Tool                                                         | Location                  | Description                                                                        |
| ------------------------------------------------------------ | ------------------------- | ---------------------------------------------------------------------------------- |
| [Neovim](https://github.com/neovim/neovim)                   | `~/.config/nvim`          | Text editor with LSP, treesitter, fzf, DAP                                         |
| [Tmux](https://github.com/tmux/tmux)                         | `~/.tmux.conf`            | Terminal multiplexer                                                               |
| [Kitty](https://github.com/kovidgoyal/kitty)                 | `~/.config/kitty`         | GPU-accelerated terminal                                                           |
| [Ghostty](https://github.com/ghostty-org/ghostty)            | `~/.config/ghostty`       | Fast native terminal                                                               |
| [Vim](https://github.com/vim/vim)                            | `~/.vimrc`                | Basic Vim config with essential plugins                                            |
| [Zsh](https://www.zsh.org)                                   | `~/.zshrc`                | Shell with [Zinit plugin manager](https://github.com/zdharma-continuum/zinit)      |
| [Starship](https://github.com/starship/starship)             | `~/.config/starship.toml` | Cross-shell prompt                                                                 |
| [Git](https://git-scm.com)                                   | `~/.gitconfig`            | Git config with [delta](https://github.com/dandavison/delta) and sensible defaults |
| [Delta](https://github.com/dandavison/delta)                 | `~/.config/delta`         | Syntax-highlighted git diffs with Catppuccin theme                                 |
| [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) | —                         | Colorscheme across all tools                                                       |
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)        | —                         | Monospace font with icons                                                          |
| [GNU Stow](https://www.gnu.org/software/stow/)               | `~/.dotfiles`             | Dotfiles manager                                                                   |

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
| [lazygit](https://github.com/jesseduffield/lazygit)     | `~/.zshrc`            | —        | Terminal UI for git                   |
| [delta](https://github.com/dandavison/delta)            | `~/.gitconfig`        | —        | Better git diff pager                 |

## Setup

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to symlink dotfiles into the appropriate locations.

> [!WARNING]
> This will overwrite your existing configuration files. A backup is created automatically during installation.

### Prerequisites

```bash
# macOS
xcode-select --install  # gcc, make, git, python3
brew install git stow neovim tmux starship node python go \
             ripgrep fzf fd eza zoxide bat yazi btop fastfetch tlrc lazygit git-delta
brew install --cask kitty ghostty font-jetbrains-mono-nerd-font
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  # rust

# Linux (Ubuntu/Debian)
sudo apt update && sudo apt install -y git stow neovim tmux nodejs python3 python3-pip golang \
    ripgrep fzf fd-find eza zoxide bat yazi btop fastfetch tlrc lazygit gcc make
curl -sS https://starship.rs/install.sh | sh  # starship
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  # rust
cargo install git-delta  # delta
# Kitty:   https://sw.kovidgoyal.net/kitty/
# Ghostty: https://ghostty.org/download
# Font:    https://www.nerdfonts.com/font-downloads (JetBrainsMono Nerd Font)
```

> [!NOTE]
> If you encounter errors during installation, refer to the package's documentation.
>
> `node`, `gcc`, `make`, `python3`, `go`, `rustc`, and `ripgrep` are required for Neovim LSP servers and DAP debuggers.

### Quick Install

```bash
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

./install.sh
```

### Manual Installation

```bash
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Backup existing configs
mkdir -p ~/dotfiles-backup
cp ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.gitconfig ~/.gitignore_global ~/dotfiles-backup/ 2>/dev/null
cp -r ~/.config/nvim ~/.config/kitty ~/.config/ghostty ~/dotfiles-backup/ 2>/dev/null
cp -r ~/.config/bat ~/.config/btop ~/.config/fastfetch ~/.config/yazi ~/.config/delta ~/dotfiles-backup/ 2>/dev/null
cp ~/.config/starship.toml ~/dotfiles-backup/ 2>/dev/null

# Remove originals
rm -rf ~/.config/nvim ~/.config/kitty ~/.config/ghostty \
       ~/.config/bat ~/.config/btop ~/.config/fastfetch ~/.config/yazi ~/.config/delta \
       ~/.tmux.conf ~/.zshrc ~/.vimrc ~/.gitconfig ~/.gitignore_global \
       ~/.config/starship.toml

# Create symlinks
stow -vt ~ */

# Install TPM and tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
```

### Post-Installation

- **Neovim**: Open `nvim` — plugins auto-install via lazy.nvim, then wait for Mason to finish
- **Tmux**: Plugins are installed automatically via TPM — if missing, press `Ctrl-a + I` inside tmux
- **Shell**: Restart your terminal or run `source ~/.zshrc` — Zinit will auto-install all Zsh plugins on first run
- **Git**: Update `[user]` and `[github]` in `git/.gitconfig` with your own details

### Managing Configs

```bash
stow -vt ~ nvim       # stow a package
stow -Dvt ~ nvim      # remove symlinks
ls -la ~/.config/nvim # verify: should point to ~/.dotfiles/nvim/.config/nvim
```

## License

MIT
