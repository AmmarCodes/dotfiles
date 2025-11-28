return {
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "ruby", "eruby", "vim", "lua", "bash" },
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
        "<cmd>lua require(\"treesj\").split()<cr>",
        desc = "Split line into block",
      },
      {
        "<leader>cj",
        "<cmd>lua require(\"treesj\").join()<cr>",
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
    "sindrets/diffview.nvim",
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
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
    "tiagovla/scope.nvim",
    config = true,
  },
  {
    "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
    event = { "BufReadPre", "BufNewFile" },
    cond = function()
      -- Only activate if token is present in environment variable.
      -- Remove this line to use the interactive workflow.
      return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
    end,
    opts = {
      statusline = {
        enabled = false,
      },
      -- Disable Started Code Suggestions LSP Integration messages
      minimal_message_level = vim.log.levels.ERROR,
      code_suggestions = {
        -- For the full list of default languages, see the 'auto_filetypes' array in
        -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
        auto_filetypes = { "ruby", "javascript", "javascriptreact", "html", "css", "typescript", "typescriptreact" },
        ghost_text = {
          enabled = true,
          accept_suggestion = "<C-l>",
          clear_suggestions = "<C-k>",
          stream = true,
        },
      },
    },
  },
}
