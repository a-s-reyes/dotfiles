-- UI: which-key, neo-tree, bufferline, lualine, indent guides

-- icons (shared by the UI plugins)
require("nvim-web-devicons").setup()

-- which-key (keybinding popups — the "intuitive" Helix-like menu)
local wk = require("which-key")
wk.setup({})
wk.add({
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>b", group = "buffer" },
    { "<leader>x", group = "diagnostics" },
    { "<leader>t", group = "terminal" },
    { "<leader>c", group = "code" },
    { "<leader>D", group = "debug" },
})

-- neo-tree (VSCode-style left sidebar)
require("neo-tree").setup({
    close_if_last_window = true,
    filesystem = {
        follow_current_file = { enabled = false }, -- avoids redraw-loop flicker
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
    },
    window = { width = 32 },
})
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer" })

-- bufferline (VSCode-style tabs)
require("bufferline").setup({})
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- lualine (status bar)
require("lualine").setup({
    options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "|",
    },
})

-- indent guides
require("ibl").setup()

-- notifications (pretty popups; becomes the default vim.notify handler)
local notify = require("notify")
notify.setup({ timeout = 3000 })
vim.notify = notify
vim.keymap.set("n", "<leader>un", function() notify.dismiss({ silent = true }) end, { desc = "Dismiss notifications" })
