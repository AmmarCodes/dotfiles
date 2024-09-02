return {
  {
    "andymass/vim-matchup",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "ruby", "eruby", "vim", "lua", "bash" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end,
  },
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "dkarter/bullets.vim",
    ft = { "markdown", "text" },
    config = function()
      vim.g["bullets_set_mappings"] = 0
    end,
  },
  {
    "tpope/vim-projectionist",
    event = "BufReadPre",
    ft = { "javascript", "ruby", "typescript", "vue" },
  },
  {
    "gpanders/editorconfig.nvim",
    event = "BufReadPre",
  },
  {
    -- markdown preview
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]() -- install without yarn or npm
    end,
    cmd = { "MarkdownPreview" },
    ft = "markdown",
  },
  -- Open file on remote website
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { mappings = nil },
    keys = {
      {
        "<leader>yr",
        '<cmd>lua require("gitlinker").get_buf_range_url("n")<cr>',
        desc = "Copy remote git link of the current file",
      },
      {
        "<leader>yr",
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {silent = false})<cr>',
        mode = "v",
        desc = "Copy remote git link of the current selection",
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "javascript", "vue", "html", "tmux", "lua", "gitconfig" },
    config = true,
    opts = {
      user_default_options = {
        names = false,
        css_fn = true,
      },
    },
  },
  {
    "smoka7/multicursors.nvim",
    opts = {},
    dependencies = {
      "smoka7/hydra.nvim",
    },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    keys = {
      { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test suite" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
      { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#start_normal"] = 1
      vim.g["test#neovim#term_position"] = "vert botright"
      vim.g["test#neovim_sticky#kill_previous"] = 1
      vim.g["test#preserve_screen"] = 0
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")

      npairs.setup({
        check_ts = true,
      })
      npairs.add_rules({
        Rule("{{", "  }", "vue"):set_end_pair_length(2):with_pair(ts_conds.is_ts_node("text")),
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPre",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("refactoring").setup({})
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
    keys = {
      {
        "<leader>cs",
        '<cmd>lua require("treesj").split()<cr>',
        desc = "Split line into block",
      },
      {
        "<leader>cj",
        '<cmd>lua require("treesj").join()<cr>',
        desc = "Join block into line",
      },
    },
  },
  {
    "kassio/neoterm",
    lazy = true,
    enabled = false,
    cmd = { "Tnew" },
    config = function()
      vim.g.neoterm_default_mod = "vertical"
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      { "SmiteshP/nvim-navic" },
    },
    opts = {
      -- configurations go here
      -- theme = {
      --   normal = { bg = "#f2e9e1" },
      -- },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = { backdrop = 1 },
      plugins = {
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = true }, -- disables the tmux statusline
      },
    },
    cmd = "ZenMode",
  },
  {
    "folke/twilight.nvim",
    opts = {},
    cmd = "Twilight",
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    enabled = function()
      if vim.bo.filetype == "lazy" then
        return false
      end
      return true
    end,
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
    },
  },
  {
    -- Disable some resource heavy features when opening a big file
    "LunarVim/bigfile.nvim",
  },
}
