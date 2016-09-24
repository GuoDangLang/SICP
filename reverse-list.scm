(define (reversee li)
    (define (reversee-recu l count)
      (if (= count 1)
	(append (list) (list (car l)))
	(append (reversee-recu (cdr l) (- count 1)) (list (car l)))))
    (if (null? li) li (reversee-recu li (length li))))
(define (reversee-ver2 li)
  (define (iter items temp)
    (if (null? items)
      temp 
      (iter (cdr items) (cons (car items) temp))))
  (iter li (list)))



