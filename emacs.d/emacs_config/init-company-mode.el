(require 'company)
(setq company-idle-delay 0.3)
(add-to-list 'company-backends 'company-cider)
(add-to-list 'company-backends 'company-clang)
