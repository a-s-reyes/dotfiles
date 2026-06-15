;;; lang.el --- language support: LSP via eglot -*- lexical-binding: t; -*-
;; ≈ your nvim lsp.lua. Uses built-in eglot + clangd for C/C++.
;; REQUIRES clangd on PATH:  sudo dnf install clang-tools-extra

;; Eglot is built into Emacs 29+. Auto-start it in C/C++ buffers (both the
;; classic and tree-sitter major modes). Completion flows through corfu, which
;; you already have; hover docs show via eldoc automatically.
(use-package eglot
  :ensure nil
  :hook ((c-mode c++-mode c-ts-mode c++-ts-mode) . eglot-ensure)
  :bind (:map eglot-mode-map
         ("C-c l r" . eglot-rename)         ; rename symbol project-wide
         ("C-c l a" . eglot-code-actions)   ; quick-fixes / refactors
         ("C-c l f" . eglot-format-buffer)  ; format the whole buffer
         ("C-c l d" . eldoc-doc-buffer))    ; hover docs in a buffer
  :config
  (setq eglot-autoshutdown t))             ; stop the server when its last buffer closes

;; Navigation already works via built-in xref once eglot is on:
;;   M-.  go to definition      M-,  jump back      M-?  find references
