
#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
DAY=$(date +%j)
WALLPAPER=$(ls -1 "$WALLPAPER_DIR" | sed -n "$(( (DAY % $(ls -1 "$WALLPAPER_DIR" | wc -l)) + 1 ))p")

# Kill any previous swaybg instance
pkill swaybg

# Launch swaybg with selected wallpaper
swaybg -i "$WALLPAPER_DIR/$WALLPAPER" -m fill &

# Run Wallust for theming
wallust run -c "$HOME/.config/wallust/wallust.toml" "$WALLPAPER_DIR/$WALLPAPER"
