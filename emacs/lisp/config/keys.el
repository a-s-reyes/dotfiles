;;; keys.el --- global keybindings -*- lexical-binding: t; -*-
;; Loaded LAST (after the modules) so the commands it binds already exist.
;; The Emacs equivalent of your nvim keymaps.lua. Native Emacs keys, no evil.

(global-set-key (kbd "C-x g") #'magit-status)    ; git
(global-set-key (kbd "C-c t") #'treemacs)         ; toggle the file tree
(global-set-key (kbd "C-x b") #'consult-buffer)   ; nicer buffer switcher

;; Add your own here, e.g.:
;; (global-set-key (kbd "C-c r") #'consult-recent-file)
;; (global-set-key (kbd "C-s")   #'consult-line)
