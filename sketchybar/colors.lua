-- Load colors from the active theme file managed by theme-set
-- See: themes/active-sketchybar.lua
local home = os.getenv("HOME")
return dofile(home .. "/.dotfiles/themes/active-sketchybar.lua")
