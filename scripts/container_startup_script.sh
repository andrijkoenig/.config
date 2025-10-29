#!/bin/bash

PROJECT_DIR="$HOME/project"
SESSION_NAME="main"
ZSHRC="$HOME/.zshrc"
export TERM="xterm-256color"  # Set TERM explicitly before starting tmux

cd "$PROJECT_DIR" || { echo "Directory not found: $PROJECT_DIR"; exit 1; }

# Install SSL cert if provided
if [ -f /tmp/cert.pem ]; then
    CERT_DIR="/usr/local/share/ca-certificates"
    sudo cp /tmp/cert.pem "$CERT_DIR/custom-cert.crt"
    sudo update-ca-certificates
fi

clear

tmux

