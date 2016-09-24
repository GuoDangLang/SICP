(load "stream-pac")
(define (stream-limit-n s tole)
  (let ((n 0))
    (define (limit s tole)
      (let ((former (stream-car s))
	    (later (stream-car (stream-cdr s))))
	    (if (< (abs (- later former)) tole)
	      n
	      (begin (set! n (+ 1 n))
		     (limit (stream-cdr s) tole)))))
    (limit s tole)))
(define (sequence n)
  (cons-stream (/ 1.0 n)
	(stream-map - (sequence (+ n 1)))))
(define ln2-stream
  (partial-sums (sequence 1)))
(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1))
	(s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
			  (+ s0 (* -2 s1) s2)))
		 (euler-transform (stream-cdr s)))))
(define (make-tableau transform s)
  (cons-stream s
	       (make-tableau transform
			     (transform s))))
(define (accelerated-sequence transform s)
  (stream-map stream-car
	      (make-tableau transform s)))
(define fast-ln2
  (accelerated-sequence euler-transform ln2-stream))
