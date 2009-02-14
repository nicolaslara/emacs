;;; Word to Emacs
;;; Author: Nicolas Lara <nicolas@ac.labf.usb.ve>
;;; Created: 21-03-2005
;;; NO MORE EXCUSES FOR USING WORD INSTEAD OF EMACS
;;; 
;;; To-Do: OpenOfficeWriter (.sxw) to Emacs

(defun word-to-emacs()
  (cond ((string-match "\\.doc" (buffer-name))
         (shell-command (concat "antiword '" (buffer-file-name) "'"))
         (kill-buffer (buffer-name))
         (delete-window)
         ))
  )
  

(provide 'word-to-emacs)
