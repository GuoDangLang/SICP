(define-syntax while
  (syntax-rules ()
		((while condition body)
		(begin (define while-iter (lambda () (if condition
		(begin body (while-iter))
		'done)))
		(while-iter)))))
;;;(define (while condition body)
  ;;;(define (while-iter)
    ;;;(if condition
      ;;;(begin body (while-iter))
      ;;;'done))
  ;;;(while-iter))
(define (test-while x)
  (while (< x 10) (begin (set! x (+ x 2)) (display x))))
