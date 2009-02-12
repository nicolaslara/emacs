;; load git-emacs
(add-to-list 'load-path (concat elisp-root "/tools/git-emacs"))
(require 'git-emacs)
;; deactivates ido (which is loaded by git-emacs)
(ido-mode 0)

;; load cedet (if experiencing problems, recompile)
(add-to-list 'load-path (concat elisp-root "/tools/cedet/common"))
(load-file (concat elisp-root "/tools/cedet/common/cedet.el"))
(semantic-load-enable-excessive-code-helpers)

;; load Emacs Code Browser
(add-to-list 'load-path (concat elisp-root "/tools/ecb/"))
(load-file (concat elisp-root "/tools/ecb/ecb.el"))
(require 'ecb-autoloads)

;; load JDEE
(add-to-list 'load-path 
             (expand-file-name 
              (concat elisp-root "/tools/jde/lisp")))
(setq defer-loading-jde t)
(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
	    (append
	     '(("\\.java\\'" . jde-mode))
	     auto-mode-alist)))
  (require 'jde))

(defun my-jde-mode-hook ()
  (setq c-basic-offset 4))
(add-hook 'jde-mode-hook 'my-jde-mode-hook)

;; load auctex/preview-latex
(load (concat elisp-root "/tools/auctex/site-lisp/auctex.el") nil t t)
(load (concat elisp-root "/tools/auctex/site-lisp/preview-latex.el") nil t t)