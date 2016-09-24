(define (count-pair-nb obj)
  (let ((aux '()))
    (define (elapse? x w)
      (if (null? w)
	(begin (set! aux (append aux (list x))) false)
	(if (eq? (car w) x)
	  true
	  (elapse? x (cdr w)))))
    (define (count x)
      (if (not (pair? x))
	0
	(if (eq? (car x) (cdr x))
	  (+ 1 (count (car x)))
	  (cond ((elapse? (car x) aux) (+ 1 (count (cdr x))))
		((elapse? (cdr x) aux) (+ 1 (count (car x))))
		(else (+ 1 
			 (count (car x))
			 (count (cdr x))))))))
    (count obj)))
	  
