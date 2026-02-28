local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffD7C483,
	black = 0xff000000,
	grey = 0xff666666,
	bg = 0xff222222,
	fg = 0xffC2C2B0,

	mauve = 0xffBB7744,
	red = 0xff685742,
	peach = 0xffE59875,
	yellow = 0xffB36D43,
	green = 0xff5F875F,
	teal = 0xffC9A554,
	blue = 0xff78824B,

	shadow = 0xff000000,
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
		bg = 2236962,
		border = 0xff666666,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg3 = 0xff666666,
	bg2 = palette.bg,
	bg1 = 4281479730,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
