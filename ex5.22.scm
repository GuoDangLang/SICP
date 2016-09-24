(define append-machine
  (make-machine
    '(l1 l2 val continue)
    (list
	 (list 'null? null?))
    '(controller
       (initialize)
       (assign continue (label end))
       append
       (test (op null?) (reg l1))
       (branch (label base-case))
       (assign val (op car) (reg l1))
       (save continue)
       (save val)
       (assign l1 (op cdr) (reg l1))
       (assign continue (label recur))
       (goto (label append))
       recur
       (assign continue (reg val))
       (restore val)
       (assign val (op cons) (reg val) (reg continue))
       (restore continue)
       (goto (reg continue))
       base-case
       (assign val (reg l2))
       (goto (label recur))
       end
       (perform (op print) (reg val))
       (statistics))))
(set-register-contents! append-machine 'l1 (list 1 2))
(set-register-contents! append-machine 'l2 (list 3 4))
(define append!-machine
  (make-machine
    '(l1 l2 val continue)
    (list 
      (list 'null? null?))
    '(controller
       (initialize)
       (assign continue (label end))
       append!
       


      
