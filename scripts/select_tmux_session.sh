#!/bin/bash

# Check if there are any tmux sessions
SESSIONS=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

if [ -z "$SESSIONS" ]; then
    echo "No tmux sessions found. Creating default session."
    exec tmux new -s main
fi


# Use fzf to select a session
SELECTED=$(echo "$SESSIONS" | fzf --prompt="Select tmux session: ")

# If user cancels fzf, drop into a shell instead of exiting
if [ -z "$SELECTED" ]; then
    exec zsh
fi

exec tmux attach -t "$SELECTED"