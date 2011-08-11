(global-set-key [f11] 'fullscreen)
(global-set-key [f10] 'scroll-bar-mode)
(global-set-key [f9] 'cross)
(global-set-key [f8] 'make-frame-on-display)
(global-set-key [f7] 'publish-buffer)
(global-set-key [f6] 'set-frame-name)
(global-set-key [f5] 'goto-line)
;(get-ip-address "wlan0")
(global-set-key [delete] 'delete-char)
(global-set-key [backspace] 'delete-backward-char)
;(global-set-key (kbd "M-<up>") 'move-line-up)
;(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "C-x )") 'goto-matching-paren)
(global-set-key (kbd "M-C-f") 'find-file-at-point)

;; disable insert key
(global-set-key [insert] (lambda () (interactive)))
(global-set-key [insertchar] (lambda () (interactive)))

;; Make the <backspace> key scroll backwards in Info mode
(define-key isearch-mode-map [backspace] 'isearch-delete-char)

;; Better middle mouse button interaction
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;mark-stack
(global-set-key (kbd "C-x <next>") 'local-push-mark)
(global-set-key (kbd "C-x <prior>") 'local-pop-mark)
(global-set-key (kbd "C-x S-<prior>") 'global-pop-mark)
