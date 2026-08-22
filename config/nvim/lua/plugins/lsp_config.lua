local on_attach = function(client, bufnr)
    -- Keybindings for LSP go here
    -- e.g., vim.api.nvim_buf_set_keymap(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

require("lspconfig").pylsp.setup({
    on_attach = on_attach,
    settings = {
        pylsp = {
            -- specific pylsp settings
            plugins = {
                jedi_completion = { enabled = true }, -- example setting
                -- ... other plugins as needed
            },
        },
    },
})

