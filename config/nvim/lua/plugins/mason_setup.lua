
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pylsp", "lua_ls" }, -- Install the Python LSP server
})
