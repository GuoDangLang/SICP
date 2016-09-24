(load "stream-pac")
(define rand-init 1)
(define (rand-update x)
  (+ x 10))
(define (random-generator command-stream)
  (define random
    (cons-stream rand-init
		 (stream-map (lambda (num command)
			       (cond ((null? command)
				      the-empty-stream)
				     ((eq? command 'generate)
				      (rand-update num))
				     ((and (pair? command)
					   (eq? (car command) 'reset))
				      (cdr command))
				     (else (error "Bad Command--" command))))
			     random command-stream)))
  random)
(define commands
  (cons-stream 'generate
	       (cons-stream (cons 'reset 10)
			    (cons-stream 'generate
					 commands))))
(define ans (random-generator commands))

