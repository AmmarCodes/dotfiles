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
  {
    "stevearc/conform.nvim",
    opts = {
      -- formatters = {
      -- rubocop = {
      --   command = "bundle exec rubocop",
      -- },
      -- },
      formatters_by_ft = {
        -- ruby = { "rubocop" },
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
    "nvimdev/dashboard-nvim",
    opts = function()
      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          week_header = {
            enable = true,
          },
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
      icons = { rules = false },
      spec = {
        { "<leader>t", group = "test" },
        { "<leader>y", group = "yank" },
        { "<leader>yf", group = "file" },
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
  -- {
  --   "L3MON4D3/LuaSnip",
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --   },
  --   build = "make install_jsregexp",
  --   config = function()
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --     require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })
  --
  --     local ls = require("luasnip")
  --     local s = ls.snippet
  --     local t = ls.text_node
  --     local i = ls.insert_node
  --     local f = ls.function_node
  --
  --     local function box(opts)
  --       local function box_width()
  --         return opts.box_width or vim.opt.textwidth:get()
  --       end
  --
  --       local function padding(cs, input_text)
  --         local spaces = box_width() - (2 * #cs)
  --         spaces = spaces - #input_text
  --         return spaces / 2
  --       end
  --
  --       local comment_string = function()
  --         return require("luasnip.util.util").buffer_comment_chars()[1]
  --       end
  --
  --       return {
  --         f(function()
  --           local cs = comment_string()
  --           return string.rep(string.sub(cs, 1, 1), box_width())
  --         end, { 1 }),
  --         t({ "", "" }),
  --         f(function(args)
  --           local cs = comment_string()
  --           return cs .. string.rep(" ", math.floor(padding(cs, args[1][1])))
  --         end, { 1 }),
  --         i(1, "placeholder"),
  --         f(function(args)
  --           local cs = comment_string()
  --           return string.rep(" ", math.ceil(padding(cs, args[1][1]))) .. cs
  --         end, { 1 }),
  --         t({ "", "" }),
  --         f(function()
  --           local cs = comment_string()
  --           return string.rep(string.sub(cs, 1, 1), box_width())
  --         end, { 1 }),
  --       }
  --     end
  --
  --     require("luasnip").add_snippets("all", {
  --       -- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#box-comment-like-ultisnips
  --       s({ trig = "box" }, box({ box_width = 24 })),
  --       s({ trig = "bbox" }, box({})),
  --     })
  --   end,
  --   opts = {
  --     history = true,
  --     delete_check_events = "TextChanged",
  --   },
  --   keys = function()
  --     return {}
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
  --           cmp.select_next_item()
  --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --         -- this way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
  {
    "folke/noice.nvim",
    keys = { { "<c-b>", false } },
  },
  {
    "RRethy/vim-illuminate",
    event = "LazyFile",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](true)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      -- vim.g.lualine_laststatus = vim.o.laststatus
      -- if vim.fn.argc(-1) > 0 then
      --   -- set an empty statusline till lualine loads
      --   vim.o.statusline = " "
      -- else
      --   -- hide the statusline on the starter page
      --   vim.o.laststatus = 0
      -- end
    end,
    opts = function()
      local Util = require("lazyvim.util")
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          -- theme = "auto",
          -- globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },

          section_separators = "",
          component_separators = "",
          globalstatus = true,
          theme = {
            normal = {
              a = "StatusLine",
              b = "StatusLine",
              c = "StatusLine",
            },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
            },
          },

          lualine_c = {
            Util.lualine.root_dir(),
            -- {
            --   "diagnostics",
            --   symbols = {
            --     error = icons.diagnostics.Error,
            --     warn = icons.diagnostics.Warn,
            --     info = icons.diagnostics.Info,
            --     hint = icons.diagnostics.Hint,
            --   },
            -- },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { Util.lualine.pretty_path() },
          },
          lualine_x = {
            -- stylua: ignore
            {
              ---@diagnostic disable-next-line: undefined-field
              function() return require("noice").api.status.command.get() end,
              ---@diagnostic disable-next-line: undefined-field
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              ---@diagnostic disable-next-line: undefined-field
              function() return require("noice").api.status.mode.get() end,
              ---@diagnostic disable-next-line: undefined-field
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg("Special"),
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
            { "location", icon = "", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            -- function()
            --   return " " .. os.date("%R")
            -- end,
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
      },
    },
  },
  { "echasnovski/mini.pairs", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
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
}
