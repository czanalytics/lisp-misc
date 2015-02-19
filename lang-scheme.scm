; kawa-2.0 R7RS
; http://www.gnu.org/software/kawa/news.html

;;;; R7RS p81
;;;; integrate y_k' = f(y_1,y_2,...,y__n) differential equation system

(define (integrate-system system-derivative
			  initial-state
			  h)
  (let ((next (runge-kutta-4 system-derivative h)))
    (letrec ((states
	      (cons initial-state
		    (delay (map-streams next
					states)))))
      states)))


(define (runge-kutta-4 f h)
  (let ((*h (scale-vector h))
	(*2 (scale-vector 2))
	(*1/2 (scale-vector (/ 1 2)))
	(*1/6 (scale-vector (/ 1 6))))
    (lambda (y)
      ;; y is a system state
      (let* ((k0 (*h (f y)))
	     (k1 (*h (f (add-vectors y (*1/2 k0)))))
	     (k2 (*h (f (add-vectors y (*1/2 k1)))))
	     (k3 (*h (f (add-vectors y k2)))))
	(add-vectors y
		     (*1/6 (add-vectors k0
					(*2 k1)
					(*2 k2)
					k3)))))))
(define (elementwise f)
  (lambda vectors
    (generate-vector
     (vector-length (car vectors))
     (lambda (i)
       (apply f
	      (map (lambda (v) (vector-ref v i))
		   vectors))))))

(define (generate-vector size proc)
  (let ((ans (make-vector size)))
    (letrec ((loop
	      (lambda (i)
		(cond ((= i size) ans)
		      (else
		       (vector-set! ans i (proc i))
		       (loop (+ i 1)))))))
      (loop 0))))

(define add-vectors (elementwise +))
(define (scale-vector s)
  (elementwise (lambda (x) (* x s))))

(define (map-streams f s)
  (cons (f (head s))
	(delay (map-streams f (tail s)))))

(define head car)
(define (tail stream)
  (force (cdr stream)))

;;; electronics example
(define (damped-oscillator R L C) 
  (lambda (state)
    (let ((Vc (vector-ref state 0))
	  (Il (vector-ref state 1)))
      (vector (- 0 (+ (/ Vc (* R C)) (/ Il C)))
	      (/ Vc L)))))

;;; main
(define the-states
  (integrate-system
   (damped-oscillator 10000 1000 .001)
   ’#(1 0)
    .01))

;;;; end of RK example

(define x (+ 1/3 1/4 -1/5 -1/3i 405/50+2/3i))

(define y (* 4.0 (expt unit:cm 2)))

(require 'quaternions)
