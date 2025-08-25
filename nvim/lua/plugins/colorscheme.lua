return {
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   priority = 1000,
  --   opts = {
  --     dark_variant = "moon",
  --   },
  -- },
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
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   opts = {
  --     update_interval = 1000,
  --     set_dark_mode = function()
  --       vim.api.nvim_set_option_value("background", "dark", {})
  --       vim.cmd("colorscheme catppuccin")
  --     end,
  --     set_light_mode = function()
  --       vim.api.nvim_set_option_value("background", "light", {})
  --       vim.cmd("colorscheme rose-pine-dawn")
  --     end,
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
