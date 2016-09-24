(load "stream-pac")
(define (sqrt-improve guess x)
  (/ (+ guess (/ x guess)) 2))
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
		 (stream-map (lambda (guess)
			       (sqrt-improve guess x))
			     guesses)))
  guesses)
(define (stream-limit s tolerance)
  (let ((former (stream-car s))
	(later (stream-car (stream-cdr s))))
    (if (< (abs (- later former)) tolerance)
      later
      (stream-limit (stream-cdr s) tolerance))))
(define (sqrtt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
