local colors = require("colors")
local settings = require("settings")

local time = sbar.add("item", {
  icon = {
    drawing = false,
  },
  label = {
    y_offset = 0.5,
    color = colors.teal,
    padding_right = settings.paddings * 2,
    padding_left = settings.paddings * 2,
    align = "center",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Black"],
      -- size = 14,
    },
  },
  position = "right",
  update_freq = 30,
  padding_left = 0,
  padding_right = 0,
  background = {
    color = colors.item_bg_color,
    corner_radius = settings.corner_radius,
  },
})

local date = sbar.add("item", {
  icon = {
    drawing = false,
  },
  label = {
    y_offset = 0.5,
    color = colors.white,
    padding_right = settings.paddings * 2,
    padding_left = settings.paddings * 2,
    align = "right",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 12,
    },
  },
  position = "right",
  update_freq = 30,
  padding_left = settings.group_paddings,
  padding_right = settings.group_paddings,
  background = {
    color = colors.item_bg_color,
  },
  click_script = "open -a 'Calendar'",
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

time:subscribe({ "forced", "routine", "system_woke" }, function()
  time:set({ label = os.date("%H:%M") })
end)

date:subscribe({ "forced", "routine", "system_woke" }, function()
  date:set({ label = os.date("%a %d %b") })
end)
