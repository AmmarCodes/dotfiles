-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- url: https://github.com/hrsh7th/nvim-cmp

local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
		"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
		"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
		"hrsh7th/cmp-nvim-lsp-signature-help", -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
		"saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
		"rafamadriz/friendly-snippets", -- Snippet collection
		"onsails/lspkind.nvim",
	},
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	--- LuaSnip setup
	luasnip.config.set_config({
		history = false, -- If true, Snippets that were exited can still be jumped back into.
		update_events = "TextChanged,TextChangedI", -- Update more often, :h events for more info.
		region_check_events = "CursorMoved", -- Ref: https://github.com/L3MON4D3/LuaSnip/issues/91
	})

	luasnip.filetype_extend("ruby", { "rails" })

	-- this will lazy load all filetypes
	require("luasnip/loaders/from_vscode").load({ include = { "ruby", "rails", "javascript", "vue", "html", "css" } })

	--- CMP setup
	cmp.setup({
		-- Load snippet support
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		-- Completion settings
		completion = {
			--completeopt = 'menu,menuone,noselect'
			keyword_length = 2,
		},

		-- Key mapping
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),

			-- Tab mapping
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end,
		},

		-- Load sources, see: https://github.com/topics/nvim-cmp
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer" },
		},

		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol", -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			}),
		},
	})
end

return M
