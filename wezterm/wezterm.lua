-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = wezterm.config_builder()

local key_mod_panes = "CMD"

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
config.line_height = 1.5
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
	-- right = 0,
	-- left = 0,
	bottom = 0,
	top = 0,
}

config.native_macos_fullscreen_mode = true
config.adjust_window_size_when_changing_font_size = false

-- config.window_close_confirmation = "NeverPrompt"

-- maximize window on start
-- local mux = wezterm.mux
-- wezterm.on("gui-attached", function()
-- 	-- maximize all displayed windows on startup
-- 	local workspace = mux.get_active_workspace()
-- 	for _, window in ipairs(mux.all_windows()) do
-- 		if window:get_workspace() == workspace then
-- 			window:gui_window():maximize()
-- 		end
-- 	end
-- end)

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

wezterm.on("format-tab-title", function(tab)
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

return config
