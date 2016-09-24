(define (make-zero-crossings input-stream last-value)
  (cons-stream 
    (sign--change-detector (stream-car input-stream) last-value)
    (make-zero-crossing (stream-cdr input-stream)
			(stream-car input-stream))))
(define zero-crossings (make-zero-crossings sense-data 0))
(load "stream-pac")
(define zero-crossings
    (stream-map sign-change-detector sense-data (stream-cdr sense-data)))
(define zero-crossing
    (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))
;;;the second one is equivalent to the book's vesion
;;;;;;the first one is my idea,i think it's the very beginning of the signal.
