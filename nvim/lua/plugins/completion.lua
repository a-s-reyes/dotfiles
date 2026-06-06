-- Completion: nvim-cmp + LuaSnip + lspkind (+ autopairs-on-confirm)
require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then luasnip.jump(1)
            else fallback() end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then luasnip.jump(-1)
            else fallback() end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
    formatting = {
        format = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 }),
    },
})

-- auto-insert pairs after completing a function, etc. (autopairs set up in editor.lua)
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
