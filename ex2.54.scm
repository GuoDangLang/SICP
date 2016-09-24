(define (equall? a b)
  (let ((na (cdr a))
	(nb (cdr b)))
  (if (and (null? na) (null? nb)) true
    (if (eq? (car a) (car b)) (equall? na nb)
      false))))
