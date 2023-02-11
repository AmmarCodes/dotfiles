return {
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		vim.cmd([[colorscheme everforest]])
	-- 		vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]])
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[colorscheme catppuccin-frappe]])
			-- vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]])
		end,
	},
	{
		-- Bufferline
		"akinsho/bufferline.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = true,
	},
	{
		-- Automatically move to last place in the opened file
		"ethanholz/nvim-lastplace",
		config = true,
	},
	{
		-- Better buffer deletion
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
	},
	{
		"junegunn/fzf.vim",
		dependencies = {
			{ "junegunn/fzf", build = "./install --bin" },
		},
		cmd = { "Files" },
	},
	{
		-- Better %
		"andymass/vim-matchup",
		config = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
	},
	{
		-- Add end to close functions
		"RRethy/nvim-treesitter-endwise",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
	},
	{
		-- Color brackets and paranthesis
		"p00f/nvim-ts-rainbow",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
	},
	{
		-- Auto close html tags
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = true,
		lazy = true,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = true,
		lazy = true,
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		lazy = true,
	},
	{
		"windwp/nvim-autopairs",
		config = true,
		lazy = true,
	},
	{
		--  Add/change/delete surrounding delimiter pairs with ease.
		"kylechui/nvim-surround",
		event = "InsertEnter",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		lazy = true,
	},
	{
		-- Indentation detection
		"Darazaki/indent-o-matic",
		event = "BufReadPost",
		config = function()
			require("indent-o-matic").setup({})
		end,
	},
	-- multi cursors / selection
	{ "mg979/vim-visual-multi", lazy = true },
	-- Improve nvim UI
	{ "stevearc/dressing.nvim" },

	-- Tmux navigator
	{ "christoomey/vim-tmux-navigator", lazy = true },

	-- Highlight current word uses
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},

	-- Automatic lists
	{ "dkarter/bullets.vim", lazy = true },

	-- Motions
	{
		"phaazon/hop.nvim",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},

	-- Projectionist
	{ "tpope/vim-projectionist", lazy = true },
	-- They say this gives nicer notifications
	{ "rcarriga/nvim-notify" },

	-- editorconfig
	{ "gpanders/editorconfig.nvim", event = "BufReadPre" },

	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]() -- install without yarn or npm
		end,
		cmd = { "MarkdownPreview" },
	},

	-- Copy file location with current line
	{
		"diegoulloao/nvim-file-location",
		config = true,
		event = "VeryLazy",
	},
	-- Open file on remote website
	{
		"ruifm/gitlinker.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitlinker").setup({ mappings = nil })
		end,
		lazy = true,
	},
	-- Session manager
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "~/.config/nvim", "/" },
				auto_session_use_git_branch = true,
			})
		end,
	},
	"SmiteshP/nvim-navic",
	{ "folke/which-key.nvim", config = true, event = "VeryLazy" },
	{ "dstein64/vim-startuptime", cmd = { "StartupTime" } },
	{ "j-hui/fidget.nvim", config = true, cmd = { "VeryLazy" } },
	{ "tpope/vim-sleuth", lazy = true },
	{ "williamboman/mason.nvim", cmd = "Mason", config = true },
}
