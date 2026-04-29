#!/usr/bin/env sh
set -eu

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/sway"
state_file="$config_dir/wallpaper"
waybar_color_file="${XDG_CONFIG_HOME:-$HOME/.config}/waybar/colors.css"
wallpaper_dir="${XDG_WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"

pick_first_image() {
    find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | head -n 1
}

if [ "$#" -gt 0 ]; then
    wallpaper="$1"
    printf '%s\n' "$wallpaper" > "$state_file"
elif [ -f "$state_file" ]; then
    wallpaper="$(cat "$state_file")"
else
    wallpaper="$(pick_first_image || true)"
fi

if [ -z "${wallpaper:-}" ] || [ ! -f "$wallpaper" ]; then
    swaymsg output '*' bg '#191724' solid_color >/dev/null 2>&1 || true
    command -v notify-send >/dev/null 2>&1 && notify-send "Wallpaper" "No valid wallpaper found"
    exit 0
fi

swaymsg output '*' bg "$wallpaper" fill >/dev/null 2>&1 || true

if command -v wal >/dev/null 2>&1; then
    wal -q -n -i "$wallpaper" >/dev/null 2>&1 || true
    if [ -f "$HOME/.cache/wal/colors-waybar.css" ]; then
        cp "$HOME/.cache/wal/colors-waybar.css" "$waybar_color_file"
        pkill -USR2 -x waybar >/dev/null 2>&1 || true
    fi
fi

command -v notify-send >/dev/null 2>&1 && notify-send "Wallpaper set" "$(basename "$wallpaper")"
