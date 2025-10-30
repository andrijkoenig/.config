#!/bin/bash

set -euo pipefail

PROJECT_DIR="$HOME/project"
SESSION_NAME="main"
ZSHRC="$HOME/.zshrc"
export TERM="xterm-256color"  # Ensure color and term correctness for tmux

cd "$PROJECT_DIR" || { echo "Directory not found: $PROJECT_DIR"; exit 1; }

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    exec tmux attach -t "$SESSION_NAME"
fi

if [ -f /tmp/cert.pem ]; then
    echo "Found cert at /tmp/cert.pem, installing..."
    CERT_DIR="/usr/local/share/ca-certificates"
    sudo cp /tmp/cert.pem "$CERT_DIR/custom-cert.crt"
    sudo update-ca-certificates
fi

tmux new-session -d -s "$SESSION_NAME" -n 'editor' -c "$PROJECT_DIR" "zsh -i -c 'nvim'"
tmux new-window -t "$SESSION_NAME:" -n 'shell' -c "$PROJECT_DIR" "zsh -i"
tmux select-window -t "$SESSION_NAME:editor"

exec tmux attach -t "$SESSION_NAME"

