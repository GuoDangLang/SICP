(define (split proc proc2)
  (lambda (painter n)
    (if (= n 0)
      painter
      (let ((smaller ((split proc proc2) painter (- n 1))))
	(proc painter (proc2 smaller smaller))))))
