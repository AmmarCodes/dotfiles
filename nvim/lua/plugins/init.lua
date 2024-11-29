return {
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
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "javascript", "vue", "html", "tmux", "lua", "gitconfig" },
    config = true,
    opts = {
      user_default_options = {
        names = false,
        css_fn = true,
        AARRGGBB = true,
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
      vim.opt.shell = "bash"
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "vert botright"
      vim.g["test#php#phpunit#executable"] = "php artisan test"
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
    "Bekaboo/dropbar.nvim",
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          chars = {
            horizontal_line = "─",
            right_arrow = "─",
          },
          style = "#85c1dc",
          duration = 10,
          delay = 100,
        },
        line_num = { enable = true },
        indent = {
          enable = true,
          chars = {
            "┊",
          },
        },
      })
    end,
  },
  {
    -- helps with folding
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      ---@diagnostic disable-next-line: missing-fields
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
    },
  },
  {
    "sindrets/diffview.nvim",
  },
}
