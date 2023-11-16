-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, keymap, command, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, keymap, command, options)
end

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Map Esc to kk
map("i", "kk", "<Esc>")

-- Clear search highlighting with enter
map("n", "<cr>", ":nohl<CR>")

-- Toggle auto-indenting for code paste
-- map('n', '<F2>', ':set invpaste paste?<CR>')
-- vim.opt.pastetoggle = '<F2>'

-- Change split orientation
-- map("n", "<leader>tk", "<C-w>t<C-w>K") -- change vertical to horizontal
-- map("n", "<leader>th", "<C-w>t<C-w>H") -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- yank file name / path
map("n", "<leader>yfr", ':let @*=expand("%")<CR>', { desc = "Yank file relative path" })
map("n", "<leader>yff", ':let @*=expand("%:p")<CR>', { desc = "Yank file full path" })
map(
	"n",
	"<leader>yfl",
	"<cmd>lua NvimFileLocation.copy_file_location()<cr>",
	{ desc = "Yank file path with line number" }
)

-- Bubbling lines
map("n", "<c-Up>", ":m .-2<cr>")
map("n", "<c-Down>", ":m .+1<cr>")

-- Switch to previous buffer
map("n", "<leader>b<leader>", ":b#<CR>", { desc = "Switch to previous buffer" })
-- Switch buffers with <shift> hl
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- easier moving of code blocks
map("v", "<", "<gv")
map("v", ">", ">gv")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- NvimTree
map("n", "<leader>ee", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" }) -- open/close
map("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Show current file in NvimTree" }) -- show file in NvimTree

-- fzf-lua
map("n", "<C-p>", require("fzf-lua").files, { desc = "Find files" })
map("n", "<C-b>", require("fzf-lua").buffers, { desc = "Find current buffers" })

map("n", "<leader>sw", require("fzf-lua").grep, { desc = "Search for something (using Rg)" })
map("n", "<leader>ss", require("fzf-lua").grep_cword, { desc = "Search for current word under cursor" })

map("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete current buffer" })
map("n", "<leader>ba", ":bufdo Bdelete<CR>", { desc = "Delete all buffers" })
map("n", "<leader>bo", '<cmd>%bdelete | e# | normal `"<CR>', { desc = "Delete other buffers" })

-- vim-visual-multi disable all mappings except ctrl-n
vim.g.VM_default_mappings = 0

-- ruifm/gitlinker.nvim
map(
	"n",
	"<leader>yrl",
	':lua require"gitlinker".get_buf_range_url("n")<cr>',
	{ desc = "Copy remote git link of the current file" }
)
map(
	"v",
	"<leader>yrl",
	':lua require"gitlinker".get_buf_range_url("v", {silent = false})<cr>',
	{ desc = "Copy remote git link of the current selection" }
)

-- Move to specific window, credits: https://www.reddit.com/r/neovim/comments/115dcvy/tip_jump_to_any_window_with_just_two_keystrokes/
for i = 1, 6 do
	local lhs = "<leader>" .. i
	local rhs = i .. "<c-w>w"
	vim.keymap.set("n", lhs, rhs, { desc = "Move to window " .. i })
end

-- Exit insert mode in Terminal
map("t", "<C-o>", "<C-\\><C-n>")

-- map(
-- 	"n",
-- 	"<leader>ln",
-- 	require("illuminate").goto_next_reference,
-- 	{ desc = "Jump to next occurance of symbol under cursor" }
-- )
--
-- map(
-- 	"n",
-- 	"<leader>lb",
-- 	require("illuminate").goto_prev_reference,
-- 	{ desc = "Jump to previous occurance of symbol under cursor" }
-- )
