;;; dashboard.el --- startup dashboard -*- lexical-binding: t; -*-
;; ≈ your old Doom dashboard. Shows on `emacs` launch with the EMACS banner.

(use-package dashboard
  :init
  (setq dashboard-startup-banner (expand-file-name "banner.txt" user-emacs-directory)
        dashboard-banner-logo-title "Welcome back"
        dashboard-center-content t            ; center the banner + lists
        dashboard-projects-backend 'project-el ; use built-in project.el (no projectile)
        dashboard-items '((recents   . 5)
                          (projects  . 5)
                          (bookmarks . 5))
        ;; Stoic footer — dashboard picks one at random each launch.
        dashboard-footer-messages
        '("You have power over your mind, not outside events. Realize this, and you will find strength. — Marcus Aurelius"
          "The happiness of your life depends upon the quality of your thoughts. — Marcus Aurelius"
          "Waste no more time arguing about what a good man should be. Be one. — Marcus Aurelius"
          "The best revenge is to not be like your enemy. — Marcus Aurelius"
          "If it is not right, do not do it; if it is not true, do not say it. — Marcus Aurelius"
          "We suffer more often in imagination than in reality. — Seneca"
          "It is not that we have a short time to live, but that we waste a lot of it. — Seneca"
          "Luck is what happens when preparation meets opportunity. — Seneca"
          "Difficulties strengthen the mind, as labor does the body. — Seneca"
          "He who is brave is free. — Seneca"
          "It is not what happens to you, but how you react to it that matters. — Epictetus"
          "No man is free who is not master of himself. — Epictetus"
          "Wealth consists not in having great possessions, but in having few wants. — Epictetus"
          "First say to yourself what you would be; and then do what you have to do. — Epictetus"
          "Don't explain your philosophy. Embody it. — Epictetus"
          "Man conquers the world by conquering himself. — Zeno of Citium"
          "We have two ears and one mouth, so we should listen more than we say. — Zeno of Citium"
          "Fate guides the willing, but drags the unwilling. — Cleanthes"
          "If I had followed the multitude, I should not have studied philosophy. — Chrysippus"
          "Virtue is acquired not by reasoning, but by practice. — Musonius Rufus"))
  :config
  (dashboard-setup-startup-hook))             ; show the dashboard at startup
