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
