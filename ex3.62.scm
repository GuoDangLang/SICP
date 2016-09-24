(load "ex3.60.scm")
(define (div-series s1 s2)
  (if (zero? (stream-car s2))
    (error "The beichushu can't be zero")
    (mul-series s1 (invert-unit-series s2))))
(define tangent
  (div-seires sine-series
	      cosine-series))
