#!/bin/sh
set -eu
WALLPAPER_DIR="/etc/nixos/modules/wallpapers"
PICKED=$(fd . "$WALLPAPER_DIR" -tf -d1 -x basename | sort | rofi -dmenu -p "Wallpapers") || exit 1

[ -z "$PICKED" ] && exit 0;

pkill swaybg || true

swaybg -mfill -i "$WALLPAPER_DIR/$PICKED" &
