
(defun kms:base-minor-modes-hook ()
  (cua-mode 0)
  (local-set-key (kbd "C-v" ) 'cua-paste)
  (whitespace-mode 1)
  (auto-revert-mode 1)
  (subword-mode 1)
  )

(defun kms:default-mode-hook ()
  (kms:base-minor-modes-hook)
  (hl-line-mode 1)
  (visual-line-mode 1)
  (yas-minor-mode 1)
  (autopair-mode 1)
  (highlight-symbol-mode 1)
  (company-mode 1)
  (local-set-key (kbd "<C-tab>" ) 'company-complete)
  )

(defun kms:markdown-mode-hook ()
  (kms:base-minor-modes-hook)
  (visual-line-mode 1)
  (autopair-mode 1)
  (flyspell-mode 1)
  )

;In puppet I end up aligning resource block on the string => a lot
(defun kms:align-string-equals ()
  (interactive)
  (if (region-active-p)
      (align (region-beginning) (region-end))
    )
  )

(defun kms:puppet-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (local-set-key (kbd "C-M-=" ) 'kms:align-string-equals)
  )

(defun kms:shell-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (set (make-local-variable 'company-backends) '((company-yasnippet company-capf company-dabbrev-code)))
  )

(defun auto-byte-recompile ()
  "If the current buffer is in emacs-lisp-mode and there already exists an `.elc'
file corresponding to the current buffer file, then recompile the file."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(defun kms:emacs-lisp-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (add-hook 'after-save-hook 'auto-byte-recompile)
  (rainbow-delimiters-mode 1)
  )

(defun kms:clojure-mode-hook ()
  (kms:base-minor-modes-hook)
  (autopair-mode 1)
  (rainbow-delimiters-mode 1)
  )

;; If python-shell-virtualenv-root is set (perhaps using .dir-locals.el) when
;; flycheck is loaded it will search the virtualenv for python, pylint and flake8
(defun flycheck-virtualenv-executable-find (executable)
  "Find an EXECUTABLE in the current virtualenv if any."
  (if (bound-and-true-p python-shell-virtualenv-root)
      (let ((exec-path (python-shell-calculate-exec-path)))
        (executable-find executable))
    (executable-find executable)))

(defun flycheck-virtualenv-setup ()
  "Setup Flycheck for the current virtualenv."
  (setq-local flycheck-executable-find #'flycheck-virtualenv-executable-find))

(defun kms:python-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (flycheck-virtualenv-setup)

  (setq autopair-handle-action-fns
        (list #'autopair-default-handle-action
              #'autopair-python-triple-quote-action))

  (require 'dap-mode)
  (require 'dap-ui)
  (require 'dap-python)
  (dap-mode 1)
  (dap-ui-mode 1)
  ;; enables mouse hover support
  (dap-tooltip-mode 1)
  ;; use tooltips for mouse hover
  ;; if it is not enabled `dap-mode' will use the minibuffer.
  (tooltip-mode 1)

  (require 'lsp-python-ms)
  (lsp)
  (add-to-list 'company-backends 'company-lsp)
  (company-mode 1)
  (company-quickhelp-mode 1) ; enable help popups
  (tree-sitter-hl-mode)
  )

(defun kms:cpp-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  (autopair-mode 1)
  (c-mode)
  ; style I want to use in c++ mode
  (c-add-style "kms-style"
               '("stroustrup"
                 (indent-tabs-mode . nil)
                 (c-basic-offset . 4) ))

  (c-set-style "kms-style")        ; use my-style defined above
  (auto-fill-mode)
  (require 'ccls)
  (setq ccls-sem-highlight-method 'font-lock)
  (lsp)
  (add-to-list 'company-backends 'company-lsp)
  (company-mode 1)
  (company-quickhelp-mode 1) ; enable help popups
  (tree-sitter-hl-mode)
  )

(defun kms:org-mode-hook ()
  (kms:base-minor-modes-hook)
  (flyspell-mode 1)
  (visual-line-mode 1)
  (yas-minor-mode 1)
  )

;; go get -u github.com/nsf/gocode
;; go get -u github.com/rogpeppe/godef
;; go get -u golang.org/x/tools/cmd/goimports
;; go get -u github.com/jstemmer/gotags
(defun kms:go-mode-hook ()
  (kms:base-minor-modes-hook)
  (require 'company-go)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-to-list 'company-backends 'company-go)
  (company-mode 1)
  (local-set-key (kbd "<C-tab>" ) 'company-complete)
  (hl-line-mode 1)
  (visual-line-mode 1)
  (yas-minor-mode 1)
  (autopair-mode 1)
  (highlight-symbol-mode 1)
  (flycheck-mode 1)
  (go-eldoc-setup)
  (tree-sitter-hl-mode)
  )

(defun kms:groovy-mode-hook ()
  (kms:default-mode-hook)
  (flycheck-mode 1)
  )

(defun kms:terraform-mode-hook ()
  (kms:default-mode-hook)
  (terraform-mode)
  (require 'company-terraform)
  (company-terraform-init)
  (company-quickhelp-mode 1) ; enable help popups
  )

(add-hook 'emacs-lisp-mode-hook 'kms:emacs-lisp-mode-hook)
(add-hook 'puppet-mode-hook 'kms:puppet-mode-hook)
(add-hook 'sh-mode-hook 'kms:shell-mode-hook)
(add-hook 'python-mode-hook 'kms:python-mode-hook)
(add-hook 'ruby-mode-hook 'kms:default-mode-hook)
(add-hook 'org-mode-hook 'kms:org-mode-hook)
(add-hook 'markdown-mode-hook 'kms:markdown-mode-hook)
(add-hook 'clojure-mode-hook 'kms:clojure-mode-hook)
(add-hook 'c++-mode-hook 'kms:cpp-mode-hook)
(add-hook 'go-mode-hook 'kms:go-mode-hook)
(add-hook 'groovy-mode-hook 'kms:groovy-mode-hook)
(add-hook 'terraform-mode-hook 'kms:terraform-mode-hook)

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(provide 'mode-hooks)
