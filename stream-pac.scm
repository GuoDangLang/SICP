(define stream-null? null?)
(define the-empty-stream '())
(define (force x)
  (x))
;;;(define-syntax delay
  ;;;(syntax-rules ()
	;;;	((_ exp) (lambda () exp))))
(define-syntax cons-stream
  (syntax-rules ()
		((_ a b) (cons a (delay b)))))
(define (stream-car s)
  (car s))
(define (stream-cdr s)
  (force (cdr s)))
(define (stream-enumerate-interval a b)
  (if (> a b)
    '()
    (cons-stream a (stream-enumerate-interval (+ a 1) b))))
(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
	((pred (stream-car stream)) (cons-stream (stream-car stream)
						 (stream-filter pred (stream-cdr stream))))
	(else (stream-filter pred (stream-cdr stream)))))
(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))
;;;(define (stream-map proc s)
  ;;;(if (stream-null? s)
    ;;;the-empty-stream
    ;;;(cons-stream (proc (stream-car s)) (stream-map proc (stream-cdr s)))))
(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
	   (stream-for-each proc (stream-cdr s)))))
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))
(define (memo-proc x)
  (let ((already-run? false)
	(result false))
    (lambda ()
      (if already-run?
	result
	(begin (set! already-run? true)
	       (set! result (x))
	       result)))))
(define-syntax delay
  (syntax-rules ()
		((_ exp) (memo-proc (lambda () exp)))))
(define (stream-map proc . argstream)
  (if (stream-null? (car argstream))
    the-empty-stream
    (cons-stream (apply proc (map stream-car argstream))
		 (apply stream-map
			(cons proc (map stream-cdr argstream))))))
(define (scale-stream stream n)
  (stream-map (lambda (x) (* n x)) stream))
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ 1 n))))
(define (divisible? x y) (= (remainder x y) 0))
(define primes
  (cons-stream
    2
    (stream-filter prime? (integers-starting-from 3))))
(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) true)
	  ((divisible? n (stream-car ps)) false)
	  (else (iter (stream-cdr ps)))))
  (iter primes))
(define (add-stream s b)
  (stream-map + s b))
(define (mul-stream s b)
  (stream-map * s b))
(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (stream-map + ones integers)))
(define (partial-sums s)
  (define sum
    (cons-stream (stream-car s)
		 (stream-map + sum
			     (stream-cdr s))))
  sum)
(define (stream-append a b)
  (if (stream-null? a)
    b
    (cons-stream (stream-car a)
		 (stream-append (stream-cdr a) b))))


  
