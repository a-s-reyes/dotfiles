;;; completion.el --- minibuffer + in-buffer completion -*- lexical-binding: t; -*-
;; Minibuffer + in-buffer completion (the fuzzy-find experience).

;; Vertico — vertical list of candidates in the minibuffer.
(use-package vertico
  :init (vertico-mode))

;; Marginalia — rich annotations beside each candidate.
(use-package marginalia
  :init (marginalia-mode))

;; Orderless — type space-separated fragments, in any order, to match.
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles partial-completion)))))

;; Consult — powerful commands: consult-buffer, consult-line, consult-ripgrep…
(use-package consult
  :defer t)

;; Corfu — in-buffer (as-you-type) completion popup.
(use-package corfu
  :init (global-corfu-mode))
