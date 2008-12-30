;;
;; Emacs configuration file
;; 2008 Dic 26
;; Nicolas Lara
;;


(add-to-list 'load-path "/home/test/elisp" t)

(load-library "variables")
(load-library "native")
(load-library "colors") ;;depends on variables
(load-library "functions")
(load-library "modes")
(load-library "keys")

