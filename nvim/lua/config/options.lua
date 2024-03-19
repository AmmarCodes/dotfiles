-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.mapleader = ","
local opt = vim.opt

opt.swapfile = false -- Don't use swapfile
opt.wildignore = "*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
opt.confirm = false -- Confirm to save changes before exiting modified buffer

opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "v:lua.vim.treesitter.foldtext()"
