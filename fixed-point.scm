(define tolerance 0.00001)
(define (close-enough? x y)
  (< (abs (- x y)) tolerance))
(define (fixed-point f guess) 
  (define (try x)
    (let ((next (f x)))
      (if (close-enough? next x)
	next
	(try next))))
  (try guess))



