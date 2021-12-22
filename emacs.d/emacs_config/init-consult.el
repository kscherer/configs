(require 'consult)

(global-set-key (kbd "C-x b") 'consult-buffer)

;; isearch integration
(global-set-key (kbd "M-s e") 'consult-isearch-history)

(define-key minibuffer-local-isearch-map (kbd "M-/") #'isearch-complete-edit)
(let ((map isearch-mode-map))
  (define-key map (kbd "C-g") #'isearch-cancel) ; instead of `isearch-abort'
  (define-key map (kbd "M-/") #'isearch-complete)
  (define-key map (kbd "M-e") #'consult-isearch-history)
  (define-key map (kbd "M-e") #'consult-isearch-history)
  (define-key map (kbd "<up>") #'isearch-repeat-backward)
  (define-key map (kbd "<down>") #'isearch-repeat-forward)
  )

;; be a little smarter in pulling up the kill-ring for pasting
(defun my/consult-yank-or-yank-pop (&optional arg)
  "Call `consult-yank'. If called after a yank, call `yank-pop' instead."
  (interactive "*p")
  (if (eq last-command 'yank)
      (yank-pop arg)
    (consult-yank-pop)))

(global-set-key (kbd "M-y") 'my/consult-yank-or-yank-pop)
(global-set-key (kbd "M-g M-g") 'consult-goto-line)
(global-set-key (kbd "M-g g") 'consult-goto-line)
