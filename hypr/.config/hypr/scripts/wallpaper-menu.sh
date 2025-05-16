#!/bin/bash
export PATH="$HOME/.local/bin/:$PATH"
HYPRPAPER_CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"

# FOLDER EXISTS VERIFICATION
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Wallpaper directory $WALLPAPER_DIR doesn't exist."
  notify-send "ERROR:" "Wallpaper directory $WALLPAPER_DIR doesn't exist."
  exit 1
fi

SELECTED=$(find -L "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) | rofi -dmenu -p "Select a wallpaper")

[ -z "$SELECTED" ] && exit 0

# HYPRPAPER CONFIG
wal -i "$SELECTED" --cols16
hyprctl hyprpaper reload ,"$SELECTED"
echo "preload = $SELECTED" > "$HYPRPAPER_CONFIG_FILE"
echo "wallpaper = $MONITOR_NAME,$SELECTED" >> "$HYPRPAPER_CONFIG_FILE"


notify-send -i $SELECTED "Wallpaper updated" "$(basename "$SELECTED")"
