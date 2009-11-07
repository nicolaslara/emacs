(defun add-or-push (key value hash)
  (if (gethash key hash)
      (progn
      (puthash key (cons value (gethash key hash)) hash))
    (progn 
      (puthash key (list value) hash))))

(defun clear-push-mark-for-buffer ()
  "Resets the buffer's stack"
  (interactive)
  (puthash (buffer-name) () local-mark-stack))

(defun clear-global-push-mark ()
  "Resets the buffer's stack"
  (interactive)
  (setq global-mark-stack '())
  (maphash (lambda (kk vv) (puthash kk () local-mark-stack)) local-mark-stack)
  )

(defun local-push-mark ()
  "Pushes a the current point to a stack"
  (interactive)
  (if (boundp 'local-mark-stack)
      (progn 
        (let (buffer point)
          (setq buffer (buffer-name))
          (setq point (point))
          (add-or-push buffer point  local-mark-stack)
          (message "Pushed %d on %s" point buffer)
          (if (boundp 'global-mark-stack)
              (setq global-mark-stack (cons (list point buffer) global-mark-stack))
            (setq global-mark-stack (list point buffer)))))
    (progn
      (setq local-mark-stack (make-hash-table))
      (local-push-mark))))

(defun local-pop-mark ()
  "Pops the a mark from the current buffer's stack"
  (interactive)
  (let (stack)
    (setq stack (gethash (buffer-name) local-mark-stack))
    (if (and (boundp 'local-mark-stack) stack)
        (progn 
          (goto-char (pop stack))
          (puthash (buffer-name) stack local-mark-stack)
          (setq global-mark-stack 
                (remove (list (point) (buffer-name)) global-mark-stack)))
      (message "No marks to pop"))))

(defun global-pop-mark ()
  "Pops a mark from any buffer"
  (interactive)
  (let (pos buffer)
    (setq pos (car global-mark-stack))
    (setq buffer (nth 1 (car global-mark-stack)))
    (setq stack (gethash buffer local-mark-stack))
    (if (and (boundp 'global-mark-stack) stack)
        (progn 
          (switch-to-buffer buffer)
          (goto-char (pop stack))
          (puthash buffer stack local-mark-stack)
          (setq global-mark-stack (remove (list pos buffer) global-mark-stack)))
      (message "No marks to pop"))))

(provide 'marks)
