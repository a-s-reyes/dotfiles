# bash

Portable bash configuration. Single-file setup with sensible defaults.

## What's in here

| File | Purpose |
|---|---|
| `bashrc` | The bashrc itself — sourced every interactive shell |

The file is organized in sections: history, PATH, aliases, functions, prompt, local overrides.

## Prerequisites

Just `bash`. Present by default on most Linux distros and macOS. On Windows, `bash` comes via Git Bash, WSL, or MSYS2.

## Installation

### Step 1 — bridge the file

Symlink `~/.bashrc` to this file.

**Linux / macOS / WSL:**
```bash
ln -sf ~/dotfiles/bash/bashrc ~/.bashrc
```

### Step 2 — make sure login shells run it

By default `~/.bash_profile` runs at login (SSH, TTY console) but `~/.bashrc` does not. Create a `~/.bash_profile` that sources `~/.bashrc` so the config runs in both cases:

```bash
cat > ~/.bash_profile <<'EOF'
[ -f ~/.bashrc ] && . ~/.bashrc
EOF
```

If you already have a `~/.bash_profile`, add that line manually.

### Step 3 — verify

Open a new terminal. Test:
```bash
type ll                # should show: ll is aliased to 'ls -lah --color=auto'
echo $EDITOR           # should show: nvim
history | wc -l        # history is now persisted at 100k entries
```

If the prompt is colored green/blue, you're done.

## Per-machine overrides

The last line of `bashrc` sources `~/.bashrc.local` if it exists:

```bash
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
```

Put machine-specific or sensitive stuff there — work proxies, internal aliases, secrets. **`~/.bashrc.local` is not in git** and won't be shared between machines.

Example `~/.bashrc.local`:
```bash
export AWS_PROFILE=work
alias deploy='ssh prod.internal'
```

## What's configured

- **History** — 100k entries, deduped, append on exit (not overwrite).
- **Editor** — `EDITOR` and `VISUAL` set to `nvim`.
- **PATH** — adds `~/.local/bin` and `~/.cargo/bin` if they exist.
- **Aliases** — `ll`, `l`, `la`, `..`, `...`, `grep` with color, plus git shortcuts (`gs`, `gd`, `gco`, `gp`, `gl`).
- **Functions** — `mkcd <dir>` (mkdir + cd in one call).
- **Prompt** — green `user@host` : blue `path` `$`.

## Customizing

- **Add an alias**: append to the aliases section.
- **Add a function**: append to the functions section.
- **Change prompt**: edit the `PS1` line. Or install [Starship](https://starship.rs) and replace the prompt line with `eval "$(starship init bash)"`.
- **Add tool init** (fzf, zoxide, etc.): append `eval "$(zoxide init bash)"` etc. at the bottom, before the local-override source line.

## Reloading

After editing:
```bash
source ~/.bashrc
```

Or open a new terminal.

## Updating

```bash
cd ~/dotfiles && git pull
source ~/.bashrc
```
