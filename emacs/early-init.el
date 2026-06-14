;;; early-init.el --- loaded before the UI and package system -*- lexical-binding: t; -*-

;; Speed up startup: crank GC way up now; init.el lowers it again after load.
(setq gc-cons-threshold most-positive-fixnum)

;; We bootstrap packages ourselves in init.el, so don't auto-initialize here.
(setq package-enable-at-startup nil)

;; Keep Emacs's default UI chrome — menu bar, toolbar, scroll bar (vanilla look).
;; To hide any of them, add e.g. (menu-bar-mode -1) here.
(setq inhibit-startup-screen t)        ; skip the default splash (the dashboard replaces it)

;; Opaque (vanilla). Transparency is omitted on purpose: on this PGTK/Wayland
;; build alpha can't be limited to the buffer — it dims the menu bar too.
;; To re-enable later: (add-to-list 'default-frame-alist '(alpha-background . 95))

;;; early-init.el ends here
