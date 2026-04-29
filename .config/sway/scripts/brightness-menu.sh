#!/usr/bin/env sh
set -eu

if ! command -v brightnessctl >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Brightness" "brightnessctl is not installed"
    exit 1
fi
if ! command -v wofi >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Brightness" "wofi is not installed"
    exit 1
fi

current="$(brightnessctl -m | cut -d, -f4)"
choices="10%\n20%\n30%\n40%\n50%\n60%\n70%\n80%\n90%\n100%"

selected="$(printf '%b\n' "$choices" | wofi --dmenu --prompt "brightness (${current})")" || exit 0
[ -n "$selected" ] || exit 0

case "$selected" in
    *%)
        brightnessctl set "$selected" >/dev/null
        ;;
    *)
        exit 0
        ;;
esac

command -v notify-send >/dev/null 2>&1 && notify-send "Brightness" "Set to $selected"
