export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export TERM="xterm-256color"        # Fix tmux color issues

autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

alias vim="nvim"
alias vi="nvim"

alias ..="cd .."
alias ...="cd ../.."

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

setopt autocd             # 'foldername' -> cd foldername
setopt correct            # command typo correction
setopt histignoredups     # don't store duplicate history
setopt share_history      # share history across terminals