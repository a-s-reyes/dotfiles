;;; defaults.el --- built-in editor settings -*- lexical-binding: t; -*-
;; Loaded by init.el. The Emacs equivalent of your nvim options.lua:
;; just built-in settings, no packages.

;; ── Quality of life ──────────────────────────────────────────────────
(setq inhibit-startup-message t
      ring-bell-function 'ignore       ; no audible/visual bell
      use-short-answers t              ; y/n instead of typing "yes" + RET
      make-backup-files nil            ; no foo~ files
      create-lockfiles nil)            ; no .#foo files

;; Keep Emacs's own "customize" writes out of init.el (and out of git).
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil 'nomessage))

;; ── Display ──────────────────────────────────────────────────────────
(global-display-line-numbers-mode 1)   ; line numbers in every buffer
(column-number-mode 1)                  ; show column number in the modeline
(set-face-attribute 'default nil :height 130)  ; font size — tweak to taste

;; ── Editing ──────────────────────────────────────────────────────────
(electric-pair-mode 1)                  ; auto-close brackets/quotes
(global-auto-revert-mode 1)             ; reload files changed on disk
(setq auto-revert-verbose nil)

;; ── History / sessions ───────────────────────────────────────────────
(recentf-mode 1)                        ; remember recently opened files
(savehist-mode 1)                       ; remember minibuffer history
(save-place-mode 1)                     ; reopen files at the last cursor spot

;; ── Platform-specific ────────────────────────────────────────────────
;; macOS: make Command act as Meta (so M-x etc. match Linux/Windows).
;; Setting the unused variant is harmless on whichever Mac build you run.
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
        ns-command-modifier  'meta
        mac-option-modifier  'super
        ns-option-modifier   'super))
