;; selection highlight
(delete-selection-mode 1) 

;; show line numbers
(line-number-mode 1) 

;; show column number
(column-number-mode 1) 

;; show matching parens
(show-paren-mode 1)

;; show current function
(which-func-mode 1)  

;; auto-complete
(icomplete-mode 1) 

;; paren highlight
(show-paren-mode 1) 

;; remove toolbar
(tool-bar-mode 0) 

;; remove menu
(menu-bar-mode 0) 

;; Turn off bugging yes-or-no-p
(fset 'yes-or-no-p 'y-or-n-p)

;; Default window navigation bindings
(windmove-default-keybindings)

;; Shell colors
(ansi-color-for-comint-mode-on)

;; Activate dired and tramp
(require 'dired)
(require 'dired-x)
(require 'wdired)
(require 'tramp)
