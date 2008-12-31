;; load git-emacs
(add-to-list 'load-path (concat elisp-root "/tools/git-emacs"))
(require 'git-emacs)

;; load cedet (if experiencing problems, recompile)
(load-file (concat elisp-root "/tools/cedet/common/cedet.el"))
(semantic-load-enable-excessive-code-helpers)