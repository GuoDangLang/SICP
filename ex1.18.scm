(define (halve n) (/ n 2))
(define (double n) (+ n n))
(define (even? n) (= (remainder n 2) 0))
(define (*-iter a b)
  (cond ((= a 1) b)
	((even? a) (*-iter (halve a) (double b)))
	(else (+ b (*-iter (- a 1) b)))))
