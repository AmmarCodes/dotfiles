return {
	"nvimtools/none-ls.nvim",
	event = "BufReadPre",
	enabled = false,
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		local null_ls = require("null-ls")
		require("null-ls").setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				-- null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.diagnostics.stylelint,
				null_ls.builtins.code_actions.gitsigns,
				null_ls.builtins.diagnostics.rubocop.with({ args = { "--lsp" } }),
				null_ls.builtins.formatting.rubocop.with({ args = { "--lsp" } }),
			},
		})
	end,
}
