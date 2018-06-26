; Copied from http://www.masteringemacs.org/articles/2012/09/10/hiding-replacing-modeline-strings/

(defvar mode-line-cleaner-alist
  '((company-mode . " C")
    (yas-minor-mode . " υ")
    (paredit-mode . " π")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . "")
    (whitespace-mode . "")
    (visual-line-mode . "")
    (highlight-symbol-mode . "")
    (auto-revert-mode . "")
    ;; Major modes
    (lisp-interaction-mode . "λ")
    (hi-lock-mode . "")
    (python-mode . "Py")
    (emacs-lisp-mode . "EL")
    (nxhtml-mode . "nx")
    )
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")


(defun clean-mode-line ()
  "Replace modeline lighters with new ones."
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let ((mode (car cleaner))
                 (mode-str (cdr cleaner)))
             (when (memq mode minor-mode-list)
                 (setcar (cdr (assq mode minor-mode-alist)) mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)
