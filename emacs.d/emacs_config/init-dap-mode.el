(require 'dap-mode)

(define-key dap-mode-map (kbd "<f7>") 'dap-breakpoint-toggle)
(define-key dap-mode-map (kbd "<f8>") 'dap-continue)
(define-key dap-mode-map (kbd "<f9>") 'dap-next)
(define-key dap-mode-map (kbd "<f10>") 'dap-step-in)
(define-key dap-mode-map (kbd "<f10>") 'dap-step-out)
(define-key dap-mode-map (kbd "<f12>") 'dap-debug)
