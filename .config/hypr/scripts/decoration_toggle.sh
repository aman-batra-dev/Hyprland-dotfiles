#!/bin/bash

# File to track current state
STATE_FILE="/tmp/hypr_visuals_enabled"

if [ -f "$STATE_FILE" ]; then
    # Currently enabled – disable blur and shadows
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword decoration:shadow:enabled false
    hyprctl keyword animations:enabled false
    hyprctl keyword misc:vfr false
    notify-send "Hyprland Visuals" "Blur and shadows disabled for performance"
    rm -f "$STATE_FILE"
else
    # Currently disabled – enable blur and shadows
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword decoration:shadow:enabled true
    hyprctl keyword animations:enabled true
    hyprctl keyword misc:vfr true
    notify-send "Hyprland Visuals" "Blur and shadows enabled"
    touch "$STATE_FILE"
fi

