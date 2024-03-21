return {
  {
    "sainnhe/everforest",
    enabled = false,
    config = function()
      vim.g.everforest_better_performance = 1
      vim.cmd([[set background=light]])
    end,
  },
  {
    "sainnhe/gruvbox-material",
    enabled = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  {
    "shaunsingh/nord.nvim",
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = true
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false

      vim.opt.background = "dark"
      vim.cmd.colorscheme("nord")
    end,
    enabled = false,
  },
  {
    "catppuccin",
    enabled = false,
    opts = {
      flavour = "frappe",
      dim_inactive = {
        enabled = true,
      },
      integrations = {
        mini = {
          enabled = false,
        },
      },
    },
  },
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
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      -- add Rg command to mimic the old Rg
      vim.api.nvim_create_user_command("Rg", function(opts)
        require("fzf-lua").grep({ search = opts.args })
      end, { bang = true, nargs = "?", desc = "Rg command, but from fzf-lua" })

      local actions = require("fzf-lua.actions")
      require("fzf-lua").setup({
        actions = {
          files = {
            -- instead of the default action 'actions.file_edit_or_qf'
            -- it's important to define all other actions here as this
            -- table does not get merged with the global defaults
            ["default"] = actions.file_edit,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["alt-q"] = actions.file_sel_to_qf,
          },
        },
      })
    end,
    -- stylua: ignore
    keys = {
      { "<C-p>"     , "<cmd>FzfLua files<cr>",                                                     desc = "Find files" },
      { "<C-b>"     , "<cmd>FzfLua buffers<cr>",                                                   desc = "Find current buffers" },
      { "<leader>sw", "<cmd>FzfLua grep<cr>",                                                      desc = "Search for something (using Rg)" },
      { "<leader>ss", "<cmd>FzfLua grep_cword<cr>",                                                desc = "Search for current word under cursor" },
      -- replacing lazyvim telescope keys with fzf-lua
      { "<leader>/" , "<cmd>FzfLua live_grep<cr>",                                                 desc = "Grep" },
      { "<leader>:" , "<cmd>FzfLua command_history<cr>",                                           desc = "Command History" },
      { "<leader>," , "<cmd>FzfLua files<cr>",                                                     desc = "Find Files" },
      -- find
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",                                                   desc = "Buffers" },
      { "<leader>fc", '<cmd>lua require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })<cr>', desc = "Find Config File", },
      { "<leader>ff", "<cmd>FzfLua files<cr>",                                                     desc = "Find files" },
      { "<leader>fr", "<cmd>FzfLua oldfiles",                                                      desc = "Recent" },
      -- search
      { '<leader>s"', "<cmd>FzfLua registers<cr>",                                                 desc = "Registers" },
      { "<leader>sa", "<cmd>FzfLua autocmd<cr>",                                                   desc = "Auto Commands" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>",                                           desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>",                                                  desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>",                                      desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspac<cr>",                                      desc = "Workspace diagnostics" },
      { "<leader>sg", "<cmd>FzfLua grep<cr>",                                                      desc = "Grep" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>",                                                 desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>",                                                desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>",                                                   desc = "Key Maps" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>",                                                 desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>",                                                     desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>",                                                    desc = "Resume" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>",                                                desc = "Word under cursor" },
      { "<leader>sw", "<cmd>FzfLua grep_visual<cr>",                                               desc = "Selection", mode = "v"  },
      { "<leader>uC", "<cmd>FzfLua colorschemes<cr>",                                              desc = "Colorscheme" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>",                                      desc = "Goto Symbol" },
      { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>",                                     desc = "Goto Symbol (Workspace)" },
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
      theme = {
        normal = { bg = "#f2e9e1" },
      },
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
    config = function()
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({
        virtual_text = false,
      })
      require("lsp_lines").setup()
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("headlines").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-dawn",
    },
  },
}
