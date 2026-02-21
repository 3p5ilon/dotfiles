# My Dotfiles

Personal development environment configuration files.

## Requirements

- **Git** (for cloning)
  - macOS: `brew install git`
  - Linux: `sudo apt install git`

- **GNU Stow** (for symlink management)
  - macOS: `brew install stow`
  - Linux: `sudo apt install stow`

## Installation

1. Clone the repo to your $HOME directory:

```bash
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. ⚠️ Prepare Your System

Stow cannot overwrite existing files. You must delete or move any current configurations (Neovim, Tmux, Zsh, Kitty, Ghosty, etc.) from your home directory before stowing.

```bash
# 1. Backup your current configs (recommended)
mkdir -p ~/dotfiles-backup
cp ~/.zshrc ~/.tmux.conf ~/dotfiles-backup/ 2>/dev/null
cp -r ~/.config/nvim ~/.config/kitty ~/.config/ghosty ~/dotfiles-backup/ 2>/dev/null

# 2. Remove originals so Stow can create the links (safe since you have backup)
rm -rf ~/.config/nvim ~/.config/kitty ~/.config/ghosty ~/.tmux.conf ~/.zshrc
```

3. Create symlinks:

```bash
# Stow all packages
stow -vt ~ */

# Or install specific app
stow -vt ~ nvim
stow -vt ~ tmux
stow -vt ~ zsh
```
## Troubleshooting

**Conflict Error**: If you encounter "existing target is neither a link nor a directory," a file is blocking Stow. Remove the conflicting file and rerun stow:

```bash
rm -f ~/.filename
stow -vt ~ package-name
```

**Remove Symlinks**: To unlink packages without deleting dotfiles:

```bash
stow -Dt ~ <package-name>
```

## License

MIT
