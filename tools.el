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

;; Word to Emacs 
;; (requieres antiword)
(autoload 'word-to-emacs (concat elisp-root "/tools/word-to-emacs"))
(add-to-list 'auto-mode-alist '("\\.doc\\'" . word-to-emacs))

;; In-place annotations
(require 'ipa)
;; Redefined to make annotations above the line 
(defun ipa-set-overlay-text (overlay text)
  (if (string-match ipa-annotation-id-regexp text)
      (setq text (match-string 2 text)))
  (save-excursion
    (beginning-of-line)
    (overlay-put overlay 'before-string
                 (if (equal text "")
                     ""
                   (propertize (concat "[" text "]\n") 'face ipa-annotation-face)))))
(defun ipa-create-overlay (pos text)
  (save-excursion
    (goto-char pos)
    (setq pos (point-at-bol))
    (let ((overlay (make-overlay pos pos nil t nil)))
     (ipa-set-overlay-text overlay text)
     (push (cons overlay text) ipa-annotations-in-buffer)
     (ipa-sort-overlays))))

(require 'htmlize)

;; Org-mode
(add-to-list 'load-path (concat elisp-root "/tools/git-emacs"))
(require 'org-install)

;; mark-stack
(add-to-list 'load-path (concat elisp-root "/tools/"))
(require 'marks)