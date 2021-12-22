(require 'plantuml-mode)

;; Sample jar configuration
(setq plantuml-jar-path "/home/kscherer/bin/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
(setq plantuml-output-type "png")

;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
