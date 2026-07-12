#!/bin/sh

try() { "$@" >/dev/null 2>&1 || true; }

[ -f "$HOME/.config/zsh/.zprofile" ] && . "$HOME/.config/zsh/.zprofile"

try setxkbmap -option caps:escape
try wal -R

try feh --bg-scale "$HOME/dotfiles/others/knight.png" &
try dunst &
try picom &
try dwmblocks &

exec dwm
