#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/DotfileSync.java/DotfileSync.java"
OUT="$ROOT/.dotfiles-sync"

mkdir -p "$OUT"
javac -d "$OUT" "$SRC"
exec java -cp "$OUT" DotfileSync "$@"
