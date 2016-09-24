(load "stream-pac")
(define ones (cons-stream 1 ones))
(define integers
  (cons-stream 0 (add-stream ones integers)))
(define (interleave a b)
  (cons-stream (stream-car a)
	       (interleave b (stream-cdr a))))
(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
		  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))
(define ans (pairs integers integers))
;;; (1,100) -> 200
;;; (99,100) -> 3*(2^98) - 1
;;; (100,100) -> 2^100 - 1
;;; if you want the num of pair precede it then sub the ans by 1;
