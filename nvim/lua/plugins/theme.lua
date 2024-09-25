return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  {
    "catppuccin",
    opts = {
      flavour = "frappe",
      dim_inactive = {
        enabled = true,
      },
      show_end_of_buffer = false,
      integration_default = false,
      integrations = {
        barbecue = { dim_dirname = true, bold_basename = true, dim_context = false, alt_background = false },
        mini = {
          enabled = false,
        },
        cmp = true,
        gitsigns = true,
        hop = true,
        illuminate = { enabled = true },
        native_lsp = { enabled = true, inlay_hints = { background = true } },
        neogit = true,
        neotree = true,
        semantic_tokens = true,
        treesitter = true,
        treesitter_context = true,
        vimwiki = true,
        which_key = true,
      },
    },
  },
  {
    "sainnhe/gruvbox-material",
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
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "rose-pine-dawn",
      colorscheme = "gruvbox-material",
    },
  },
}
