(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-delay 0.1)
 '(ibuffer-expert t)
 '(magit-commit-ask-to-stage nil)
 '(magit-save-some-buffers (quote dontask))
 '(magit-stage-all-confirm nil)
 '(org-structure-template-alist
   (quote
    (("a" . "export ascii")
     ("c" . "center")
     ("C" . "comment")
     ("e" . "example")
     ("E" . "export")
     ("h" . "export html")
     ("l" . "export latex")
     ("q" . "quote")
     ("s" . "src")
     ("v" . "verse"))))
 '(package-selected-packages (quote (go-mode f gl-conf-mode queue let-alist)))
 '(safe-local-variable-values
   (quote
    ((eval progn
           (setq python-shell-virtualenv-root
                 (concat
                  (locate-dominating-file default-directory dir-locals-file)
                  "/.venv")))
     (encoding . utf-8))))
 '(sh-indent-comment t)
 '(tab-width 4)
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
