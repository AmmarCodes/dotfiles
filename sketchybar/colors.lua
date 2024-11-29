local catppuccin = {
	white = 0xffcdd6f4, -- #cdd6f4
	black = 0xff181926, -- #181926
	grey = 0xff939ab7, -- #939ab7
	bg = 0xff292c3c, -- #292c3c

	rosewater = 0xfff5e0dc, -- #f5e0dc
	flamingo = 0xfff2cdcd, -- #f2cdcd
	pink = 0xfff5c2e7, -- #f5c2e7
	mauve = 0xffcba6f7, -- #cba6f7
	red = 0xfff38ba8, -- #f38ba8
	maroon = 0xffeba0ac, -- #eba0ac
	peach = 0xfffab387, -- #fab387
	yellow = 0xfff9e2af, -- #f9e2af
	green = 0xffa6e3a1, -- #a6e3a1
	teal = 0xff94e2d5, -- #94e2d5
	sky = 0xff89dceb, -- #89dceb
	sapphire = 0xff74c7ec, -- #74c7ec
	blue = 0xff89b4fa, -- #89b4fa
	lavender = 0xffb4befe, -- #b4befe
}

local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local colors = catppuccin

return {
	transparent = 0x00000000,

	black = colors.black,
	grey = colors.grey,
	white = colors.white,

	orange = colors.peach,
	magenta = colors.mauve,

	rosewater = colors.rosewater,
	flamingo = colors.flamingo,
	pink = colors.pink,
	mauve = colors.mauve,
	red = colors.red,
	maroon = colors.maroon,
	peach = colors.peach,
	yellow = colors.yellow,
	green = colors.green,
	teal = colors.teal,
	sky = colors.sky,
	sapphire = colors.sapphire,
	blue = colors.blue,
	lavender = colors.lavender,

	bar = {
		bg = 0xff292c3c, -- #292c3c
		border = 0xff2c2e34, -- #2c2e34
	},
	popup = {
		bg = 0xc02c2e34, -- #2c2e34
		border = 0xff7f8490, -- #7f8490
	},
	bg3 = 0xff303446, -- #303446
	bg2 = colors.bg,
	bg1 = 0xff232634, -- #232634

	with_alpha = with_alpha,
	item_bg_color = with_alpha(colors.bg, 0.5),
}
