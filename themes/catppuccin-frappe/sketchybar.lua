local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local palette = {
	white = 0xffcdd6f4,
	black = 0xff181926,
	grey = 0xff939ab7,
	bg = 0xff292c3c,
	fg = 0xffcdd6f4,

	mauve = 0xffca9ee6,
	red = 0xffe78284,
	peach = 0xffef9f76,
	yellow = 0xffe5c890,
	green = 0xffa6d189,
	teal = 0xff81c8be,
	blue = 0xff8caaee,

	shadow = 0xff232634,
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
		bg = 0x00303446,
		border = 0xff414559,
	},
	popup = {
		bg = 0xc0303446,
		border = 0xff626880,
	},
	bg3 = 0xff414559,
	bg2 = palette.bg,
	bg1 = 0xff232634,

	shadow = palette.shadow,
	with_alpha = with_alpha,
	item_bg_color = with_alpha(palette.bg, 4),
}
