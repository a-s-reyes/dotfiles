-- tokyonight (plugin declared in plugins/init.lua)
-- styles: "storm" | "night" | "moon" | "day"
-- moonfly is also installed as an alt: :colorscheme moonfly
require("tokyonight").setup({
    style = "moon",
    transparent = true, -- don't paint a background → terminal shows through
    styles = {
        sidebars = "transparent", -- neo-tree sidebar
        floats = "transparent", -- popups (which-key, telescope)
    },
})
vim.cmd.colorscheme("tokyonight")
