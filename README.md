# Dotfiles

My development configuration files managed with GNU Stow for easy deployment across machines.

## Prerequisites

Ensure you have Git and GNU Stow installed:

```bash
# macOS
brew install git stow

# Linux
sudo apt install git stow
```

## Setup

### 1. Clone the repo to your home directory

```bash
git clone https://github.com/3p5ilon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Backup Existing Configs

Stow cannot overwrite existing files. Back up your current configuration before proceeding:

```bash
# Creating dotfiles-backup in home directory
mkdir -p ~/dotfiles-backup

# Copying existing files to dotfiles-backup
cp -r ~/.config/nvim ~/.config/kitty ~/.tmux.conf ~/.zshrc ~/dotfiles-backup/ 2>/dev/null
```

Then remove the originals so Stow can create symlinks:

```bash
rm -rf ~/.config/nvim ~/.config/kitty ~/.tmux.conf ~/.zshrc
```

### 3. Install Packages

Create symlinks for all packages:

```bash
# Install all packages
stow -vt ~ */

# Or install specific packages
stow -vt ~ nvim tmux zsh
```

To remove symlinks for a package:

```bash
stow -Dt ~ <package-name>
```

## License

MIT
