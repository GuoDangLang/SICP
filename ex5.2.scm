(dada-paths
  (registers
    ((name n))
    ((name product )
     (buttons ((name product<-r) (source (operation *)))))
    ((name counter)
     (buttons ((name counter<-t) (source (operation +))))))
  (operations
    ((name *)
     (inputs (register product) (register counter)))
    ((name +)
     (inputs (register counter) (constant 1)))))
(controller
  (assign product (const 1))
  (assign counter (const 1))
  test-b
  (test >)
  (branch (label fib-done))
  (product<-r)
  (counter<-t)
  (goto (label test-b))
  fib-done)
(controller 
  (test (op >) (reg counter) (reg n))
  (branch (label fib-done))
  (assign product (op *) (reg counter) (reg product))
  (assign product (op +) (reg counter) (const 1))
  (goto (label test-b))
  fib-done)
