(load "ex1.42.scm")
(define (repeated f times)
  (define (iter count temp)
    (if (= count times)
      temp
      (iter (+ 1 count) (compose f temp))))
  (iter 1 f))

