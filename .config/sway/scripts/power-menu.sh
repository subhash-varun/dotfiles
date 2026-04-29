#!/usr/bin/env bash

chosen=$(printf "Shutdown\nReboot\nSleep\nLogout" | wofi --dmenu --prompt "Power")

case "$chosen" in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Sleep) systemctl suspend ;;
    Logout) swaymsg exit ;;
esac
