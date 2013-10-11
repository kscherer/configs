;;custom global keybindins not part of another package
(defun move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1)
  )

(defun move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1)
  )

(global-set-key (kbd "M-h") 'backward-delete-char-untabify)
(global-set-key (kbd "M-H") 'subword-backward-kill)

(global-set-key (kbd "C-o") 'move-cursor-next-pane)
(global-set-key (kbd "C-O") 'move-cursor-previous-pane)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-x k") 'close-current-buffer)
(global-set-key (kbd "C-S-t") 'open-last-closed)

;; Use shell-like backspace C-h, rebind help to F1
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "<f1>") 'help-command)

;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

;; mimic vim j for join
(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1))) 

