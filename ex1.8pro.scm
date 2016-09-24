(define (square x) (* x x))
(define (triple x) (* x x x))
(define (improve y x) (/ (+ (/ x (square y)) (* 2 y)) 3))
(define (good-enough? y x) (< (abs (- (improve y x) y)) 0.001))
(define (cube-iter y x)
  (if (good-enough? y x)
    y
    (cube-iter (improve y x) x)))
(define (cubett x) (cube-iter 2.0 x))
