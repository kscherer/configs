(autoload 'clojure-mode "clojure-mode" "Major mode for editing clojure")
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(require 'clojure-mode)
(modify-syntax-entry ?_ "w" clojure-mode-syntax-table)
