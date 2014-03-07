(require 'yasnippet)
(yas-global-mode -1)
(setq yas-prompt-functions (quote (yas-completing-prompt yas-ido-prompt yas-no-prompt)))
(yas-reload-all)
