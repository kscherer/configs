(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

(define-abbrev-table 'puppet-mode-abbrev-table '
  (
   ;; common words used in puppet files
   ("en" "ensure =>" nil 0)
   ("sou" "source =>" nil 0)
   ("dir" "directory" nil 0)
   ("ru" "running" nil 0)
   ("tr" "true" nil 0)
   ("fa" "false" nil 0)
   ))

(abbrev-mode 1)

;Specify regexp used to supply index entries used by imenu
(add-hook 'puppet-mode-hook
          (lambda ()
            (set-variable
             'imenu-generic-expression
             (list
              (list "class" "^class *\\([a-z0-9_:]+\\)" 1)
              ))))
