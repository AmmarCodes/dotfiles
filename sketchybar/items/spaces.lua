local app_icons = require("helpers.icon_map")
local colors = require("colors")
local settings = require("settings")

local item_order = ""

sbar.exec("aerospace list-workspaces --monitor focused", function(spaces)
	for space_name in spaces:gmatch("[^\r\n]+") do
		local space = sbar.add("item", "space." .. space_name, {
			icon = {
				-- font = { family = settings.font.numbers, size = 15 },
				-- string = space_name, -- string.sub(space_name, 3),
				-- padding_left = settings.group_paddings * 2, -- 7,
				-- padding_right = settings.group_paddings * 2,
				-- color = colors.white,
				-- highlight_color = colors.black,
				-- background = { height = settings.bar_height, corner_radius = settings.corner_radius },
				-- y_offset = 1,
				drawing = "off",
			},
			label = {
				padding_right = 12,
				padding_left = settings.group_paddings,
				color = colors.grey,
				highlight_color = colors.black,
				font = "sketchybar-app-font:Regular:14.0",
				y_offset = -1,
			},
			padding_right = 1,
			padding_left = 1,
			background = {
				color = colors.item_bg_color,
				border_width = settings.border,
				-- border_color = colors.black,
				highlight_color = colors.bg1,
				height = settings.bar_height - 4,
				offset_y = 0,
			},
		})

		local space_bracket = sbar.add("bracket", { space.name }, {
			padding_right = settings.group_paddings, -- 7,
		})

		-- Padding space
		local space_padding = sbar.add("item", "space.padding." .. space_name, {
			script = "",
			width = settings.group_paddings,
		})

		space:subscribe("mouse.clicked", function()
			sbar.exec("aerospace workspace " .. space_name)
		end)

		-- use aerospace_workspace_change space_windows_change
		space:subscribe("aerospace_workspace_change", function(env)
			local selected = env.FOCUSED_WORKSPACE == space_name
			space:set({
				label = { highlight = selected },
				background = {
					-- alpha = selected and 0.7 or 0.5,
					border_width = selected and 0 or settings.border,
					color = selected and colors.mauve or "",
					shadow = selected and {
						drawing = selected and "on" or "off",
						color = colors.shadow,
						distance = 2,
						angle = 55,
					} or { drawing = "off" },
				},
			})
			space_bracket:set({
				background = { border_color = selected and colors.grey or colors.bg2 },
			})
			sbar.exec(
				"aerospace list-windows --format %{app-name} --json  --workspace " .. space_name,
				function(windows)
					local no_app = true
					local icon_line = ""
					local hash = {}
					for i, app in ipairs(windows) do
						no_app = false
						local app_name = app["app-name"]
						-- the following condition is to prevent duplicated entry for the same app
						if not hash[app_name] then
							local lookup = app_icons[app_name]
							local icon = ((lookup == nil) and app_icons["default"] or lookup)
							icon_line = icon_line .. " " .. icon

							hash[app_name] = true
						end
					end

					if no_app then
						icon_line = " —"
					end

					space:set({ label = icon_line })
				end
			)
		end)

		item_order = item_order .. " " .. space.name .. " " .. space_padding.name
	end
	sbar.exec("sketchybar --reorder " .. item_order .. " front_app")
end)
