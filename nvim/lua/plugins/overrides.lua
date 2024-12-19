return {
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
        yamlls = {
          settings = {
            yaml = {
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
            },
          },
        },
        vtsls = {
          settings = {
            typescript = {
              tsserver = { maxTsServerMemory = 8192 },
              -- log = "verbose",
              -- :lua vim.cmd.edit(vim.lsp.get_log_path())
            },
          },
        },
        intelephense = {
          filetypes = { "php", "blade", "php_only" },
          settings = {
            intelephense = {
              filetypes = { "php", "blade", "php_only" },
              files = {
                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                maxSize = 5000000,
              },
            },
          },
        },
      },
      inlay_hints = {
        enabled = false, -- true
        -- exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      actions = {
        files = {
          true,
          ["enter"] = require("fzf-lua.actions").file_edit,
        },
      },
      files = {
        -- cwd_prompt = true,
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude vendor --exclude public]],
      },
      marks = {
        marks = "[A-Za-z]",
      },
    },
    keys = {
      {
        "<C-p>",
        "<cmd>FzfLua files previewer=false git_icons=false<cr>",
        desc = "Find files",
      },
      {
        "<C-b>",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Find current buffers",
      },
      {
        "<leader>sw",
        "<cmd>FzfLua grep<cr>",
        desc = "Search for something (using Rg)",
      },
      {
        "<leader>ss",
        "<cmd>FzfLua grep_cword<cr>",
        desc = "Search for current word under cursor",
      },
      {
        "<leader>,",
        "<cmd>FzfLua files<cr>",
        desc = "Find Files",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        highlight = { underline = true, sp = "blue" }, -- Optional
        always_show_bufferline = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        style_preset = require("bufferline").style_preset.minimal,
        hover = {
          enabled = false,
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
            ---@diagnostic disable-next-line: undefined-global
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
    keys = {
      { "<leader>ba", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    },
  },
  {
    "folke/noice.nvim",
    keys = { { "<c-b>", false } },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local Util = require("lazyvim.util")
      local Snacks = require("snacks")
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
            },
          },

          lualine_c = {
            Util.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { Util.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),
            -- stylua: ignore
            {
              ---@diagnostic disable-next-line: undefined-field
              function() return require("noice").api.status.command.get() end,
              ---@diagnostic disable-next-line: undefined-field
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              ---@diagnostic disable-next-line: undefined-field
              function() return require("noice").api.status.mode.get() end,
              ---@diagnostic disable-next-line: undefined-field
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
  { "echasnovski/mini.pairs", enabled = false },
  {
    "folke/flash.nvim",
    opts = {
      label = {
        rainbow = {
          enabled = true,
        },
      },
      highlight = {
        backdrop = false,
      },
      modes = {
        char = {
          -- jump_labels = true,
          highlight = { backdrop = false },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = false, -- this disables the autocomplete popup from showing when running A or o
        },
      },
    },
  },
}
