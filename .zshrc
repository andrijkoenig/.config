export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export TERM="xterm-256color"        # Fix tmux color issues

autoload -U colors && colors
autoload -Uz vcs_info

precmd() { vcs_info }  # Update Git info before each prompt

zstyle ':vcs_info:git:*' formats '(%b)'
PROMPT='%F{green}%n@%m%f %F{blue}%~%f %F{yellow}${vcs_info_msg_0_}%f %# '

alias vim="nvim"
alias vi="nvim"
alias ..="cd .."
alias ...="cd ../.."

alias tm="tmux attach || tmux new -s main"

alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

alias reload="source ~/.zshrc"

setopt autocd             # 'foldername' -> cd foldername
setopt correct            # command typo correction
setopt histignoredups     # don't store duplicate history
setopt share_history      # share history across terminals