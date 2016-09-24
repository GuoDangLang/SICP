(define (fold-leftt op ini sequence)
  (define (iter result seq)
    (if (null? seq)
      result
      (iter (op result (car seq))
	    (cdr seq))))
  (iter ini sequence))
(define (fold-rightt op ini sequence)
  (if (null? sequence)
    nil
    (op (car sequence)
	(fold-rightt op ini (cdr sequence)))))

(define (new-reverser sequence)
  (fold-rightt (lambda (x y) (append y (list x))) nil sequence))
(define (new-reversel sequence)
  (fold-leftt (lambda (x y) (cons y x)) nil sequence))
