;;;Until we learn how to build the amb evaluator, we can only use the traditional way to work it out;
(define (detemine-floor)
  (define (merge x)
    (if (null? x)
      '()
      (append (car x) (merge (cdr x)))))
  (define (walk-one2five li)
    (list (cons 1 li) (cons 2 li) (cons 3 li) (cons 4 li) (cons 5 li)))
  (define (get-list list n)
    (if (= n 0)
      list
      (get-list (merge (map (lambda (x) (walk-one2five x)) list)) (- n 1))))
  (define (distinct? li)
    (cond ((null? li) true)
	  ((null? (cdr li)) true)
	  ((member (car li) (cdr li)) false)
	  (else (distinct? (cdr li)))))
  (let ((obj-list (get-list (list '()) 5)))
    (define (met list)
      (if (null? list)
	'()
	(let ((baker (car (car list)))
	      (cooper (cadr (car list)))
	      (fletcher (caddr (car list)))
	      (miller (cadddr (car list)))
	      (smith (cadr (cdddr (car list)))))
	  (cond ((not (distinct? (car list))) (met (cdr list)))
		((= baker 5) (met (cdr list)))
		((= cooper 1) (met (cdr list)))
		((= fletcher 5) (met (cdr list)))
		((= fletcher 1) (met (cdr list)))
		((<= miller cooper) (met (cdr list)))
		((= (abs (- fletcher cooper)) 1) (met (cdr list)))
		(else (cons (car list) (met (cdr list))))))))
    (met obj-list)))

	  
