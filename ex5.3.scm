;1.
(controller
  (assign x (op read))
  (assign guess (const 1.0))
  test-goog
  (test (op good-enough?) (reg guess) (reg x))
  (branch (label done))
  (assign t (op improve) (reg x) (reg guess))
  (assign guess (reg t))
  done
  (perform (op print) (reg guess))
  )
;2.
;good-enough?
(controller
  (assign x (op read))
  (assign guess (const 1.0))
  (assign square (op *) (reg guess) (reg guess))
  (assign d (op -) (reg square) (reg x))
  test-neg-or-pos
  (test (op <) (reg d) (const 0))
  (branch (label test-neg))
  (assign abs (reg d))
  (goto test-end)
  test-neg
  (assign temp (op -) (reg 0) (reg d))
  (assign abs (reg temp))
  test-end
  (test (op <) (reg abs) (const 0.001)))
;improve 
(controller
  (assign x (op read))
  (assign guess (const 1.0))
  (assign div (op /) (reg x) (reg guess))
  (assign add (op +) (reg guess) (reg div))
  (assign average (op /) (reg add) (const 2.0))
  (perform (op print) (reg average)))
;it's eazy to combine them all together;
;




