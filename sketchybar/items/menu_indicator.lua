-------------------MENU INDICATOR ICON-----------------
-------------------------------------------------------
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local menu_indicator = sbar.add("item", {
  position = "left",
  align = "center",
  icon = {
    padding_left = 5,
    padding_right = 3,
    color = colors.bar.foreground_alt,
    string = "􀾅",
    font = {
      size = 14,
    },
  },
  background = {
    border_width = 0,
    color = colors.bar.bg,
    corner_radius = 6,
  },
})

menu_indicator:subscribe("mouse.entered", function(env)
  local selected = env.SELECTED == "true"
  sbar.animate("elastic", 15, function()
    menu_indicator:set({
      background = {
        color = {
          alpha = 1,
        },
      },
      icon = {

        color = colors.bar.foreground_alt,
        font = {
          size = 18,
        },
      },
    })
  end)
end)

menu_indicator:subscribe("mouse.exited", function(env)
  local selected = env.SELECTED == "true"
  sbar.animate("elastic", 15, function()
    menu_indicator:set({
      background = {
        color = {
          alpha = 1,
        },
      },
      label = {
        color = colors.bar.foreground_alt,
        font = {
          size = 14,
        },
      },
      icon = {

        color = colors.bar.foreground_alt,
        font = {
          size = 14,
        },
      },
    })
  end)
  -- Animate the menu items when they show up
end)

-- Define a variable to keep track of the icon state
local iconState = false

menu_indicator:subscribe("mouse.clicked", function(env)
  local selected = env.SELECTED == "true"
  sbar.trigger("swap_menus_and_spaces")
  sbar.animate("elastic", 15, function()
    -- Toggle the iconState variable
    iconState = not iconState

    -- Set the icon based on the current state
    local newIcon = iconState and "􀾄" or "􀾅" -- Replace "􀋷" with the other icon you want to show

    menu_indicator:set({
      icon = {
        string = newIcon,
      },
    })
  end)
end)
