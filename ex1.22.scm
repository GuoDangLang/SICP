(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime n (- (runtime) start-time))))
(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))
(define (odd? n) (= (remainder n 2) 1))
(define (search-for-primes begin end)
  (define (prime-iter cur end)
    (if (not (> cur end)) (timed-prime-test cur))
    (if (not (> cur end)) (search-for-primes (+ cur 2) end)))
  (prime-iter (if (odd? begin) begin (+ 1 begin))
	      (if (odd? end) end (- 1 end))))
