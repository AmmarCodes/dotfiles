local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffFFFCF0,
	black = 0xff100F0F,
	grey = 0xff100F0F,
	bg = 0xffFFFCF0,
	fg = 0xff100F0F,

	mauve = 0xffCE5D97,
	red = 0xffD14D41,
	peach = 0xffE59875,
	yellow = 0xffD0A215,
	green = 0xff879A39,
	teal = 0xff3AA99F,
	blue = 0xff205EA6,

	shadow = 0xff100F0F,
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
		bg = 16776432,
		border = 0xff100F0F,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff100F0F,
	bg2 = palette.bg,
	bg1 = 4296019200,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
