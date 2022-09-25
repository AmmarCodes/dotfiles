local mason_ok, mason = pcall(require, "mason")

if not mason_ok then
  return
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua",
    "bashls",
    "cssls",
    "eslint",
    "html",
    "tsserver",
    "solargraph",
    "stylelint_lsp",
    "vuels",
    "stylua",
  },
})
