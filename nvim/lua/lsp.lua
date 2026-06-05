require("mason").setup()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

-- clangd: C/C++. Uses the system clangd on PATH (no Mason download needed).
--   --clang-tidy        run the project's .clang-tidy checks inline
--   --background-index  index the whole project for fast goto-def / references
-- clangd auto-finds compile_commands.json / .clangd via its root markers.
vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
})

vim.lsp.enable({
    "clangd",
    "lua_ls",
})

-- Format C/C++ on save via clangd (uses the project's .clang-format).
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.c", "*.cpp", "*.cc", "*.cxx", "*.h", "*.hpp", "*.hh" },
    callback = function()
        vim.lsp.buf.format()
    end,
})
