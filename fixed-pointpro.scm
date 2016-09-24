(define tolerance 0.00001)
(define (close-enough? x y)
  (< (abs (- x y)) tolerance))
(define (dp x)
  (newline)
  (display x))
(define (fixed-point f guess) 
  (define (try x)
    (let ((next (f x)))
      (if (not (close-enough? next x)) (dp next))
      (if (close-enough? next x)
	next
	(try next))))
  (try guess))



