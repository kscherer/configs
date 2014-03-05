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

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(el-get 'sync)

(setq el-get-user-package-directory "~/.emacs.d/emacs_config")
(add-to-list 'el-get-recipe-path "~/.emacs.d/local_recipes")

(setq my-packages
      (append
       '(el-get autopair el-get goto-last-change magit
                org-mode puppet-mode smex highlight-symbol tabbar
                undo-tree yasnippet fastnav rfringe flycheck
                edit-server ledger-mode color-theme-solarized expand-region
                key-chord pp-c-l yaml-mode multiple-cursors
                ace-jump-mode clojure-mode s cider
                paredit rainbow-delimiters markdown-mode flx helm
                ido-ubiquitous cl-lib git-modes company-mode
                )
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

(setq custom-file "~/.emacs.d/emacs_config/custom.el")
(load custom-file 'noerror)

; need to add these to the path so that byte cache will work
(add-to-list 'load-path "~/.emacs.d/emacs_config/")

;; default emacs configuration directory
(defconst kms:emacs-config-dir "/home/kscherer/.emacs.d/emacs_config/" "")

;; utility finction to auto-load my package configurations
(defun kms:load-config-file (filelist)
  (dolist (file filelist)
    (load (expand-file-name
           (concat kms:emacs-config-dir file)))
    (message "Loaded config file:%s" file)
    ))

;; load my configuration files
(kms:load-config-file '(
                        "settings.el"
                        "open_line_config.el"
                        "backup_config.el"
                        "vi_emulation.el"
                        "kill_enhancements.el"
                        "tramp_config.el"
                        "mode-hooks.el"
                        "global-keys.el"
                        "global_abbrev.el"
                        "clean-mode-line.el"
                        "ido-goto-symbol.el"
                        "toggle-quotes.el"
                        "hippie-setup.el"
                        ))
