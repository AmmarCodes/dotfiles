local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffD3C6AA,
	black = 0xff2D353B,
	grey = 0xff6A7468,
	bg = 0xff3D484D,
	fg = 0xffD3C6AA,

	mauve = 0xffD699B6,
	red = 0xffE57E80,
	peach = 0xffE59875,
	yellow = 0xffDABB7F,
	green = 0xffA7C080,
	teal = 0xff83C093,
	blue = 0xff7FBBB3,

	shadow = 0xff2D353B,
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
		bg = 0x00282E33,
		border = 0xff495156,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff414B50,
	bg2 = palette.bg,
	bg1 = 0xff2E383C,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
