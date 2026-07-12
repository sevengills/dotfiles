#!/usr/bin/env bash
set -euo pipefail

SRC="$HOME/dotfiles/scripts"
DEST="$HOME/.local/bin/scripts"

mkdir -p "$DEST"

find "$SRC" -type f | while read -r file; do
    name="$(basename "$file")"

    # skip docs / hidden files / non-scripts
    case "$name" in
        README*|readme*|*.md|*.org) continue ;;
    esac

    # only link executable files
    if [ -x "$file" ]; then
        ln -sf "$file" "$DEST/$name"
        echo "Linked: $name"
    fi
done
