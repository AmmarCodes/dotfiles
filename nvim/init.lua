--[[

Inspirations:
- https://github.com/brainfucksec/neovim-lua
- https://github.com/folke/dot
--]]

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Import Lua modules
require("lazy_init")
require("core/options")
require("core/autocmds")
require("core/keymaps")

vim.api.nvim_create_user_command("Fold", function()
	-- Fold current buffer based on treesitter
	-- https://www.jmaguire.tech/posts/treesitter_folding/
	local opt = vim.opt
	opt.foldmethod = "expr"
	opt.foldexpr = "nvim_treesitter#foldexpr()"
end, {})
