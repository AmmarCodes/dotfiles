local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffD4BE98,
	black = 0xff3C3836,
	grey = 0xff3C3836,
	bg = 0xff282828,
	fg = 0xffD4BE98,

	mauve = 0xffD3869B,
	red = 0xffEA6962,
	peach = 0xffE59875,
	yellow = 0xffD8A657,
	green = 0xffA9B665,
	teal = 0xff89B482,
	blue = 0xff7DAEA3,

	shadow = 0xff3C3836,
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
		bg = 2631720,
		border = 0xff3C3836,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff3C3836,
	bg2 = palette.bg,
	bg1 = 4281874488,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
