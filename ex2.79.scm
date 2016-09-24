(define (install-scheme-equ-package)
  (put 'equ? '(scheme-number scheme-number) =)
  'done)
(define (install-complex-equ-package)
  (define (equ? x y)
    (and (= (real-part x) (real-part y) (= (imag-part x) (imag-part y)))))
  (put 'equ? '(complex complex) equ?)
  'done)
(define (install-rational-equ-package)
  (define (equ? x y)
    (= (* (numer x) (denom y)) (* (numer y) (denom x))))
  (put 'equ? '(rational rational) equ?)
  'done)
(define (equ? x y) (apply-generic 'edu? x y))
