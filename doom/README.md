# doom (Doom Emacs)

My [Doom Emacs](https://github.com/doomemacs/doomemacs) configuration — just the `$DOOMDIR` files (`~/.config/doom`). The Doom framework itself and all downloaded packages live in `~/.config/emacs` and are **not** tracked here (same idea as nvim's downloaded plugins).

## What's in here

| File | Purpose |
|---|---|
| `init.el` | which Doom **modules** are enabled — run `doom sync` after editing |
| `config.el` | personal settings — theme, fonts, keybinds, dashboard banner |
| `packages.el` | extra packages beyond what Doom ships — run `doom sync` after editing |

These three files are the entire `$DOOMDIR`.

## Prerequisites

- **Emacs 29+** (built against 30.2).
- **git**, **[ripgrep](https://github.com/BurntSushi/ripgrep)** (`rg`), **fd** — used for search and project navigation.
- **A Nerd Font** — for icons in the modeline and dashboard.

```bash
# Linux
sudo dnf install emacs git ripgrep fd-find    # Fedora
sudo apt install emacs git ripgrep fd-find    # Debian/Ubuntu
sudo pacman -S emacs git ripgrep fd           # Arch

# macOS
brew install emacs git ripgrep fd
```

## Installation (fresh machine)

### Step 1 — install Doom

Doom is a framework you clone into Emacs's config dir, then run its installer:

```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

Add `~/.config/emacs/bin` to your `PATH` so you can just type `doom`.

### Step 2 — link this config

Doom reads `$DOOMDIR`, which defaults to `~/.config/doom`. Symlink it to this folder:

```bash
ln -s ~/dotfiles/doom ~/.config/doom
```

Or let the repo bootstrap do the backup + link: `./bootstrap.sh doom`.

### Step 3 — sync and launch

```bash
doom sync      # installs the packages your modules/packages.el declare
emacs
```

## What's configured

Coming from Vim/Neovim this will feel familiar:

- **`evil +everywhere`** — Vim keybindings throughout, with leader `SPC` (same as the nvim config), so motions and the leader workflow carry over.
- **Completion** — `vertico` + `corfu +orderless` (the modern Doom stack, not ivy/helm/company).
- **Git** — `magit`.
- **Org-mode** — notes/agenda; org files live in `~/org/`.
- **UI** — `doom-one` theme, dashboard with a custom ASCII "EMACS" banner, modeline, git-gutter, workspaces. Absolute line numbers.
- **Languages enabled** — `emacs-lisp`, `markdown`, `org`, `sh`.

**Not enabled yet** (uncomment in `init.el`, then `doom sync`):

- **LSP** — `(lsp +eglot)` for IDE features (go-to-definition, diagnostics, server-backed completion).
- **Languages** — `(cc +lsp)` for C/C++, plus `python`, `(rust +lsp)`, etc. are all commented out.

## Customizing

| To… | Edit | Then |
|---|---|---|
| enable/disable a feature module | `init.el` | `doom sync`, restart Emacs |
| add/remove a package | `packages.el` | `doom sync`, restart Emacs |
| tweak settings, keybinds, theme | `config.el` | reload with `SPC h r r` (no sync needed) |

Useful: `SPC h d h` opens Doom's docs/module index; `doom doctor` diagnoses problems.

## Updating

```bash
cd ~/dotfiles && git pull     # this config
doom upgrade                  # Doom core + packages
doom sync                     # always after editing init.el / packages.el
```

## Cross-platform note

Best on **Linux/macOS**. Doom runs on Windows but is noticeably rougher (path quirks, native-comp, slower startup), so this config is wired only into `bootstrap.sh` (Linux/macOS), not `bootstrap.ps1`.
