# dotfiles

Personal configuration for the tools I live in. Portable across Linux, macOS, and Windows.

## Layout

```
dotfiles/
├── bash/         portable .bashrc + README
├── tmux/         tmux.conf with vim-style navigation + README
├── git/          portable gitconfig + README
├── nvim/         Neovim config — native vim.pack + mini.nvim, no plugin-manager framework
├── bootstrap.sh  Linux/macOS link script
└── bootstrap.ps1 Windows link script
```

Each tool folder (except `nvim/`) has its own `README.md` with prerequisites, install steps, key bindings, and customization notes.

## Quick start

### Linux / macOS

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh
```

By default `bootstrap.sh` links every applicable tool. To link only specific ones:

```bash
./bootstrap.sh nvim tmux
```

### Windows

Enable **Developer Mode** first (Settings → For developers → Developer Mode = On) so symlink creation doesn't require admin every time.

```powershell
git clone <repo-url> D:\repos\dotfiles
cd D:\repos\dotfiles
.\bootstrap.ps1
```

Default links `nvim` (junction). Add other tools as their folders are created.

## What each script does

For every tool it's asked to link:

1. Backs up the existing config (if any) to `<path>.backup`.
2. Creates a symlink (or junction on Windows) from the user's expected config location to this repo.
3. Skips silently if the source doesn't exist in the repo.

Re-running is safe — existing links get replaced cleanly; real files get backed up exactly once.

## Per-tool

| Folder | Tool | Bridging | Notes |
|---|---|---|---|
| [`bash/`](bash/README.md) | bash shell | symlink (live mount) | per-machine override via `~/.bashrc.local` |
| [`tmux/`](tmux/README.md) | tmux | symlink (live mount) | prefix is `Ctrl-a`, vim-style nav |
| `nvim/` | Neovim | symlink (live mount) | native `vim.pack` config — needs Neovim nightly (0.12+) |
| [`git/`](git/README.md) | git | **template only** | copy manually to `~/.gitconfig` on a new machine |

## Neovim

A lean, framework-free config built on Neovim's own building blocks. `init.lua` just loads a handful of modules under `lua/`:

| Module | What it does |
|---|---|
| `options.lua` | editor options + yank-highlight autocmd |
| `keymaps.lua` | leader is `Space`; QoL motions, visual-mode line moves, native undotree |
| `commands.lua` | `:PackAdd` / `:PackDel` / `:PackUpdate` wrappers around `vim.pack` |
| `pack.lua` | plugin list + setup for the [mini.nvim](https://github.com/nvim-mini/mini.nvim) suite and fugitive |
| `treesitter.lua` | installs parsers (`c`, `cpp`, `lua`, `bash`, `json`, `markdown`) and starts highlighting per filetype |
| `lsp.lua` | `mason` + `nvim-lspconfig`; enables `clangd` and `lua_ls`, format-on-save for C/C++ |

**Plugins** (managed by the built-in `vim.pack`, no lazy.nvim/packer):
moonfly colorscheme, the mini.nvim suite (`files`, `pick`, `completion`, `snippets`, `surround`, `diff`, `notify`, `cmdline`), `friendly-snippets`, `nvim-treesitter`, `nvim-lspconfig`, `mason.nvim`, and `vim-fugitive`.

**Prerequisites:** Neovim nightly (uses `vim.pack`), [ripgrep](https://github.com/BurntSushi/ripgrep) for the mini.pick grep/file pickers, a system `clangd` on `PATH` for C/C++, and a Nerd Font for icons.

A few key bindings: `-` opens the mini file explorer, `<leader>pf` picks files, `<leader>ps` greps the word under the cursor, `<leader>gg` opens fugitive, `<leader>u` toggles the undotree.

## Updating

```bash
cd ~/dotfiles
git pull
```

For nvim plugins (from inside Neovim):
```
:PackUpdate          " update everything
:PackUpdate name     " update specific plugins
```

For shell config (after editing aliases/functions):
```bash
source ~/.bashrc
```

For tmux:
```bash
tmux source-file ~/.config/tmux/tmux.conf
```

## Adding a new tool

1. Create a new folder at the repo root: `mkdir <tool>`.
2. Put the canonical config inside it.
3. Add a `README.md` covering prerequisites, install, key bindings, and customization.
4. Add a link block to `bootstrap.sh` and/or `bootstrap.ps1`.

## Per-machine overrides

The bash config sources `~/.bashrc.local` at the end if it exists. Put work-only proxies, internal aliases, and anything secret there — those files are gitignored.

## License

MIT.
