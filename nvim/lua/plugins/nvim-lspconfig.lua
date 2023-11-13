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
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		-- Highlighting references
		if client.server_capabilities.document_highlight then
			vim.api.nvim_exec(
				[[
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
			]],
				false
			)
		end

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
		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		local opts = { noremap = true, silent = true }

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		-- buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		-- buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
		-- buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
		-- buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		-- buf_set_keyman("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		-- buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		-- buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
		buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
		-- buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
		buf_set_keymap(
			"n",
			"<leader>p",
			"<cmd>lua vim.lsp.buf.format()<CR>",
			vim.tbl_deep_extend("keep", opts, { desc = "Format document using LSP" })
		)

		navic.attach(client, bufnr)

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"bashls",
				"cssls",
				"eslint",
				"html",
				"tsserver",
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
	local servers = { "solargraph", "bashls", "html", "cssls", "tsserver", "vuels", "lua_ls" }

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

	function print_table(node)
		local cache, stack, output = {}, {}, {}
		local depth = 1
		local output_str = "{\n"

		while true do
			local size = 0
			for k, v in pairs(node) do
				size = size + 1
			end

			local cur_index = 1
			for k, v in pairs(node) do
				if (cache[node] == nil) or (cur_index >= cache[node]) then
					if string.find(output_str, "}", output_str:len()) then
						output_str = output_str .. ",\n"
					elseif not (string.find(output_str, "\n", output_str:len())) then
						output_str = output_str .. "\n"
					end

					-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
					table.insert(output, output_str)
					output_str = ""

					local key
					if type(k) == "number" or type(k) == "boolean" then
						key = "[" .. tostring(k) .. "]"
					else
						key = "['" .. tostring(k) .. "']"
					end

					if type(v) == "number" or type(v) == "boolean" then
						output_str = output_str .. string.rep("\t", depth) .. key .. " = " .. tostring(v)
					elseif type(v) == "table" then
						output_str = output_str .. string.rep("\t", depth) .. key .. " = {\n"
						table.insert(stack, node)
						table.insert(stack, v)
						cache[node] = cur_index + 1
						break
					else
						output_str = output_str .. string.rep("\t", depth) .. key .. " = '" .. tostring(v) .. "'"
					end

					if cur_index == size then
						output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
					else
						output_str = output_str .. ","
					end
				else
					-- close the table
					if cur_index == size then
						output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
					end
				end

				cur_index = cur_index + 1
			end

			if size == 0 then
				output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
			end

			if #stack > 0 then
				node = stack[#stack]
				stack[#stack] = nil
				depth = cache[node] == nil and depth + 1 or depth - 1
			else
				break
			end
		end

		-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
		table.insert(output, output_str)
		output_str = table.concat(output)

		print(output_str)
	end

	-- Call setup
	for _, lsp in ipairs(servers) do
		local settings = vim.tbl_deep_extend("force", {
			on_attach = on_attach,
			root_dir = root_dir,
			capabilities = capabilities,
			flags = {
				-- default in neovim 0.7+
				debounce_text_changes = 150,
			},
		}, config[lsp] or {})

		-- if lsp == "vuels" then
		-- 	print_table(settings)
		-- end

		lspconfig[lsp].setup(settings)
	end
end

return M
