local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffBAC2DE,
	black = 0xff45475A,
	grey = 0xff585B70,
	bg = 0xff1E1E2E,
	fg = 0xffCDD6F4,

	mauve = 0xffF5C2E7,
	red = 0xffF38BA8,
	peach = 0xffE59875,
	yellow = 0xffF9E2AF,
	green = 0xffA6E3A1,
	teal = 0xff94E2D5,
	blue = 0xff89B4FA,

	shadow = 0xff45475A,
}

return {
	transparent = 0x00000000,

	black = palette.black,
	grey = palette.grey,
	white = palette.white,
	fg = palette.fg,

	orange = palette.peach,
	magenta = palette.mauve,

	mauve = palette.mauve,
	red = palette.red,
	peach = palette.peach,
	yellow = palette.yellow,
	green = palette.green,
	teal = palette.teal,
	blue = palette.blue,

	bar = {
		bg = 1973806,
		border = 0xff585B70,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff585B70,
	bg2 = palette.bg,
	bg1 = 4281216574,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
