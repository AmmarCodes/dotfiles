local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffE6D9DB,
	black = 0xff72696A,
	grey = 0xff948A8B,
	bg = 0xff2C2525,
	fg = 0xffE6D9DB,

	mauve = 0xffA8A9EB,
	red = 0xffFD6883,
	peach = 0xffE59875,
	yellow = 0xffF9CC6C,
	green = 0xffADDA78,
	teal = 0xff85DACC,
	blue = 0xffF38D70,

	shadow = 0xff72696A,
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
		bg = 2893093,
		border = 0xff948A8B,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff948A8B,
	bg2 = palette.bg,
	bg1 = 4282135861,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
