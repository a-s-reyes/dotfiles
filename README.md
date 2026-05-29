# dotfiles

Personal configuration for the tools I live in. Portable across Linux, macOS, and Windows.

## Layout

```
dotfiles/
├── bash/         portable .bashrc + README
├── zsh/          portable .zshrc + README
├── tmux/         tmux.conf with vim-style navigation + README
├── git/          portable gitconfig + README
├── nvim/         Neovim config (NvChad v2.5 starter) + README
├── bootstrap.sh  Linux/macOS link script
└── bootstrap.ps1 Windows link script
```

Each tool folder has its own `README.md` with prerequisites, install steps, key bindings, and customization notes.

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
| [`zsh/`](zsh/README.md) | zsh shell | symlink (live mount) | per-machine override via `~/.zshrc.local` |
| [`tmux/`](tmux/README.md) | tmux | symlink (live mount) | prefix is `Ctrl-a`, vim-style nav |
| [`nvim/`](nvim/README.md) | Neovim | symlink (live mount) | NvChad-based, requires Nerd Font + ripgrep + fd |
| [`git/`](git/README.md) | git | **template only** | copy manually to `~/.gitconfig` on a new machine |

## Updating

```bash
cd ~/dotfiles
git pull
```

For nvim plugins (after pulling a new `lazy-lock.json`):
```
:Lazy sync
```

For shell config (after editing aliases/functions):
```bash
source ~/.bashrc      # or ~/.zshrc
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

Shell configs source machine-specific files (`~/.bashrc.local`, `~/.zshrc.local`) at the end if they exist. Put work-only proxies, internal aliases, and anything secret there — those files are gitignored.

## License

MIT for everything I wrote. The `nvim/` folder includes its upstream MIT `LICENSE` from the NvChad starter.
