local colors = require("colors")
local settings = require("settings")

local time = sbar.add("item", {
	icon = {
		drawing = false,
	},
	label = {
		color = colors.black,
		padding_right = 10,
		padding_left = 10,
		align = "center",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Black"],
			-- size = 14,
		},
	},
	position = "right",
	update_freq = 30,
	padding_left = 1,
	padding_right = 0,
	background = {
		color = colors.green,
		corner_radius = 8,
	},
})

local date = sbar.add("item", {
	icon = {
		drawing = false,
	},
	label = {
		color = colors.white,
		padding_right = 10,
		padding_left = 2,
		align = "right",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 12,
		},
	},
	position = "right",
	update_freq = 30,
	padding_left = 1,
	padding_right = 1,
	background = {
		color = colors.transparent,
	},
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

time:subscribe({ "forced", "routine", "system_woke" }, function()
	time:set({ label = os.date("%H:%M") })
end)

date:subscribe({ "forced", "routine", "system_woke" }, function()
	date:set({ label = os.date("%a %d %b") })
end)
