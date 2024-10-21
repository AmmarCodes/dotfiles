return {
  -- source: https://seankegel.com/neovim-for-php-and-laravel
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
        php = { { "pint", "php_cs_fixer" } },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "pint", "phpstan" },
    },
  },
  {
    -- Add a Treesitter parser for Laravel Blade to provide Blade syntax highlighting.
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "blade",
        "php_only",
      })
    end,
    config = function(_, opts)
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
    end,
  },
  {
    -- Add the blade-nav.nvim plugin which provides Goto File capabilities
    -- for Blade files.
    "ricardoramirezr/blade-nav.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    ft = { "blade", "php" },
  },
  "ricardoramirezr/blade-nav.nvim",
  dependencies = { -- totally optional
    "hrsh7th/nvim-cmp", -- if using nvim-cmp
    { "ms-jpq/coq_nvim", branch = "coq" }, -- if using coq
  },
  ft = { "blade", "php" }, -- optional, improves startup time
  opts = {
    close_tag_on_complete = true, -- default: true
  },
  {
    -- Remove phpcs linter.
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
    },
  },
}
