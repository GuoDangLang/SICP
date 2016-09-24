(load "stream-pac")
(define (integral delayed-stream y0 dt)
  (define int
    (cons-stream y0
	       (let ((integrand (force delayed-stream)))
		 (add-stream integrand
			     int)))))
(define (solve-2nd a b y0 dy0 dt)
  (define d (integral dd dy0 dt))
  (define y (integral d y0 dt))
  (define dd (addstream (scale-stream d a)
			(scale-stream y b)))
  y)
