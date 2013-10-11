;; flymake-puppet.el --- Flymake support for puppet
;; Deepak Giridharagopal <deepak@brownman.org>
(require 'flymake)
(require 'rfringe)
(require 'flymake-cursor)

(defconst flymake-puppet-err-line-patterns
  '(("\\(.*line \\([0-9]+\\).*\\)" nil 2 nil 1)
    ("\\(.*.rb:[0-9]+.*\\)" nil nil nil 1)
    ("Error: Could not parse for environment .+: \\(.+\\) at \\(.+\\):\\([0-9]+\\)" 2 3 nil 1))
  )

(defun flymake-puppet-create-temp-in-system-tempdir (file-name prefix)
  "Return a temporary file name into which flymake can save buffer contents.

  This is tidier than `flymake-create-temp-inplace', and therefore
  preferable when the checking doesn't depend on the file's exact
  location."
  (make-temp-file (or prefix "flymake-puppet") nil ".pp"))

(defun flymake-puppet-init ()
  "Construct a command that flymake can use to check puppetscript source."
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-copy))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "puppet-lint" (list local-file))))

(defun flymake-puppet-load ()
  "Configure flymake mode to check the current buffer's puppet syntax.

  This function is designed to be called in `puppet-mode-hook'; it
  does not alter flymake's global configuration, so function
  `flymake-mode' alone will not suffice."
  (interactive)
  (set (make-local-variable 'flymake-allowed-file-name-masks) '(("\\.pp$" flymake-puppet-init)))
  (set (make-local-variable 'flymake-err-line-patterns) flymake-puppet-err-line-patterns)
  (if (executable-find "puppet-lint")
      (flymake-mode t)
    (message "Not enabling flymake: puppet-lint command not found")))

(provide 'flymake-puppet)
