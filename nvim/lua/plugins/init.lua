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
		enabled = true,
		config = function()
			require("catppuccin").setup({
				bg = {
					light = "latte",
					dark = "frappe",
				},
				integrations = {
					alpha = true,
					cmp = true,
					mason = true,
					notify = true,
					nvimtree = true,
					telescope = true,
					gitsigns = true,
				},
				color_overrides = {
					latte = {
						base = "#FFFFFF",
					},
				},
			})

			vim.cmd([[set background=light]])
			vim.cmd([[colorscheme catppuccin]])
			-- vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]])
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = function()
			require("gruvbox").setup({
				-- invert_selection = true,
				-- inverse = false,
			})
			-- vim.cmd([[background dark]])
			vim.cmd([[colorscheme gruvbox]])
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
		cmd = { "Files", "Rg" },
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
		event = "BufReadPre",
	},
	{
		-- Indentation detection
		-- "Darazaki/indent-o-matic",
		-- event = "BufReadPost",
		-- config = function()
		-- 	require("indent-o-matic").setup({})
		-- end,
	},
	-- multi cursors / selection
	{ "mg979/vim-visual-multi" },
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
		enabled = false,
		-- you can configure Hop the way you like here; see :h hop-config
		opts = { keys = "etovxqpdygfblzhckisuran" },
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					-- when `true`, flash will be activated during regular search by default.
					-- You can always toggle when searching with `require("flash").toggle()`
					enabled = false,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- Projectionist
	{ "tpope/vim-projectionist", event = "BufReadPre" },
	-- They say this gives nicer notifications
	{
		"rcarriga/nvim-notify",
		opts = { max_width = 50 },
	},

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
		opts = { mappings = nil },
		lazy = true,
	},
	-- Session manager
	{
		"rmagatti/auto-session",
		opts = {
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Downloads", "~/.config/nvim", "/" },
			auto_session_use_git_branch = true,
		},
	},
	"SmiteshP/nvim-navic",
	{ "folke/which-key.nvim", config = true, event = "VeryLazy" },
	{ "dstein64/vim-startuptime", cmd = { "StartupTime" } },
	{ "j-hui/fidget.nvim", config = true, cmd = { "VeryLazy" } },
	{ "tpope/vim-sleuth", lazy = true },
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true,
		opt = {
			"luacheck",
			"rubocop",
			"ruby-lsp",
			"vetur-vls",
			"typescript-language-server",
			"lua-language-server",
			"bash-language-server",
			"css-lsp",
			"eslint-lsp",
			"html-lsp",
			"prettierd",
			"stylelint-lsp",
			"stylua",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			max_width = 50,
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			popupmenu = {
				enabled = false,
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
	},
	{
		"vim-test/vim-test",
		cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
		keys = {
			{ "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test suite" },
			{ "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
			{ "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test nearest" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
		},
		config = function()
			vim.g["test#strategy"] = "neovim"
			vim.g["test#neovim#start_normal"] = 1
			vim.g["test#neovim#term_position"] = "vert botright"
		end,
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
}
