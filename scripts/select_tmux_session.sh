#!/bin/bash

# Check if there are any tmux sessions
SESSIONS=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

if [ -z "$SESSIONS" ]; then
    echo "No tmux sessions running."
    exit 1
fi

# Use fzf to select a session
SELECTED=$(echo "$SESSIONS" | fzf --prompt="Select tmux session: ")

if [ -n "$SELECTED" ]; then
    tmux attach -t "$SELECTED"
fi
