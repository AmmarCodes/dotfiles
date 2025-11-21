local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = settings.bar_height,
  color = colors.bar.bg,
  margin = 4,
  corner_radius = settings.corner_radius,
  shadow = false,
  blur_radius = 10,
  padding_right = 4,
  padding_left = 4,
  y_offset = 2,
})
