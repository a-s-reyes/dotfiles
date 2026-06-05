# nvim

A lean, framework-free Neovim config. No lazy.nvim/packer — plugins are managed by Neovim's built-in `vim.pack`, and most features come from the [mini.nvim](https://github.com/nvim-mini/mini.nvim) suite.

## What's in here

| File | Purpose |
|---|---|
| `init.lua` | entry point — loads the modules below, then sets the colorscheme |
| `lua/options.lua` | editor options + yank-highlight autocmd |
| `lua/keymaps.lua` | leader is `Space`; QoL motions, visual-mode line moves, native undotree |
| `lua/commands.lua` | `:PackAdd` / `:PackDel` / `:PackUpdate` wrappers around `vim.pack` |
| `lua/pack.lua` | plugin list + setup for the mini.nvim suite and fugitive |
| `lua/treesitter.lua` | installs parsers and starts highlighting per filetype |
| `lua/lsp.lua` | `mason` + `nvim-lspconfig`; enables `clangd` and `lua_ls`, format-on-save for C/C++ |

The whole folder is symlinked into place as one unit, so everything under `lua/` travels with it.

## Prerequisites

- **Neovim nightly (0.12+).** The config uses the built-in `vim.pack` plugin manager, which only exists on nightly. `:PackDel` / `:PackUpdate` need 0.13.
- **git** — `vim.pack` clones plugins over https.
- **A Nerd Font** — for icons in mini.nvim UIs. Install one (e.g. [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)) and set it as your terminal font.
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** (`rg`) — used by the mini.pick grep/file pickers.
- **A system `clangd` on `PATH`** — for C/C++ LSP and format-on-save (uses the project's `.clang-format` / `.clang-tidy`). `lua_ls` is installed automatically by `mason`.

Quick install of the CLI prerequisites:
```bash
# Linux
sudo dnf install neovim ripgrep clang-tools-extra    # Fedora
sudo apt install neovim ripgrep clangd               # Debian/Ubuntu
sudo pacman -S neovim ripgrep clang                   # Arch

# macOS
brew install neovim ripgrep llvm                      # clangd ships with llvm

# Windows
winget install Neovim.Neovim BurntSushi.ripgrep.MSVC LLVM.LLVM
```
(Make sure the Neovim you get is recent enough; if your package manager lags, grab a nightly build from the [Neovim releases page](https://github.com/neovim/neovim/releases).)

## Installation

The config lives at a per-OS location and is bridged with a single directory link pointing at this folder.

| OS | Neovim config path |
|---|---|
| Linux / macOS | `~/.config/nvim` |
| Windows | `%LOCALAPPDATA%\nvim` (i.e. `~\AppData\Local\nvim`) |

### Step 1 — back up any existing config

If you already have a config there, move it aside first:
```bash
# Linux / macOS
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
```
```powershell
# Windows (PowerShell)
if (Test-Path "$env:LOCALAPPDATA\nvim") { Move-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.backup" }
```

### Step 2 — link the folder

**Linux / macOS / WSL** (symlink the directory):
```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

**Windows** — pick one. A **junction** needs no special privileges; a symlink needs Developer Mode or an admin shell.

PowerShell, junction (recommended):
```powershell
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "D:\repos\dotfiles\nvim"
```
cmd.exe, junction:
```cmd
mklink /J "%LOCALAPPDATA%\nvim" "D:\repos\dotfiles\nvim"
```

> Or just run the repo's bootstrap script, which does the backup + link for you:
> `./bootstrap.sh nvim` (Linux/macOS) or `.\bootstrap.ps1 nvim` (Windows).

### Step 3 — first launch

Open `nvim`. On the first run `vim.pack` clones every plugin from the list in `lua/pack.lua` and treesitter installs its parsers — give it a moment. If a plugin hasn't finished downloading, restart nvim once it's done (`<leader>re` runs `:restart`).

Verify:
- The **moonfly** colorscheme is active.
- `<leader>pf` opens a file picker.
- `:checkhealth` is clean for the bits you care about.

## Key bindings

Leader is `Space`.

| Keys | Action |
|---|---|
| `-` | Open the mini.files explorer |
| `<leader>-` | Open mini.files at the current file |
| `<leader>pf` | Pick files |
| `<leader>ps` | Grep the word under the cursor |
| `<leader>pk` | Search keymaps |
| `<leader>vh` | Search help tags |
| `<leader>xx` | Diagnostics picker |
| `gd` | Go to definition |
| `<leader>f` | Format buffer |
| `df` | Show line diagnostics |
| `<leader>gg` | Open fugitive (full-page tab) |
| `<leader>gd` | Git diff split |
| `<leader>u` | Toggle the native undotree |
| `<leader>s` | Replace the word under the cursor globally |
| `<C-c>` | Clear search highlight |

mini.surround adds `sa`/`sd`/`sr` for add/delete/replace surrounding.

## Plugins

Managed by `vim.pack` (list in `lua/pack.lua`):

- **[vim-moonfly-colors](https://github.com/bluz71/vim-moonfly-colors)** — colorscheme
- **[mini.nvim](https://github.com/nvim-mini/mini.nvim)** — `files`, `pick`, `extra`, `completion`, `snippets`, `surround`, `diff`, `notify`, `cmdline`
- **[friendly-snippets](https://github.com/rafamadriz/friendly-snippets)** — snippet collection loaded by mini.snippets
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** (`main` branch) — parsers for `c`, `cpp`, `lua`, `bash`, `json`, `markdown`
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** + **[mason.nvim](https://github.com/mason-org/mason.nvim)** — LSP setup
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)** — git in the editor

## Managing plugins

```vim
:PackAdd user/repo        " add one or more plugins
:PackDel name             " remove plugins
:PackUpdate               " update everything
:PackUpdate name          " update specific plugins
```
Add a plugin permanently by appending its URL to the `vim.pack.add({...})` list in `lua/pack.lua`.

### Lockfile

`vim.pack` writes **`nvim-pack-lock.json`** into this folder, pinning each plugin to an exact git revision (the modern equivalent of `lazy-lock.json`). It's **committed to the repo on purpose** so a fresh machine installs the same plugin versions and you can roll back a bad `:PackUpdate` from git history.

Treat it like any other lockfile: it changes when you run `:PackUpdate`, so commit the updated file to propagate version bumps to your other machines.
```bash
cd ~/dotfiles && git add nvim/nvim-pack-lock.json && git commit -m "nvim: bump plugins"
```
If you'd rather let plugins float to the latest on every machine instead, gitignore it and drop the tracked copy.

## Customizing

- **Editor options** → `lua/options.lua`.
- **Keymaps** → `lua/keymaps.lua`.
- **Add an LSP server** → add it to `lua/lsp.lua` (`vim.lsp.config` + `vim.lsp.enable`); install the server via `:Mason` or have it on `PATH`.
- **Add a treesitter parser** → add the language to `ensure_installed` in `lua/treesitter.lua`.
- **Change colorscheme** → swap the plugin in `lua/pack.lua` and the `colorscheme` line in `init.lua`.

## Updating

```bash
cd ~/dotfiles && git pull
```
Then in nvim: `:PackUpdate` (plugins) and re-run treesitter installs if you added parsers.
