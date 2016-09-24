(define (integral stream initial dt)
  (define int
    (cons-stream initial 
		 (add-stream (scale-stream stream dt)
			     int)))
  int)
(define (rc r c dt)
  (lambda (i v0)
    (add-stream (scale-stream i r)
		(integral (scale-stream i (/ 1 c)) v0 dt))))
(define rc1 (rc 5 1 0.5))

