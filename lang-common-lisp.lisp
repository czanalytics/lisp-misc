;;;; Notes on basic Common Lisp features
;;;; C.Barski: Land of Lisp (2011)
;;;;
;;;; SBCL  
;;;; Usage: sbcl > load("lang-common-lisp.lisp")

;;; REPL 
(+ 1 (* 2 3))

;;; functions
(defun foo ()
  ;; dummy
 () ;
 (+ 2 3))

(foo)

(defparameter *foo* 16) 
(setf *foo* 8)
(defvar *immutable* 1) 

;;;
(print "CL")
(princ "Lisp \" ")

;;;
(ash *foo* -1) ; half
(ash *foo* +1) ; double

(defun add-one (i)
  (1+ i)) ; 1-

(add-one (* 2 3))

(let ((a 2)
      (b 3))
      (+ a b))

(flet ((f+ (i)
	   (+ i 1))
       (f- (i)
	   (- i 1)))
      
      (f+ (f- 1)))

(labels ((f+ (i) ; fun available
	     (+ i 1))
	 (f++ (i)
	      (f+ (f+ i))))
      
      (f++ 1))

(eq 'A 'a) ; T
(expt 2 3) ; 2^3
(/ 2 3) ; 2/3

(cons 1 NIL) ; (1)
(cons 1 ())
(cons 'a 'b) ; (a . b)
(cons 'a '(b c)); (a b c)
(cons 'a (cons 'b 'c)); (a b . c)

(list 1 2 3)
(list 'a '(b c) 'd)

(car '(a b c)) 
(cdr '(a b c)); cddr caddr cadadr
