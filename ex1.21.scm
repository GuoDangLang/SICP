(define (smallest-divisor n)
  (find-divisor n 2))
(define (square n) (* n n))
(define (devided? a b) (= (remainder b a) 0))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((devided? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

