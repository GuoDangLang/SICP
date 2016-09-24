(define (make-frame variables values)
  (if (null? varibales)
    '()
    (cons (cons (car variables) (car values)) (make-frame (cdr variables)
							  (cdr values)))))
(define (frame-variables frame) (map car frame))
(define (frame-values frame) (map cdr frame))
(define (add-binding-to-frame! var val frame)
  (cons (cons var val) frame))
