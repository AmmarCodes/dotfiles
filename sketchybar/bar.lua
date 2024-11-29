local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 28,
  color = colors.bar.bg,
  margin = 8,
  corner_radius = 6,
  shadow = false,
  blur_radius = 10,
  padding_right = 0,
  padding_left = 0,
  y_offset = 4,
})
