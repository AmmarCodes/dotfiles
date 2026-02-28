local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffE5E9F0,
	black = 0xff3B4252,
	grey = 0xff4C566A,
	bg = 0xff2E3440,
	fg = 0xffD8DEE9,

	mauve = 0xffB48EAD,
	red = 0xffBF616A,
	peach = 0xffE59875,
	yellow = 0xffEBCB8B,
	green = 0xffA3BE8C,
	teal = 0xff88C0D0,
	blue = 0xff81A1C1,

	shadow = 0xff3B4252,
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
		bg = 3028032,
		border = 0xff4C566A,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff4C566A,
	bg2 = palette.bg,
	bg1 = 4282270800,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
