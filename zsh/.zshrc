export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

export EDITOR='nvim'
alias g++="/opt/homebrew/bin/g++-15"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Conda initialization
__conda_setup="$('/Users/talapa/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/talapa/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/talapa/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/talapa/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/talapa/.bun/_bun" ] && source "/Users/talapa/.bun/_bun"

# Disable Ctrl+s so tmux can use it as prefix
stty -ixon

# Antigravity
export PATH="/Users/talapa/.antigravity/antigravity/bin:$PATH"
