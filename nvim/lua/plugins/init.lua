return {
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_better_performance = 1
      vim.cmd([[set background=light]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "comment",
        "css",
        "diff",
        "git_rebase",
        "gitattributes",
        "gitignore",
        "graphql",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "ruby",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- "prettierd",
        vale_ls = {},
        emmet_language_server = {
          filetypes = { "vue", "eruby", "html", "haml", "javascript" },
        },
        stylelint_lsp = {
          filetypes = { "css", "scss" },
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
    "nvim-telescope/telescope.nvim",
    -- stylua: ignore
    keys = {
      -- disable the keymap to grep files
      { "<leader><space>", false },
      { "<leader>,",       false },
      { "<leader>fF",      false },
      -- git
      { "<leader>gc",      false },
      { "<leader>gs",      false },
      -- search
      { "<leader>sb",      false },
      { "<leader>sG",      false },
      { "<leader>so",      false },
      { "<leader>sW",      false },
      { "<leader>sw",      false },
      { "<leader>sW",      false, mode = "v" },
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
    "nvimdev/dashboard-nvim",
    opts = function()
      local logo = [[
           ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
           ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
           ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
           ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
           ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
           ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "FzfLua files",                                                  desc = " Find file",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                             desc = " New file",        icon = " ", key = "n" },
            { action = "FzfLua oldfiles",                                               desc = " Recent files",    icon = " ", key = "r" },
            { action = "FzfLua live_grep",                                              desc = " Find text",       icon = " ", key = "g" },
            { action = [[require('fzf-lua').files({cwd = vim.fn.stdpath("config") })]], desc= " Config",           icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                             desc = " Restore Session", icon = " ", key = "s" },
            -- { action = "LazyExtras",                                                    desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                          desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                            desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>"] = {
          y = {
            name = "+yank",
            f = {
              name = "+file",
            },
          },
        },
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
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin", enabled = false },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        highlight = { underline = true, sp = "blue" }, -- Optional
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
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
