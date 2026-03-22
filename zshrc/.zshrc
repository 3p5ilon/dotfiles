# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_all_dups

# Zinit - plugin manager (auto-installs if missing)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Starship prompt (auto-installs from GitHub releases via Zinit)
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Path
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    alias g++="/opt/homebrew/bin/g++-15"
fi
export PATH="$HOME/.local/bin:$PATH"

# Better completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Aliases
alias c='clear'
alias cat="bat"    # better cat
# alias grep="rg"    # better grep
# alias find="fd"    # better find
alias man="tldr"   # better man

# eza - better ls
alias ls="eza --icons --group-directories-first"
alias la="eza -a --icons --group-directories-first"
alias lt="eza --tree --icons"
alias l='eza -l --group-directories-first --icons'
alias ll="eza -la --icons --git --group-directories-first"

# zoxide - smarter cd
eval "$(zoxide init zsh)"
alias cd="z"

# yazi - terminal file manager
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# fzf - fuzzy finder
eval "$(fzf --zsh)"

# fzf catppuccin mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A,border:#6C7086,label:#CDD6F4 \
--height 40% --border rounded --layout reverse"

# fzf with fd integration for file indexing
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --exclude .git"

# fzf previews - use fd for path and directory completion
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# fzf completions - use fd for path and directory completion
_fzf_compgen_path() { fd --hidden --exclude .git . "$1" }
_fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1" }
_fzf_comprun() {
    local command=$1
    shift
    case "$command" in
        cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
        export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
        ssh)          fzf --preview 'dig {}' "$@" ;;
        *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
    esac
}

# Conda
__conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
