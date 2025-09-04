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
    "catgoose/nvim-colorizer.lua",
    ft = { "css", "javascript", "vue", "html", "tmux", "lua", "gitconfig", "typescript" },
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
    "jake-stewart/multicursor.nvim",
    keys = {
      {
        "<esc>",
        function()
          local mc = require("multicursor-nvim")
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          elseif mc.hasCursors() then
            mc.clearCursors()
          else
            -- Default <esc> handler.
            vim.cmd("noh")
            LazyVim.cmp.actions.snippet_stop()
          end
        end,
      },
      -- stylua: ignore start
      { mode = { "n", "v" }, "<leader>m",     function () require("multicursor-nvim").matchAddCursor(1) end,    desc = "Add a new next cursor by matching word/selection" },
      { mode = { "n", "v" }, "<leader>M",     function () require("multicursor-nvim").matchAddCursor(-1) end,   desc = "Add a new previous cursor by matching word/selection" },
      { mode = { "n", "v" }, "<leader>A",     function () require("multicursor-nvim").matchAllAddCursors() end, desc = "Add all matches in the document" },
      { mode = { "n" },      "<c-leftmouse>", function () require("multicursor-nvim").handleMouse() end,        desc = "Add and remove cursors with control + left click" },
      { mode = { "n", "v" }, "<c-q>",         function () require("multicursor-nvim").toggleCursor() end,       desc = "Add and remove cursors using the main cursor" },
      { mode = { "n" },      "<leader>a",     function () require("multicursor-nvim").alignCursors() end,       desc = "Align cursor columns" },
      { mode = { "v" },      "I",             function () require("multicursor-nvim").insertVisual() end,       desc = "Insert for each line of visual selections" },
      { mode = { "v" },      "A",             function () require("multicursor-nvim").appendVisual() end,       desc = "Append for each line of visual selections" },
      -- stylua: ignore end
    },
    config = function()
      require("multicursor-nvim").setup()

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
  {
    "smoka7/multicursors.nvim",
    enabled = false,
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
    dependencies = { "preservim/vimux" },
    keys = {
      { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test suite" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
      { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
      { "<leader>tc", "<cmd>VimuxCloseRunner<cr>", desc = "Test close tmux test pane" },
    },
    config = function()
      vim.opt.shell = "bash"
      vim.g["test#custom_strategies"] = {
        snacks = function(cmd)
          require("snacks").terminal(cmd, { win = { position = "right", enter = true }, interactive = false })
          vim.cmd("stopinsert")
          vim.cmd("normal! G")
        end,
      }
      -- vim.g["test#strategy"] = "snacks"
      vim.g["test#strategy"] = "vimux"
      vim.g["VimuxOrientation"] = "h"
      vim.g["VimuxHeight"] = "40%"
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
    "echasnovski/mini.tabline",
    version = false,
    config = true,
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
    enabled = false,
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
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    -- enabled = false,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern", -- Can be: "modern", "classic", "minimal", "ghost", "simple", "nonerdfont", "amongus"
        options = {
          -- Show the source of the diagnostic.
          -- show_source = false,
          set_arrow_to_diag_color = true,
          multilines = {
            -- Enable multiline diagnostic messages
            enabled = true,
            -- Always show messages on all lines for multiline diagnostics
            always_show = true,
            -- Display all diagnostic messages on the cursor line, not just those under cursor
            show_all_diags_on_cursorline = true,
          },
        },
      })
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {}, -- your configuration
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "*",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
    opts = {
      provider = "claude",
      behaviour = {
        auto_suggestions = true,
        enable_cursor_planning_mode = true,
      },
      suggestion = { debounce = 1200 },
    },
  },
  {
    "tiagovla/scope.nvim",
    config = true,
  },
}
