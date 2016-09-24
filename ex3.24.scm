(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (assoc-new key records)
      (cond ((null? records) false)
	    ((same-key? key (car records)) (car records))
	    (else (assoc-new key (cdr records)))))
    (define (lookup key1 key2)
      (let ((subtable (assoc-new key1 (cdr local-table))))
	(if subtable
	  (let ((record (assoc-new key2 (cdr subtable))))
	    (if record
	      (cdr record)
	      false))
	  false)))
    (define (insert! key1 key2 value)
      (let ((subtable (assoc-new key1 (cdr local-table))))
	(if subtable
	  (let ((record (assoc-new key2 (cdr subtable))))
	    (if record 
	      (set-cdr! record value)
	      (set-cdr! subtable (cons (cons key2 value)
				       (cdr subtable)))))
	  (set-cdr! local-table
		    (cons (list key1 (cons key2 value))
			  (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
	    ((eq? m 'insert!) insert!)
	    (else (error "Unkown-- FUck you!" m))))
    dispatch))
(define (same-key? key record)
  (cond ((number? key) 
	 (if (number? (car record)) (if (and (> key (- (car record) 0.1)) (< key (+ (car record) 0.1)))
	   true
	   false)
	   false))
	(else (equal? key (car record)))))
(define shiyan (make-table same-key?))
(define get
  (shiyan 'lookup))
(define put
  (shiyan 'insert!))
	    
