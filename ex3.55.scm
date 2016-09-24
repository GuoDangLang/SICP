(load "stream-pac")
(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-stream ones integers)))
(define (partial-sums s)
  (cons-stream (stream-car s) (add-stream (stream-cdr s) (partial-sums s))))
(define s (partial-sums integers))
