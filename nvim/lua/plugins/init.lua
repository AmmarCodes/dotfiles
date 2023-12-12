return {
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_better_performance = 1
      vim.cmd([[set background=light]])
    end,
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
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
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
    ft = { "css", "javascript", "vue", "html" },
    config = true,
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
