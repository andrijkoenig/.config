#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECTS_DIR="$HOME/projects"

for dir in "$PROJECTS_DIR"/*; do
    if [ -d "$dir/.git" ]; then
        "$SCRIPT_DIR/create_tmux_session.sh" "$dir"
    fi
done

echo "All projects processed."
