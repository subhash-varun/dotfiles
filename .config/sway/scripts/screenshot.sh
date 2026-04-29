#!/usr/bin/env sh
set -eu

mode="${1:-area}"
out_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$out_dir"
file="$out_dir/$(date +%Y-%m-%d_%H-%M-%S).png"

if ! command -v grim >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Screenshot" "grim is not installed"
    exit 1
fi
if ! command -v wl-copy >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Screenshot" "wl-copy is not installed"
    exit 1
fi

case "$mode" in
    full)
        grim - | tee "$file" | wl-copy
        ;;
    area)
        if ! command -v slurp >/dev/null 2>&1; then
            command -v notify-send >/dev/null 2>&1 && notify-send "Screenshot" "slurp is not installed"
            exit 1
        fi
        selection="$(slurp)" || exit 0
        grim -g "$selection" - | tee "$file" | wl-copy
        ;;
    *)
        echo "Usage: $0 [full|area]" >&2
        exit 2
        ;;
esac

command -v notify-send >/dev/null 2>&1 && notify-send "Screenshot copied" "Saved: $file"
