local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xff575279,
	black = 0xffF2E9E1,
	grey = 0xff9893A5,
	bg = 0xffFAF4ED,
	fg = 0xff575279,

	mauve = 0xff907AA9,
	red = 0xffB4637A,
	peach = 0xffE59875,
	yellow = 0xffEA9D34,
	green = 0xff286983,
	teal = 0xffD7827E,
	blue = 0xff56949F,

	shadow = 0xffF2E9E1,
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
		bg = 16446701,
		border = 0xff9893A5,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff9893A5,
	bg2 = palette.bg,
	bg1 = 4295689469,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
