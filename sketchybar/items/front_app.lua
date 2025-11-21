local app_icons = require("helpers.app_icons")
local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
  background = { color = colors.item_bg_color, height = settings.bar_height, corner_radius = settings.corner_radius },

  display = "active",
  icon = {
    font = { family = "sketchybar-app-font", style = "Regular", size = 16 },
    color = colors.blue,
    background = { color = colors.item_bg_color, height = settings.bar_height, corner_radius = settings.corner_radius },
    padding_left = settings.paddings * 2,
    padding_right = settings.group_paddings,
  },
  label = {
    padding_left = settings.group_paddings,
    padding_right = settings.paddings * 2,
    font = {
      style = settings.font.style_map["Black"],
      size = 12.0,
    },
  },
  padding_left = 10,
  updates = true,
})

-- local space_bracket = sbar.add("bracket", { "front_app" }, {
-- 	background = {
-- 		color = colors.transparent,
-- 		border_color = colors.bg2,
-- 		height = 28,
-- 		border_width = 2,
-- 	},
-- })

-- this condition will prevent having empty bar item in some cases (especially after reloading sketchybar)
front_app:subscribe("front_app_switched", function(env)
  local lookup = app_icons[env.INFO]
  local icon = ((lookup == nil) and app_icons["default"] or lookup)
  front_app:set({ label = { string = env.INFO }, icon = icon })
end)
