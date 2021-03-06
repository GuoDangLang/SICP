(define (next divisor) (if (= (remainder divisor 2) 0) (+ divisor 1) (+ divisor 2)))
(define (square x) (* x x))
(define (divised? fortest n) (= (remainder n fortest) 0))
(define (smallest-divisor n) 
  (define (test-divi fortest n) (cond ((> (square fortest) n) n)
				      ((divised? fortest n) fortest)
				      (else (test-divi (next fortest) n))))
  (test-divi 2 n))
(define (prime? n) (= (smallest-divisor n) n))
