(define (make-frame var val)
  (cons var val))
(define (frame-variables frame) (list (car frame)))
(define (frame-values frame) (list (cdr frame)))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))
(define (empty-env? env)
  (null? env))
(define (env-variables env)
    (define (merge x)
      (if (null? x)
	'()
	(append (car x) (merge (cdr x)))))
    (merge (map frame-variables env)))
(define (env-values env)
    (define (merge x)
      (if (null? x)
	'()
	(append (car x) (merge (cdr x)))))
    (merge (map frame-values env)))
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())
;;(define test-list (list (list 1 2 3) (list 3 4 5) (list 5 6 7)))
(define (lookup-variable-value var env)
  (define (lookup variables values)
    (if (null? variables)
      (error "Unbound variable" var)
      (if (eq? var (caar variables))
	(car values)
	(lookup (cdr variables) (cdr values)))))
  (lookup (env-variables env) (env-values env)))
(define (set-variable-value! var val env)
  (define (lookup-set! variables vals)
    (if (null? variables)
      (error "Sorry Unbound variable -- SET!" var)
      (if (eq? var (caar variables))
	(set-car! (car vals) val)
	(lookup-set! (cdr variables) (cdr vals)))))
  (lookup-set! (env-variables env) (env-values env))
  'ok)
(define test-env (list (cons (list 'x 'y 'z) (list 1 2 3)) (cons (list 'a 'b 'c) (list 4 5 6)) (cons (list 'm 'n 'q) (list 7 8 9))))