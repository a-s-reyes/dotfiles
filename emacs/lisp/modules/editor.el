;;; editor.el --- file tree + tree-sitter -*- lexical-binding: t; -*-
;; ≈ your nvim editor.lua + treesitter.lua

;; Treemacs — the file-tree sidebar (like nvim's neo-tree). Opened via C-c t.
(use-package treemacs
  :defer t)

;; Icons for the tree. nerd-icons works in GUI *and* terminal, but needs a
;; Nerd Font: run `M-x nerd-icons-install-fonts` once, then restart Emacs.
(use-package nerd-icons)
(use-package treemacs-nerd-icons
  :after (treemacs nerd-icons)
  :config
  (treemacs-load-theme "nerd-icons"))

;; treesit-auto — installs tree-sitter grammars on demand and switches to the
;; faster *-ts-mode major modes automatically. Guarded so it's skipped cleanly
;; on Emacs builds without tree-sitter compiled in (e.g. minimal/older builds).
(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (use-package treesit-auto
    :config
    (setq treesit-auto-install 'prompt)   ; ask before downloading a grammar
    (global-treesit-auto-mode)))
