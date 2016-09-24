(define (last-pair li)
  (define (last-pair-iter l)
    (let ((temp (car l))
	(next (cdr l)))
    (if (null? next)
      temp
      (last-pair next))))
  (if (null? li) (display "no value") (last-pair-iter li)))
