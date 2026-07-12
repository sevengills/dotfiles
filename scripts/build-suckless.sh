#!/bin/sh

read -p "Build suckless tools? [y/N]: " ans

case "$ans" in
  y|Y)
    make -C suckless/dwm && sudo make -C suckless/dwm install
    make -C suckless/dmenu && sudo make -C suckless/dmenu install
    make -C suckless/dwmblocks && sudo make -C suckless/dwmblocks install
    ;;
esac
