(define dx 0.001)
(define (smooth f)
  (lambda (x) (/ (+ (f x) (f (- x dx)) (f (+ dx x))) 3)))


