(load "commonfunc")
(define (conss a b)
  (* ((power a) 2) ((power b) 3)))
(define (carr x)
  (define (get-iter a val)
    (if (not (= (remainder val 2) 0))
      a
      (get-iter (+ 1 a) (/ val 2))))
  (get-iter 0 x))
(define (cdrr y)
  (define (get-iter b val)
    (if (not (= (remainder val 3) 0))
      b
      (get-iter (+ 1 b) (/ val 3))))
  (get-iter 0 y))
