(define (assoc key records)
  (cond ((null? records) false)
	((eq? (caar records) key) (car records))
	(else (assoc key (cdr records)))))
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup k1 k2)
      (let ((subtable (assoc k1 (cdr local-table))))
	(if subtable
	  (let ((record (assoc k2 (cdr subtable))))
	    (if record (cdr record)
	      false)))
	false))
    (define (insert! k1 k2 value)
      (let ((subtable (assoc k1 (cdr local-table))))
	(if subtable
	  (let ((record (assoc k2 (cdr subtable))))
	    (if record
	      (set-cdr! record value)
	      (set-cdr! subtable (cons (cons k2 value)
				       (cdr subtable)))))
	  (set-cdr! local-table (cons (list k1 (cons k2 value))
				      (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
	    ((eq? m 'insert-proc!) insert!)
	    (else (error "Unkown operation -- TABLE" m))))
    dispatch))
(define evaluator (make-table))
(define get (evaluator 'lookup-proc))
(define put (evaluator 'insert-proc!))
(define (install-evaluator-package)
  (put 'eval 'quote (lambda (x) (text-of-quotation x)))
  (put 'eval 'define eval-definition)
  (put 'eval 'set! eval-assignment)
  (put 'eval 'if eval-if)
  (put 'eval 'lambda (lambda (x y) (make-procedure (lambda-parameters x)
						   (lambda-body x) y)))
  (put 'eval 'begin (lambda (x y) (eval-sequence (begin-sequence x) y)))
  (put 'eval 'cond (lambda (x y) (eval (cond->if x) y)))
  'ok)
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
	((variable? exp) (lookup-variable-value exp env))
	((get 'eval (car exp)) (apply (get 'op (car expr) exp env)))
	((application? exp) (apply (eval (operator exp) env)
				   (list-of-value (operands expr) env)))
	(else 
	  (error "Unkonw expression type -- EVAL" exp))))
    
    
