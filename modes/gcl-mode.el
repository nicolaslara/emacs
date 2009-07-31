;;; gcl-mode-el -- Major mode para editar archivos GCL
;;; $Id: gcl-mode.el,v 1.20 2004/10/16 02:48:19 julio Exp $

;; Author: Julio Castillo <julio@gia.usb.ve>
;; Created: 6 Jan 2004
;; Keywords: GaCeLa major-mode

;; Copyright (C) 2004 Julio Castillo <julio@gia.usb.ve>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary
;;
;; Major mode para editar archivos GaCeLa.  Para mayor infomacion ver:
;; http://libra.ac.labf.usb.ve/GCLWiki/
;; 
;; Las palabras clave (keywords), los tipos y las funciones nativas
;; fueron sacadas de los ejemplos disponibles en:
;; http://www.gia.usb.ve/~carlos/ci2616/gcl/guia_gcl.html,
;; http://libra.ac.labf.usb.ve/GCLWiki/
;; y del codigo fuente
;;
;; constantes predefinidas
;; (regexp-opt '("MAX_INT" "MIN_INT" "MAX_DOUBLE" "MIN_DOUBLE" "false" "true") t)
;;
;; otros que hacen mas facil la lectura
;; (regexp-opt '("]|" "|[" "/\\" "\\/" "->" ":=" ">>" ":=") t)
;;
;;
;;; Instalacion
;;
;; Agregar a ~/.emacs lo siguiente:
;;
;;   (autoload 'gcl-mode "gcl-mode")
;;   (setq load-path (append '("~/elisp") load-path))
;;   (setq auto-mode-alist (append '(("\\.gcl\\'" .  gcl-mode)) auto-mode-alist))
;;
;; Poner gcl-mode.el en ~/elisp/
;;
;;; Cosas que faltan
;;
;;  Con el highlighting:
;;
;;    * Considerar incluir "=" "=>" "<=" "<" ">" ":" "!" "!=" "==" al conjunto de "otros que
;;      hacen la lectura mas facil"
;;
;;  Con la indentacion
;;    * Indentar los constantes y variables despues de const y var.  Ejemplo:
;;      const A=x         |      var A:=x
;;            B=y         |          B:=y
;;            C=z :int    |          C:=z :int
;;
;;    * Considerar la lineas anteriores para la indentacion.  Ejemplo:
;;      unaVariable :=    A
;;                     \/ B
;;                     \/ C
;; 
;;    * Permitir inv, bound, pre, post y block solo dentro de "{..}"
;;
;;    * Se indenta mal cuando las primeras lineas del archivo son comentarios
;;
;;; History:
;;
;;; Code:

(provide 'gcl-mode)

(defvar gcl-mode-hook nil)

(defvar gcl-mode-map
  (let ((gcl-mode-map (make-keymap)))
    (define-key gcl-mode-map "\C-j" 'newline-and-indent)
;    (define-key gcl-mode-map [f9] 'gcl-reload)
;    (define-key gcl-mode-map [f1] 'gcl-find-column)
    gcl-mode-map)
  "Keymap para GaCeLa mode")

(defconst gcl-font-lock-keywords-1
  (let ((kw1 (concat "\\<\\("
		    (mapconcat 'regexp-quote
		       '("abort"   "array"	"block"
			 "bound"   "const"	"data"
			 "div"	   "dmax"	"dmin"
			 "do"	   "else"	"fi"
			 "fun"	   "gcd"	"if"
			 "in"	   
			 "inv"	   "matches"
			 "max"	   "min"	"mod"
			 "od"	   "of"		"out"
			 "post"	   "pre"	"proc"
			 "program" "proof"	"random"
			 "skip"	   "spec"
			 "then"	   "type"	
			 "var"	   "while"  
             "concrete"         "abstract"
             "implements"       "meth"
             "coupling" 
             "import"  "repr"   "witness"
             "operations" "constr"
			 ) "\\|") "\\)\\>"))
	(bi (concat "\\<\\("
		    (mapconcat 'regexp-quote
		       '("%cat"			"%count"
			 "%exists"		"%first"
			 "%forall"		"%intersect"
			 "%max"			"%max"
			 "%min"			"%min"
			 "%pi"			"%set"
			 "%sigma"		"%sigma"
			 "%sigma"		"%union"
			 "toInt"                "toDouble"
			 "sqrt"
			 "abs"			"addCircle"
			 "addFilledCircle"	"addLine"
			 "addText"		"card"
			 "complement"		"eraseAll"
			 "eraseCircles"		"eraseLines"
			 "eraseTexts"		"hasCircles"
			 "hasFilledCircle"	"hasLines"
			 "hasTexts"		"intersect"
			 "isEmpty"		"member"
			 "newScreen"		"readDouble"
			 "readInt"		"readIntArray"
			 "readIntMatrix"	"readString"
			 "subseteq"		"union"
			 "write"		"writeIntArray"
			 "addColoreddLine"      "hasFilledCircles"
			 "isVisible"            "show"
			 "hide"           "substring"
             "abrirArchivoLeyendolo" "abrirArchivoAnexandole"
             "abrirArchivoCreandolo" "cerrarArchivo"
             "leerLineaDeArchivo" "escribirLineaEnArchivo"
;;;; Me parece que esto lo sobrecarga mucho
;;              "length" 
;;              "gt" "ge" "lt" "le" "eq" "ne"
;;              "emptySeq" "insertLeft"
;;              "insertRight" "nth"
;;              "fr" "hd"
;;              "count" "isSubseq"
;;              "equal" "concat"
;;              "emptySet" "insert"
;;              "remove" "member"
;;              "elements" "union"
;;              "intersect" "difference"
			 )                      "\\|") "\\)\\>"))
	
	(tipos (concat "\\<\\("
		    (mapconcat 'regexp-quote
		       '("int"    "boolean"
			 "String" "double"
			 "Screen" "Set"
             "Seq"
			 ) "\\|") "\\)\\>"))

	(consts (concat "\\<\\("
		    (mapconcat 'regexp-quote
		       '("MAX_INT"    "MIN_INT"
			 "MAX_DOUBLE" "MIN_DOUBLE"
			 "false" "true"
			 ) "\\|") "\\)\\>"))

	)
	
    (list
     ;; palabras clave
     (cons kw1 font-lock-keyword-face)
     
     ;; tipos predefinidos
     (cons tipos font-lock-type-face)
     
     ;; funciones nativas
     (cons bi font-lock-builtin-face)
     
     ;; constantes
     (cons consts font-lock-constant-face)
     ;'("\\<[0-9]+(.[0-9]*)+\\>" . font-lock-constant-face)
     
     ;; nombre de funciones, procedimintos y programas
     '("proc[ \t]+\\([a-zA-Z]+[a-zA-Z0-9_]*\\)" 1 font-lock-function-name-face)
     '("fun[ \t]+\\([a-zA-Z]+[a-zA-Z0-9_]*\\)" 1 font-lock-function-name-face)
     '("program[ \t]+\\([a-zA-Z]+[a-zA-Z0-9_]*\\)" 1 font-lock-function-name-face)
     
     ;; nombre de tipos
     '("type[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)" 1 font-lock-type-face)
     
					; otros
     '("\\(->\\|/\\\\\\|:=\\(?:\\)?\\|>>\\|\\\\/\\|\\]|\\||\\[?\\)" 1 font-lock-variable-name-face)
     
     ))
  "Highlighting basico para GaCeLa mode")

(defvar gcl-font-lock-keywords gcl-font-lock-keywords-1
  "Highlighting default para GaCeLa mode")

(defvar gcl-mode-syntax-table
  (let ((gcl-mode-syntax-table (make-syntax-table)))
	
    ;; permite _ en los nombres
    (modify-syntax-entry ?_ "w" gcl-mode-syntax-table)
	
    ;; Cometarios como en C
    (modify-syntax-entry ?/ ". 124b" gcl-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" gcl-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" gcl-mode-syntax-table)
    gcl-mode-syntax-table)
  "Syntax table para `gcl-mode'")

(defun gcl-find-column ()
  "Determina la culumna a la que hay que indentar una linea de codigo en GaCeLa mode"
  (interactive)
    (let ((open-count 0) (close-count 0) (pos (point)) result)
      (save-excursion
	(beginning-of-line)
	(while (setq pos (re-search-backward "|[[]\\|\\(\\b\\(do\\|if\\)\\b\\)" (point-min) t))
	  (unless (string= "font-lock-string-face" (get-text-property pos 'face))
	    (setq open-count (+ open-count 1)))))
      (save-excursion
	(beginning-of-line)
	(while (setq pos (re-search-backward "[]]|\\|\\(\\b\\(\\od\\|fi\\)\\b\\)" (point-min) t))
	  (unless (string= "font-lock-string-face" (get-text-property pos 'face))
	    (setq close-count (+ close-count 1)))))
      (save-excursion
	(beginning-of-line)
	(when (looking-at "[ \t]*\\([]]|\\|od\\|fi\\|else\\)")
	  (setq close-count (+ close-count 1))))
      
      (if (wholenump (setq result (* 4 (- open-count close-count))))
	  result
	(prog1 0 (message "Hay mas bloques cerrados que abiertos -- indentando a 0")))))
	
    
	
;; (defun gcl-restart ()
;;   "solo para debuggear. Compila, carga y descarga gcl-mode para no tener
;;     que abrir y cerrar emacs cada vez que se hace un cambio. Solo sirve si
;;     se ejecuta desde gcl-mode.el"
;;   (interactive)
;;   (emacs-lisp-byte-compile-and-load)
;; ;;;   (kill-buffer "ejercicio3.gcl")
;;   (unload-feature 'gcl-mode)
;;   (require 'gcl-mode)
;; ;;;  (other-frame 1)
;; ;;;  (find-file "/home/julio/ci2615/gcl-ejemplos/ejercicio3.gcl")
;;  )

;; (defun gcl-reload ()
;;   "selo para debuggear. Pone y quita gcl-mode en el buffer que se utilice"
;;   (interactive)
;;   (gcl-mode)
;;   (gcl-mode))

(defun gcl-indent-line ()
  "Funcion para indentar una linea en GaCeLa mode"
  (interactive)
  (indent-line-to (gcl-find-column)))

(defun gcl-mode ()
  "Major mode para editar codigo en GaCeLa"
  (interactive)
  (kill-all-local-variables)
  (use-local-map gcl-mode-map)
  (set-syntax-table gcl-mode-syntax-table)

  (make-local-variable 'font-lock-string-face)
  (make-local-variable 'indent-line-function)
  (make-local-variable 'comment-start)
  (make-local-variable 'comment-end)
;  (make-local-variable 'comment-start-skip)

  (setq major-mode            'gcl-mode
	mode-name             "GaCeLa"
	comment-start           "// "
	comment-end             ""
;	comment-start-skip      " *"
	font-lock-defaults    '(gcl-font-lock-keywords)
	indent-line-function  'gcl-indent-line)

  (run-hooks 'gcl-mode-hook))

(provide 'gcl-mode)

;;; gcl-mode.el ends here
