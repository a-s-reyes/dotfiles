# nvim

Neovim configuration based on the NvChad v2.5 starter.

## What's in here

| File | Purpose |
|---|---|
| `init.lua` | Entry point — bootstraps lazy.nvim, loads NvChad |
| `lazy-lock.json` | Pins exact plugin versions — commit this |
| `lua/chadrc.lua` | NvChad UI overrides (theme, statusline) |
| `lua/options.lua` | Vim options (line numbers, tabs, etc.) |
| `lua/mappings.lua` | Custom keybindings |
| `lua/autocmds.lua` | Autocommands |
| `lua/configs/lspconfig.lua` | LSP server registration |
| `lua/configs/conform.lua` | Formatters per filetype |
| `lua/plugins/init.lua` | Custom plugin specs |

## Prerequisites

Install before bridging the config:

- **Neovim** 0.10+ (built against 0.12)
- **Git**
- **A Nerd Font** (JetBrainsMono Nerd Font recommended) — required for icons. Set it as your terminal's font.
- **`ripgrep`** — required for Telescope's live-grep
- **`fd`** — fast file finding
- **A C compiler** — Treesitter compiles parsers on first use
- **Language toolchains** for any language you'll work in (e.g., `zig`, `node`, `python`)

### Windows
```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install DEVCOM.JetBrainsMonoNerdFont
```

### Linux (Debian/Ubuntu)
```bash
sudo apt install neovim git ripgrep fd-find build-essential
# Nerd Font: download JetBrainsMono from nerdfonts.com, copy to ~/.local/share/fonts, run fc-cache
```

### macOS
```bash
brew install neovim git ripgrep fd
brew install --cask font-jetbrains-mono-nerd-font
```

## Installation

### Step 1 — bridge the config

Point Neovim's config dir at this folder.

**Linux / macOS:**
```bash
rm -rf ~/.config/nvim
ln -s ~/dotfiles/nvim ~/.config/nvim
```

**Windows (PowerShell, admin or Developer Mode):**
```powershell
Remove-Item $env:LOCALAPPDATA\nvim -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Junction -Path $env:LOCALAPPDATA\nvim -Target D:\repos\dotfiles\nvim
```

### Step 2 — first launch

```
nvim
```

On the first launch:
1. `lazy.nvim` clones itself into the data directory.
2. It reads `lazy-lock.json` and installs every plugin at the pinned version. You'll see a progress window — wait for it.
3. NvChad compiles its theme cache.
4. Errors may flash for missing LSPs/parsers — ignore them on first launch.

Quit (`:q`) and reopen. Most errors disappear because plugins are now present.

### Step 3 — install LSPs and Treesitter parsers

LSP servers and parsers aren't tracked in git (they're machine-specific binaries). Install them inside Neovim:

```
:Mason
:TSInstall lua vim vimdoc zig
```

`:Mason` opens an interactive list — find a server, press `i` to install, `X` to uninstall.

### Step 4 — verify

Open a file. You should see:
- Syntax highlighting (Treesitter)
- File-type icons in the tree (Nerd Font working)
- LSP diagnostics inline (if an LSP is installed for that filetype)
- `<space>ff` opens Telescope's file picker
- `<space>e` toggles the file tree

## Common keybindings

Leader = `<space>`. Full reference: `:NvCheatsheet` or `<space>ch`.

| Keys | Action |
|---|---|
| `<space>ff` | Find files |
| `<space>fw` | Live grep |
| `<space>fb` | Buffers |
| `<space>e` | Toggle file tree |
| `<C-n>` | Toggle file tree (alt) |
| `<Tab>` / `<S-Tab>` | Next/prev buffer |
| `<space>x` | Close buffer |
| `<C-h/j/k/l>` | Move between windows |
| `gd` | Go to definition (LSP) |
| `K` | Hover docs (LSP) |
| `<space>ra` | Rename symbol (LSP) |
| `<space>ca` | Code action (LSP) |
| `<space>fm` | Format file (conform) |
| `<space>/` | Toggle comment |
| `<space>th` | Change theme |

## Customizing

- **Add a language**: edit `lua/configs/lspconfig.lua` (add the LSP name to the `servers` list), then `:Mason` to install it. Add the parser to `ensure_installed` in `lua/plugins/init.lua`. Add a formatter to `lua/configs/conform.lua` if needed.
- **Change theme**: `:Telescope themes` or edit `lua/chadrc.lua`.
- **Add keymaps**: append to `lua/mappings.lua`.
- **Add a plugin**: add a spec block to `lua/plugins/init.lua`.

## Updating

```bash
cd ~/dotfiles && git pull
nvim
```
Inside nvim:
```
:Lazy sync
```
To update plugins to their latest versions and refresh the lockfile:
```
:Lazy update
```
Then commit the updated `lazy-lock.json`.
