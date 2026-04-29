Primeagen-style Sway profile

Core binds:
- Super+Return: terminal (kitty)
- Super+D: launcher (wofi)
- Super+B: browser (firefox)
- Super+H/J/K/L: focus left/down/up/right
- Super+Shift+H/J/K/L: move window left/down/up/right
- Super+1..0: switch workspace
- Super+Shift+1..0: move window to workspace
- Super+R: resize mode

Screenshots (grim + slurp + wl-copy):
- Print: full screen to clipboard + file
- Shift+Print: region capture to clipboard + file
- Super+Print: region capture to clipboard + file
- Saved in: ~/Pictures/Screenshots

Clipboard history (cliphist + wofi):
- Super+Shift+Y: open clipboard history picker and copy selection back to clipboard
- History watcher auto-starts with sway using `scripts/start-cliphist.sh`

Wallpaper + pywal:
- Super+Shift+W: pick wallpaper with wofi
- Startup restores last wallpaper from: ~/.config/sway/wallpaper
- Running wallpaper picker also refreshes pywal and updates waybar colors

Theme:
- Rose Pine Moon-inspired palette for sway, waybar, wofi, and mako.

Reload without logout:
- swaymsg reload

If some programs are missing, install:
- sway waybar wofi mako kitty brightnessctl wl-clipboard grim slurp swaybg pywal cliphist
