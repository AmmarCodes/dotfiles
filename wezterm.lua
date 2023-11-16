-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "Catppuccin Latte"
config.colors = { background = "#FFFFFF" }
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("Monaspace Neon", { weight = "Medium" })
config.harfbuzz_features = { "calt", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }

config.font_rules = {
	{
		italic = true,
		font = wezterm.font("Monaspace Radon", { weight = "Medium" }),
	},
}
config.font_size = 14
config.line_height = 1.5
config.window_decorations = "RESIZE"
config.window_padding = {
	bottom = 0,
}

config.native_macos_fullscreen_mode = true
config.adjust_window_size_when_changing_font_size = false

config.window_close_confirmation = "NeverPrompt"

-- maximize window on start
wezterm.on("gui-attached", function()
	-- maximize all displayed windows on startup
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

-- and finally, return the configuration to wezterm
return config
