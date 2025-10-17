local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 24,
	color = colors.bar.bg,
	margin = 4,
	corner_radius = 6,
	shadow = false,
	blur_radius = 10,
	padding_right = 0,
	padding_left = 0,
	y_offset = 0,
})
