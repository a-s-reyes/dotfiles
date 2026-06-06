-- Editing niceties: autopairs, surround, terminal, diagnostics panel, multi-cursor

-- auto-close brackets/quotes (cmp integration lives in completion.lua)
require("nvim-autopairs").setup({})

-- surround: sa add / sd delete / sr replace
require("nvim-surround").setup({})

-- terminal (VSCode-style toggle: Ctrl-\ or <leader>tt)
require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    direction = "float",
})
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- trouble: problems / diagnostics panel
require("trouble").setup({})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics list" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })

-- vim-visual-multi: Ctrl-n to add a cursor on the next match (VSCode Ctrl-D feel) — no setup needed.
