(require 'company)
(global-company-mode -1)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-complete)
  (define-key company-active-map (kbd "TAB") #'company-complete)
  (setq company-frontends
        '(company-pseudo-tooltip-unless-just-one-frontend
          company-preview-frontend
          company-echo-metadata-frontend)
        company-format-margin-function #'company-vscode-dark-icons-margin
        company-backends '(company-capf :with company-yasnippet)
        company-require-match 'never
        )
  )
