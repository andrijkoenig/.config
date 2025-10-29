export EDITOR="nvim"
export VISUAL="nvim"

export XDG_CONFIG_HOME=~/.config
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export TERM="xterm-256color"        # Fix tmux color issues

autoload -U colors && colors

setopt autocd 
setopt always_to_end            
setopt correct
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

alias vi="nvim"
alias c="clear"
alias l="ls -lah"
alias la="ls -A"
alias ll="ls -lh"

# Make directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias reload="source ~/.zshrc"

PROMPT='%F{46}%~ ❯ %f'

