-- keymaps.lua — core/general keymaps.
-- (Plugin-specific keymaps live with their plugin in lua/plugins/*.lua)
-- Leader is Space; press <leader> and pause for the which-key menu.

vim.g.mapleader = " "

-- helper: map(mode, lhs, rhs, desc, [opts])
local function map(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend("force", { desc = desc }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- ── Editing ──────────────────────────────────────────────────────────
map("x", "p", [["_dP]], "Paste over selection (keep yank)")
map({ "n", "v" }, "<leader>d", [["_d]], "Delete without yanking")
map("n", "J", "mzJ`z", "Join lines (keep cursor)")
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("v", "<", "<gv", "Unindent (keep selection)")
map("v", ">", ">gv", "Indent (keep selection)")
-- finer undo: add break-points after punctuation
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- ── Movement & scrolling ─────────────────────────────────────────────
map("n", "<C-d>", "<C-d>zz", "Half page down (centered)")
map("n", "<C-u>", "<C-u>zz", "Half page up (centered)")
map("n", "n", "nzzzv", "Next search result (centered)")
map("n", "N", "Nzzzv", "Prev search result (centered)")

-- ── Search & highlight ───────────────────────────────────────────────
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word under cursor (file)")
map("n", "<C-c>", "<cmd>nohlsearch<cr>", "Clear search highlight", { silent = true })
map("i", "<C-c>", "<Esc>", "Escape")

-- ── Windows ──────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", "Go to left window")
map("n", "<C-j>", "<C-w>j", "Go to lower window")
map("n", "<C-k>", "<C-w>k", "Go to upper window")
map("n", "<C-l>", "<C-w>l", "Go to right window")
map("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")
map("n", "<leader>-", "<C-w>s", "Split window below")
map("n", "<leader>|", "<C-w>v", "Split window right")

-- ── Buffers ──────────────────────────────────────────────────────────
map("n", "<leader>bb", "<cmd>e #<cr>", "Switch to last buffer")

-- ── Tabs ─────────────────────────────────────────────────────────────
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "New tab")
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", "Next tab")
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", "Prev tab")
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close tab")
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", "Close other tabs")
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "First tab")
map("n", "<leader><tab>l", "<cmd>tablast<cr>", "Last tab")

-- ── Files ────────────────────────────────────────────────────────────
map({ "n", "i", "x" }, "<C-s>", "<cmd>w<cr><esc>", "Save file")
map("n", "<leader>fn", "<cmd>enew<cr>", "New file")
map("n", "<leader>X", "<cmd>!chmod +x %<cr>", "Make file executable", { silent = true })
map("n", "<leader>K", "<cmd>norm! K<cr>", "Keyword lookup")

-- ── Diagnostics & lists ──────────────────────────────────────────────
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, "Next error")
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, "Prev error")
map("n", "]w", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end, "Next warning")
map("n", "[w", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN }) end, "Prev warning")
map("n", "<leader>xq", "<cmd>copen<cr>", "Quickfix list")
map("n", "<leader>xl", "<cmd>lopen<cr>", "Location list")

-- ── UI toggles (<leader>u…) ──────────────────────────────────────────
map("n", "<leader>uw", function() vim.wo.wrap = not vim.wo.wrap end, "Toggle wrap")
map("n", "<leader>us", function() vim.wo.spell = not vim.wo.spell end, "Toggle spell")
map("n", "<leader>ul", function() vim.wo.number = not vim.wo.number end, "Toggle line numbers")
map("n", "<leader>uL", function() vim.wo.relativenumber = not vim.wo.relativenumber end, "Toggle relative numbers")
map("n", "<leader>uc", function() vim.wo.conceallevel = vim.wo.conceallevel > 0 and 0 or 2 end, "Toggle conceal")
map("n", "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, "Toggle diagnostics")
map("n", "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "Toggle inlay hints")

-- ── Misc ─────────────────────────────────────────────────────────────
map("n", "<leader>re", "<cmd>restart<cr>", "Restart Neovim")
-- undotree on <leader>U (so <leader>u stays the toggle prefix)
map("n", "<leader>U", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, "Toggle undotree")
