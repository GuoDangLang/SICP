(define (fibpro n) 
  (if (< n 3) n (+ (fibpro (- n 1)) (* 2 (fibpro (- n 2))) (* 3 (fibpro (- n 3))))))

(define (f n)
  (f-iter 0 1 2 n))
(define (f-iter a b c n)
  (if (= n 2) c
	(f-iter b c (+ c (* 2 b) (* 3 a)) (- n 1))))
