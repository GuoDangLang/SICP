(define (make-accumulator base)
  (lambda (addend) (set! base (+ base addend))
    base))
