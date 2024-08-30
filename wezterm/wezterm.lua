-- Pull in the wezterm API
local wezterm = require("wezterm")

local act = wezterm.action
local mux = wezterm.mux

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- local state = {
-- 	debug_mode = false,
-- }

local key_mod_panes = "CMD"

-- local colors = {
-- 	base = "#faf4ed",
-- 	surface = "#fffaf3",
-- 	overlay = "#f2e9e1",
-- 	muted = "#9893a5",
-- 	subtle = "#797593",
-- 	text = "#575279",
-- 	love = "#b4637a",
-- 	gold = "#ea9d34",
-- 	rose = "#d7827e",
-- 	pine = "#286983",
-- 	foam = "#56949f",
-- 	iris = "#907aa9",
-- 	highlight_low = "#f4ede8",
-- 	highlight_med = "#dfdad9",
-- 	highlight_high = "#cecacd",
-- }

local keys = {
	{
		key = ",",
		mods = "CMD",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "/opt/homebrew/bin/nvim", "/Users/aalakkad/.wezterm.lua" },
		}),
	},
	{
		key = ".",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette,
	},

	{
		key = "p",
		mods = key_mod_panes,
		action = act.ShowLauncherArgs({ flags = "FUZZY|TABS|WORKSPACES" }),
	},

	{
		key = "Enter",
		mods = key_mod_panes,
		action = act.ToggleFullScreen,
	},
	{
		key = "w",
		mods = key_mod_panes,
		action = act.CloseCurrentPane({ confirm = true }),
	},
	-- {
	-- 	mods = "LEADER",
	-- 	key = "-",
	-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	mods = "LEADER",
	-- 	key = "\\",
	-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	mods = "LEADER",
	-- 	key = "z",
	-- 	action = wezterm.action.TogglePaneZoomState,
	-- },
	-- {
	-- 	mods = "LEADER|CTRL",
	-- 	key = "a",
	-- 	action = act.SendKey({ key = "a", mods = "CTRL" }),
	-- },
	-- {
	-- 	mods = "LEADER|CTRL",
	-- 	key = "l",
	-- 	action = act.SendKey({ key = "l", mods = "CTRL" }),
	-- },
	-- {
	-- 	mods = "LEADER",
	-- 	key = "z",
	-- 	action = wezterm.action.TogglePaneZoomState,
	-- },
	-- {
	-- 	mods = "LEADER",
	-- 	key = "c",
	-- 	action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	-- },
	-- {
	-- 	mods = "LEADER",
	-- 	key = "a",
	-- 	action = wezterm.action.ActivateLastTab,
	-- },
}

for i = 1, 8 do
	-- LEADER + number to activate that tab
	table.insert(keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- source: https://wezfurlong.org/wezterm/config/lua/wezterm.gui/get_appearance.html
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Frappe"
	else
		return "rose-pine-dawn"
	end
end

config.term = "wezterm"
config.keys = keys
-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.debug_key_events = true

config.color_scheme = scheme_for_appearance(get_appearance()) -- "rose-pine-dawn" -- "Catppuccin Frappe" -- "Everforest Light (Gogh)" -- Catppuccin Latte"
config.color_scheme = "Catppuccin Frappe"
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font = wezterm.font("MonoLisa", { weight = "Medium" })
config.font_size = 14
config.line_height = 1.26
config.command_palette_font_size = 16
-- config.command_palette_fg_color = colors.text
-- config.command_palette_bg_color = colors.highlight_high
config.harfbuzz_features = { "calt", "dlig", "ss01", "ss02", "ss03", "ss06", "ss07", "ss08", "ss10", "ss15", "ss16" }
config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 0.9,
}
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("PrimarySelection"),
	},

	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.OpenLinkAtMouseCursor,
	},
}
config.quick_select_patterns = {
	"[0-9a-f]{7,40}", -- hashes
	"[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", -- uuids
	"https?:\\/\\/\\S+",
}
config.show_new_tab_button_in_tab_bar = false

config.underline_position = -7
config.window_decorations = "RESIZE"
config.window_padding = {
	right = "2cell",
	left = "2cell",
	bottom = 0,
	top = 0,
}

config.native_macos_fullscreen_mode = true
config.adjust_window_size_when_changing_font_size = false

-- config.window_close_confirmation = "NeverPrompt"

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

