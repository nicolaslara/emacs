;; set terminal variable
(if (eq window-system nil)
    "is it running from the terminal?"
    (setq terminal t)
  (setq terminal nil)
  )

;; set elisp-root variable
(setq elisp-root "/home/test/elisp")

;; No tabs, spaces
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Ispell program
(setq-default ispell-program-name "aspell")

;; Backups 
(setq
   backup-by-copying t ; don't clobber symlinks
   backup-directory-alist '(("." . "~/.emacs_backups")) ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
