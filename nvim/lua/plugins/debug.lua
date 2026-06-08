-- debug.lua — nvim-dap debugger for C/C++ (adapter: codelldb)
-- One-time setup of the adapter:   :MasonInstall codelldb
-- Compile with debug symbols:      gcc -g -o prog main.c   (the -g matters!)

local dap = require("dap")
local dapui = require("dapui")

-- ── codelldb adapter (LLDB-based; works for C / C++ / Rust) ──────────
local exe = vim.fn.has("win32") == 1 and ".exe" or "" -- Windows binary needs .exe
local codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb" .. exe
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb,
        args = { "--port", "${port}" },
    },
}

-- ── C / C++ launch configuration ─────────────────────────────────────
local launch = {
    {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
            -- prompt for the compiled binary to debug (Tab-completes paths)
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
dap.configurations.c = launch
dap.configurations.cpp = launch

-- ── UI + inline variable values ──────────────────────────────────────
dapui.setup()
require("nvim-dap-virtual-text").setup() -- shows variable values next to your code

-- open/close the UI panels automatically with the debug session
dap.listeners.before.attach.dapui = function() dapui.open() end
dap.listeners.before.launch.dapui = function() dapui.open() end
dap.listeners.before.event_terminated.dapui = function() dapui.close() end
dap.listeners.before.event_exited.dapui = function() dapui.close() end

-- ── keymaps ──────────────────────────────────────────────────────────
-- Function keys = the VS Code-style in-session controls
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: continue / start" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: step into" })

-- <leader>D… menu  (capital D — lowercase <leader>d is your delete-without-yank)
local function map(lhs, fn, desc) vim.keymap.set("n", lhs, fn, { desc = desc }) end
map("<leader>Db", dap.toggle_breakpoint, "Toggle breakpoint")
map("<leader>Dc", dap.continue, "Continue / start")
map("<leader>Do", dap.step_out, "Step out")
map("<leader>Dt", dap.terminate, "Terminate")
map("<leader>Dr", function() dap.repl.toggle() end, "Toggle REPL")
map("<leader>Du", function() dapui.toggle() end, "Toggle UI")
map("<leader>De", function() dapui.eval() end, "Eval expression")
