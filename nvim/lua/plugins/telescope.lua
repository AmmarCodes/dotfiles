-----------------------------------------------------------
-- Telescope and telescope plugins configuration file
-----------------------------------------------------------

-- Plugin: telescope
-- url: https://github.com/nvim-telescope/telescope.nvim

local M = {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	version = false,
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-frecency.nvim",
	},
}

function M.config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local trouble = require("trouble.providers.telescope")

	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "› ",
			entry_prefix = "  ",
			initial_mode = "insert",
			select_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_cutoff = 120,
					-- preview_width = 0.55,
					-- results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "node_modules", "%.git/." },
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			-- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			-- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			-- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			-- Developer configurations: Not meant for general override
			-- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-t>"] = trouble.open_with_trouble,
				},

				n = { ["<C-t>"] = trouble.open_with_trouble, ["q"] = require("telescope.actions").close },
			},
			previewer = false,
		},
		pickers = {
			find_files = {
				-- theme = "dropdown",
				previewer = true,
				layout_config = {
					-- width = 0.5,
					height = 0.8,
					prompt_position = "top",
					preview_cutoff = 120,
				},
			},
			git_files = {
				previewer = true,
				layout_config = {
					height = 0.8,
					prompt_position = "top",
					preview_cutoff = 120,
				},
			},
			buffers = {
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer,
					},
					n = {
						["<c-d>"] = actions.delete_buffer,
					},
				},
				previewer = false,
				initial_mode = "insert",
				theme = "dropdown",
				layout_config = {
					width = 0.5,
					height = 0.4,
					prompt_position = "top",
					preview_cutoff = 120,
				},
			},
			current_buffer_fuzzy_find = {
				previewer = true,
				-- theme = "dropdown",
				layout_config = {
					-- width = 0.5,
					height = 0.8,
					prompt_position = "top",
					preview_cutoff = 120,
				},
			},
			live_grep = {
				only_sort_text = true,
				previewer = true,
				layout_config = {
					horizontal = {
						width = 0.9,
						height = 0.75,
						preview_width = 0.6,
					},
				},
			},
			grep_string = {
				only_sort_text = true,
				previewer = true,
				layout_config = {
					horizontal = {
						width = 0.9,
						height = 0.75,
						preview_width = 0.6,
					},
				},
			},
			lsp_references = {
				show_line = false,
				previewer = true,
				layout_config = {
					horizontal = {
						width = 0.9,
						height = 0.75,
						preview_width = 0.6,
					},
				},
			},
			treesitter = {
				show_line = false,
				previewer = true,
				layout_config = {
					horizontal = {
						width = 0.9,
						height = 0.75,
						preview_width = 0.6,
					},
				},
			},
		},
		extensions = {
			fzf = {
				case_mode = "smart_case",
				fuzzy = true,
				override_file_sorter = true,
				override_generic_sorter = true,
			},
			frecency = {
				default_workspace = "CWD",
				show_scores = true,
				show_unindexed = true,
				disable_devicons = false,
				ignore_patterns = {
					"*.git/*",
					"*/tmp/*",
					"*/lua-language-server/*",
				},
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					previewer = false,
					initial_mode = "normal",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							width = 0.5,
							height = 0.4,
							preview_width = 0.6,
						},
					},
				}),
			},
		},
	})

	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")
	telescope.load_extension("frecency")
end

return M
