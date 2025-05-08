export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

autoload -U colors && colors

PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '

alias vim="nvim"
alias vi="nvim"
alias tm="tmux attach || tmux new -s main"
alias ..="cd .."
alias ...="cd ../.."
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

alias reload="source ~/.zshrc"

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^R' history-incremental-search-backward  # Ctrl+R search
