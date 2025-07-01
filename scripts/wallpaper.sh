#!/usr/bin/env bash

#CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Wallpaper directory
WALLPAPER_DIRECTORY="$HOME/Pictures/Wallpapers"

mapfile -t MONITORS < <(hyprctl -j monitors | jq -r '.[].name')
LENGTH=$(hyprctl monitors | grep -c 'Monitor')

# Select random wallpapers that aren't the null.jpg from the directory
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIRECTORY" -type f ! -name "null.jpg" | shuf -n "$LENGTH")

for i in "${!MONITORS[@]}"; do
   echo $i
   echo ${WALLPAPERS[i]}, ${MONITORS[i]}
   hyprctl hyprpaper preload "${WALLPAPERS[i]}"
   echo "PRELOADED"
   hyprctl hyprpaper wallpaper "${MONITORS[i]}, ${WALLPAPERS[i]}"
done

#Unload unused images to free memory
hyprctl hyprpaper unload unused
