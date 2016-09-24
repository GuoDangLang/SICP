(define nil (list))
(define (accumulate op initial sequence)
  (if (null? sequence) initial
    (op (car sequence)
	(accumulate op initial (cdr sequence)))))
(define (mapp p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))
(define (lengthh sequence)
  (accumulate (lambda (x y) (if (not (null? x)) (+ 1 y))) 0 sequence))
(define (appendd seq1 seq2)
  (accumulate cons seq2 seq1))