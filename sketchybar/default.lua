local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --default domain
sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		color = colors.fg,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
		background = { image = { corner_radius = settings.corner_radius } },
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Semibold"],
			size = 13.0,
		},
		background = {
			corner_radius = settings.corner_radius,
			height = settings.bar_height - 4,
		},
		color = colors.fg,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	background = {
		height = settings.bar_height - 4,
		corner_radius = settings.corner_radius,
		-- border_width = 1,
		-- border_color = colors.bg2,
		image = {
			corner_radius = settings.corner_radius,
			-- border_color = colors.grey,
			-- border_width = 1,
		},
	},
	popup = {
		background = {
			border_width = settings.border,
			corner_radius = settings.corner_radius,
			border_color = colors.popup.border,
			color = colors.popup.bg,
			shadow = { drawing = true },
		},
	},
	padding_left = 5,
	padding_right = 5,
	scroll_texts = true,
})
