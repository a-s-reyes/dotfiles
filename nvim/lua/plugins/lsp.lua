-- lsp.lua — mason + native LSP, completion capabilities from nvim-cmp

require("mason").setup()

-- advertise nvim-cmp's completion capabilities to every server
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

-- clangd: C/C++. Uses the system clangd on PATH.
--   --background-index  index the whole project for fast goto-def / references
-- (clang-tidy is off — it applied opinionated C++ style rules to C files)
vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index", "--clang-tidy=false" },
})

vim.lsp.enable({ "clangd", "lua_ls" })

vim.diagnostic.config({ virtual_text = true })

-- LSP keymaps. Neovim 0.11+ already binds these by default when a server
-- attaches: grr references, grn rename, gra code action, gri implementation,
-- grt type definition, gO symbols, K hover, [d/]d diagnostics. So we only add
-- the few actions that have NO built-in default.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buf = args.buf
        local function map(lhs, fn, desc)
            vim.keymap.set("n", lhs, fn, { buffer = buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("df", vim.diagnostic.open_float, "Line diagnostics")
        map("<leader>cf", vim.lsp.buf.format, "Format buffer")
    end,
})

-- Format C/C++ on save via clangd (uses the project's .clang-format).
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.c", "*.cpp", "*.cc", "*.cxx", "*.h", "*.hpp", "*.hh" },
    callback = function()
        vim.lsp.buf.format()
    end,
})
