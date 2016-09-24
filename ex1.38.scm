(define (thed val) (if (or (= (remainder val 3) 1) (= (remainder val 3) 0))
		     1
		     (* 2 (+ 1 (floor (/ val 3))))))
