;;; ui.el --- theme + keybinding hints -*- lexical-binding: t; -*-
;; ≈ your nvim colorscheme.lua + ui.lua

;; Theme — the same tokyo-night you ran in Doom.
(use-package doom-themes
  :config
  (load-theme 'doom-tokyo-night :no-confirm))

;; which-key — pops up the available keybindings as you type a prefix.
;; Built into Emacs 30, so :ensure nil (no download).
(use-package which-key
  :ensure t                          ; install from MELPA so it works on Emacs 29 too
  :init (which-key-mode)             ; (it's built-in on 30+, but :ensure t is portable)
  :config (setq which-key-idle-delay 0.3))
