(define (apply-generic-pro op . args)
  (let ((typetags (map taype-tag args)))
    (let ((proc  (get op typetags)))
      (if proc 
	(apply proc (map contents args))
	(if (= (length args) 2)
	  (let ((type1 (car type-tags))
		(type2 (cadr type-tags)))
	    (if (not (eq? type1 type2))
	      (let ((a1 (car args))
		    (a2 (cadr args))
		    (t1->t2 (get-coercion type1 type2))
		    (t2->t1 (get-coercion type2 type1)))
		(cond ((t1->t2) (apply-generic-pro op (t1->t2 a1) a2))
		      ((t2->t1) (apply-generic-pro op a1 (t2->t1 a2)))
		      (else (error "NO METHODS FOR THESE TYPES"
				   (list op typetags)))))
	      (error "NO METHODS FOR THESE TYPES"
		     (list op typetags))))
	  (error "NO METHODS FOR THESE TYPES"
		 (list op typetags)))))))
