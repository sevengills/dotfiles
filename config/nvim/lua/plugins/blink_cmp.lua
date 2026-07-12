require("blink.cmp").setup({
    -- Minimal setup for LSP and buffer completion
    sources = {
        { name = "lsp" },
        { name = "buffer" },
        -- Add snippet source if you installed LuaSnip
        -- { name = "luasnip" },
    },
    -- You can add keymaps here, e.g.,
    -- mapping = {
    --     ["<C-y>"] = require("blink.cmp").confirm,
    --     ["<C-n>"] = require("blink.cmp").select_next_item,
    --     ["<C-p>"] = require("blink.cmp").select_prev_item,
    -- },
})

