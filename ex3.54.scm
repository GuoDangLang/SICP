(load "stream-pac")
(define factorials (cons-stream 1 (mul-stream (integers-starting-from 2)
					      factorials)))

