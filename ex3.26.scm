(define (make-table)
  (let ((local-binary (list (cons '() '()) (cons '() '())))
    (define (ptr tree)
      (cadr tree))
    (define (keyval tree)
      (car tree))
    (define (key-tree tree)
      (caar tree))
    (define (val-tree tree)
      (cdar tree))
    (define (assoc-bi key tree)
      (cond ((null? tree) false)
	    ((equal? key (key-tree tree)) tree)
	    ((< key (key-tree tree)) (assoc-bi key (car (ptr tree))))
	    ((> key (key-tree tree)) (assoc-bi key (cdr (ptr tree))))
	    (else (error "fuck something wrong"))))
    (define (lookup key)
      (let ((result (assoc-bi key local-binary)))
	(if result
	  (val-tree result)
	  false)))
    (define (adjoin pair tree)
      (let ((ins (list pair (cons '() '())))
	    (key (car pair)))
	(if (null? tree) ins
	  (cond ((= key (key-tree tree)) (set-cdr! (keyval tree) (cdr pair)))
		((< key (key-tree tree))
	    (if (null? (car (ptr-tree tree))) (set-car! (ptr-tree tree) ins)
	      (adjoin pair (car (ptr-tree tree)))))
		((> key (key0tree tree))
		 (if (null? (cdr (ptr-tree tree))) (set-cdr! (ptr-tree tree) ins)
		   (adjoin pair (cdr (ptr-tree tree)))))))))
	      
    (define (insert! key val)
      (let ((result (assoc-bi key local-binary)))
	(if result
	  (set-cdr! (keyval result) val)
	  (adjoin (cons key val) local-binary)))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
	    ((eq? m 'insert!) insert!)
	    (else (error "go fuck yourself"))))
    dispatch)))

	    
