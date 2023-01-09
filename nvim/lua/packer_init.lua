-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
	print("Cloning packer ..")

	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Install plugins
return packer.startup(function(use)
	-- Add you plugins here:
	use("wbthomason/packer.nvim") -- packer can manage itself

	-- Color schemes
	-- use("rmehri01/onenord.nvim")
	-- use("shaunsingh/nord.nvim")
	-- use("neanias/everforest-nvim")
	-- use({ "RRethy/nvim-base16" })
	-- use({
	-- 	"marko-cerovac/material.nvim",
	-- 	config = function()
	-- 		require("material").setup({
	-- 			contrast = {
	-- 				sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
	-- 				floating_windows = false, -- Enable contrast for floating windows
	-- 				line_numbers = false, -- Enable contrast background for line numbers
	-- 				sign_column = false, -- Enable contrast background for the sign column
	-- 				cursor_line = false, -- Enable darker background for the cursor line
	-- 				non_current_windows = false, -- Enable darker background for non-current windows
	-- 				popup_menu = false, -- Enable lighter background for the popup menu
	-- 			},
	--
	-- 			italics = {
	-- 				comments = true, -- Enable italic comments
	-- 				keywords = true, -- Enable italic keywords
	-- 				functions = false, -- Enable italic functions
	-- 				strings = false, -- Enable italic strings
	-- 				variables = false, -- Enable italic variables
	-- 			},
	--
	-- 			contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
	-- 				"terminal", -- Darker terminal background
	-- 				"packer", -- Darker packer background
	-- 				"qf", -- Darker qf list background
	-- 			},
	--
	-- 			high_visibility = {
	-- 				lighter = false, -- Enable higher contrast text for lighter style
	-- 				darker = false, -- Enable higher contrast text for darker style
	-- 			},
	--
	-- 			disable = {
	-- 				colored_cursor = false, -- Disable the colored cursor
	-- 				borders = false, -- Disable borders between verticaly split windows
	-- 				background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
	-- 				term_colors = false, -- Prevent the theme from setting terminal colors
	-- 				eob_lines = false, -- Hide the end-of-buffer lines
	-- 			},
	--
	-- 			lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
	--
	-- 			async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
	--
	-- 			custom_highlights = {}, -- Overwrite highlights with your own
	--
	-- 			plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
	-- 				trouble = true,
	-- 				nvim_cmp = true,
	-- 				neogit = true,
	-- 				gitsigns = true,
	-- 				git_gutter = true,
	-- 				telescope = true,
	-- 				nvim_tree = true,
	-- 				sidebar_nvim = true,
	-- 				lsp_saga = true,
	-- 				nvim_dap = true,
	-- 				nvim_navic = true,
	-- 				which_key = true,
	-- 				sneak = true,
	-- 				hop = true,
	-- 				indent_blankline = true,
	-- 				nvim_illuminate = true,
	-- 				mini = true,
	-- 			},
	-- 		})
	-- 	end,
	-- })

	-- Open alternative file
	-- use({
	-- 	"rgroli/other.nvim",
	-- 	config = function()
	-- 		require("other-nvim").setup({
	-- 			mappings = {
	-- 				"rails",
	-- 				{
	-- 					pattern = "/app/(.*)/.*.js$",
	-- 					target = "/spec/%1/",
	-- 					transformer = "lowercase",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- })

	-- Improve startup time
	use("lewis6991/impatient.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
