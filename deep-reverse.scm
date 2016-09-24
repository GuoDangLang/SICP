(define nil (list))
(define (reverses li)
  (define (iter l temp)
    (if (null? l)
      temp
      (iter (cdr l) (cons (car l) temp))))
  (iter li nil))
(define (deep-reverse li)
  (define (iter l temp)
    (if (null? l)
      temp
      (if (pair? (car l)) (iter (cdr l) (cons (deep-reverse (car l)) temp))
	(iter (cdr l) (cons (car l) temp)))))
  (iter li (list)))

