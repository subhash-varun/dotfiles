#!/usr/bin/env sh
set -eu

command -v wl-paste >/dev/null 2>&1 || exit 0
command -v cliphist >/dev/null 2>&1 || exit 0

pkill -f "wl-paste --type text --watch cliphist store" 2>/dev/null || true
pkill -f "wl-paste --type image --watch cliphist store" 2>/dev/null || true

wl-paste --type text --watch cliphist store >/dev/null 2>&1 &
wl-paste --type image --watch cliphist store >/dev/null 2>&1 &
