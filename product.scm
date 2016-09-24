(define (product f a next b)
  (if (> a b)
    1
    (* (f a) (product f (next a) next b))
    ))

