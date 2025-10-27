export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export TERM="xterm-256color"        # Fix tmux color issues

autoload -U colors && colors
PROMPT='%n@%m %{$fg[green]%}%~%{$reset_color%} $ '

source <(fzf --zsh)
setopt autocd             
setopt correct
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

export HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd:vim'

alias vim="nvim"
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
