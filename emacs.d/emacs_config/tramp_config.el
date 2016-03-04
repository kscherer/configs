(setq tramp-default-user "kscherer")
(setq tramp-default-method "ssh")
(setq tramp-auto-save-directory "~/.emacs.d/backup")

;; (defun my-mode-line-function ()
;;   "change face of modeline if editing a file as root"
;;   (when (string-match "^/su\\(do\\)?:" default-directory)
;;     (setq mode-line-format
;;           (format-mode-line mode-line-format 'font-lock-warning-face))))

;; (add-hook 'find-file-hooks 'my-mode-line-function)
;; (add-hook 'dired-mode-hook 'my-mode-line-function)

(defun find-alternative-file-with-sudo ()
  (interactive)
  (let ((fname (or buffer-file-name
                   dired-directory)))
    (when fname
      (if (string-match "^/sudo:root@localhost:" fname)
          (setq fname (replace-regexp-in-string
                       "^/sudo:root@localhost:" ""
                       fname))
        (setq fname (concat "/sudo:root@localhost:" fname)))
      (find-alternate-file fname))))

(global-set-key (kbd "C-x C-r") 'find-alternative-file-with-sudo)

; Disable version control for remote files
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

;(setq tramp-verbose 3)
