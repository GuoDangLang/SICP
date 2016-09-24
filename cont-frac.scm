(define (cont-frac n d k)
    (define (cont-fracrecu count)
      (if (> count k)
	0
	(/ (n count) (+ (d count) (cont-fracrecu (+ 1 count))))))
    (cont-fracrecu 1))




