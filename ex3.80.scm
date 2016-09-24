(load "stream-pac")
(define (integral delayed-stream initial dt)
  (define int
    (cons-stream initial
	       (let ((integrand (force delayed-stream)))
		 (add-stream integrand
			     int))))
  int)
(define (RLC r l c dt)
  (lambda (i0 v0)
    (define vc (integral (delay (scale-stream il (- (/ 1 c)))) v0 dt))
    (define il (integral (delay dil) i0 dt))
    (define dil (add-stream (scale-stream vc (/ 1 l))
			    (scale-stream il (- (/ r l)))))
    (define (merge-stream s b)
      (cons-stream (cons (stream-car s) (stream-car b))
		   (merge-stream (stream-cdr s) (stream-cdr b))))
  (merge-stream vc il)))
(define rlc0 (RLC 1 1 0.2 0.1))
(define ans (rlc0 0 10))

