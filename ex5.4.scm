;1.
(controller
  (assign b (read))
  (assign n (read))
  (assign continue (label expt-done))
  expt-loop
  (test (op =) (reg n) (const 0))
  (branch (label base-case))
  (save continue)
  (assign n (op -) (reg n) (const 1))
  (assign continue (after-expt))
  (goto expt-loop)
  after-expt
  (restore n)
  (restore continue)
  (assign val (op *) (reg b) (reg val))
  (goto (reg continue))
  base-case
  (assign val (const 1))
  (goto (reg continue))
  expt-done)
;2.
(controller
  (assign b (read))
  (assign n (read))
  (assign product (const 1))
  (assign counter (reg n))
  it-expt-loop
  (test (op =) (reg counter) (const 0))
  (branch (label loop-done))
  (assign counter (op -) (reg counter) (const 1))
  (assign product (op *) (reg b) (reg product))
  (goto (label it-epxt-loop))
  loop-done)
(define expt-machine
  (make-machine
    '(b n product counter)
    (list (list '- -) (list '* *) (list '= =))
    '(expt-body
       (assign product (const 1))
       (assign counter (reg n))
       it-expt-loop
       (test (op =) (reg counter) (const 0))
       (branch (label loop-done))
       (assign counter (op -) (reg counter) (const 1))
       (assign product (op *) (reg b) (reg product))
       (goto (label it-expt-loop))
       loop-done)))

