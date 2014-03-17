;autocomplete
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

;;----------------------------------------------------------------------------
;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
;;----------------------------------------------------------------------------
;; (setq tab-always-indent 'complete)  ;; use 'complete when auto-complete is disabled
;; (add-to-list 'completion-styles 'initials t)

;; hook AC into completion-at-point
;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (setq completion-at-point-functions '(auto-complete)))
;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(setq ac-use-fuzzy nil)
(setq ac-use-menu-map t)

;; Use tab and return to complete
(define-key ac-completing-map (kbd "<return>") nil)
(define-key ac-completing-map (kbd "<tab>") 'ac-complete)
(define-key ac-menu-map (kbd "<tab>") 'ac-complete)
(define-key ac-menu-map (kbd "<return>") 'ac-complete)

;; show menu
(setq ac-auto-show-menu t)

;don't show help popups
(setq ac-use-quick-help nil)

;; expand full entry, not just common part
(setq ac-expand-on-auto-complete nil)

;disable auto-completion after certain words
(add-hook 'sh-mode-hook
          (lambda ()
            (make-local-variable 'ac-ignores)
            (add-to-list 'ac-ignores "fi")))

(add-hook 'ruby-mode-hook
          (lambda ()
            (make-local-variable 'ac-ignores)
            (add-to-list 'ac-ignores "end")))
