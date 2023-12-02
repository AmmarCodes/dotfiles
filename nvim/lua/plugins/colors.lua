return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    config = function()
      local navic = require("nvim-navic")

      require("lualine").setup({
        options = {
          theme = "auto", -- "catppuccin", -- auto
          -- section_separators = { left = "", right = "" },
          -- component_separators = { left = "", right = "" },
          section_separators = "", -- disabling separators
          component_separators = "", -- disabling separators
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            "branch",
            "diff",
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              -- symbols = { error = " ", warn = " ", info = " ", hint = " " },
              sections = { "error", "warn", "info", "hint" },
            },
          },
          lualine_c = {
            {
              "filename",
              show_filename_only = false,
              file_status = true,
              path = 1,
            },
            { navic.get_location, cond = navic.is_available },
          },
          lualine_x = { "filetype" },
        },
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require("catppuccin").setup({
        bg = {
          light = "latte",
          dark = "frappe",
        },
        integrations = {
          alpha = true,
          cmp = true,
          mason = true,
          notify = true,
          nvimtree = true,
          gitsigns = true,
        },
        color_overrides = {
          latte = {
            -- base = "#FFFFFF",
          },
        },
      })

      vim.cmd([[set background=light]])
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_better_performance = 1
      vim.cmd([[set background=light]])
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "shaunsingh/solarized.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require("gruvbox").setup()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
