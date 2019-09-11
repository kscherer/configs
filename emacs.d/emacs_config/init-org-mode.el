(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-indent-indentation-per-level 1)
(setq org-agenda-files (file-expand-wildcards "~/.emacs.d/org/*.org"))

(setq org-html-validation-link nil)

;; enable exporters for org-mode
(setq org-export-backends (quote (beamer html)))

;; enable plantuml babel backend
(require 'ob-plantuml)
(require 'ob-ditaa)
(setq org-plantuml-jar-path "/home/kscherer/bin/plantuml.jar")
(defun my-org-confirm-babel-evaluate (lang body)
  (not (or (string= lang "plantuml") (string= lang "ditaa"))))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
