#!/bin/bash

PROJECTS_DIR="$HOME/projects"

for dir in "$PROJECTS_DIR"/*; do
    if [ -d "$dir/.git" ]; then
        ./create_tmux_session.sh "$dir"
    fi
done

echo "All projects processed."
