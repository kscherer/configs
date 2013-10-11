
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
                                        ;(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-indent-indentation-per-level 1)
(setq org-agenda-files (file-expand-wildcards "~/.emacs.d/org/*.org"))

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (org-set-local 'yas-trigger-key [tab])
;;             (define-key yas-keymap [tab] 'yas-next-field-group)))

;; Make lines not dissapear into the right margin while in org-mode
;(add-hook 'org-mode-hook 'soft-wrap-lines)

;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Show lot sof clocking history so it's easy to pick items off the C-F11 list
;(setq org-clock-history-length 36)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Save clock data and state changes and notes in the LOGBOOK drawer
;(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(global-set-key (kbd "<f12>") 'org-clock-in)
(global-set-key (kbd "M-<f12>") 'org-clock-out)

;; enable exporters for org-mode
(setq org-export-backends (quote (beamer html)))
