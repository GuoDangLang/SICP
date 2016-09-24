(define rand-init 0)
(define (rand-update x) (+ x 10))
(define rand
  (let ((memo rand-init))
    (define (dispatch m)
      (cond ((eq? m 'generate) (set! memo (rand-update memo)) memo)
	    ((eq? m 'reset) (lambda (x) (set! memo x) x))
	    (else "sorry")))
    dispatch))
      
  
