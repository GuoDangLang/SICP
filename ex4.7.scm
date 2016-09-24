(define (let*? exp)
  (tagged-list? exp 'let*))
(define (let*-body exp) ;using caddr not cddr is due to let* only evaluate one line; ex. (+ x 1) (+ x 2) only return value of (+ x 2)
  (caddr exp))
(define (let*-inits exp)
  (cadr exp))
(define (let*->nested-lets exp)
  (let ((inits (let*-inits exp))
	(body (let*-body exp)))
    (define (make-lets exprs)
      (if (null? exprs)
	body
	(list 'let (car inits) (make-lets (cdr exprs)))))
    (make-lets inits)))


