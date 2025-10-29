local catppuccin = {
  white = 0xffD3C6AA, -- #cdd6f4
  black = 0xff181926, -- #181926
  grey = 0xff7A8478, -- #939ab7
  bg = 0xff292c3c, -- #292c3c

  rosewater = 0xfff5e0dc, -- #f5e0dc
  flamingo = 0xfff2cdcd, -- #f2cdcd
  pink = 0xfff5c2e7, -- #f5c2e7
  mauve = 0xffD699B6, -- #cba6f7
  red = 0xffE57E80, -- #f38ba8
  maroon = 0xffeba0ac, -- #eba0ac
  peach = 0xffE59875, -- #fab387
  yellow = 0xfff9e2af, -- #f9e2af
  green = 0xffA7C080, -- #a6e3a1
  teal = 0xff94e2d5, -- #94e2d5
  sky = 0xff89dceb, -- #89dceb
  sapphire = 0xff74c7ec, -- #74c7ec
  blue = 0xff7FBBB3, -- #89b4fa
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
    bg = 0xff282E33, -- #292c3c
    border = 0xff495156, -- #2c2e34
  },
  popup = {
    bg = 0xc02c2e34, -- #2c2e34
    border = 0xff7f8490, -- #7f8490
  },
  bg3 = 0xff414B50, -- #303446
  bg2 = colors.bg,
  bg1 = 0xff2E383C, -- #232634

  with_alpha = with_alpha,
  item_bg_color = with_alpha(colors.bg, 0.5),
}
