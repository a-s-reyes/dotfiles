
vim.g.mapleader = " "

-- Esc clears the leftover search highlight (kickstart.nvim style;
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Hop between split windows without the <C-w> prefix (also in kickstart.nvim).
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Keep the selection after indenting, so you can press < or > repeatedly
vim.keymap.set("v", "<", "<gv", { desc = "Indent left, keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right, keep selection" })

-- Ctrl-S to save
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
