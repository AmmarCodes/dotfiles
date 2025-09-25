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
      setup = {
        gitlab_lsp = function(_, opt)
          local configs = require("lspconfig.configs")
          local lspconfig = require("lspconfig")

          -- GitLab Due settings
          if configs.gitlab_lsp then
            return
          end
          local settings = {
            baseUrl = "https://gitlab.com",
            token = vim.env.GITLAB_TOKEN,
          }
          configs.gitlab_lsp = {
            default_config = {
              name = "gitlab_lsp",
              cmd = {
                "npx",
                "--registry=https://gitlab.com/api/v4/packages/npm/",
                "@gitlab-org/gitlab-lsp@6.8.0",
                "--stdio",
              },
              filetypes = { "ruby", "go", "javascript", "typescript", "rust" },
              single_file_support = true,
              root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
              end,
              settings = settings,
            },
            docs = {
              description = "GitLab Code Suggestions",
            },
          }

          lspconfig.gitlab_lsp.setup({})
        end,
      },
      servers = {
        -- "prettierd",
        vale_ls = {},
        gitlab_lsp = {},
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
        -- rubocop = {
        --   cmd = { "bundle", "exec", "rubocop", "--lsp" },
        -- },
        ruby_lsp = {
          cmd = { "/Users/aalakkad/.local/share/mise/shims/ruby-lsp" },
          settings = {
            init_options = {
              enabled_features = {
                code_actions = true,
                code_lens = true,
                completion = true,
                definition = true,
                diagnostics = true,
                document_highlights = true,
                document_link = true,
                document_symbols = true,
                folding_ranges = true,
                formatting = true,
                hover = true,
                inlay_hint = true,
                on_type_formatting = true,
                selection_ranges = true,
                semantic_highlighting = true,
                signature_help = true,
                type_hierarchy = true,
                workspace_symbol = true,
              },
              features_configuration = {
                inlay_hint = {
                  implicit_hash_value = true,
                  implicit_rescue = true,
                },
              },
              -- indexing = {
              --   excluded_patterns = { 'path/to/excluded/file.rb' },
              --   included_patterns = { 'path/to/included/file.rb' },
              --   excluded_gems = { 'gem1', 'gem2', 'etc.' },
              --   excluded_magic_comments = { 'compiled:true' },
              -- },
              formatter = "auto",
              linters = {},
              experimental_features_enabled = true,
            },
          },
        },
        -- intelephense = {
        --   filetypes = { "php", "blade", "php_only" },
        --   settings = {
        --     intelephense = {
        --       filetypes = { "php", "blade", "php_only" },
        --       files = {
        --         associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
        --         maxSize = 5000000,
        --       },
        --     },
        --   },
        -- },
      },
      inlay_hints = {
        enabled = false, -- true
        -- exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      diagnostics = {
        virtual_text = false, -- disabling this since I'm using tiny-inline-diagnostic plugin defined in ./init.lua
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
        fd_opts = [[--color=never --type f --exclude .git --exclude vendor --exclude public]],
      },
      marks = {
        marks = "[A-Za-z]",
      },
      oldfiles = {
        include_current_session = true,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
      grep = {
        rg_glob = true,
        glob_flag = "--iglob", -- case insensitive globs
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
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
        -- highlight = { underline = true, sp = "blue" }, -- Optional
        always_show_bufferline = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        indicator = {
          style = "underline",
        },
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
        -- trigger = {
        --   show_on_insert_on_trigger_character = false, -- this disables the autocomplete popup from showing when running A or o
        -- },
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
      },
      signature = { enabled = true },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
███████╗██████╗ ███████╗███████╗
██╔════╝██╔══██╗██╔════╝██╔════╝
█████╗  ██████╔╝█████╗  █████╗  
██╔══╝  ██╔══██╗██╔══╝  ██╔══╝  
██║     ██║  ██║███████╗███████╗
╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝

  ██████╗  █████╗ ██╗     ███████╗███████╗████████╗██╗███╗   ██╗███████╗ 
  ██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝╚══██╔══╝██║████╗  ██║██╔════╝ 
  ██████╔╝███████║██║     █████╗  ███████╗   ██║   ██║██╔██╗ ██║█████╗   
  ██╔═══╝ ██╔══██║██║     ██╔══╝  ╚════██║   ██║   ██║██║╚██╗██║██╔══╝   
  ██║     ██║  ██║███████╗███████╗███████║   ██║   ██║██║ ╚████║███████╗ 
  ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝ 
]],
        },
      },
    },
  },
}
