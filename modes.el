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
