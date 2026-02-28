local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffF99957,
	black = 0xff060B1E,
	grey = 0xff6D7DB6,
	bg = 0xff060B1E,
	fg = 0xffFFCEAD,

	mauve = 0xffC89DC1,
	red = 0xffED5B5A,
	peach = 0xffE59875,
	yellow = 0xffE9BB4F,
	green = 0xff92A593,
	teal = 0xffA3BFD1,
	blue = 0xff7D82D9,

	shadow = 0xff060B1E,
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
		bg = 396062,
		border = 0xff6D7DB6,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff6D7DB6,
	bg2 = palette.bg,
	bg1 = 4279638830,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
