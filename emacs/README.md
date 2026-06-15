# emacs

A hand-built, vanilla **Emacs 30** config — no framework. `init.el` is the
orchestrator; the real config lives in `lisp/`.

## Layout

```
emacs/
├── early-init.el          # pre-UI: GC, disable bars, transparency
├── init.el                # bootstrap (MELPA + use-package) → loads lisp/
├── banner.txt             # ASCII art for the dashboard
└── lisp/
    ├── config/            # core behavior
    │   ├── defaults.el     #   built-in settings
    │   └── keys.el         #   keybindings
    └── modules/           # features/pkgs
        ├── ui.el           #   doom-themes + which-key
        ├── completion.el   #   vertico/marginalia/orderless/consult/corfu
        ├── editor.el       #   treemacs + tree-sitter
        ├── git.el          #   magit
        └── dashboard.el     #   startup screen (uses banner.txt)
```

## Install

The `.el` files are OS-agnostic — only the symlink *target* differs per platform:

| OS | Config location | Linker |
|---|---|---|
| Linux / macOS | `~/.config/emacs` | `./bootstrap.sh emacs` |
| Windows | `%APPDATA%\.emacs.d` | `.\bootstrap.ps1 emacs` |

Or link by hand on Linux/macOS:

```bash
ln -s ~/repo/dotfiles/emacs ~/.config/emacs
```

First launch downloads the packages from MELPA (~1 min, needs network); after
that, just run `emacs`.

**Requirements:** Emacs **29+** (30+ recommended). Optional per-feature tools:
`git` (magit), `ripgrep` (consult), a C compiler (tree-sitter grammar builds).

## Keybinds (native Emacs keys)

| Key | Does |
|---|---|
| `C-x g` | Magit (git) |
| `C-c t` | Treemacs (file tree) |
| `C-x b` | Switch buffer (consult) |
| `M-x`   | Run any command (with fuzzy completion) |

## Adding a package

Drop a `use-package` block into the matching `lisp/modules/*.el` — or make a new
module file and add one `my/load` line in `init.el`. That's the whole workflow.

## Note

Emacs writes runtime data (`elpa/`, caches, history) *into* this folder; the
`.gitignore` keeps it out of git. Only the `.el` source is tracked.
