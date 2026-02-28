local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xff5C5F77,
	black = 0xffBCC0CC,
	grey = 0xffACB0BE,
	bg = 0xffEFF1F5,
	fg = 0xff4C4F69,

	mauve = 0xffEA76CB,
	red = 0xffD20F39,
	peach = 0xffE59875,
	yellow = 0xffDF8E1D,
	green = 0xff40A02B,
	teal = 0xff179299,
	blue = 0xff1E66F5,

	shadow = 0xffBCC0CC,
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
		bg = 15725045,
		border = 0xffACB0BE,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xffACB0BE,
	bg2 = palette.bg,
	bg1 = 4294967813,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
