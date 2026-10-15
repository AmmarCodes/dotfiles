local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Polling lives in the item's script (items/vpn.sh): sketchybar only delivers
-- its own built-in events to lua items -- "routine" and custom `--trigger`
-- events never reach the lua callbacks. Note that calling `vpn:subscribe()`
-- here would clear the item's `script`, so the click is handled with
-- click_script instead.
local vpn = sbar.add("item", "widgets.vpn", {
	position = "right",
	y_offset = 1,
	icon = {
		string = icons.switch.off,
		color = colors.grey,
	},
	label = { drawing = false },
	update_freq = 10,
	script = "$CONFIG_DIR/items/vpn.sh",
	click_script = "open -a 'Mullvad VPN'",
})

-- Background around the item
sbar.add("bracket", "widgets.vpn.bracket", { vpn.name }, {
	background = { color = colors.item_bg_color },
})

sbar.add("item", "widgets.vpn.padding", {
	position = "right",
	width = settings.group_paddings,
})
