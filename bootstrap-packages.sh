#!/usr/bin/env bash

sudo pacman -S --needed \
  git stow zsh neovim tmux \
  ripgrep fzf curl jq wget xclip \
  wireplumber \
  xorg-server xorg-xinit base-devel \
  libx11 libxft libxft libxinerama \
  feh picom dunst python-pywal \
  playerctl brightnessctl
