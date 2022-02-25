(set-frame-font "Noto Mono-10")
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

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(require 'el-get-elpa)
   ;; Build the El-Get copy of the package.el packages if we have not
   ;; built it before.  Will have to look into updating later ...
   (unless (file-directory-p el-get-recipe-path-elpa)
       (package-refresh-contents)
       (el-get-elpa-build-local-recipes))

(add-to-list 'el-get-recipe-path "~/.emacs.d/local_recipes")
(setq el-get-user-package-directory "~/.emacs.d/emacs_config")

(setq my:el-get-packages
      '(autopair
        goto-last-change
        magit
        highlight-symbol
        tabbar
        undo-tree
        browse-kill-ring
        yasnippet
        rfringe
        flycheck

        ;; language modes
        puppet-mode
        yaml-mode
        clojure-mode cider
        go-mode go-eldoc
        ledger-mode
        markdown-mode
        org-mode
        org-reveal
        terraform-mode
        hcl-mode
        groovy-mode

        edit-server
        color-theme-solarized
        expand-region
        key-chord
        pp-c-l
        avy s which-key
        rainbow-delimiters
        queue let-alist cl-lib
        company-mode beacon
        company-quickhelp pos-tip
        company-prescient
        lsp-mode lsp-ui lsp-python-ms
        dap-mode
        all-the-icons
        doom-modeline
        ace-window
        consult consult-flycheck consult-lsp
        prescient
        selectrum selectrum-prescient
        tree-sitter tree-sitter-indent tree-sitter-langs
        ;;swiper
        ;;fastnav
        ;;smex
        ;;flx
        ;;multiple-cursors
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
              "hippie-setup" "company-go"
              ))
