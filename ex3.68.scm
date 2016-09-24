(load "stream-pac")
(define ones (cons-stream 1 ones))
(define integers (cons-stream 0 (add-stream ones integers)))
(define (interleave s t)
  (if (stream-null? s) t
    (cons-stream (stream-car s)
		 (interleave t (stream-cdr s)))))
(define (pairs s t)
  (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
		  t)
    (pairs (stream-cdr s) (stream-cdr t))))
(define shiyan (pairs integers integers))
