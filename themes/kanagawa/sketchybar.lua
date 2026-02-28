local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffC8C093,
	black = 0xff090618,
	grey = 0xff727169,
	bg = 0xff1F1F28,
	fg = 0xffDCD7BA,

	mauve = 0xff957FB8,
	red = 0xffC34043,
	peach = 0xffE59875,
	yellow = 0xffC0A36E,
	green = 0xff76946A,
	teal = 0xff6A9589,
	blue = 0xff7E9CD8,

	shadow = 0xff090618,
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
		bg = 2039592,
		border = 0xff727169,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff727169,
	bg2 = palette.bg,
	bg1 = 4281282360,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
