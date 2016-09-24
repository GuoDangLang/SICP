(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
	((stream-null? s2) s1)
	(else (let ((cars1 (stream-car s1))
		    (cars2 (stream-car s2)))
		(cond ((< (weight cars1) (weight cars2))
		       (cons-stream cars1
				    (merge-weighted (stream-cdr s1) s2
						    weight)))
		      ((= (weight cars1) (weight cars2))
		       (cons-stream cars1
				    (merge-weighted (stream-cdr s1) s2 weight))
