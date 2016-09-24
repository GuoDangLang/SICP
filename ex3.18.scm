(define (circle? x)
  (let ((temp x))
    (define (c? y)
      (if (null? y)
	false
	(if (eq? y temp)
	  true
	  (c? (cdr y)))))
    (c? (cdr x))))
      
