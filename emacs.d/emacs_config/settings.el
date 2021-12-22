(require 'functions)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

(mouse-wheel-mode t)                           ; Mouse-wheel enabled
(setq-default indent-tabs-mode nil)            ; Use spaces instead of tabs
(global-font-lock-mode 1)                      ; Color enabled
(setq font-lock-maximum-decoration t)
(show-paren-mode 1)                            ; Highlight parenthesis pairs
(setq blink-matching-paren-distance nil)       ; Blinking parenthesis
(setq show-paren-style 'parenthesis)           ; Highlight text between parens
(blink-cursor-mode 0)                          ; No blinking cursor
(setq-default indicate-empty-lines t)          ; Show empty lines
(setq require-final-newline 't)                ; Always newline at end of file
(setq next-line-add-newlines nil)              ; Add newline when at buffer end
;(icomplete-mode t)                             ; Completion in mini-buffer
(setq frame-title-format "%b - emacs")         ; Use buffer name as frame title
(setq ispell-dictionary "english")             ; Set ispell dictionary
(setq calendar-week-start-day 1)               ; Week starts monday
;(setq disabled-command-hook nil)               ; Allow all disabled commands
(setq undo-limit 10000)                        ; Increase number of undo
(mouse-avoidance-mode 'jump)                   ; Mouse avoids cursor
(setq echo-keystrokes 0.1)
(setq inhibit-startup-screen t)
(delete-selection-mode t)               ; region is replaced by text
(setq browse-kill-ring-quit-action 'save-and-restore)
(setq load-prefer-newer t)  ; ignore older .elc files
(setq initial-scratch-message nil)
(setq split-height-threshold nil) ; favor spliting screen vertically
(setq split-width-threshold 160)

(setq view-read-only t) ; use view mode keybindings on all read only buffers

;(setq cua-prefix-override-inhibit-delay 1.0)

;; force default for all modes
(setq-default tab-width 4)

;make the y or n suffice for a yes or no question
(fset 'yes-or-no-p 'y-or-n-p)

;;Text mode is happier than Fundamental mode ;-)
(setq major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Default to unified diffs
(setq diff-switches "-u")

;; make emacs use the clipboard
(setq select-enable-clipboard t)

;; Transparently open compressed files
(auto-compression-mode t)

 ;; Tabbar
(require 'tabbar)
(tabbar-mode 1)
(global-set-key (kbd "<C-next>") 'tabbar-forward-tab)
(global-set-key (kbd "<C-prior>") 'tabbar-backward-tab)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(autoload 'linum-mode "linum" "toggle line numbers on/off" t)
(global-set-key (kbd "C-<f5>") 'linum-mode)

(mapc
     (lambda (pair)
       (if (eq (cdr pair) 'perl-mode)
           (setcdr pair 'cperl-mode)))
     (append auto-mode-alist interpreter-mode-alist))
(setq cperl-hairy t) ;; Turns on most of the CPerlMode options
(setq cperl-electric-parens nil)

(setq
  scroll-step 1
  scroll-margin 3
  scroll-conservatively 100000
  scroll-up-aggressively 0.0
  scroll-down-aggressively 0.0
  scroll-preserve-screen-position t)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Initialize emacs server if it is not already running
(require 'server)
(if (not (eq t (server-running-p server-name)))
    (server-start))

;; Save minibuffer history
(savehist-mode 1)

;; turn on save place so that when opening a file, the cursor will be at the last position.
(require 'saveplace)
(setq-default save-place t)

(require 'recentf)
(setq recentf-menu-before "Close")
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(recentf-mode 1)

;; When turning on flyspell-mode, automatically check the entire buffer.
;; Why this isn't the default baffles me.
(defadvice flyspell-mode (after advice-flyspell-check-buffer-on-start activate)
  (flyspell-buffer))

;; ----------------------------------------------------------------------------
;; Make emacs open all files in last emacs session.
;;
;; This functionality is provided by desktop-save-mode (“feature”
;; name: “desktop”). The mode is not on by default in emacs 23, and
;; has a lot options. The following is init settings for the mode for
;; ErgoEmacs.
;;
;; Goal: have emacs always auto open the set of opend files in last
;; session, even if emacs crashed in last session or the OS crashed in
;; last session. Also, don't bother users by asking questions like “do
;; you want to save desktop?” or “do you want to override last session
;; file?”, because these are annoying and terms like “session” or
;; “desktop” are confusing to most users because it can have many
;; meanings.

;; Some tech detail: set the desktop session file at
;; ‹user-emacs-directory› (default is “~/.emacs.d/.emacs.desktop”).  This file
;; is our desktop file. It will be auto created and or over-written.
;; if a emacs expert has other desktop session files elsewhere, he can
;; still use or manage those.

(require 'desktop)

(defun desktop-settings-setup ()
  "Some settings setup for desktop-save-mode."
  (interactive)

  ;; At this point the desktop.el hook in after-init-hook was
  ;; executed, so (desktop-read) is avoided.
  (when (not (eq (emacs-pid) (desktop-owner))) ; Check that emacs did not load a desktop yet
    ;; Here we activate the desktop mode
    (desktop-save-mode 1)

    ;; The default desktop is saved always
    (setq desktop-save t)

    ;; The default desktop is loaded anyway if it is locked
    (setq desktop-load-locked-desktop t)

    ;; Set the location to save/load default desktop
    (setq desktop-dirname user-emacs-directory)

    ;; Make sure that even if emacs or OS crashed, emacs
    ;; still have last opened files.
    (add-hook 'find-file-hook
              (lambda ()
                (run-with-timer 5 nil
                                (lambda ()
                                  ;; Reset desktop modification time so the user is not bothered
                                  (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name))))
                                  (desktop-save user-emacs-directory)))))

    ;; Read default desktop
    (if (file-exists-p (concat desktop-dirname desktop-base-file-name))
        (desktop-read desktop-dirname))

    ;; Add a hook when emacs is closed to we reset the desktop
    ;; modification time (in this way the user does not get a warning
    ;; message about desktop modifications)
    (add-hook 'kill-emacs-hook
              (lambda ()
                ;; Reset desktop modification time so the user is not bothered
                (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name))))))
    )
  )

(add-hook 'after-init-hook
          'desktop-settings-setup
          (lambda ()
            ;; No splash screen
            (setq inhibit-startup-screen t)

            ;; If the *scratch* buffer is the current one, then create a new
            ;; empty untitled buffer to hide *scratch*
            (if (string= (buffer-name) "*scratch*")
                (new-empty-buffer))
            )
          t) ;; append this hook to the tail

;; automatically indenting yanked text if in programming-modes
(defvar yank-indent-modes '(emacs-lisp-mode
                            c-mode c++-mode
                            tcl-mode sql-mode
                            perl-mode cperl-mode
                            java-mode jde-mode
                            lisp-interaction-mode
                            LaTeX-mode TeX-mode
                            puppet-mode sh-mode)
  "Modes in which to indent regions that are yanked (or yank-popped)")

(defvar yank-advised-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur.")

(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) yank-advised-indent-threshold)
      (indent-region beg end nil)))

(defadvice yank (after yank-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
      (let ((transient-mark-mode nil))
        (yank-advised-indent-function (region-beginning) (region-end)))))

(defadvice yank-pop (after yank-pop-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
      (let ((transient-mark-mode nil))
        (yank-advised-indent-function (region-beginning) (region-end)))))

(setq completion-ignore-case t                 ;; ignore case when completing...
      read-file-name-completion-ignore-case t) ;; ...filenames too

;; Change cursor color according to mode; inspired by
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically
(setq djcb-read-only-color       "gray")
;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for set-cursor-type

(setq djcb-read-only-cursor-type 'hbar)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "#839496")
(setq djcb-normal-cursor-type    'box)

(defun djcb-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."

  (cond
    (buffer-read-only
      (set-cursor-color djcb-read-only-color)
      (setq cursor-type djcb-read-only-cursor-type))
    (overwrite-mode
      (set-cursor-color djcb-overwrite-color)
      (setq cursor-type djcb-overwrite-cursor-type))
    (t
      (set-cursor-color djcb-normal-color)
      (setq cursor-type djcb-normal-cursor-type))))

(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(defvar recently-closed-buffers (cons nil nil) "A list of recently closed buffers. The max number to track is controlled by the variable recently-closed-buffers-max.")
(defvar recently-closed-buffers-max 10 "The maximum length for recently-closed-buffers.")

(defun close-current-buffer ()
"Close the current buffer.

Similar to (kill-buffer (current-buffer)) with the following addition:

• prompt user to save if the buffer has been modified even if the buffer is not associated with a file.
• make sure the buffer shown after closing is a user buffer.
• if the buffer is a file, add the path to the list recently-closed-buffers.

A emacs buffer is one who's name starts with *.
Else it is a user buffer."
 (interactive)
 (let (emacsBuff-p isEmacsBufferAfter)
   (if (string-match "^*" (buffer-name))
       (setq emacsBuff-p t)
     (setq emacsBuff-p nil))

   ;; offer to save buffers that are non-empty and modified, even for non-file visiting buffer. (because kill-buffer does not offer to save buffers that are not associated with files)
   (when (and (buffer-modified-p)
              (not emacsBuff-p)
              (not (string-equal major-mode "dired-mode"))
              (if (equal (buffer-file-name) nil)
                  (if (string-equal "" (save-restriction (widen) (buffer-string))) nil t)
                t
                )
              )
     (if (y-or-n-p
            (concat "Buffer " (buffer-name) " modified; Do you want to save?"))
       (save-buffer)
       (set-buffer-modified-p nil)))

   ;; save to a list of closed buffer
   (when (not (equal buffer-file-name nil))
     (setq recently-closed-buffers
           (cons (cons (buffer-name) (buffer-file-name)) recently-closed-buffers))
     (when (> (length recently-closed-buffers) recently-closed-buffers-max)
           (setq recently-closed-buffers (butlast recently-closed-buffers 1))
           )
     )

   ;; close
   (kill-buffer (current-buffer))

   ;; if emacs buffer, switch to a user buffer
   (if (string-match "^*" (buffer-name))
       (setq isEmacsBufferAfter t)
     (setq isEmacsBufferAfter nil))
   (when isEmacsBufferAfter
     (next-user-buffer)
     )
   )
 )

(defun open-last-closed ()
  "Open the last closed file."
  (interactive)
  (find-file (cdr (pop recently-closed-buffers)) ) )

(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(require 'whitespace)
(setq whitespace-style (quote (face tabs tabs-mark trailing lines-tail)))
(setq whitespace-line-column 100)
(set-face-foreground 'whitespace-tab "red4")

;; http://endlessparentheses.com/faster-pop-to-mark-command.html
(setq set-mark-command-repeat-pop t)
(defun modi/multi-pop-to-mark (orig-fun &rest args)
  "Call ORIG-FUN until the cursor moves.
  Try the repeated popping up to 10 times."
  (let ((p (point)))
    (dotimes (i 10)
      (when (= p (point))
        (apply orig-fun args)))))

(advice-add 'pop-to-mark-command :around #'modi/multi-pop-to-mark)
