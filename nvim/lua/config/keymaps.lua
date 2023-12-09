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

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- yank file name / path
map("n", "<leader>yfr", ':let @*=expand("%")<CR>', { desc = "Yank file relative path" })
map("n", "<leader>yff", ':let @*=expand("%:p")<CR>', { desc = "Yank file full path" })

-- Exit insert mode in Terminal
map("t", "<C-o>", "<C-\\><C-n>")

map("n", "<leader>ba", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })

map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
