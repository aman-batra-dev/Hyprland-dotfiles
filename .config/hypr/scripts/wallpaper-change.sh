#!/bin/bash

CONFIG_FILE=~/.config/hypr/hyprpaper.conf
WALLPAPER_DIR=~/.wallpapers

function set_wallpaper() {
  # Get a random wallpaper
  wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n1)

  # Ensure a wallpaper is selected
  if [[ -z "$wallpaper" ]]; then
    echo "No wallpapers found! Exiting..."
    exit 1
  fi

  # Write new config BEFORE restarting hyprpaper
  echo "splash = false" > "$CONFIG_FILE"
  echo "ipc = true" >> "$CONFIG_FILE"

  monitors=$(hyprctl monitors -j | jq -r ".[].name")
  for monitor in $monitors; do
    echo "preload = $wallpaper" >> "$CONFIG_FILE"
    echo "wallpaper = $monitor,$wallpaper" >> "$CONFIG_FILE"
  done

  # Restart hyprpaper AFTER writing the config
  pkill -x hyprpaper
  sleep 0.5  # Prevents instant fallback to Hyprland's default wallpaper
  hyprpaper &
}

function main() {
  # Start hyprpaper if not running
  if ! pgrep -x "hyprpaper" > /dev/null; then
    hyprpaper &
    sleep 1
  fi

  # Initial wallpaper setup
  set_wallpaper

  # Change wallpaper every 10 minutes
  while true; do
    sleep 10m
    set_wallpaper
  done
}

main

