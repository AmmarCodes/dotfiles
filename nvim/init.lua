--[[

Neovim init file
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]

-- Import Lua modules
require("packer_init")
require("core/options")
require("core/autocmds")
require("core/keymaps")
require("core/colors")
require("core/statusline")
require("plugins/nvim-tree")
require("plugins/indent-blankline")
require("plugins/telescope")
require("plugins/nvim-cmp")
require("plugins/mason")
require("plugins/nvim-lspconfig")
require("plugins/nvim-treesitter")
require("plugins/alpha-nvim")

vim.api.nvim_create_user_command("Fold", function()
	-- Fold current buffer based on treesitter
	-- https://www.jmaguire.tech/posts/treesitter_folding/
	local opt = vim.opt
	opt.foldmethod = "expr"
	opt.foldexpr = "nvim_treesitter#foldexpr()"
end, {})
