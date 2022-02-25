(setq lsp-prefer-flymake nil)
(setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))

(add-hook 'hack-local-variables-hook
          (lambda ()
            (when (derived-mode-p 'python-mode)
              (require 'lsp-python-ms)
              (lsp-deferred))))
