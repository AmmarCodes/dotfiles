-----------------------------------------------------------
-- Indent line configuration file
-----------------------------------------------------------

-- Plugin: indent-blankline
-- url: https://github.com/lukas-reineke/indent-blankline.nvim

local M = {
  "lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
  init = function()
    vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]])
  end,
  config = {
    show_trailing_blankline_indent = false,
    use_treesitter = true,
    char = "▏",
    context_char = "▎",
    show_current_context = true,
    -- show_current_context_start = true,
    show_first_indent_level = false,
    filetype_exclude = {
      "lspinfo",
      "packer",
      "checkhealth",
      "help",
      "man",
      "dashboard",
      "git",
      "markdown",
      "text",
      "terminal",
      "NvimTree",
      "TelescopePrompt",
      "TelescopeResults",
    },
    buftype_exclude = {
      "terminal",
      "nofile",
      "quickfix",
      "prompt",
    },
  }
}

return M
