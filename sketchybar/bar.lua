local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = settings.bar_height,
	color = colors.bar.bg,
	-- margin = 4,
	corner_radius = settings.corner_radius,
	shadow = false,
	blur_radius = 10,
	padding_right = 12,
	padding_left = 12,
	y_offset = 0,
})
