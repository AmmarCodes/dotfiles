local colors = require("colors")
local settings = require("settings")

local cal = sbar.add("item", {
	display = 1,
	icon = {
		color = colors.white,
		padding_left = 10,
		-- padding_right = 10,
		font = {
			style = settings.font.style_map["Regualr"],
			size = 12,
		},
		align = "left",
	},
	label = {
		color = colors.white,
		padding_right = 10,
		padding_left = 2,
		align = "right",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 15,
		},
	},
	position = "right",
	update_freq = 30,
	padding_left = 1,
	padding_right = 1,
	background = {
		color = colors.item_bg_color,
	},
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

cal:subscribe({ "forced", "routine", "system_woke" }, function()
	cal:set({ icon = os.date("%a %d %b"), label = os.date("%H:%M") })
end)
