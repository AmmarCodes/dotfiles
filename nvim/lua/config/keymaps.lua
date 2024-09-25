-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, keymap, command, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, keymap, command, options)
end

-- Clear search highlighting with enter
map("n", "<cr>", ":nohl<CR>")

-- paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- yank file name / path
map("n", "<leader>yfr", ':let @*=expand("%")<CR>', { desc = "Yank file relative path" })
map("n", "<leader>yff", ':let @*=expand("%:p")<CR>', { desc = "Yank file full path" })

-- Exit insert mode in Terminal
map("t", "<C-o>", "<C-\\><C-n>")

map("n", "<leader>ba", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })

-- smart deletion, dd
-- It solves the issue, where you want to delete empty line, but dd will override your last yank.
-- Code below will check if u are deleting empty line, if so - use black hole register.
-- [src: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3]
map("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { noremap = true, expr = true })

------------------------
--    smart-splits    --
------------------------
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

-- move visually selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
