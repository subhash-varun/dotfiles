#!/usr/bin/env sh
set -eu

wallpaper_dir="${XDG_WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"

choices="$(find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | sort)"
[ -n "$choices" ] || exit 0

selected="$(printf '%s\n' "$choices" | wofi --dmenu --prompt wallpaper)" || exit 0
[ -n "$selected" ] || exit 0

"${XDG_CONFIG_HOME:-$HOME/.config}/sway/scripts/set-wallpaper.sh" "$selected"
