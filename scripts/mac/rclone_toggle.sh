#!/bin/bash

# 1. Dynamically read from Environment Variables, Command Arguments, or Defaults
# Format: ${VARIABLE:-FallbackValue}
REMOTE_NAME="${RCLONE_REMOTE:-${1:-your_remote_name:}}"
MOUNT_DIR="${RCLONE_MOUNT_DIR:-${2:-$HOME/CloudDrive}}"
RCLONE_PATH="${RCLONE_BIN_PATH:-${3:-/usr/local/bin}}"

# 2. Toggle logic
if pgrep -x "rclone" > /dev/null; then
    echo "Disconnecting rclone mount from $MOUNT_DIR..."
    diskutil unmount force "$MOUNT_DIR" 2>/dev/null
    killall rclone 2>/dev/null
    rm -rf "$MOUNT_DIR"
    echo "Disconnected."
else
    echo "Cleaning up and mounting $REMOTE_NAME to $MOUNT_DIR..."
    umount "$MOUNT_DIR" 2>/dev/null
    diskutil unmount force "$MOUNT_DIR" 2>/dev/null
    rm -rf "$MOUNT_DIR"
    
    mkdir -p "$MOUNT_DIR"
    sleep 1

    exec "$RCLONE_PATH" mount "$REMOTE_NAME" "$MOUNT_DIR" \
        --vfs-cache-mode full \
        --vfs-cache-max-age 24h \
        --vfs-cache-max-size 10G
fi
