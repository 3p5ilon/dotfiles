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

1. Clone the repo to your home directory:

```bash
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. ⚠️ **Important**: Stow will not create symlinks if files already exist. Back up or remove your existing configs:

```bash
# Backup your current configs (recommended)
mkdir -p ~/dotfiles-backup
cp ~/.zshrc ~/dotfiles-backup/ 2>/dev/null
cp ~/.tmux.conf ~/dotfiles-backup/ 2>/dev/null
cp -r ~/.config/nvim ~/dotfiles-backup/ 2>/dev/null

# Remove existing files (safe since you have backup)
rm -rf ~/.config/nvim ~/.tmux.conf ~/.zshrc

```

3. Create symlinks:

```bash
stow -vt ~ */
```

