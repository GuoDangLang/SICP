(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define (intergers-from n)
  (cons n (delay (intergers-from (+ n 1)))))
(define intergers (intergers-from 1))
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
			 seq))

  
