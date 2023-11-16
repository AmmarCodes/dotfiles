return {
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
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local actions = require("fzf-lua.actions")
			require("fzf-lua").setup({
				actions = {
					files = {
						-- instead of the default action 'actions.file_edit_or_qf'
						-- it's important to define all other actions here as this
						-- table does not get merged with the global defaults
						["default"] = actions.file_edit,
						["ctrl-s"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
						["ctrl-t"] = actions.file_tabedit,
						["alt-q"] = actions.file_sel_to_qf,
					},
				},
			})
		end,
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
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local ts_conds = require("nvim-autopairs.ts-conds")

			npairs.setup({
				check_ts = true,
			})
			npairs.add_rules({
				Rule("{{", "  }", "vue"):set_end_pair_length(2):with_pair(ts_conds.is_ts_node("text")),
			})
		end,
	},
	{
		--  Add/change/delete surrounding delimiter pairs with ease.
		"kylechui/nvim-surround",
		event = "InsertEnter",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
		event = "BufReadPre",
	},
	-- multi cursors / selection
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	-- Improve nvim UI
	{ "stevearc/dressing.nvim" },

	-- Tmux navigator
	{ "christoomey/vim-tmux-navigator", lazy = true, event = "BufReadPost" },

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
	{
		"dkarter/bullets.vim",
		config = function()
			vim.g["bullets_set_mappings"] = 0
		end,
	},

	-- Motions
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

	-- editorconfig
	{ "gpanders/editorconfig.nvim", event = "BufReadPre" },

	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]() -- install without yarn or npm
		end,
		cmd = { "MarkdownPreview" },
		lazy = true,
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
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.register({
				["<leader>"] = {
					l = {
						name = "LSP",
						n = {
							require("illuminate").goto_prev_reference,
							"Jump to next occurance of symbol under cursor",
						},
						b = {
							require("illuminate").goto_prev_reference,
							"Jump to previous occurance of symbol under cursor",
						},
					},
					y = {
						name = "Yank",
						r = { name = "Remote link" },
						f = { name = "File" },
					},
					t = {
						name = "Test",
					},
					s = { name = "Search" },
					e = { name = "NvimTree" },
					b = { name = "Buffers" },
				},
			}, opts)
		end,
	},
	{ "dstein64/vim-startuptime", cmd = { "StartupTime" } },
	{ "j-hui/fidget.nvim", config = true, cmd = { "VeryLazy" } },
	{ "tpope/vim-sleuth", event = "VeryLazy" },
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
			vim.g["test#strategy"] = "neovim_sticky"
			vim.g["test#neovim#start_normal"] = 1
			vim.g["test#neovim#term_position"] = "vert botright"
		end,
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				-- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				mode = "workspace_diagnostics",
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 15,
				padding = false,
				action_keys = {
					-- key mappings for actions in the trouble list
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM" }, -- close all folds
					open_folds = { "zR" }, -- open all folds
					toggle_fold = { "za" }, -- toggle fold of current file
				},
				auto_jump = {},
				use_diagnostic_signs = true,
			})
		end,
	},
}
