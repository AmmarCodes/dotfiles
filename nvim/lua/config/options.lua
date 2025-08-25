-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
local opt = vim.opt

opt.swapfile = false -- Don't use swapfile
opt.undofile = true -- Persistent undo
opt.wildignore = "*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
opt.confirm = false -- Confirm to save changes before exiting modified buffer
opt.background = "dark"

vim.g.lazyvim_php_lsp = "intelephense"
vim.g.snacks_animate = false

vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true,

  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
})

----------------------------------
-- Folding - replacing ufo-nvim --
----------------------------------

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

-- Default to treesitter folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})
vim.api.nvim_create_autocmd("LspDetach", { command = "setl foldexpr<" })
