SSID=$(networksetup -getairportnetwork en0 | sed -E 's,^Current Wi-Fi Network: (.+)$,\1,')

# FONT="JetBrainsMono Nerd Font Mono"

sketchybar --set $NAME label="$SSID"
