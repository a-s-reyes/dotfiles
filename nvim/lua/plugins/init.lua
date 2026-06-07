-- plugins/init.lua — the authoritative plugin list + load order.
-- vim.pack has no auto-import (unlike lazy.nvim), so each group below is
-- require()'d explicitly. One vim.pack.add() keeps install order/deps correct.

vim.pack.add({
    -- colorscheme
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/bluz71/vim-moonfly-colors", -- alt (try with :colorscheme moonfly)

    -- shared dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/MunifTanjim/nui.nvim",

    -- ui / discoverability
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/rcarriga/nvim-notify",

    -- fuzzy finder
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/MagicDuck/grug-far.nvim",

    -- completion + snippets
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/onsails/lspkind.nvim",

    -- git
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/tpope/vim-fugitive",

    -- editing niceties
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/mg979/vim-visual-multi",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/dstein64/vim-startuptime",

    -- debugging
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/theHamsta/nvim-dap-virtual-text",

    -- lsp + treesitter
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
})

-- ── vim.pack management commands ──────────────────────────────────────
vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    if opts.args:match("%S") then
        vim.pack.update(vim.split(opts.args, "%s+", { trimempty = true }))
    else
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })

-- ── load groups (order matters) ──────────────────────────────────────
require("plugins.colorscheme") -- early, so lualine's auto theme reads it
require("plugins.ui")
require("plugins.finder")
require("plugins.editor")      -- autopairs.setup() before completion's cmp hook
require("plugins.completion")
require("plugins.git")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.debug")
