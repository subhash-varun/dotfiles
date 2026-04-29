#!/usr/bin/env sh
set -eu

if ! command -v cliphist >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Clipboard" "cliphist is not installed"
    exit 1
fi
if ! command -v wofi >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Clipboard" "wofi is not installed"
    exit 1
fi
if ! command -v wl-copy >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Clipboard" "wl-copy is not installed"
    exit 1
fi

selection="$(cliphist list | wofi --dmenu --prompt 'Clipboard')" || exit 0
[ -n "$selection" ] || exit 0

printf '%s\n' "$selection" | cliphist decode | wl-copy
command -v notify-send >/dev/null 2>&1 && notify-send "Clipboard" "Copied selection to clipboard"
