(define f 
  (let ((count 1))
    (lambda (x)
      (if (= x count) (begin (set! count 1) count)
	(begin (set! count 0) count)))))
