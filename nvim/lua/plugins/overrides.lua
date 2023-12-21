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
      },
    },
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
      { "<leader>sg",      false },
      { "<leader>so",      false },
      { "<leader>sW",      false },
      { "<leader>sw",      false },
      { "<leader>sW",      false, mode = "v" },
      { "<leader>sR",      false },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function()
      local logo = "\n\nWelcome!\n\n"

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
          t = {
            name = "+test",
          },
        },
      },
    },
  },
  { "folke/tokyonight.nvim", enabled = false },
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
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })

      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      local function box(opts)
        local function box_width()
          return opts.box_width or vim.opt.textwidth:get()
        end

        local function padding(cs, input_text)
          local spaces = box_width() - (2 * #cs)
          spaces = spaces - #input_text
          return spaces / 2
        end

        local comment_string = function()
          return require("luasnip.util.util").buffer_comment_chars()[1]
        end

        return {
          f(function()
            local cs = comment_string()
            return string.rep(string.sub(cs, 1, 1), box_width())
          end, { 1 }),
          t({ "", "" }),
          f(function(args)
            local cs = comment_string()
            return cs .. string.rep(" ", math.floor(padding(cs, args[1][1])))
          end, { 1 }),
          i(1, "placeholder"),
          f(function(args)
            local cs = comment_string()
            return string.rep(" ", math.ceil(padding(cs, args[1][1]))) .. cs
          end, { 1 }),
          t({ "", "" }),
          f(function()
            local cs = comment_string()
            return string.rep(string.sub(cs, 1, 1), box_width())
          end, { 1 }),
        }
      end

      require("luasnip").add_snippets("all", {
        -- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#box-comment-like-ultisnips
        s({ trig = "box" }, box({ box_width = 24 })),
        s({ trig = "bbox" }, box({})),
      })
    end,
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "folke/noice.nvim",
    keys = { { "<c-b>", false } },
  },
  { "echasnovski/mini.pairs", enabled = false },
}
