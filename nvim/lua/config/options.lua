-- options.lua — editor settings, grouped by purpose.

-- ── General ──────────────────────────────────────────────────────────
vim.g.netrw_banner = 0           -- no netrw banner (neo-tree is the explorer)
vim.opt.confirm = true           -- prompt to save instead of erroring on :q
vim.opt.updatetime = 200         -- faster CursorHold → diagnostics / gitsigns

-- ── Appearance / UI ──────────────────────────────────────────────────
vim.opt.termguicolors = true     -- 24-bit color (required by the UI plugins)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true        -- highlight the current line
vim.opt.signcolumn = "yes"       -- always show the sign column
vim.opt.colorcolumn = "0"
vim.opt.laststatus = 3           -- single global statusline
vim.opt.showmode = false         -- lualine already shows the mode
vim.opt.guicursor = ""           -- block cursor in all modes
vim.opt.scrolloff = 8            -- keep 8 lines above/below the cursor
vim.opt.sidescrolloff = 8        -- and 8 columns left/right (with nowrap)
vim.opt.conceallevel = 2         -- hide markup (e.g. markdown); toggle: <leader>uc
vim.opt.wrap = false

-- ── Indentation ──────────────────────────────────────────────────────
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true         -- spaces, not tabs
vim.opt.smartindent = true

-- ── Splits ───────────────────────────────────────────────────────────
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ── Search ───────────────────────────────────────────────────────────
vim.opt.ignorecase = true
vim.opt.smartcase = true         -- case-sensitive when the query has capitals
vim.opt.inccommand = "split"     -- live preview of :substitute
vim.opt.grepprg = "rg --vimgrep" -- use ripgrep for :grep

-- ── Completion ───────────────────────────────────────────────────────
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.shortmess:append("c")    -- quiet completion messages
vim.opt.pumheight = 10           -- cap the popup-menu height
vim.opt.pumblend = 10            -- slight popup transparency

-- ── Files, undo & clipboard ──────────────────────────────────────────
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true          -- persistent undo across sessions
vim.opt.undolevels = 10000
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.clipboard:append("unnamedplus") -- sync with the system clipboard
vim.opt.isfname:append("@-@")
