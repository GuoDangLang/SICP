((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
	1
	(* k (ft ft (- k 1))))))) 10)
(define (fibonacci n)
  (cond ((= n 1) 0)
	((= n 2) 1)
	(else (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))
((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (fb n)
      (cond ((= n 1) 0)
	    ((= n 2) 1)
	    (else (+ (fb fb (- n 1)) (fb fb (- n 2)))))))) 10)