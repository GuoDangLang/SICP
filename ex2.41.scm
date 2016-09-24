(define (all-triples n)
  (accumulate append nil 
	      (map (lambda (x) 
		     (map (lambda (y) (append (list x) y))
			    (unique-pairs (- x 1))))
		   (enumerate-interval 1 n))))
(define (sum-to-s? triple s)
  (define (iter result t)
    (if (null? t)
      result
      (iter (+ result (car t)) (cdr t))))
  (= s (iter 0 triple)))
(define (triple-of-s n s)
  (define (judge tr)
    (sum-to-s? tr s))
  (filterr judge (all-triples n)))

  
		       
