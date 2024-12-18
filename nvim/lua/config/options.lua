-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
local opt = vim.opt

opt.swapfile = false -- Don't use swapfile
opt.wildignore = "*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
opt.confirm = false -- Confirm to save changes before exiting modified buffer
opt.background = "dark"

vim.g.lazyvim_php_lsp = "intelephense"
vim.g.snacks_animate = false
