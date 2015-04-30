(require 'ido)
(require 'flx-ido)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      confirm-nonexistent-file-or-buffer nil
      ido-max-prospects 10
      ido-default-file-method 'selected-window
      ido-auto-merge-work-directories-length -1)

(ido-mode t)
;; smarter fuzzy matching for ido
(flx-ido-mode t)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

;; see https://github.com/lewang/flx
(setq gc-cons-threshold 20000000)
