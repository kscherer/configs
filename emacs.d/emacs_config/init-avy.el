(require 'avy)

(setq avy-keys
      '(?c ?a ?s ?d ?e ?f ?h ?w ?y ?j ?k ?l ?n ?m ?v ?r ?u ?p))

(global-set-key (kbd "C-j") 'avy-goto-word-1)
