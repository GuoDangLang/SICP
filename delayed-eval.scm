(load "stream-pac")
(define (integral stream initial dt)
  (define int
    (cons-stream initial
		 (add-stream (scale-stream stream dt)
			     int))))
;This is the original,then we solve dy/dt = f(y);
;(define (solve f yo dt)
  ;(define y (integral s yo dt))
  ;(define s (stream-map f y)))
;then this will output Premature reference to reserved name :s
(define (integral-d delayed-stream initial dt)
  (define int
    (cons-stream initial
		 (let ((integrand (force delayed-stream)))
		   (add-stream (scale-stream integrand dt)
			       int))))
    int)
(define (solve f yo dt)
  (define y (integral-d (delay s) yo dt))
  (define s (stream-map f y))
  y)
(define e (solve (lambda (y) y) 1 0.001))




