(load "ex3.78.scm")
(define (solve-2nd-general f y0 dy0 dt)
  (define d (integral (delay dd) dy0 dt))
  (define y (integral (delay d) y0 dt))
  (define dd (f d y))
  y)