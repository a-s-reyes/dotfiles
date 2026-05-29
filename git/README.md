# git

Reference gitconfig. Used as a **template** when setting up git on a new machine — not symlinked, not auto-applied. The portable starting point; each machine's `~/.gitconfig` lives on that machine.

## What's in here

| File | Purpose |
|---|---|
| `gitconfig` | The reference config — copy this to `~/.gitconfig` on a new machine, then tweak |

## Why template instead of symlink

`gitconfig` doesn't change very often (you set identity and a few aliases once, then leave it alone for months). It also accumulates **machine-specific** entries over time — `safe.directory` paths for local repos, OS-specific credential helpers, work-only overrides — that don't belong in a shared repo.

Treating this folder as a template keeps the repo clean and avoids per-machine sync ceremony. Each machine's `~/.gitconfig` is independently maintained.

For things that change often (shells, nvim, tmux), the bootstrap scripts use symlinks. Git is the exception.

## How to use

### New machine setup

**Linux / macOS:**
```bash
cp ~/dotfiles/git/gitconfig ~/.gitconfig
```

**Windows:**
```powershell
Copy-Item D:\repos\dotfiles\git\gitconfig $env:USERPROFILE\.gitconfig
```

Then open `~/.gitconfig` and tweak anything that needs to differ on this machine (credential helper, work email override, etc.).

### Existing machine

If you already have a `~/.gitconfig` that works for you, **leave it alone**. The repo's copy is a reference, not a source of truth. You don't need to migrate.

Refer to this file when you want to copy a specific alias or setting:
```bash
cat ~/dotfiles/git/gitconfig                       # eyeball it
git config --global alias.lg "log --oneline --graph --decorate"  # cherry-pick one alias
```

## What's in the config

- **Identity** — `user.name` and `user.email`. Change these per machine if you use different emails for work vs personal.
- **`init.defaultBranch = main`** — new repos start on `main`.
- **`core.editor = nvim`** — assumes nvim is on PATH.
- **`pull.rebase = false`** — `git pull` uses merge, not rebase.
- **`push.default = current`** — `git push` pushes the current branch.
- **`push.autoSetupRemote = true`** — no `--set-upstream` ceremony on first push.
- **`color.ui = auto`** — colorize git output in terminals.
- **Aliases**:
  - `git s` → `git status -sb` (short + branch line)
  - `git co` → `git checkout`
  - `git br` → `git branch`
  - `git lg` → log graph one-line
  - `git last` → show last commit
  - `git unstage <file>` → unstage a file
- **`[include] path = ~/.gitconfig.local`** — optional. If `~/.gitconfig.local` doesn't exist, git silently ignores it. Lets you split machine-specific overrides into a separate file *if* you want that pattern on a given machine. Not required.

## Don't commit secrets

This file is in a git repo. Never put tokens, passwords, or anything sensitive in `gitconfig`. The fields commonly seen in `.gitconfig` are all safe to share:

| Setting | Safe to commit? |
|---|---|
| `user.name`, `user.email` | Yes (already public in every commit you've made) |
| Aliases, color, pull/push behavior | Yes |
| `user.signingKey` (GPG key ID) | Yes — the ID is public; the private key never lives in `.gitconfig` |
| `credential.helper` (name only, e.g., `manager`) | Yes |
| Tokens, passwords, OAuth secrets | **Never** |
| `safe.directory` entries with real paths | Avoid — leaks local layout and possibly internal project names |

If you ever accumulate machine-specific or sensitive bits, keep them in a per-machine `~/.gitconfig.local` (never committed). The `[include]` directive at the bottom of `gitconfig` pulls that in automatically when it exists.

## Updating

If you tweak something in `~/.gitconfig` on a machine and want it in the repo for future setups:

```bash
# Open both, copy the line over manually
nvim ~/.gitconfig ~/dotfiles/git/gitconfig
```

Then commit and push the repo. No automatic sync — that's the trade-off of the template pattern.
