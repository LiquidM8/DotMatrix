# ~/.zshrc - Structured Basic ZSH Config

# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Loads Completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Sources ZSH Config Files
ZSHRD="${ZDOTDIR:-$HOME}/.zshrc.d"
if [[ -d $ZSHRD ]]; then
    for cfg in $ZSHRD/*.zsh(N); do
        source "$cfg"
    done
fi
unset cfg ZSHRD

# Globbing
setopt CORRECT                # Auto-correct commands
setopt EXTENDED_GLOB          # Use extended globbing

# Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
export PS1=" %F{39}%B󰣇%b%f %1~: "
setopt prompt_subst

eval "$(starship init zsh)"
