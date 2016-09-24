(define one (lambda (y) (lambda (x) (y x))))
(define two (lambda (y) (lambda (x) (y (y x)))))
(define (add m n) (lambda (f) (lambda (x) ((m f) ((n f) x)))))
