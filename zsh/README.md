# zsh

Portable zsh configuration. Single-file setup with sensible defaults.

## What's in here

| File | Purpose |
|---|---|
| `zshrc` | The zshrc itself — sourced every interactive shell |

Organized in sections: history, completion, PATH, aliases, functions, prompt, local overrides.

## Prerequisites

- **`zsh`** installed. Default on macOS since 2019. On Linux, install with your package manager:
  ```bash
  sudo apt install zsh         # Debian/Ubuntu
  sudo pacman -S zsh           # Arch
  sudo dnf install zsh         # Fedora
  ```

## Installation

### Step 1 — bridge the file

```bash
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
```

### Step 2 — make zsh your default shell (optional)

```bash
chsh -s "$(which zsh)"
```

Log out and back in for the change to take effect. To check:
```bash
echo $SHELL                    # should show /bin/zsh or /usr/bin/zsh
```

If you don't want to change the default shell, just type `zsh` to launch it on demand.

### Step 3 — verify

Open a new zsh terminal. Test:
```zsh
type ll                        # should show: ll is an alias for 'ls -lah'
echo $EDITOR                   # should show: nvim
```

Press `Tab` twice after typing `git ` — completion menu should appear with arrow-key selection.

## Per-machine overrides

The last line of `zshrc` sources `~/.zshrc.local` if it exists:

```zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
```

Put machine-specific or sensitive stuff there — work proxies, internal aliases, secrets. **`~/.zshrc.local` is not in git** and won't be shared between machines.

Example `~/.zshrc.local`:
```zsh
export AWS_PROFILE=work
alias deploy='ssh prod.internal'
```

## What's configured

- **History** — 100k entries, deduped, shared across all open shells (`SHARE_HISTORY`).
- **Editor** — `EDITOR` and `VISUAL` set to `nvim`.
- **Completion** — case-insensitive, menu-select with arrow keys.
- **PATH** — adds `~/.local/bin` and `~/.cargo/bin` if they exist.
- **Aliases** — `ll`, `l`, `la`, `..`, `...`, plus git shortcuts (`gs`, `gd`, `gco`, `gp`, `gl`).
- **Functions** — `mkcd <dir>` (mkdir + cd in one call).
- **Prompt** — green `user@host` : blue `path` `%`.

## Customizing

- **Add an alias**: append to the aliases section.
- **Add a function**: append to the functions section.
- **Change prompt**: edit the `PROMPT` line. Or install [Starship](https://starship.rs) and replace the prompt line with `eval "$(starship init zsh)"`.
- **Add a plugin framework**: not included. If you want one, the lightweight options are [zinit](https://github.com/zdharma-continuum/zinit) or [antidote](https://getantidote.github.io). Add the init at the top of `zshrc`.
- **Add tool init** (fzf, zoxide, etc.): append `eval "$(zoxide init zsh)"` etc. at the bottom, before the local-override source line.

## Reloading

After editing:
```zsh
source ~/.zshrc
```

Or open a new terminal.

## Updating

```bash
cd ~/dotfiles && git pull
source ~/.zshrc
```
