export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim -c 'Man!' -o -"
export TERM="tmux-256color"

export XDG_CONFIG_HOME=$HOME/.config


## Aliases

# generic
alias mkd='mkdir -p'
alias cl='clear'
alias upgrade='brew update && brew upgrade && brew upgrade --cask wez/wezterm/wezterm-nightly --no-quarantine --greedy-latest && brew cleanup'

# cd (zoxide)
alias cd='z'

# find (files), search (text) and view
alias f='fd -H'
alias s='rg --hidden'
alias ls='eza --long --no-user --header --icons --git --all --group-directories-first'
alias tree='eza --long --no-user --header --icons --git --all --group-directories-first --tree'

# tasks
alias tui='htop'  # ui
alias tm='mprocs' # manager


# git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gC='git clone'
alias gc='git commit -m'
alias gd='git diff'
alias gm='git merge'
alias gco='git checkout'
alias gn='git checkout -b' # *new* branch
alias gp='git pull'
alias gsp='git stash && git pull && git stash pop'
alias gP='git push'
alias gr='git rebase'
alias gR='git reset'
alias gS='git stash'
alias gs='git status'


# nvim
alias v='nvim'


# tmux
alias t='tmux'
alias td='tmux detach'

alias ts='select_tmux_session.sh'
