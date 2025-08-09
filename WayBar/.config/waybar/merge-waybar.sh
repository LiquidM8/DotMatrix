#!/bin/bash
# Author: LiquidM8
# Usage: Merge Waybar configuration and styles

CONFIG_DIR="$HOME/.config/waybar"

# Merge JSONC configuration files into one
# Uses slurp to combine all JSONC files in config.d
# Applies config to standard config file
jq --slurp 'add' "$CONFIG_DIR"/config.d/*.jsonc >"$CONFIG_DIR/config"

# Merge CSS fragments into one style file
cat "$CONFIG_DIR"/style.d/*.css >"$CONFIG_DIR/style.css"

# Reloads Waybar if running to apply changes
pkill -SIGUSR2 waybar 2>/dev/null || waybar &
