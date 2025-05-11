#!/bin/bash

PROJECT_DIR="$HOME/project"
SESSION_NAME="main"

# Change to the project directory
cd "$PROJECT_DIR" || { echo "Directory not found: $PROJECT_DIR"; exit 1; }

# Create a new tmux session with the first window running nvim
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" 'nvim'

# Create a second window in the same directory using the default shell
tmux new-window -t "$SESSION_NAME:" -n 'shell' -c "$PROJECT_DIR"

# Attach to the tmux session
tmux attach-session -t "$SESSION_NAME"