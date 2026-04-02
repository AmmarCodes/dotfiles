local colors = require("colors")
local settings = require("settings")

local weather = sbar.add("item", "widgets.weather", {
  position = "right",
  icon = {
    font = {
      family = "JetBrainsMono Nerd Font Mono",
      style = settings.font.style_map["Regular"],
      size = 20.0,
    },
    padding_right = 0,
    padding_left = settings.paddings / 2,
  },
  label = {
    string = "",
    font = { size = 12 },
    padding_right = settings.paddings / 2,
  },
  background = {
    color = colors.item_bg_color,
  },
  update_freq = 600,
})

local function get_icon(code)
  local n = tonumber(code) or 0
  if n == 113 then
    return ""
  elseif n == 116 or n == 119 or n == 122 then
    return "󰅟"
  elseif n == 143 or n == 248 or n == 260 then
    return ""
  elseif
    n == 179
    or n == 182
    or n == 185
    or n == 281
    or n == 284
    or n == 311
    or n == 314
    or n == 317
    or n == 350
    or n == 362
    or n == 374
    or n == 377
  then
    return ""
  elseif
    n == 176
    or n == 263
    or n == 266
    or n == 293
    or n == 296
    or n == 299
    or n == 302
    or n == 305
    or n == 308
    or n == 353
    or n == 356
    or n == 359
  then
    return ""
  elseif n == 200 or n == 386 or n == 389 then
    return ""
  elseif n == 392 then
    return ""
  else
    return ""
  end
end

weather:subscribe({ "forced", "routine", "system_woke" }, function()
  local handle = io.popen("curl -s \"https://wttr.in/?format=j1\"")
  if handle == nil then
    weather:set({ label = "No data" })
    return
  end

  local json = handle:read("*a")
  handle:close()

  if json == nil or json == "" then
    weather:set({ label = "No data" })
    return
  end

  local temp = json:match("\"temp_C\"%s*:%s*\"(%d+)\"")
  local code = json:match("\"weatherCode\"%s*:%s*\"(%d+)\"")

  if temp == nil or code == nil then
    weather:set({ label = "No data" })
    return
  end

  weather:set({
    icon = { string = get_icon(code) },
    label = { string = temp .. "\194\176" },
  })
end)

sbar.add("bracket", "widgets.weather.bracket", { weather.name }, {
  background = { color = colors.item_bg_color },
})
