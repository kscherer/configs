(setq smex-save-file "~/.emacs.d/.smex-items")
(setq smex-history-length 20)
(smex-initialize)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
