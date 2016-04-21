(define-abbrev-table 'global-abbrev-table '
  (
   ;; normal english words
   ("8alt" "alternative" nil 0)
   ("8char" "character" nil 0)
   ("8def" "definition" nil 0)
   ("8bg" "background" nil 0)
   ("8kb" "keyboard" nil 0)
   ("8ex" "example" nil 0)
   ("8kbd" "keybinding" nil 0)
   ("8env" "environment" nil 0)
   ("8var" "variable" nil 0)
   ("8ev" "environment variable" nil 0)
   ("8cp" "computer" nil 0)
   ("inf" "infrastructure" nil 0)
   ("pup" "puppet" nil 0)
   ("ott" "Ottawa" nil 0)
   ("8ala" "Alameda" nil 0)
   ("amq" "ActiveMQ" nil 0)
   ))

;; http://endlessparentheses.com/ispell-and-abbrev-the-perfect-auto-correct.html
(define-key ctl-x-map "\C-p"
  #'endless/ispell-word-then-abbrev)

(defun endless/simple-get-word ()
  (car-safe (save-excursion (ispell-get-word nil))))

(defun endless/ispell-word-then-abbrev (p)
  "Call `ispell-word', then create an abbrev for it.
  With prefix P, create local abbrev. Otherwise it will
  be global.
  If there's nothing wrong with the word at point, keep
  looking for a typo until the beginning of buffer. You can
  skip typos you don't want to fix with `SPC', and you can
  abort completely with `C-g'."
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (if (setq bef (endless/simple-get-word))
                 ;; Word was corrected or used quit.
                 (if (ispell-word nil 'quiet)
                     nil ; End the loop.
                   ;; Also end if we reach `bob'.
                   (not (bobp)))
               ;; If there's no word at point, keep looking
               ;; until `bob'.
               (not (bobp)))
        (backward-word)
        (backward-char))
      (setq aft (endless/simple-get-word)))
    (if (and aft bef (not (equal aft bef)))
        (let ((aft (downcase aft))
              (bef (downcase bef)))
          (define-abbrev
            (if p local-abbrev-table global-abbrev-table)
            bef aft)
          (message "\"%s\" now expands to \"%s\" %sally"
                   bef aft (if p "loc" "glob")))
      (user-error "No typo at or before point"))))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)
