-- Fuzzy finder: telescope (find files, grep, command palette)
require("telescope").setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
    },
})

local tb = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", tb.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", tb.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", tb.commands, { desc = "Commands (palette)" })
vim.keymap.set("n", "<leader>fs", tb.current_buffer_fuzzy_find, { desc = "Search in buffer" })
-- keep old muscle memory
vim.keymap.set("n", "<leader>pf", tb.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>ps", tb.live_grep, { desc = "Live grep" })

-- grug-far: project-wide find & replace (<leader>s is the single-file substitute; <leader>S is project-wide)
require("grug-far").setup({})
vim.keymap.set({ "n", "x" }, "<leader>S", function() require("grug-far").open() end, { desc = "Search & replace (project)" })
