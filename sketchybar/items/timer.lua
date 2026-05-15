local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local script_path = "$CONFIG_DIR/items/timer.sh"
local durations = { 5, 10, 25 }

local timer = sbar.add("item", "widgets.timer", {
  position = "right",
  icon = {
    string = icons.timer,
    color = colors.yellow,
    padding_right = settings.group_paddings,
  },
  label = {
    string = "No timer",
    font = { family = settings.font.numbers },
    padding_right = settings.group_paddings,
  },
  y_offset = 1,
  script = script_path,
  popup = {
    align = "center",
    background = {
      color = colors.popup.bg,
      border_color = colors.popup.border,
      border_width = 1,
      corner_radius = 10,
    },
  },
})

timer:subscribe("mouse.clicked", function(env)
  sbar.exec(string.format("SENDER=%q BUTTON=%q %s", env.SENDER, env.BUTTON, script_path))
end)

local popup_generation = 0
local popup_auto_close_seconds = 1

local function close_popup()
  timer:set({ popup = { drawing = false } })
end

timer:subscribe({ "mouse.exited", "mouse.exited.global" }, close_popup)

timer:subscribe("mouse.entered", function()
  popup_generation = popup_generation + 1
  local this_generation = popup_generation
  timer:set({ popup = { drawing = true } })
  sbar.delay(popup_auto_close_seconds, function()
    if this_generation == popup_generation then
      close_popup()
    end
  end)
end)

for _, minutes in ipairs(durations) do
  sbar.add("item", "widgets.timer.preset." .. minutes, {
    position = "popup." .. timer.name,
    label = {
      string = minutes .. " Minutes",
      padding_left = 16,
      padding_right = 16,
    },
    icon = { drawing = false },
    click_script = string.format(
      "%s %d && sketchybar --set %s popup.drawing=off",
      script_path,
      minutes * 60,
      timer.name
    ),
  })
end

sbar.add("bracket", "widgets.timer.bracket", { timer.name }, {
  background = { color = colors.item_bg_color },
})

sbar.add("item", "widgets.timer.padding", {
  position = "right",
  width = settings.group_paddings,
})
