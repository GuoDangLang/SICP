(define (even? n) (= (remainder n 2) 0))
(define (square n) (* n n))
(define (expmod base exp m)
  (define (first-of-test x)
    (define (test-square x tester)
      (if (and (= tester 1)
	       (not (= x 1))
	       (not (= x (- m 1)))) 0 tester))
    (test-square x (remainder (square x) m)))
  (cond ((= exp 0) 1)
	((even? exp) (first-of-test (expmod base (/ exp 2) m)) )
	(else (remainder (* base (expmod base (- exp 1) m)) m))))
(define (fermat-test n)
  (define (tryit a)
    (not (= (expmod a (- n 1) n) 0)))
  (if (or (= n 1) (= n 2) (= n 3)) true (tryit (+ 2 (random (- n 3))))))
(define (fast-prime n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime n (- times 1)))
	(else false)))
(define (prime? n)
  (fast-prime n 100))

