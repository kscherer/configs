(defconst kms:backup-dir "~/.emacs.d/backup/" "")

(setq backup-by-copying t)      ; don't clobber symlinks

(setq backup-directory-alist
      `((".*" . ,kms:backup-dir)))

(setq auto-save-file-name-transforms
      `((".*" ,kms:backup-dir t)))

(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files kms:backup-dir t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message file)
      (delete-file file))))

