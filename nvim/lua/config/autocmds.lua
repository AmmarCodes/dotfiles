-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
-- remove auto command added by LazyVim
vim.api.nvim_clear_autocmds({ event = "TextYankPost" })
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = "1000" })
  end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- Enter insert mode when switching to terminal
-- autocmd("TermOpen", {
--   command = "setlocal listchars= nonumber norelativenumber nocursorline",
-- })
--
autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
  pattern = "term://*",
  command = "stopinsert",
})

-- show cursor line only in active window
local cursorGrp = augroup("CursorLine", { clear = true })
autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = cursorGrp })

-- Disable concealing in some file formats
autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- automatically create dirs when saving new file
-- source: https://github.com/mateuszwieloch/automkdir.nvim/blob/main/plugin/automkdir.lua
local automkdirGroup = augroup("automkdirGroup", { clear = true })

autocmd("BufWritePre", {
  callback = function(t)
    -- Function gets a table that contains match key, which maps to `<amatch>` (a full filepath).
    local dirname = vim.fs.dirname(t.match)
    -- Attempt to mkdir. If dir already exists, it returns nil.
    -- Use 755 permissions, which means rwxr.xr.x
    vim.loop.fs_mkdir(dirname, tonumber("0755", 8))
  end,
  group = automkdirGroup,
})

autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.njk", command = "setfiletype html" })
