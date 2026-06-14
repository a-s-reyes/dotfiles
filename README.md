# dotfiles

Personal configuration for the tools I live in. Portable across Linux, macOS, and Windows.

Each tool lives in its own folder with a `README.md` covering its prerequisites, install steps, symlink target, and key bindings. **This file is just the quick start — see the per-tool READMEs for the details.**

## Layout

```
dotfiles/
├── bash/         portable .bashrc                                  → bash/README.md
├── tmux/         tmux.conf with vim-style navigation               → tmux/README.md
├── git/          portable gitconfig (template, not symlinked)      → git/README.md
├── nvim/         Neovim config — vim.pack, VSCode-like stack       → nvim/README.md
├── emacs/        Emacs config — vanilla (use-package)              → emacs/README.md
├── bootstrap.sh  Linux/macOS link script
└── bootstrap.ps1 Windows link script
```

## Per-tool

Start here — each README has the full setup, including how to symlink it on each OS.

| Folder | Tool | Bridging | Setup |
|---|---|---|---|
| `bash/` | bash shell | symlink (live mount) | [bash/README.md](bash/README.md) |
| `tmux/` | tmux | symlink (live mount) | [tmux/README.md](tmux/README.md) |
| `nvim/` | Neovim | symlink (live mount) | [nvim/README.md](nvim/README.md) |
| `emacs/` | Emacs | symlink (live mount) | [emacs/README.md](emacs/README.md) |
| `git/` | git | **template only** (copy by hand) | [git/README.md](git/README.md) |

## Quick start

The bootstrap scripts do, for each tool, what its README describes by hand — back up any existing config, then symlink (or junction on Windows) the repo's copy into place.

### Linux / macOS

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh                 # link everything applicable
./bootstrap.sh nvim tmux       # or just specific tools
```

### Windows

Enable **Developer Mode** first (Settings → For developers → Developer Mode = On) so symlink creation doesn't require admin every time.

```powershell
git clone <repo-url> D:\repos\dotfiles
cd D:\repos\dotfiles
.\bootstrap.ps1                # link everything applicable (nvim today)
.\bootstrap.ps1 nvim           # or just specific tools
```

> `git/` is intentionally **not** linked by either script — it's a template you copy to `~/.gitconfig` once. See [git/README.md](git/README.md).

## What the bootstrap scripts do

For every tool they're asked to link:

1. Back up the existing config (if any) to `<path>.backup`.
2. Create a symlink (or junction on Windows) from the user's expected config location to this repo.
3. Skip silently if the source doesn't exist in the repo.

Re-running is safe — existing links get replaced cleanly; real files get backed up exactly once.

## Updating

```bash
cd ~/dotfiles && git pull
```

Then apply per tool (details in each README): `source ~/.bashrc` for bash, `:PackUpdate` in nvim, `tmux source-file ~/.config/tmux/tmux.conf` for tmux.

## Adding a new tool

1. Create a folder at the repo root: `mkdir <tool>`.
2. Put the canonical config inside it.
3. Add a `README.md` covering prerequisites, install, symlink target, key bindings, and customization.
4. Add a link block to `bootstrap.sh` and/or `bootstrap.ps1`.

## Per-machine overrides

The bash config sources `~/.bashrc.local` at the end if it exists. Put work-only proxies, internal aliases, and anything secret there — those files are gitignored.

## License

MIT.
