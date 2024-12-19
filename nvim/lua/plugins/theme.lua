return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      dark_variant = "moon",
    },
  },
  {
    "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        transparent_background = true,
        highlight_overrides = {
          all = function(C)
            return {
              -- fix visal selection within illuminated words not visible enough
              IlluminatedWordText = { bg = C.surface1 },
              IlluminatedWordRead = { bg = C.surface1 },
              IlluminatedWordWrite = { bg = C.surface1 },
              Visual = { bg = C.surface0, style = { "bold" } },
            }
          end,
        },
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          grug_far = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          blink_cmp = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      })
    end,
  },
  {
    "sainnhe/gruvbox-material",
    enabled = false,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_better_performance = true
      -- vim.g.gruvbox_material_background = "hard"
      -- gruvbox_material_diagnostic_text_highlight
      -- gruvbox_material_diagnostic_line_highlight
      -- gruvbox_material_diagnostic_virtual_text
      -- gruvbox_material_inlay_hints_background = "dimmed" -- none
      --       g:gruvbox_material_current_word~
      --
      -- Some plugins can highlight the word under current cursor, you can use this
      -- option to control their behavior.
      --
      --     Type:               |String|
      --     Available values:   `'grey background'`, `'high contrast background'`, `'bold'`,
      --     `'underline'`, `'italic'`
      --     Default value:      `'grey background'` when not in transparent mode, `'bold'`
      --     when in transparent mode.
      --
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme catppuccin")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme rose-pine-dawn")
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
