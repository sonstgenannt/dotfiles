#!/usr/bin/env bash

#CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Wallpaper directory
WALLPAPER_DIRECTORY="$HOME/Pictures/Wallpapers"

mapfile -t MONITORS < <(hyprctl monitors | grep "Monitor" | awk '{print $2}')
LENGTH=$(hyprctl monitors | grep -c 'Monitor')

# Select random wallpapers that aren't the null.jpg from the directory
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIRECTORY" -type f ! -name "null.jpg" | shuf -n "$LENGTH")

for i in "${!MONITORS[@]}"; do
   echo $i
   echo ${WALLPAPERS[i]}, ${MONITORS[i]}
   hyprctl hyprpaper reload "${MONITORS[i]}, ${WALLPAPERS[i]}"
done
