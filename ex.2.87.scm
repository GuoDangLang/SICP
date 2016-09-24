(define (install-zero?-pacaage)
  (define (=zero?-poly  coeff)
    (if (null? coeff) true
      false))
  (define (=zero?-scheme-num coeff)
    (if (= 0 coeff) true
      false))
  (put '=zero? 'polynomial =zero?-ploy)
  (put '=zero? 'scheme-num =zero?-scheme-num)
  'done)
