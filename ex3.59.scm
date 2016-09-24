(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (stream-map + ones integers)))
(define (integral-series s)
  (stream-map * (stream-map / ones integers) s))
(define sine-series (cons-stream 0 (integral-series cosine-series)))
(define cosine-series (cons-stream 1 (integral-series
				       (scale-stream sine-series -1))))
