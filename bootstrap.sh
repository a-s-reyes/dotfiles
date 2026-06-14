#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────
#  bootstrap.sh — link this repo's configs into your home directory
#  Usage:   ./bootstrap.sh             # link everything
#           ./bootstrap.sh nvim tmux   # link only specified tools
# ─────────────────────────────────────────────────────────────────

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
TOOLS_REQUESTED=("$@")

# ─────────────────────────────────────────────────────────────────
#  Helpers
# ─────────────────────────────────────────────────────────────────
link() {
    local src="$1"   # path inside the repo
    local dst="$2"   # path in $HOME

    if [ ! -e "$src" ]; then
        echo "  skip: $src does not exist in repo"
        return 0
    fi

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        # existing symlink — replace
        rm "$dst"
    elif [ -e "$dst" ]; then
        # real file/dir — back it up
        if [ -e "${dst}.backup" ]; then
            echo "  ERROR: $dst exists and ${dst}.backup also exists. Resolve manually."
            return 1
        fi
        mv "$dst" "${dst}.backup"
        echo "  backed up: $dst -> ${dst}.backup"
    fi

    ln -s "$src" "$dst"
    echo "  linked:    $dst -> $src"
}

should_link() {
    local tool="$1"
    if [ ${#TOOLS_REQUESTED[@]} -eq 0 ]; then
        return 0
    fi
    for t in "${TOOLS_REQUESTED[@]}"; do
        [ "$t" = "$tool" ] && return 0
    done
    return 1
}

# ─────────────────────────────────────────────────────────────────
#  Per-tool links
# ─────────────────────────────────────────────────────────────────
echo "Linking from: $REPO"
echo ""

if should_link nvim; then
    echo "nvim:"
    link "$REPO/nvim" "$HOME/.config/nvim"
fi

if should_link emacs; then
    echo "emacs:"
    link "$REPO/emacs" "$HOME/.config/emacs"
fi

if should_link tmux; then
    echo "tmux:"
    link "$REPO/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
fi

if should_link bash; then
    echo "bash:"
    link "$REPO/bash/bashrc" "$HOME/.bashrc"
    # ensure login shells (SSH, TTY) source .bashrc too
    if [ ! -e "$HOME/.bash_profile" ] && [ ! -L "$HOME/.bash_profile" ]; then
        cat > "$HOME/.bash_profile" <<'EOF'
[ -f ~/.bashrc ] && . ~/.bashrc
EOF
        echo "  created:   $HOME/.bash_profile (sources .bashrc)"
    fi
fi

# git/ is template-only — copy ~/dotfiles/git/gitconfig to ~/.gitconfig by hand.
# Not symlinked, not auto-linked.

echo ""
echo "Done. Open a new terminal (or 'source ~/.bashrc') to apply."
