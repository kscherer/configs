
(defun kms:base-minor-modes-hook ()
  (cua-mode 1)
  (whitespace-mode 1)
  (auto-revert-mode 1)
  (subword-mode 1)
  )

(defun kms:default-mode-hook ()
  (kms:base-minor-modes-hook)
  (auto-complete-mode 1)
  (local-set-key (kbd "<C-tab>" ) 'auto-complete)
  (hl-line-mode 1)
  (visual-line-mode 1)
  (yas-minor-mode 1)
  (autopair-mode 1)
  (highlight-symbol-mode 1)
  )

(defun kms:markdown-mode-hook ()
  (kms:base-minor-modes-hook)
  (auto-complete-mode 1)
  (local-set-key (kbd "<C-tab>" ) 'auto-complete)
  (visual-line-mode 1)
  (autopair-mode 1)
  (flyspell-mode 1)
  )

;In puppet I end up aligning resource block on the string => a lot
(defun kms:align-string-equals ()
  (interactive)
  (if (region-active-p)
      (align-string (region-beginning) (region-end) "=" 1)
    )
  )

(defun kms:puppet-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (local-set-key (kbd "C-M-=" ) 'kms:align-string-equals)
  (setq ac-sources (append '(ac-source-yasnippet) ac-sources))
  )

(defun kms:shell-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (make-local-variable 'ac-ignores)
  (add-to-list 'ac-ignores "fi")
  )

(defun auto-byte-recompile ()
  "If the current buffer is in emacs-lisp-mode and there already exists an `.elc'
file corresponding to the current buffer file, then recompile the file."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(defun kms:emacs-lisp-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (add-hook 'after-save-hook 'auto-byte-recompile)
  )

(defun kms:clojure-mode-hook ()
  (kms:base-minor-modes-hook)
  (paredit-mode 1)
  (rainbow-delimiters-mode 1)
  )

(defun kms:python-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (jedi:setup)
  )

(defun kms:cpp-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  ; style I want to use in c++ mode
  (c-add-style "kms-style"
               '("stroustrup"
                 (indent-tabs-mode . nil)
                 (c-basic-offset . 4) ))

  (c-set-style "kms-style")        ; use my-style defined above
  (auto-fill-mode)
  (c-toggle-electric-state -1)
  (c-toggle-auto-hungry-state 1)
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
  )

(add-hook 'emacs-lisp-mode-hook 'kms:emacs-lisp-mode-hook)
(add-hook 'puppet-mode-hook 'kms:puppet-mode-hook)
(add-hook 'sh-mode-hook 'kms:shell-mode-hook)
(add-hook 'python-mode-hook 'kms:python-mode-hook)
(add-hook 'ruby-mode-hook 'kms:default-mode-hook)
(add-hook 'org-mode-hook 'kms:base-minor-modes-hook)
(add-hook 'markdown-mode-hook 'kms:markdown-mode-hook)
(add-hook 'clojure-mode-hook 'kms:clojure-mode-hook)
(add-hook 'c++-mode-hook 'kms:cpp-mode-hook)

(provide 'mode-hooks)