-- config.colors = {
-- 	selection_bg = colors.gold,
--
-- 	tab_bar = {
-- 		-- The color of the strip that goes along the top of the window
-- 		-- (does not apply when fancy tab bar is in use)
-- 		background = colors.base,
--
-- 		-- The active tab is the one that has focus in the window
-- 		active_tab = {
-- 			-- The color of the background area for the tab
-- 			bg_color = colors.muted,
-- 			-- The color of the text for the tab
-- 			fg_color = colors.surface,
--
-- 			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
-- 			-- label shown for this tab.
-- 			-- The default is "Normal"
-- 			intensity = "Normal",
--
-- 			-- Specify whether you want "None", "Single" or "Double" underline for
-- 			-- label shown for this tab.
-- 			-- The default is "None"
-- 			underline = "None",
--
-- 			-- Specify whether you want the text to be italic (true) or not (false)
-- 			-- for this tab.  The default is false.
-- 			italic = false,
--
-- 			-- Specify whether you want the text to be rendered with strikethrough (true)
-- 			-- or not for this tab.  The default is false.
-- 			-- strikethrough = false,
-- 		},
--
-- 		-- Inactive tabs are the tabs that do not have focus
-- 		inactive_tab = {
-- 			bg_color = colors.highlight_low,
-- 			fg_color = colors.text,
--
-- 			-- The same options that were listed under the `active_tab` section above
-- 			-- can also be used for `inactive_tab`.
-- 		},
--
-- 		-- You can configure some alternate styling when the mouse pointer
-- 		-- moves over inactive tabs
-- 		inactive_tab_hover = {
-- 			bg_color = colors.highlight_med,
-- 			fg_color = colors.text,
-- 			-- italic = true,
--
-- 			-- The same options that were listed under the `active_tab` section above
-- 			-- can also be used for `inactive_tab_hover`.
-- 		},
--
-- 		-- The new tab button that let you create new tabs
-- 		new_tab = {
-- 			bg_color = colors.base,
-- 			fg_color = colors.text,
--
-- 			-- The same options that were listed under the `active_tab` section above
-- 			-- can also be used for `new_tab`.
-- 		},
--
-- 		-- You can configure some alternate styling when the mouse pointer
-- 		-- moves over the new tab button
-- 		-- new_tab_hover = {
-- 		-- bg_color = "#3b3052",
-- 		-- fg_color = "#909090",
-- 		-- italic = true,
--
-- 		-- The same options that were listed under the `active_tab` section above
-- 		-- can also be used for `new_tab_hover`.
-- 		-- },
-- 	},
-- }

-- copied and modified from https://github.com/protiumx/.dotfiles/blob/main/stow/wezterm/.config/wezterm/wezterm.lua
local process_icons = {
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["psql"] = "󱤢",
	["usql"] = "󱤢",
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["ssh"] = wezterm.nerdfonts.fa_exchange,
	["ssh-add"] = wezterm.nerdfonts.fa_exchange,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["nvim"] = wezterm.nerdfonts.linux_neovim,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["go"] = wezterm.nerdfonts.seti_go,
	["python3"] = "",
	["zsh"] = wezterm.nerdfonts.oct_terminal,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["git"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
}

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "." or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
		return "[?]"
	end

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	if string.find(process_name, "kubectl") then
		process_name = "kubectl"
	end

	return process_icons[process_name] or string.format("[%s]", process_name)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	local cwd = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = get_current_working_dir(tab) },
	})

	local title = string.format(" %s  %s  ", get_process(tab), cwd)

	if has_unseen_output then
		return {
			{ Foreground = { Color = "#28719c" } },
			{ Text = title },
		}
	end

	return {
		{ Text = title },
	}
end)

-- wezterm.on("update-status", function(window, pane)
-- 	local status = ""
--
-- 	if state.debug_mode then
-- 		local info = pane:get_foreground_process_info()
-- 		if info then
-- 			status = info.name
-- 			for i = 2, #info.argv do
-- 				status = status .. " " .. info.argv[i]
-- 			end
-- 		end
-- 	end
--
-- 	local time = ""
-- 	if window:get_dimensions().is_full_screen then
-- 		time = (state.debug_mode and " | " or "") .. wezterm.strftime("%R ")
-- 	end
--
-- 	window:set_right_status(wezterm.format({
-- 		{ Foreground = { Color = "#7eb282" } },
-- 		{ Text = status },
-- 		{ Foreground = { Color = "#808080" } },
-- 		{ Text = time },
-- 	}))
-- end)

-- local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- integrate smart-splits.nvim
-- smart_splits.apply_to_config(config, {
-- 	-- the default config is here, if you'd like to use the default keys,
-- 	-- you can omit this configuration table parameter and just use
-- 	-- smart_splits.apply_to_config(config)
--
-- 	-- directional keys to use in order of: left, down, up, right
-- 	direction_keys = { "h", "j", "k", "l" },
-- 	-- modifier keys to combine with direction_keys
-- 	modifiers = {
-- 		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
-- 		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
-- 	},
-- })

-- and finally, return the configuration to wezterm
return config
