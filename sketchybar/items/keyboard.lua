local settings = require("settings")

sbar.add("event", "keyboard_change", "AppleSelectedInputSourcesChangedNotification")

local keyboard = sbar.add("item", "widgets.keyboard", {
	position = "right",
	icon = {
		font = {
			style = settings.font.style_map["Regular"],
			size = 19.0,
		},
	},
})

local function refresh_keyboard_layout()
	sbar.exec(
		"defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep 'KeyboardLayout Name'",
		function(result)
			local layout = result:match("= (.-);"):gsub("^%s*(.-)%s*$", "%1"):gsub('"', "")

			local icon

			if layout == "Arabic PC" then
				icon = "􀂔" -- "󱌨"
			elseif layout == "Turkish-QWERTY" then
				icon = "􀂺" -- "T"
			elseif layout == "U.S." then
				icon = "􀂜" -- "E"
			else
				icon = layout
			end

			keyboard:set({ icon = icon })
		end
	)
end

keyboard:subscribe({ "forced", "keyboard_change" }, function()
	refresh_keyboard_layout()
end)

refresh_keyboard_layout()
