-----------------------------------------------------------
-- Dashboard configuration file
-----------------------------------------------------------

-- Plugin: alpha-nvim
-- url: https://github.com/goolord/alpha-nvim

-- For configuration examples see: https://github.com/goolord/alpha-nvim/discussions/16
local M = {
	"goolord/alpha-nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
}

function M.config()
	local dashboard = require("alpha.themes.dashboard")

	-- Footer
	local function footer()
		local version = vim.version()
		local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
		local datetime = os.date("%Y/%m/%d %H:%M:%S")

		return datetime .. " - " .. print_version
	end

	-- Banner
	local banner = {
		"                                                    ",
		" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		"                                                    ",
	}

	dashboard.section.header.val = banner

	-- Menu
	dashboard.section.buttons.val = {
		dashboard.button("e", "📝 New file", ":ene <BAR> startinsert<CR>"),
		dashboard.button("f", "🔎 Find word", ":Rg<CR>"),
		dashboard.button("r", "  Recent", ":History<CR>"),
		dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
		dashboard.button("u", "✅ Update plugins", ":PackerUpdate<CR>"),
		dashboard.button("q", "🛑 Quit", ":qa<CR>"),
	}

	dashboard.section.footer.val = footer()

	require("alpha").setup(dashboard.config)

	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M
