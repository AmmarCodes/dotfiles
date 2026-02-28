local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffF6F5DD,
	black = 0xff23372B,
	grey = 0xff53685B,
	bg = 0xff111C18,
	fg = 0xffC1C497,

	mauve = 0xffD2689C,
	red = 0xffFF5345,
	peach = 0xffE59875,
	yellow = 0xff459451,
	green = 0xff549E6A,
	teal = 0xff2DD5B7,
	blue = 0xff509475,

	shadow = 0xff23372B,
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
		bg = 1121304,
		border = 0xff53685B,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff53685B,
	bg2 = palette.bg,
	bg1 = 4280364072,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
