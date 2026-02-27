-- Theme colorscheme configuration
-- Managed by theme-set: loads the active theme's neovim spec
--
-- The active neovim.lua is copied here by `theme-set` and should return
-- a LazyVim plugin spec table. To change themes, run: theme-set <name>

local dotfiles = vim.fn.expand("~/.dotfiles")
local active_theme = dotfiles .. "/themes/active-neovim.lua"

-- Load the active theme spec if it exists, otherwise fall back to catppuccin
if vim.fn.filereadable(active_theme) == 1 then
  return dofile(active_theme)
else
  -- Fallback: catppuccin-frappe
  return {
    {
      "catppuccin",
      opts = {
        flavour = "frappe",
        integrations = {
          blink_cmp = true,
        },
        no_bold = true,
        no_italic = false,
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "catppuccin-frappe",
      },
    },
  }
end
