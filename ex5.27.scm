(load "5.4.scm")
(load "ex5.19.scm")
(define (get-global-environment)
  the-global-environment)
(define (no-more-exps? seq) (null? seq))
(define (adjoin-arg arg arglist)
  (append arglist (list arg)))
(define (last-operand? ops)
  (null? (cdr ops)))
(define (empty-arglist) '())
(define eceval-operations
  (list 
    (list 'car car)
    (list 'cdr cdr)
    (list 'cons cons)
    (list 'self-evaluating? self-evaluating?)
    (list 'user-pint user-print)
    (list 'get-global-environment get-global-environment)
    (list 'announce-output announce-for-output)
    (list 'empty-arglist empty-arglist)
    (list 'variable? variable?)
    (list 'quoted? quoted?)
    (list 'assignment? assignment?)
    (list 'definition? definition?)
    (list 'if? if?)
    (list 'lambda? lambda?)
    (list 'begin? begin?)
    (list 'application? application?)
    (list 'lookup-variable-value lookup-variable-value)
    (list 'text-of-quotation text-of-quotation)
    (list 'lambda-parameters lambda-parameters)
    (list 'lambda-body lambda-body)
    (list 'make-procedure make-procedure)
    (list 'operands operands)
    (list 'operator operator)
    (list 'adjoin-arg adjoin-arg)
    (list 'last-operand? last-operand?)
    (list 'no-operands? no-operands?)
    (list 'first-operand first-operand)
    (list 'rest-operands rest-operands)
    (list 'primitive-procedure? primitive-procedure?)
    (list 'compound-procedure? compound-procedure?)
    (list 'apply-primitive-procedure apply-primitive-procedure)
    (list 'procedure-parameters procedure-parameters)
    (list 'procedure-environment procedure-environment)
    (list 'extend-environment extend-environment)
    (list 'procedure-body procedure-body)
    (list 'begin-actions begin-actions)
    (list 'first-exp first-exp)
    (list 'last-exp? last-exp?)
    (list 'rest-exps rest-exps)
    (list 'no-more-exps? no-more-exps?)
    (list 'if-predicate if-predicate)
    (list 'true? true?)
    (list 'if-alternative if-alternative)
    (list 'if-consequent if-consequent)
    (list 'assignment-variable assignment-variable)
    (list 'assignment-value assignment-value)
    (list 'set-variable-value! set-variable-value!)
    (list 'definition-variable definition-variable)
    (list 'definition-value definition-value)
    (list 'define-variable! define-variable!)
    (list 'prompt-for-input prompt-for-input)
    (list 'user-print user-print)
    (list 'cond? cond?)
    (list 'cond-else-clause? cond-else-clause?)
    (list 'cond-predicate cond-predicate)
    (list 'cdar cdar)
    (list 'cond-clauses cond-clauses)
    (list 'let? let?)
    (list 'let-body let-body)
    (list 'let-vars let-vars)
    (list 'let-exprs let-exprs)
    (list 'cond->if cond->if)
    (list 'make-lambda make-lambda)
    ))
(define eceval
  (make-machine
    '(exp env val proc argl continue unev)
    eceval-operations
    '(
      read-eval-print-loop
      (initialize) ;(perform (op initialize-stack))
      (perform 
	(op prompt-for-input) (const ";;; EC-Eval input:"))
      (assign exp (op read))
      (assign env (op get-global-environment))
      (assign continue (label print-result))
      (goto (label eval-dispatch))
      print-result
      (statistics)
      (perform
	(op announce-output) (const ";;; EC-Eval value:"))
      (perform (op user-print) (reg val))
      (goto (label read-eval-print-loop))
      unknown-expression-type
      (assign val (const unknown-expression-type-error))
      (goto (label signal-error))
      unknown-procedure-type
      (restore continue)
      (assign val (const unknown-procedure-type-error))
      (goto (label signal-error))
      signal-error
      (perform (op user-print) (reg val))
      (goto (label read-eval-print-loop))
      eval-dispatch
      (test (op self-evaluating?) (reg exp))
      (branch (label ev-self-eval))
      (test (op variable?) (reg exp))
      (branch (label ev-variable))
      (test (op quoted?) (reg exp))
      (branch (label ev-quoted))
      (test (op assignment?) (reg exp))
      (branch (label ev-assignment))
      (test (op definition?) (reg exp))
      (branch (label ev-definition))
      (test (op if?) (reg exp))
      (branch (label ev-if))
      (test (op cond?) (reg exp))
      (branch (label ev-cond))
      (test (op lambda?) (reg exp))
      (branch (label ev-lambda))
      (test (op let?) (reg exp))
      (branch (label ev-let))
      (test (op begin?) (reg exp))
      (branch (label ev-begin))
      (test (op application?) (reg exp))
      (branch (label ev-application))
      (goto (label unknown-expression-type))
      ev-self-eval
      (assign val (reg exp))
      (goto (reg continue))
      ev-variable
      (assign val (op lookup-variable-value) (reg exp) (reg env))
      (goto (reg continue))
      ev-quoted
      (assign val (op text-of-quotation) (reg exp))
      (goto (reg continue))
      ev-lambda
      (assign unev (op lambda-parameters) (reg exp))
      (assign exp (op lambda-body) (reg exp))
      (assign val (op make-procedure)
	      (reg unev) (reg exp) (reg env))
      (goto (reg continue))
      ev-let 
      (assign argl (op let-vars) (reg exp))
      (assign unev (op let-body) (reg exp))
      (assign proc (op make-lambda) (reg argl) (reg unev))
      (assign unev (op let-exprs) (reg exp))
      (assign exp (op cons) (reg proc) (reg unev))
      (goto (label eval-dispatch))
      ev-application
      (save continue)
      (save env)
      (assign unev (op operands) (reg exp))
      (save unev)
      (assign exp (op operator) (reg exp))
      (assign continue (label ev-appl-did-operator))
      (goto (label eval-dispatch))
      ev-appl-did-operator
      (restore unev)
      (restore env)
      (assign argl (op empty-arglist))
      (assign proc (reg val))
      (test (op no-operands?) (reg unev))
      (branch (label apply-dispatch))
      (save proc)
      ev-appl-operand-loop
      (save argl)
      (assign exp (op first-operand) (reg unev))
      (test (op last-operand?) (reg unev))
      (branch (label ev-appl-last-arg))
      (save env)
      (save unev)
      (assign continue (label ev-appl-accumulate-arg))
      (goto (label eval-dispatch))
      ev-appl-accumulate-arg
      (restore unev)
      (restore env)
      (restore argl)
      (assign argl (op adjoin-arg) (reg val) (reg argl))
      (assign unev (op rest-operands) (reg unev))
      (goto (label ev-appl-operand-loop))
      ev-appl-last-arg
      (assign continue (label ev-appl-accum-last-arg))
      (goto (label eval-dispatch))
      ev-appl-accum-last-arg
      (restore argl)
      (assign argl (op adjoin-arg) (reg val) (reg argl))
      (restore proc)
      (goto (label apply-dispatch))
      apply-dispatch
      (test (op primitive-procedure?) (reg proc))
      (branch (label primitive-apply))
      (test (op compound-procedure?) (reg proc))
      (branch (label compound-apply))
      (goto (label unknown-procedure-type))
      primitive-apply
      (assign val (op apply-primitive-procedure)
	      (reg proc)
	      (reg argl))
      (restore continue)
      (goto (reg continue))
      compound-apply
      (assign unev (op procedure-parameters) (reg proc))
      (assign env (op procedure-environment) (reg proc))
      (assign env (op extend-environment)
	      (reg unev) (reg argl) (reg env))
      (assign unev (op procedure-body) (reg proc))
      (goto (label ev-sequence))
      ev-begin
      (assign unev (op begin-actions) (reg exp))
      (save continue)
      (goto (label ev-sequence))
      ev-sequence
      (assign exp (op first-exp) (reg unev))
      (test (op last-exp?) (reg unev))
      (branch (label ev-sequence-last-exp))
      (save unev)
      (save env)
      (assign continue (label ev-sequence-continue))
      (goto (label eval-dispatch))
      ev-sequence-continue
      (restore env)
      (restore unev)
      (assign unev (op rest-exps) (reg unev))
      (goto (label ev-sequence))
      ev-sequence-last-exp
      (restore continue)
      (goto (label eval-dispatch))
      ev-if
      (save exp)
      (save env)
      (save continue)
      (assign continue (label ev-if-decide))
      (assign exp (op if-predicate) (reg exp))
      (goto (label eval-dispatch))
      ev-if-decide
      (restore continue)
      (restore env)
      (restore exp)
      (test (op true?) (reg val))
      (branch (label ev-if-consequent))
      ev-if-alternative
      (assign exp (op if-alternative) (reg exp))
      (goto (label eval-dispatch))
      ev-if-consequent
      (assign exp (op if-consequent) (reg exp))
      (goto (label eval-dispatch))
      ev-cond
      (save continue)
      (assign unev (op cond-clauses) (reg exp))
      ev-cond-loop
      (assign continue (label ev-cond-clause))
      (assign proc (op car) (reg unev))
      (save unev)
      (test (op cond-else-clause?) (reg proc))
      (branch (label ev-else-cond-clause))
      (assign exp (op cond-predicate) (reg proc))
      (goto (label eval-dispatch))
      ev-cond-clause
      (restore unev)
      (test (op true?) (reg val))
      (branch (label ev-cond-actions))
      (assign unev (op cdr) (reg unev))
      (goto (label ev-cond-loop))
      ev-cond-actions
      (assign unev (op cdar) (reg unev))
      (goto (label ev-sequence))
      ev-else-cond-clause
      (restore unev)
      (assign unev (op cdar) (reg unev))
      (goto (label ev-sequence))
      ev-assignment
      (assign unev (op assignment-variable) (reg exp))
      (save unev)
      (assign exp (op assignment-value) (reg exp))
      (save env)
      (save continue)
      (assign continue (label ev-assignment-1))
      (goto (label eval-dispatch))
      ev-assignment-1
      (restore continue)
      (restore env)
      (restore unev)
      (perform
	(op set-variable-value!) (reg unev) (reg val) (reg env))
      (assign val (const ok))
      (goto (reg continue))
      ev-definition
      (assign unev (op definition-variable) (reg exp))
      (save unev)
      (assign exp (op definition-value) (reg exp))
      (save env)
      (save continue)
      (assign continue (label ev-definition-1))
      (goto (label eval-dispatch))
      ev-definition-1
      (restore continue)
      (restore env)
      (restore unev)
      (perform
	(op define-variable!) (reg unev) (reg val) (reg env))
      (assign val (const ok))
      (goto (reg continue)))))
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
      product
      (iter (* counter product)
	    (+ counter 1))))
  (iter 1 1))
(define (fac n)
  (if (= n 1)
    1
    (* (fac (- n 1)) n)))