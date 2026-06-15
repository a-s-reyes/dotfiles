;;; init.el --- entry point: bootstrap packages, then load lisp/ -*- lexical-binding: t; -*-
;; This file is the orchestrator; the real config lives in lisp/config/ and lisp/modules/.

;; ── Package system + use-package ─────────────────────────────────────
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))          ; only the first time (no network on later starts)

;; use-package is built into Emacs 29+, but install it on anything older.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)     ; auto-install any package a module names

;; ── Load my config files ─────────────────────────────────────────────
(defun my/load (relpath)
  "Load RELPATH (no extension) relative to this config directory."
  (load (expand-file-name relpath user-emacs-directory) nil 'nomessage))

(my/load "lisp/config/defaults")    ; built-in settings
(my/load "lisp/modules/ui")         ; theme + which-key
(my/load "lisp/modules/completion") ; minibuffer + in-buffer completion
(my/load "lisp/modules/editor")     ; treemacs + tree-sitter
(my/load "lisp/modules/lang")       ; LSP via eglot (C/C++)
(my/load "lisp/modules/git")        ; magit
(my/load "lisp/modules/dashboard")  ; startup screen + banner
(my/load "lisp/config/keys")        ; keybindings (load last)

;; ── Restore a sane GC threshold once startup is done ─────────────────
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold (* 16 1000 1000))))

;;; init.el ends here
