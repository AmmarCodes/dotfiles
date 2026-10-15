#!/bin/sh
# Polls the Mullvad CLI and colours the widgets.vpn item (see items/vpn.lua).
# Runs as the item's script, so sketchybar calls it every update_freq seconds.

CONFIG_DIR=${CONFIG_DIR:-"$HOME/.config/sketchybar"}
MULLVAD="/Applications/Mullvad VPN.app/Contents/Resources/mullvad"

if [ ! -x "$MULLVAD" ]; then
	sketchybar --set widgets.vpn drawing=off
	exit 0
fi

state=$("$MULLVAD" status 2>/dev/null | head -n 1 | tr -d '[:space:]')

# Icon and colours come from the lua config, which is the single source of
# truth for the icon set (settings.icons) and the active theme palette.
read -r icon color <<EOF
$(STATE="$state" lua -e "
package.path = '$CONFIG_DIR/?.lua;' .. package.path
local icons, colors = require('icons'), require('colors')
local state = os.getenv('STATE')
local on = state == 'Connected'
local icon = on and icons.switch.on or icons.switch.off
local color = on and colors.green or (state == 'Blocked' and colors.yellow or colors.grey)
print(icon .. ' ' .. string.format('0x%x', color))
")
EOF

sketchybar --set widgets.vpn icon="$icon" icon.color="$color"
