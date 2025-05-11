#!/bin/bash

PROJECT_DIR="$HOME/project"
SESSION_NAME="main"
ZSHRC="$HOME/.zshrc"
export TERM="xterm-256color"  # Set TERM explicitly before starting tmux

cd "$PROJECT_DIR" || { echo "Directory not found: $PROJECT_DIR"; exit 1; }

# Start nvim in a zsh shell with .zshrc sourced to ensure color and env correctness
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" "zsh -i -c 'nvim'"

# Start a second zsh shell window, interactive
tmux new-window -t "$SESSION_NAME:" -n 'shell' -c "$PROJECT_DIR" "zsh -i"

tmux attach-session -t "$SESSION_NAME"
