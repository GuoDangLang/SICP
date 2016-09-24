(define (square x) (* x x))
(define (even? n) (= (remainder n 2) 0))
(define (fast-iter b n) 
  (cond ((= n 2) (square b))
	((even? n) (fast-iter (square b) (/ n 2)))
	(else (* b (fast-iter b (- n 1))))))