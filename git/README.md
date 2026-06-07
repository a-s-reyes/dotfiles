# git

Reference gitconfig. Used as a **template** when setting up git on a new machine — not symlinked, not auto-applied. The portable starting point; each machine's `~/.gitconfig` lives on that machine.

## What's in here

| File | Purpose |
|---|---|
| `gitconfig` | The reference config — copy to `~/.gitconfig`, then set identity in `~/.gitconfig.local` |
| `gitignore_global` | Global ignore patterns (OS/editor junk) — copy to `~/.gitignore_global` |

## Why template instead of symlink

`gitconfig` doesn't change very often (you set identity and a few aliases once, then leave it alone for months). It also accumulates **machine-specific** entries over time — `safe.directory` paths for local repos, OS-specific credential helpers, work-only overrides — that don't belong in a shared repo.

Treating this folder as a template keeps the repo clean and avoids per-machine sync ceremony. Each machine's `~/.gitconfig` is independently maintained.

For things that change often (shells, nvim, tmux), the bootstrap scripts use symlinks. Git is the exception.

## How to use

### New machine setup

**Linux / macOS:**
```bash
cp ~/dotfiles/git/gitconfig ~/.gitconfig
cp ~/dotfiles/git/gitignore_global ~/.gitignore_global
# real identity goes in ~/.gitconfig.local (kept OFF the repo):
git config --file ~/.gitconfig.local user.name  "Your Name"
git config --file ~/.gitconfig.local user.email "you@example.com"
```

**Windows:**
```powershell
Copy-Item D:\repos\dotfiles\git\gitconfig $env:USERPROFILE\.gitconfig
```

Your name/email live in `~/.gitconfig.local` (not the repo), so the public template never carries your identity. Put other machine-specific bits (credential helper, work email) there too.

### Existing machine

If you already have a `~/.gitconfig` that works for you, **leave it alone**. The repo's copy is a reference, not a source of truth. You don't need to migrate.

Refer to this file when you want to copy a specific alias or setting:
```bash
cat ~/dotfiles/git/gitconfig                       # eyeball it
git config --global alias.lg "log --oneline --graph --decorate"  # cherry-pick one alias
```

## What's in the config

- **Identity** — placeholder `[user]` only; your real name/email go in `~/.gitconfig.local` (kept off the repo).
- **`core.excludesFile = ~/.gitignore_global`** — global ignore (see `gitignore_global`).
- **`init.defaultBranch = main`**, **`core.editor = nvim`**.
- **`pull.rebase = false`**, **`push.default = current`**, **`push.autoSetupRemote = true`** — pull/push defaults.
- **`fetch.prune = true`** — drop local refs to deleted remote branches on fetch.
- **`rebase.autostash = true`** — auto-stash/unstash around rebase & pull.
- **`rerere.enabled = true`** — remember and replay conflict resolutions.
- **`merge.conflictStyle = zdiff3`** — conflict markers include the common ancestor.
- **`diff.algorithm = histogram`**, **`diff.colorMoved = zebra`** — cleaner diffs + moved-line highlighting.
- **`commit.verbose = true`** — show the diff in the commit-message editor.
- **`color.ui` / `column.ui = auto`**, **`branch.sort = -committerdate`**, **`help.autocorrect = prompt`** — UI niceties.
- **Aliases**: `s` (status -sb), `co`, `br`, `lg` (log graph), `last`, `unstage`.
- **`[include] ~/.gitconfig.local`** — pulls in your machine-local identity/overrides (silently ignored if absent).
- **`[includeIf "gitdir:~/work/"]`** (commented example) — use a different identity per folder, e.g. work email only in work repos.

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
