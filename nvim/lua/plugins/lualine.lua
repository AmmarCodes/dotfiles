-- Statusline
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
	config = function()
		local navic = require("nvim-navic")

		require("lualine").setup({
			options = {
				theme = "auto", -- auto
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						-- symbols = { error = " ", warn = " ", info = " ", hint = " " },
						sections = { "error", "warn", "info", "hint" },
					},
				},
				lualine_c = {
					{
						"filename",
						show_filename_only = false,
						file_status = true,
					},
					{ navic.get_location, cond = navic.is_available },
				},
				lualine_x = { "filetype" },
			},
		})
	end,
}
