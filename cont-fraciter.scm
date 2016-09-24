(define (cont-frac n d k)
    (define (cont-fraciter temp count)
      (if (= count 1)
	(/ (n 1) temp)
	(cont-fraciter (+ (d (- count 1)) (/ (n count) temp)) (- count 1))))
    (cont-fraciter (d k) k))




