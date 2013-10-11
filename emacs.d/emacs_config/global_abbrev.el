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

;; stop asking whether to save newly added abbrev when quitting emacs
(setq save-abbrevs nil)

;; turn on abbrev mode
(setq default-abbrev-mode t)
