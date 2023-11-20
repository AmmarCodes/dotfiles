-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

local M = {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"SmiteshP/nvim-navic",
		{ "folke/neodev.nvim", config = true },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"pmizio/typescript-tools.nvim",
			config = function()
				require("typescript-tools").setup({})
			end,
		},
	},
}

function M.config()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local navic = require("nvim-navic")

	-- Diagnostic options, see: `:help vim.diagnostic.config`
	vim.diagnostic.config({
		update_in_insert = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	-- Show line diagnostics automatically in hover window
	vim.cmd([[
	autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
	]])

	-- Add additional capabilities supported by nvim-cmp
	-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

	capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.preselectSupport = true
	capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
	capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
	capabilities.textDocument.completion.completionItem.deprecatedSupport = true
	capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
	capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	-- delegate formatting to null-ls
	local lsp_formatting = function(bufnr)
		vim.lsp.buf.format({
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end

		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		navic.attach(client, bufnr)

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"bashls",
				"cssls",
				"eslint",
				"html",
				-- "tsserver",
				"solargraph",
				"stylelint_lsp",
				"vuels",
			},
		})
	end

	--[[

	Language servers setup:

	For language servers list see:
		https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

		Language server installed:

		Bash          -> bashls
		Python        -> pyright
		C-C++         -> clangd
		HTML/CSS/JSON -> vscode-html-languageserver
		JavaScript/TypeScript -> tsserver

		--]]

	-- Define `root_dir` when needed
	-- See: https://github.com/neovim/nvim-lspconfig/issues/320
	-- This is a workaround, maybe not work with some servers.
	local root_dir = function()
		return vim.fn.getcwd()
	end

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches.
	-- Add your language server below:
	local servers = {
		"solargraph",
		"bashls",
		"html",
		"cssls",
		-- "tsserver",
		"vuels",
		"lua_ls",
	}

	local config = {
		vuels = {
			settings = {
				vetur = {
					ignoreProjectWarning = true,
				},
			},
		},

		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		},
	}

	-- Call setup
	for _, lsp in ipairs(servers) do
		local settings = vim.tbl_deep_extend("force", {
			on_attach = on_attach,
			root_dir = root_dir,
			capabilities = capabilities,
		}, config[lsp] or {})

		lspconfig[lsp].setup(settings)
	end
end

return M
