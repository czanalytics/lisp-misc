;;;; Some basics of dialect of Lisp used by the GNU Emacs
;;;; http://en.wikipedia.org/wiki/Emacs_Lisp
;;;;
;;;; Interactive use ESC-X ielm
;;;; Use: (load-file "emacs-lisp-lang.el")

(length "string") ; try these in REPL
(split-string "a b")
(buffer-name) 
(buffer-size)
(substring (concat "ab" "cd") 1 3) ; "bc"

;;;
(defun area (r)
  "Calculate the area of circle with radius r" 
  ;; 
  (* pi r r)) ; pi is a built-in constant 

(describe-function 'area)
(area 51)
(symbol-function 'area)

;;;
(defun my-split-window-func ()
  (interactive) ; can be invoked with ESC-x
  (split-window-vertically)
  (set-window-buffer (next-window) (other-buffer)))
 
(global-set-key "\C-x2" 'my-split-window-func)
