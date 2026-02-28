local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffBEBEBE,
	black = 0xff333333,
	grey = 0xff8A8A8D,
	bg = 0xff121212,
	fg = 0xffBEBEBE,

	mauve = 0xffD35F5F,
	red = 0xffD35F5F,
	peach = 0xffE59875,
	yellow = 0xffB91C1C,
	green = 0xffFFC107,
	teal = 0xffBEBEBE,
	blue = 0xffE68E0D,

	shadow = 0xff333333,
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
		bg = 1184274,
		border = 0xff8A8A8D,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff8A8A8D,
	bg2 = palette.bg,
	bg1 = 4280427042,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
