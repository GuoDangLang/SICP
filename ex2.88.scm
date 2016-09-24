(define (install-subpoly-package)
  (define (negate-scheme-num x)
    (- x))
  (define (negate-rational x)
    (make-rational (- (numer x)) (- (denom x))))
  (define (negate-termlist p)
    (if (empty-termlist? p)
      (the-empty-termlist)
      (let ((ft (first-term p)))
	(adjoin-term (make-term (order ft) (negate (coeff ft)))
		     (negate-poly (rest-terms p))))))
  (put 'negate 'polynomial (lambda (poly) (make-poly (variable poly)
						     (negate-termlist
						       (term-list poly)))))
  (put 'negate 'scheme negate-scheme-num)
  (put 'negate 'rational (lambda (x) (attach-tag 'rational (negate-rational x))))
  (put 'negate 'complex (lambda (x) (make-from-real-imag (negate real-part x)
							 (negate imag-part x))))
  'done)
