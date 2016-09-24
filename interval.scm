(define (make-interval a b) (cons a b))
(define (upper-interval x) (cdr x))
(define (lower-interval x) (car x))
(define (add-interval x y)
  (make-interval (+ (lower-interval x) (lower-interval y))
		 (+ (upper-interval x) (upper-interval y))))
(define (sub-interval x y)
  (make-interval (- (upper-interval x) (lower-interval y))
		 (- (lower-interval x) (upper-interval y))))
(define (mul-interval x y)
  (let ((p1 (* (lower-interval x) (lower-interval y)))
	(p2 (* (lower-interval x) (upper-interval y)))
	(p3 (* (upper-interval x) (lower-interval y)))
	(p4 (* (upper-interval x) (upper-interval y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))
(define (div-interval x y)
    (define (check a b) 
      (if (= (- a b) 0)
	(display "fucking wrong!")
	(mul-interval x (make-interval a b))))
    (check (/ 1.0 (upper-interval y)) (/ 1.0 (lower-interval y))))
(define (mul-intervalpro x y)
  (define (endpoint-sign x)
    (cond ((and (>= (upper-interval x) 0) (>= (lower-interval x) 0)) 1)
	  ((and (< (upper-interval x) 0) (< (lower-interval x) 0)) -1)
	  (else 0)))
  (let ((es-x (endpoint-sign x))
	(es-y (endpoint-sign y))
	(x-up (upper-interval x))
	(x-lo (lower-interval x))
	(y-up (upper-interval y))
	(y-lo (lower-interval y)))
    (cond ((> es-x 0) (cond ((> es-y 0)
			     (make-interval (* x-lo y-lo) (* x-up y-up)))
			    ((< es-y 0)
			     (make-interval (* y-lo x-up) (* x-lo y-up)))
			    (else (make-interval (* y-lo x-up) (* x-up y-up)))))
	  ((< es-x 0) (cond ((> es-y 0)
			     (make-interval (* x-lo y-up) (* x-up y-lo)))
			    ((< es-y 0)
			     (make-interval (* x-up y-up) (* x-lo y-lo)))
			    (else (make-interval (* x-lo y-up) (* x-lo y-lo)))))
	  (else (cond ((> es-y 0)
		       (make-interval (* x-lo y-up) (* x-up y-up)))
		      ((< es-y 0)
		       (make-interval (* x-up y-lo) (* x-lo y-lo)))
		      (else 
			(make-interval (min (* x-lo y-up) (* x-up y-lo)) 
				       (max (* x-lo y-lo) (* x-up y-up)))))))))
(define (make-center-percent c p)
  (make-interval (- c (* c p)) (+ c (* c p))))
(define (center-interval x)
  (/ (+ (upper-interval x) (lower-interval x)) 2))
(define (percent-interval x)
  (/ (/ (- (upper-interval x) (lower-interval x)) (center-interval x)) 2))
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
		  (add-interval (div-interval one r1)
				(div-interval one r2)))))
  


