(require 'flycheck)
;; Run pylint if flake8 does not return any errors
(flycheck-add-next-checker 'python-flake8 'python-pylint)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
