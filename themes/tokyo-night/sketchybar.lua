local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xff787C99,
	black = 0xff32344A,
	grey = 0xff444B6A,
	bg = 0xff1A1B26,
	fg = 0xffA9B1D6,

	mauve = 0xffAD8EE6,
	red = 0xffF7768E,
	peach = 0xffE59875,
	yellow = 0xffE0AF68,
	green = 0xff9ECE6A,
	teal = 0xff449DAB,
	blue = 0xff7AA2F7,

	shadow = 0xff32344A,
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
		bg = 1710886,
		border = 0xff444B6A,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff444B6A,
	bg2 = palette.bg,
	bg1 = 4280953654,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
