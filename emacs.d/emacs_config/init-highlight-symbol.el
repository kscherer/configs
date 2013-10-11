;;emulate the vi * search functionality
(setq highlight-symbol-on-navigation-p t)
(global-set-key (kbd "C-*") 'highlight-symbol-next)
(global-set-key (kbd "C-M-*") 'highlight-symbol-prev)
