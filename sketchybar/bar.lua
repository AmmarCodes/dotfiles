local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 26,
	color = colors.item_bg_color, -- colors.bar.bg
	margin = 6,
	corner_radius = 6,
	shadow = true,
	blur_radius = 10,
	padding_right = 0,
	padding_left = 0,
	y_offset = 4,
})
