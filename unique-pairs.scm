(load "millerrabin")
(define (unique-pairs n)
  (accumulate append nil
	      (map (lambda (x)
		     (map (lambda (y) (list x y))
			  (enumerate-interval 1 (- x 1))))
		   (enumerate-interval 1 n))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filterr prime-sum?
		(unique-pairs n))))
(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))
(define (prime-sum-pair n)
  (map make-pair-sum
       (filterr prime-sum?
		(flatmap
		  (lambda (i)
		    (map (lambda (j) (list i j))
			 (enumerate-interval 1 (- i 1))))
		  (enumerate-interval 1 n)))))
