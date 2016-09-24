(load "stream-pac")
(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))
;;; it got the rational value of den divided by radix;
