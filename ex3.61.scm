(load "ex3.60.scm")
(define (invert-unit-series s)
  (define x
    (cons-stream 1 (mul-series (scale-stream (stream-cdr s) -1)
			       x)))
  x)
(define ans (invert-unit-series cosine-series))
