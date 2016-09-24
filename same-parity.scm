(define (same-parity-recu . li)
  (if (null? li) li
    (let ((judge (car li)))
      (define (recu l)
	(if (null? l)
	  (list)
	  (let ((val (car l))
		(lval (cdr l)))
	    (if (= (remainder (- val judge) 2) 0) (cons val (recu lval))
	      (recu lval)))))
      (recu li))))

(define (same-parity . li)
  (if (null? li) li
    (let ((judge (car li)))
      (define (iter l result)
	(if (null? l) result
	  (let ((val (car l))
		(lval (cdr l)))
	    (if (= (remainder (- val judge) 2) 0) (iter lval (cons result val)) (iter lval result)))))
      (iter li (list)))))
