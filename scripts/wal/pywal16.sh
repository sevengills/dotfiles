#!/usr/bin/env bash
set -e

# ------------------------------
# Sync pywal-generated configs
# ------------------------------

ln -sf ~/.cache/wal/picom.conf        ~/.config/picom/picom.conf
ln -sf ~/.cache/wal/dunstrc            ~/.config/dunst/dunstrc
# ln -sf ~/.cache/wal/vars               ~/.config/shell/vars
ln -sf ~/.cache/wal/pywal16.yml        ~/.config/termusic/themes/pywal16.yml

# ------------------------------
# Reload / refresh running apps
# ------------------------------

# Reload dunst cleanly
pkill dunst || true
setsid -f dunst >/dev/null 2>&1

# Reload qutebrowser colors if running
pgrep qutebrowser >/dev/null && \
  qutebrowser ':config-source' || true

# Refresh dwm bar (your custom script / signal)
refresh || true

# ------------------------------
# Optional: RGB sync (hardware)
# ------------------------------

if [ -f ~/.cache/wal/rgb ]; then
  sudo openrgb \
    --noautoconnect \
    -c "$(tail -n +2 ~/.cache/wal/rgb)" \
    -b 65
fi

# ------------------------------
# Notify user
# ------------------------------

notify-send "Pywal" "Wallpaper and colorscheme applied"
