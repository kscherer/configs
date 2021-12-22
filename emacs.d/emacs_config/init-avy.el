(require 'avy)

(setq avy-keys
      '(?c ?a ?s ?d ?e ?f ?h ?j ?n ?l ?n ?v ?r ?u ?p))

(global-set-key (kbd "C-j") 'avy-goto-char-timer)

(defun avy-action-kill-whole-line (pt)
  (save-excursion
    (goto-char pt)
    (kill-whole-line))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

(defun avy-action-copy-whole-line (pt)
  (save-excursion
    (goto-char pt)
    (cl-destructuring-bind (start . end)
        (bounds-of-thing-at-point 'line)
      (copy-region-as-kill start end)))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

(defun avy-action-yank-whole-line (pt)
  (avy-action-copy-whole-line pt)
  (save-excursion (yank))
  t)

;; (defcustom avy-dispatch-alist
;;   '((?x . avy-action-kill-move)
;;     (?X . avy-action-kill-stay)
;;     (?t . avy-action-teleport)
;;     (?m . avy-action-mark)
;;     (?n . avy-action-copy)
;;     (?y . avy-action-yank)
;;     (?Y . avy-action-yank-line)
;;     (?i . avy-action-ispell)
;;     (?z . avy-action-zap-to-char))

(setf
 (alist-get ?w avy-dispatch-alist) 'avy-action-copy
 (alist-get ?W avy-dispatch-alist) 'avy-action-copy-whole-line
 (alist-get ?K avy-dispatch-alist) 'avy-action-kill-whole-line
 )

