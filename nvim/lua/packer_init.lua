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

	-- Cursorhold fix
	use({
		"antoinemadec/FixCursorHold.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			vim.g.cursorhold_updatetime = 100
		end,
	})

	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	})

	-- Icons
	use({
		"kyazdani42/nvim-web-devicons",
		event = "VimEnter",
	})

	-- Treesitter interface
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		require = "nvim-treesitter/nvim-treesitter",
	})

	-- Add end to close functions
	use({ "RRethy/nvim-treesitter-endwise", require = "nvim-treesitter/nvim-treesitter" })

	-- Color brackets and paranthesis
	use({ "p00f/nvim-ts-rainbow", require = "nvim-treesitter/nvim-treesitter" })

	-- Auto close html tags
	use({ "windwp/nvim-ts-autotag", require = "nvim-treesitter/nvim-treesitter" })

	-- Better %
	use("andymass/vim-matchup")

	-- Commenting
	use({
		"numToStr/Comment.nvim",
		config = function()
			local Comment = require("Comment")
			local utils = require("Comment.utils")

			Comment.setup({
				pre_hook = function(ctx)
					local location = nil
					if ctx.ctype == utils.ctype.blockwise then
						location = require("ts_context_commentstring.utils").get_cursor_location()
					elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
						location = require("ts_context_commentstring.utils").get_visual_start_location()
					end

					return require("ts_context_commentstring.internal").calculate_commentstring({
						key = ctx.ctype == utils.ctype.linewise and "__default" or "__multiline",
						location = location,
					})
				end,
			})
		end,
	})

	-- Color schemes
	-- use("rmehri01/onenord.nvim")
	use({
		"marko-cerovac/material.nvim",
		config = function()
			require("material").setup({
				contrast = {
					sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
					floating_windows = false, -- Enable contrast for floating windows
					line_numbers = false, -- Enable contrast background for line numbers
					sign_column = false, -- Enable contrast background for the sign column
					cursor_line = false, -- Enable darker background for the cursor line
					non_current_windows = false, -- Enable darker background for non-current windows
					popup_menu = false, -- Enable lighter background for the popup menu
				},

				italics = {
					comments = true, -- Enable italic comments
					keywords = true, -- Enable italic keywords
					functions = false, -- Enable italic functions
					strings = false, -- Enable italic strings
					variables = false, -- Enable italic variables
				},

				contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
					"terminal", -- Darker terminal background
					"packer", -- Darker packer background
					"qf", -- Darker qf list background
				},

				high_visibility = {
					lighter = false, -- Enable higher contrast text for lighter style
					darker = false, -- Enable higher contrast text for darker style
				},

				disable = {
					colored_cursor = false, -- Disable the colored cursor
					borders = false, -- Disable borders between verticaly split windows
					background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
					term_colors = false, -- Prevent the theme from setting terminal colors
					eob_lines = false, -- Hide the end-of-buffer lines
				},

				lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

				async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

				custom_highlights = {}, -- Overwrite highlights with your own

				plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
					trouble = true,
					nvim_cmp = true,
					neogit = true,
					gitsigns = true,
					git_gutter = true,
					telescope = true,
					nvim_tree = true,
					sidebar_nvim = true,
					lsp_saga = true,
					nvim_dap = true,
					nvim_navic = true,
					which_key = true,
					sneak = true,
					hop = true,
					indent_blankline = true,
					nvim_illuminate = true,
					mini = true,
				},
			})
		end,
	})

	-- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	use({
		"folke/lua-dev.nvim",
		config = function()
			require("lua-dev").setup()
		end,
	})

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({})
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			require("null-ls").setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.diagnostics.stylelint,
				},
			})
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
			"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
			"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
			"hrsh7th/cmp-nvim-lsp-signature-help", -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
			"saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
		},
	})

	--  Add/change/delete surrounding delimiter pairs with ease.
	use({
		"kylechui/nvim-surround",
		event = "InsertEnter",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			local navic = require("nvim-navic")

			require("lualine").setup({
				options = {
					theme = "auto", -- nord
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
							show_filename_only = true,
							file_status = true,
						},
						{ navic.get_location, cond = navic.is_available },
					},
					lualine_x = { "filetype" },
				},
			})
		end,
	})

	-- git labels
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({})
		end,
	})

	-- Open file on remote website
	use("ruanyl/vim-gh-line")
	use({
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("gitlinker").setup({ mappings = nil })
		end,
	})

	-- Dashboard (start screen)
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	})

	-- Indent guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_trailing_blankline_indent = false,
				use_treesitter = true,
				char = "▏",
				context_char = "▏",
				show_current_context = true,
			})
		end,
	})

	-- Automatically move to last place in the opened file
	use({
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({})
		end,
	})

	-- Better buffer deletion
	use({ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } })

	-- Snippet collection
	use({ "rafamadriz/friendly-snippets", after = "LuaSnip", opt = true })

	-- Fzf

	use({ "junegunn/fzf", run = "./install --bin" })
	use({ "junegunn/fzf.vim" })

	-- Indentation detection
	use({
		"Darazaki/indent-o-matic",
		event = "BufReadPost",
		config = function()
			require("indent-o-matic").setup({})
		end,
	})

	-- multi cursors / selection
	use({ "mg979/vim-visual-multi" })

	-- Improve nvim UI
	use({ "stevearc/dressing.nvim" })

	-- Session manager
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "~/.config/nvim", "/" },
				auto_session_use_git_branch = true,
			})
		end,
	})

	-- Tmux navigator
	use("christoomey/vim-tmux-navigator")

	-- Highlight current word uses
	use("RRethy/vim-illuminate")

	-- Automatic lists
	use("dkarter/bullets.vim")

	-- Motions
	use({
		"phaazon/hop.nvim",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- Projectionist
	use("tpope/vim-projectionist")

	-- Which key
	use({
		"folke/which-key.nvim",
		keys = { "<leader>", ",", '"', "'", "`" },
		config = function()
			require("which-key").setup({
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "  ", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},

				popup_mappings = {
					scroll_down = "<c-d>", -- binding to scroll down inside the popup
					scroll_up = "<c-u>", -- binding to scroll up inside the popup
				},

				window = {
					border = "none", -- none/single/double/shadow
				},

				layout = {
					spacing = 6, -- spacing between columns
				},

				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

				triggers_blacklist = {
					-- list of mode / prefixes that should never be hooked by WhichKey
					i = { "j", "k" },
					v = { "j", "k" },
				},
			})
		end,
	})

	-- Open alternative file
	use({
		"rgroli/other.nvim",
		config = function()
			require("other-nvim").setup({
				mappings = {
					"rails",
					{
						pattern = "/app/(.*)/.*.js$",
						target = "/spec/%1/",
						transformer = "lowercase",
					},
				},
			})
		end,
	})

	-- Improve startup time
	use("lewis6991/impatient.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
