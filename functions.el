;; fullscreen
;; ----------
;; make the window fullscreen
;;
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;; goto-matching-paren
;; -------------------
;; If point is sitting on a parenthetic character, jump to its match.
;; This matches the standard parenthesis highlighting for determining which
;; one it is sitting on.
;;
(defun goto-matching-paren ()
  "If point is sitting on a parenthetic character, jump to its match."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1))
        ((progn
           (backward-char 1)
           (looking-at "\\s\)")) (forward-char 1) (backward-list 1))))

;; move-line
(defun move-line (n)
  "Move the current line up or down by N lines."
  (let ((col  0) (start 0) (end 0)) 
    (setq col (current-column))
    (beginning-of-line) (setq start (point))
    (end-of-line) (forward-char) (setq end (point))
    (let ((line-text (delete-and-extract-region start end)))
      (forward-line n)
      (insert line-text)
      (forward-line -1)
      (forward-char col))))

;; move-line-up
(defun move-line-up (n)
  "Move the current line up by N lines. Default 1"
(interactive "p")
(move-line (if (null n) -1 (- n))))

;; move-line-down
(defun move-line-down (n)
"Move the current line down by N lines. Default 1"
(interactive "p")
(move-line (if (null n) 1 n)))

;; line and column highlighting
(require 'vline)
(defun cross ()
  (interactive)
  (hl-line-mode)
  (vline-mode))

;; Print number of words in the region.
(defun count-words (start end)
  "Print number of words in the region."
  (interactive "r")
  (save-excursion
    (let ((n 0))
      (goto-char start)
      (while (< (point) end)
        (when (forward-word 1)
          (setq n (1+ n))))
      (message "Region has %d words" n)
      n)))

;;
;; goto-longest-line
;; --------------------
;; Sometimes for code is nice to find lines that are pushed out too far.
;; This function moves point to the end of the longest line.
;;
(defun goto-longest-line ()
  "Finds the longest line and puts the point there."
  (interactive)
  (let ((width 0)
        (pos 0))
    (goto-char (point-min))
    (while (= (forward-line 1) 0)
      (end-of-line)
      (let ((curwid (current-column)))
        (unless (<= curwid width)
          (setq width curwid)
          (setq pos (point)))))
    (goto-char pos)))

;;
;; kill-other-buffers
;; ------------------
;; I find that Emacs buffers multiply faster than rabbits.  They were
;; regenerating faster than I could kill them so I wrote this.  (Original
;; version was my first code in ELisp!)  Run this macro to kill all but the
;; active buffer and the unsplit the window if need be.
;;
(defun kill-other-buffers ()
  "Kill all buffers except the current and unsplit the window."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))   ; Delete other buffers
  (delete-other-windows)                                      ; And then unsplit the current window...
  (delete-other-frames))                                      ; ...and remove other frames, too.

