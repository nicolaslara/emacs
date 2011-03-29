(add-to-list 'load-path (concat elisp-root "/modes/"))

;; Loads Erlang mode
(load "erlang.el" nil t t)
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))

;; Loads ReST mode
(setq frame-background-mode 'dark)
(require 'rst)
(setq auto-mode-alist
      (append '(("\\.txt$" . rst-mode)
                ("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))

;; Loads js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; nxml-mode
(load (concat elisp-root "/modes/nxml/rng-auto.el"))
    
;; loads ruby-mode
(setq load-path (cons (concat elisp-root "/modes/ruby/") load-path))
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; Haskell Compiler (interactive)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

(setq load-path (cons (concat elisp-root "/modes/haskell/") load-path))
(load "haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))

(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)

(add-to-list 'auto-mode-alist '("\\.x\\'" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.y\\'" . haskell-mode))

;; What files to invoke the new html-mode for?
(add-to-list 'auto-mode-alist '("\\.inc\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.[sj]?html?\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))

;; GaCeLa mode
(autoload 'gcl-mode "gcl-mode")
(setq auto-mode-alist (append '(("\\.gcl\\'" . gcl-mode)) auto-mode-alist))

;; Django html-mode
(autoload 'django-html-mode "django-html-mode")
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\'" . django-html-mode))

;; Cheetah mode
(define-derived-mode cheetah-mode html-mode "Cheetah"
  (make-face 'cheetah-variable-face)
  (font-lock-add-keywords
   nil
   '(
     ("\(#\(from\|else\|try\|pass\|silent\|except\|include\|set\|import\|for\|if\|end\)+\)\>" 1 font-lock-type-face)
     ("\(#\(from\|for\|end\)\).*\<\(for\|import\|if\|try\|in\)\>" 3 font-lock-type-face)
     ("\(\$\(?:\sw\|}\|{\|\s_\)+\)" 1 font-lock-variable-name-face))
   )
  (font-lock-mode 1)
  )
(setq auto-mode-alist (cons '( "\.tmpl'" . cheetah-mode ) auto-mode-alist ))

;; Clojure mode
(add-to-list 'load-path (concat elisp-root "/modes/clojure-mode//"))
(require 'clojure-mode)

;; Javascript mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)