(require 'flycheck)
(setq-default flycheck-emacs-lisp-load-path 'inherit)
;; Run pylint if flake8 does not return any errors
(flycheck-add-next-checker 'python-flake8 'python-pylint)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
