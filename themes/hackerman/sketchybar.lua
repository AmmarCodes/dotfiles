local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xff85E1FB,
	black = 0xff0B0C16,
	grey = 0xff6A6E95,
	bg = 0xff0B0C16,
	fg = 0xffDDF7FF,

	mauve = 0xff86A7DF,
	red = 0xff50F872,
	peach = 0xffE59875,
	yellow = 0xff50F7D4,
	green = 0xff4FE88F,
	teal = 0xff7CF8F7,
	blue = 0xff829DD4,

	shadow = 0xff0B0C16,
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
		bg = 723990,
		border = 0xff6A6E95,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff6A6E95,
	bg2 = palette.bg,
	bg1 = 4279966758,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
