(define (product term a next b) 
  (define (product-iter a b result)
    (if (> a b)
      result
      (product-iter (next a) b (* (term a) result))))
  (product-iter a b 1))
