(define (iter-improve good-enough? improve)
  (lambda (x) (let ((next (improve x)))
		(if (good-enough? x next)
		  next
		  (improve next)))))
(define (impro-fixed-point guess)
  (define goodenough?
