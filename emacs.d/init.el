;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  )

(toggle-fullscreen)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/local_recipes")
(setq el-get-user-package-directory "~/.emacs.d/emacs_config")

(setq my:el-get-packages
       '(auto-complete autopair goto-last-change
         magit org-mode org-reveal
         smex highlight-symbol tabbar
         undo-tree yasnippet fastnav
         rfringe flycheck puppet-mode
         edit-server ledger-mode color-theme-solarized expand-region
         key-chord pp-c-l yaml-mode multiple-cursors
         avy clojure-mode s cider which-key
         paredit rainbow-delimiters markdown-mode flx helm
         queue cl-lib jedi virtualenvwrapper
         company-mode pymacs beacon hungry-delete
         )
       )
(el-get 'sync my:el-get-packages)

(setq custom-file "~/.emacs.d/emacs_config/custom.el")
(load custom-file 'noerror)

; my configuration files
(add-to-list 'load-path "~/.emacs.d/emacs_config/")

;; load my configuration files with load so elc gets picked up
(mapc 'load '("settings" "open_line_config" "backup_config"
              "vi_emulation" "kill_enhancements" "tramp_config"
              "mode-hooks" "global-keys" "global_abbrev"
              "clean-mode-line" "ido-goto-symbol" "toggle-quotes"
              "hippie-setup"
              ))
