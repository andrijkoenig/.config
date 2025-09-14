export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export TERM="xterm-256color"        # Fix tmux color issues

autoload -U colors && colors
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "

source <(fzf --zsh)
setopt autocd             
setopt correct

export HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd:vim'

alias vim="nvim"
alias vi="nvim"

alias c="clear"
alias l="ls -lah"
alias la="ls -A"
alias ll="ls -lh"

alias tm="tmux attach || tmux new -s main"

alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

# Make directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias reload="source ~/.zshrc"
