# tmux

tmux configuration with vim-style navigation and sensible defaults.

## What's in here

| File | Purpose |
|---|---|
| `tmux.conf` | The tmux config — read on tmux startup |

Organized in sections: prefix, general options, splits, navigation, reload, copy mode, status bar.

## Prerequisites

- **`tmux`** installed. Native to Linux/macOS; on Windows runs under WSL, MSYS2, or Cygwin only.

### Linux
```bash
sudo apt install tmux          # Debian/Ubuntu
sudo pacman -S tmux            # Arch
sudo dnf install tmux          # Fedora
```

### macOS
```bash
brew install tmux
```

Check version (needs 2.6+ for these settings, 3.0+ ideal):
```bash
tmux -V
```

## Installation

### Step 1 — bridge the file

The config uses the XDG location `~/.config/tmux/tmux.conf`. Create the directory and symlink:

```bash
mkdir -p ~/.config/tmux
ln -sf ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
```

(If you prefer the older `~/.tmux.conf` location, symlink there instead and update the reload binding in `tmux.conf` to match.)

### Step 2 — start tmux

```bash
tmux
```

You should see:
- A status bar at the top showing the session name (`[0]` by default) on the left, date/time on the right.
- Prefix bound to `Ctrl-a` instead of the default `Ctrl-b`.

### Step 3 — verify keybindings

Inside tmux, try:
- `Ctrl-a |` → splits the window vertically.
- `Ctrl-a -` → splits horizontally.
- `Ctrl-a h/j/k/l` → move between panes.
- `Ctrl-a r` → reloads the config (shows "tmux.conf reloaded" message).

## Key bindings reference

Prefix is `Ctrl-a` (rebound from default `Ctrl-b`).

### Panes
| Keys | Action |
|---|---|
| `prefix \|` | Split pane vertically (new pane keeps cwd) |
| `prefix -` | Split pane horizontally |
| `prefix h/j/k/l` | Move to pane left/down/up/right |
| `prefix H/J/K/L` | Resize pane left/down/up/right (repeatable) |
| `prefix x` | Close current pane (tmux default) |
| `prefix z` | Zoom/unzoom current pane (tmux default) |

### Windows
| Keys | Action |
|---|---|
| `prefix c` | New window (tmux default) |
| `prefix n` / `p` | Next / previous window (tmux default) |
| `prefix 1`–`9` | Jump to window N (windows start at 1) |
| `prefix ,` | Rename current window (tmux default) |

### Sessions
| Keys | Action |
|---|---|
| `prefix d` | Detach from session (tmux default) |
| `prefix s` | List sessions (tmux default) |
| `prefix $` | Rename session (tmux default) |

### Copy mode (vi-style)
| Keys | Action |
|---|---|
| `prefix [` | Enter copy mode (scrollback) |
| `v` | Start selection (in copy mode) |
| `y` | Yank selection and exit (in copy mode) |
| `q` / `Esc` | Exit copy mode |

### Config
| Keys | Action |
|---|---|
| `prefix r` | Reload `tmux.conf` |
| `prefix ?` | Show all key bindings (tmux default) |

### Sending the prefix itself
| Keys | Action |
|---|---|
| `Ctrl-a Ctrl-a` | Send literal `Ctrl-a` to the underlying shell |

## What's configured

- **Prefix** — `Ctrl-a` (more reachable than the default `Ctrl-b`).
- **Mouse** — on (click to focus pane, scroll for scrollback, drag to resize).
- **History** — 50,000 lines of scrollback per pane.
- **Indexing** — windows and panes start at 1, not 0.
- **Auto-renumber** — closing window 2 of [1,2,3] leaves [1,2], not [1,3].
- **Truecolor** — `tmux-256color` with color override for 24-bit support.
- **Splits** — `|` and `-` instead of the cryptic `%` and `"`. New panes inherit cwd.
- **Copy mode** — vi keys, `v` to select, `y` to yank.
- **Status bar** — top of screen, session name left, date/time right.

## Customizing

- **Change prefix**: edit the `set -g prefix` line (e.g., `C-Space`).
- **Add plugins**: install [TPM](https://github.com/tmux-plugins/tpm) and add `set -g @plugin 'name/repo'` lines.
- **Change theme**: tweak `status-style`, `status-left`, `status-right`. Or install a theme via TPM (e.g., `catppuccin/tmux`).
- **Disable mouse**: change `set -g mouse on` to `off`.

## Reloading

Inside tmux: `prefix r`.

From a shell:
```bash
tmux source-file ~/.config/tmux/tmux.conf
```

## Updating

```bash
cd ~/dotfiles && git pull
tmux source-file ~/.config/tmux/tmux.conf
```
