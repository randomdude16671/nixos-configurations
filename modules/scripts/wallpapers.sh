#!/bin/sh
set -eu 

WALLPAPER_DIR="/home/ghost/nixos/modules/wallpapers"
PICKED=$(fd . "$WALLPAPER_DIR" -tf -d1 -x basename | sort | fuzzel --dmenu) || exit 1

[ -z "$PICKED" ] && exit 0;

pkill swaybg || true

swaybg -mfill -i "$WALLPAPER_DIR/$PICKED" &
