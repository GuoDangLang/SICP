(define (cond? exp)
  (tagged-list? exp 'cond))
(define (cond-clauses exp)
  (cdr exp))
(define (cond-else-caluse? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
(define (additional-op? actions)
  (eq? (car actions) '=>))
(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
	  (rest (cdr clauses)))
      (if (cond-else-clause? first)
	(if (null? rest)
	  (sequence->exp (cond-actions first))
	  (error "ELSE clause isn't last -- COND->IF"
		 clauses))
	(let ((action (cond-actions first)))
	  (if (addtional-op? action)
	    (make-if (cond-predicate first)
		     (list (cadr action) (cond-predicate first))
		     (expand-clauses rest))
	    (make-if (cond-predicate first)
		     (sequence->exp (cond-actions first))
		     (expand-clauses rest))))))))
((cond? exp) (eval (cond->if exp) env)) ;;add this to eval procedure;
	    
		  
