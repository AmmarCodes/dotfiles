local colors = require("colors")

local prayers = sbar.add("item", {
	icon = { string = "", padding_left = 9, color = colors.lavender },
	padding_left = 6,
	padding_right = 0,
	label = { font = { size = 12 }, padding_right = 9 },
	position = "q",
	background = {
		color = colors.item_bg_color,
	},
	update_freq = 30,
})

prayers:subscribe({ "forced", "routine" }, function()
	local handle = io.popen("~/Library/Application\\ Support/xbar/plugins/prayer-times.30s.js")
	local all_data = handle:read("*a")
	handle:close()

	local remaining = all_data:match("^(.-)\n"):match("%d+:%d+")
	local hours, minutes = remaining:match("(%d+):(%d+)")

	local color
	if tonumber(hours) == 0 and tonumber(minutes) <= 15 then
		color = colors.red
	else
		color = colors.white
	end

	prayers:set({ label = { string = remaining, color = color } })
end)
