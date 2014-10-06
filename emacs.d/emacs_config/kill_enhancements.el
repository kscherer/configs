
;; Copied from http://www.emacswiki.org/emacs/WholeLineOrRegion
(defun my-kill-ring-save (beg end flash)
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end) nil)
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2) 'flash)))
  (kill-ring-save beg end))

(global-set-key [remap kill-ring-save] 'my-kill-ring-save)

(defadvice yank-pop (around kill-ring-browse-maybe (arg))
  "If last action was not a yank, run `browse-kill-ring' instead."
  (if (not (eq last-command 'yank))
      (browse-kill-ring)
    ad-do-it))

(ad-activate 'yank-pop)
