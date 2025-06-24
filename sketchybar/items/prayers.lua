local colors = require("colors")

local prayers = sbar.add("item", {
  icon = { string = "", padding_left = 9, color = colors.lavender },
  padding_left = 6,
  padding_right = 0,
  label = { font = { size = 12 }, padding_right = 9 },
  position = "q",
  background = {
    color = colors.item_bg_color,
  },
  update_freq = 30,
  popup = { align = "center" },
})

local prayers_bracket = sbar.add("bracket", "widgets.prayers.bracket", {
  prayers.name,
}, {
  background = { color = colors.item_bg_color },
  popup = { align = "center", height = 30 },
})

local function add_item_bar(label, value)
  return sbar.add("item", {
    position = "popup." .. prayers_bracket.name,

    icon = { string = label, width = 100, font = { size = 12 } },
    width = 150,
    label = { string = value },
    padding_left = 20,
    padding_right = 20,
  })
end

local prayer_times = {
  [1] = add_item_bar("Fajr", "xx:xx"),
  [2] = add_item_bar("Sunrise", "xx:xx"),
  [3] = add_item_bar("Dhuhr", "xx:xx"),
  [4] = add_item_bar("Asr", "xx:xx"),
  [5] = add_item_bar("Maghrib", "xx:xx"),
  [6] = add_item_bar("Ishaa", "xx:xx"),
}

local function toggle_details()
  local should_draw = prayers_bracket:query().popup.drawing == "off"
  if should_draw then
    prayers_bracket:set({ popup = { drawing = "on" } })
  end
end

local function hide_details()
  prayers_bracket:set({ popup = { drawing = false } })
end

prayers:subscribe("mouse.clicked", toggle_details)
prayers:subscribe("mouse.exited.global", hide_details)

prayers:subscribe({ "forced", "routine" }, function()
  local handle = io.popen("~/.dotfiles/sketchybar/items/prayer-times.js")
  local remaining = ""
  local i = 0
  for line in handle:lines() do
    if remaining == "" then
      remaining = line
    else
      prayer_times[i]:set({ label = line })
    end
    i = i + 1
  end
  handle:close()

  local hours, minutes = remaining:match("(%d+):(%d+)")

  local color
  if tonumber(hours) == 0 and tonumber(minutes) <= 15 then
    color = colors.red
  else
    color = colors.white
  end

  prayers:set({ label = { string = remaining, color = color } })
end)
