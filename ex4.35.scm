(define (an-integer-between l h)
  (require (>= (- h l) 0))
  (amb l (an-integer-between (+ 1 l) h)))
