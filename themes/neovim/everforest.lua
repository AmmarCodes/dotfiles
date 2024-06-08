return {
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_better_performance = 1
      vim.cmd([[set background=light]])
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
