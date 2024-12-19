local colors = require("colors")

local MR_Rate = sbar.add("item", {
	position = "right",
	icon = { string = "", padding_left = 9, color = colors.mauve },
	label = { font = { size = 12 }, string = "?", padding_right = 9 },
	padding_right = 6,
	background = {
		color = colors.bg2,
		border_width = 0,
		border_color = colors.black,
	},
	update_freq = 3600,
})

MR_Rate:subscribe({ "forced", "routine" }, function()
	-- get the data
	MR_Rate:set({ label = { string = "?" } })
	local handle = io.popen(
		'glab api "merge_requests?author_username=aalakkad&created_after='
			.. os.date("!%Y-%m-01")
			.. 'T00:00:00Z" | jq length'
	)
	local count = "?"
	if handle then
		count = handle:read("*a")
		handle:close()
	else
		count = "X"
	end

	-- local color
	-- if hours == 0 and minutes <= 15 then
	-- 	color = colors.red
	-- else
	-- 	color = colors.white
	-- end

	MR_Rate:set({ label = { string = count } })
end)
