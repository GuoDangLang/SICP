(define (inc x) (+ x 1))

(define (accumulate combiner null-value term a next b)
  (define (accu-iter x null-value)
    (if (> x b)
      null-value
      (accu-iter (next x) (combiner (term x) null-value))))
  (accu-iter a null-value))
(define (sum term a next b)
  (accumulate + 0 term a next b))
(define (product term a next b)
  (accumulate * 1 term a next b))
