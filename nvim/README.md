# nvim

Framework-free Neovim config. Plugins are managed by Neovim's built-in **`vim.pack`** (no lazy.nvim); the layout follows LazyVim's `config/` + `plugins/` split. Feel is VSCode/Helix-ish — sidebar tree, fuzzy finder, LSP, completion, git signs, and which-key popups.

## Layout

```
init.lua                 load order
lua/config/              core editor config
  options.lua  keymaps.lua  autocmds.lua
lua/plugins/             plugins, one file per purpose
  init.lua               ← plugin list (vim.pack) + :Pack* cmds + loads the rest
  colorscheme.lua  ui.lua  finder.lua  completion.lua
  editor.lua  git.lua  lsp.lua  treesitter.lua
```

`vim.pack` has no auto-import, so `plugins/init.lua` `require()`s each group file explicitly.

## Prerequisites

- **Neovim nightly (0.12+)** — for `vim.pack`
- **git**, **ripgrep** — plugin install + grep
- **a Nerd Font** — icons
- **clangd** on `PATH` — C/C++ LSP
- **tree-sitter CLI** — compiles treesitter parsers (`npm i -g tree-sitter-cli` or `cargo install tree-sitter-cli`)
- a **C compiler** — gcc/clang (Linux/macOS have one; on Windows install MSYS2 so `gcc` is on `PATH`)

## Install

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim      # or: ./bootstrap.sh nvim
```
(Windows: junction `%LOCALAPPDATA%\nvim`, or `.\bootstrap.ps1 nvim`.)

First launch clones every plugin and builds treesitter parsers — give it a moment. If a plugin looks half-broken right after the initial clone, just relaunch nvim.

clangd comes from your system; install the Lua server once:
```vim
:MasonInstall lua-language-server
```

## Per-machine & cross-platform

The same config runs on Windows and Linux/macOS. OS differences are handled automatically: on Windows treesitter builds parsers with `gcc` (needs gcc on `PATH`, e.g. MSYS2) and the debugger resolves `codelldb.exe`; on Linux/macOS both are no-ops.

Machine-specific values go in **`lua/config/local.lua`** — gitignored, optional, loaded if present:
```lua
vim.g.repos_dir = vim.fn.expand("~/repos")  -- where the startup file picker opens (Windows: "D:/repos")
```

Per-machine binaries (not in the repo — install once per OS):

| Need | Windows | Fedora |
|---|---|---|
| Lua LSP | `:MasonInstall lua-language-server` | `sudo dnf install lua-language-server` |
| C/C++ LSP | clangd via MSYS2 | `sudo dnf install clang-tools-extra` |
| debugger | `:MasonInstall codelldb` | `:MasonInstall codelldb` |

## Things worth knowing

| Task | How |
|---|---|
| Update plugins | `:PackUpdate` — then **commit `nvim-pack-lock.json`** |
| Add a plugin | add its URL to `vim.pack.add{}` in `plugins/init.lua`, restart |
| Remove a plugin | `:PackDel <name>` |
| Add an LSP server | `:MasonInstall <server>`, then enable it in `plugins/lsp.lua` |
| Change theme | edit `plugins/colorscheme.lua` (tokyonight; moonfly kept as an alt) |

**Lockfile:** `nvim-pack-lock.json` pins every plugin to an exact commit and is tracked in git — commit it after `:PackUpdate` so other machines reproduce the same versions.

**Keymaps:** leader is `Space`. Press `Space` (or `g`) and pause — **which-key** lists what's available. LSP rename/references/actions use Neovim 0.11+ defaults (`grn` / `grr` / `gra` / `gri` / `K` / `[d` / `]d`); `gd` go-to-definition is custom.
