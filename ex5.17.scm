;Table
(define (tagged-list? li x)
  (if (pair? li)
    (eq? (car li) x)
    false))
(define (assoc key records)
  (if (null? records)
    false
    (if (equal? key (caar records)) (car records)
      (assoc key (cdr records)))))
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
	(if subtable
	  (let ((record (assoc key-2 (cdr subtable))))
	    (if record
	      (cdr record)
	      false))
	  false)))
    (define (insert! key1 key2 value)
      (let ((subtable (assoc key1 (cdr local-table))))
	(if subtable
	  (let ((record (assoc key2 (cdr subtable))))
	    (if record
	      (set-cdr! record value)
	      (set-cdr! subtable (cons (cons key2 value) (cdr subtable)))))
	  (set-cdr! local-table (cons (list key1 (cons key2 value))
				      (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
	    ((eq? m 'insert-proc!) insert!)
	    (else (error "Unkown operation -- TABLE" m))))
    dispatch))
;;;5.2.1The Machine Model
(define (make-machine register-names ops controller-text)
  (let ((machine (make-new-machine)))
    (for-each (lambda (register-name)
		((machine 'allocate-register) register-name))
	      register-names)
	      ((machine 'install-operations) ops)
	      ((machine 'install-instruction-sequence)
	       (assemble controller-text machine))
	      (define (dispatch m)
		(cond ((eq? m 'trace-on) (if (machine m) (begin ((machine 'install-instruction-sequence) (assemble controller-text machine)) 'ok)))
		      ((eq? m 'trace-off) (if (machine m) (begin ((machine 'install-instruction-sequence) (assemble controller-text machine)) 'ok)))
		      (else (machine m))))
	      dispatch))
;Register
(define (make-register name)
  (let ((contents '*unassigned*))
    (define (dispatch message)
      (cond ((eq? message 'get) contents)
	    ((eq? message 'set)
	     (lambda (value) (set! contents value)))
	    (else 
	      (error "Unkown request -- REGISTER" message))))
    dispatch))
(define (get-contents register)
  (register 'get))
(define (set-contents! register value)
  ((register 'set) value))
;The stack
(define (make-stack)
  (let ((s '())
	(number-pushes 0)
	(max-depth 0)
	(current-depth 0))
    (define (push x)
      (set! s (cons x s))
      (set! number-pushes (+ 1 number-pushes))
      (set! current-depth (+ 1 current-depth))
      (set! max-depth (max current-depth max-depth)))
    (define (pop)
      (if (null? s)
	(error "Empty stack -- POP")
	(let ((top (car s)))
	  (set! s (cdr s))
	  (set! current-depth (- current-depth 1))
	  top)))
    (define (initialize)
      (set! s '())
      (set! number-pushes 0)
      (set! max-depth 0)
      (set! current-depth 0)
      'done)
    (define (print-statistics)
      (newline)
      (display (list 'total-pushes '= number-pushes
		     'maximum-depth '= max-depth)))
    (define (dispatch message)
      (cond ((eq? message 'push) push)
	    ((eq? message 'pop) (pop))
	    ((eq? message 'initialize) (initialize))
	    ((eq? message 'ps)
	     (print-statistics))
	    (else
	      (error "Unkown request -- STACK" message))))
    dispatch))
(define (pop stack)
  (stack 'pop))
(define (push stack x)
  ((stack 'push) x))
;The basic machine
(define (make-new-machine)
  (let ((pc (make-register 'pc))
	(flag (make-register 'flag))
	(stack (make-stack))
	(tflag 0)
	(the-instruction-sequence '())
	(inst-counter (make-register 'counter)))
    (let ((the-ops
	    (list (list 'initialize-stack
			(lambda () (stack 'initialize)))
		  (list 'print-stack-statistics
			(lambda () (stack 'print-statistics)))
		  (list 'read (lambda () (newline) (display "please input: ") (read)))
		  (list 'print (lambda (x) (display "   ==>>   ") (display x)))))
	  (register-table
	    (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
	(if (assoc name register-table)
	  (error "Multiply defined register : " name)
	  (set! register-table
	    (cons (list name (make-register name))
		  register-table)))
	'register-allocated)
      (define (lookup-register name)
	(let ((val (assoc name register-table)))
	  (if val
	    (cadr val)
	    (error "Unkown register: " name))))
      (define (print-inst-counter)
	(display "There are ")
	(display (get-contents inst-counter))
	(display " instructions being evaluated!")
	(set-contents! inst-counter 0))
      (define (execute)
	(let ((insts (get-contents pc)))
	  (if (null? insts)
	    'done
	    (begin ((instruction-execution-proc (car insts)))
		   (execute)))))
    (define (dispatch message)
      (cond ((eq? message 'start)
	     (set-contents! pc the-instruction-sequence)
	     (execute))
	    ((eq? message 'install-instruction-sequence)
	     (lambda (seq) (set! the-instruction-sequence seq)))
	    ((eq? message 'allocate-register) allocate-register)
	    ((eq? message 'get-register) lookup-register)
	    ((eq? message 'install-operations)
	     (lambda (ops) (set! the-ops (append the-ops ops))))
	    ((eq? message 'stack) stack)
	    ((eq? message 'trace-on) (if (= tflag 1) false (begin (set! tflag 1) true)))
	    ((eq? message 'trace-off) (if (= tflag 0) false (begin (set! tflag 0) true)))
	    ((eq? message 'operations) the-ops)
	    ((eq? message 'print-insts) (print-inst-counter))
	    ((eq? message 'tflag) tflag)
	    ((eq? message 'counter) inst-counter)
	    (else (error "Unkown request -- MACHINE" message))))
    (set-contents! inst-counter 0)
    dispatch)))
(define (start machine)
  (machine 'start))
(define (get-register-contents machine register-name)
  (get-contents (get-register machine register-name)))
(define (set-register-contents! machine register-name value)
  (set-contents! (get-register machine register-name) value)
  'done)
(define (get-register machine reg-name)
  ((machine 'get-register) reg-name))
;;;5.2.2 The Assembler
(define (assemble controller-text machine)
  (extract-labels controller-text
		  (lambda (insts labels)
		    (define (walk-labels labels)
		      (if (null? labels)
			'ok
			(let ((label-name (caar labels))
			      (insts (cdar labels)))
			  (map (lambda (inst) (set-cdr! (car inst) label-name)) insts)
			  (walk-labels (cdr labels)))))
		    (walk-labels labels)
		    (update-insts! insts labels machine)
		    insts)))
(define (extract-labels text receive)
  (if (null? text)
    (receive '() '())
    (extract-labels (cdr text)
		    (lambda (insts labels)
		      (let ((next-inst (car text)))
			(if (symbol? next-inst)
			  (receive insts
				   (cons (make-label-entry next-inst insts)
					 labels))
			  (receive (cons (make-instruction next-inst)
					 insts)
				   labels)))))))
(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
	(flag (get-register machine 'flag))
	(stack (machine 'stack))
	(ops (machine 'operations))
	(counter (machine 'counter))
	(tflag (machine 'tflag)))
    (for-each
      (lambda (inst)
	(set-instruction-execution-proc!
	  inst
	  (make-execution-procedure
	    inst labels machine pc flag stack ops counter tflag)))
      insts)))
(define (make-instruction text)
  (cons (cons text '()) '()))
(define (instruction-text inst)
  (caar inst))
(define (instruction-label inst)
  (cdar inst))
(define (instruction-execution-proc inst)
  (cdr inst))
(define (set-instruction-execution-proc! inst proc)
  (set-cdr! inst proc))
(define (make-label-entry label-name insts)
  (cons label-name insts))
(define (lookup-label labels label-name)
  (let ((val (assoc label-name labels)))
    (if val
      (cdr val)
      (error "Undefined label -- ASSEMBLE" label-name))))
(define (make-execution-procedure inst labels machine pc flag stack ops counter tflag)
  (cond ((eq? (car (instruction-text inst)) 'assign)
	 (make-assign inst machine labels ops pc counter tflag))
	((eq? (car (instruction-text inst)) 'test)
	 (make-test inst machine labels ops flag pc counter tflag))
	((eq? (car (instruction-text inst)) 'branch)
	 (make-branch inst machine labels flag pc counter tflag))
	((eq? (car (instruction-text inst)) 'goto)
	 (make-goto inst machine labels pc counter tflag))
	((eq? (car (instruction-text inst)) 'save)
	 (make-save inst machine stack pc counter tflag))
	((eq? (car (instruction-text inst)) 'restore)
	 (make-restore inst machine stack pc counter tflag))
	((eq? (car (instruction-text inst)) 'perform)
	 (make-perform inst machine labels ops pc counter tflag))
	((eq? (car (instruction-text inst)) 'initialize)
	 (make-initialize machine pc counter tflag))
	((eq? (car (instruction-text inst)) 'statistics)
	 (make-statistics machine pc counter tflag))
	(else (error "Unkown instruction type --ASSEMBLE" inst))))
;Statistics instructions
(define (make-statistics machine pc counter tflag)
  (lambda ()
    (if (= tflag 1) (begin (newline) (display "(statistics)")))
    ((machine 'stack) 'ps)
    (advance-pc pc counter)))
;Initialize instructions
(define (make-initialize machine pc counter tflag)
  (lambda ()
    (if (= tflag 1) (begin (newline) (display "(initialize)")))
    ((machine 'stack) 'initialize)
    (advance-pc pc counter)))
;Assign instructions
(define (make-assign inst machine labels operations pc counter tflag)
  (let ((target 
	  (get-register machine (assign-reg-name inst)))
	(value-exp (assign-value-exp inst)))
    (let ((value-proc
	    (if (operation-exp? value-exp)
	      (make-operation-exp
		value-exp machine labels operations)
	      (make-primitive-exp
		(car value-exp) machine labels))))
      (lambda ()
	(if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ")
			       (display (instruction-label inst))))
	(set-contents! target (value-proc))
	(advance-pc pc counter)))))
(define (assign-reg-name assign-instruction)
  (cadr (instruction-text assign-instruction)))
(define (assign-value-exp assign-instruction)
  (cddr (instruction-text assign-instruction)))
(define (advance-pc pc counter)
  (set-contents! pc (cdr (get-contents pc)))
  (set-contents! counter (+ (get-contents counter) 1)))
;Test,branch and goto instruction
(define (make-test inst machine labels operations flag pc counter tflag)
  (let ((condition (test-condition inst)))
    (if (operation-exp? condition)
      (let ((condition-proc
	      (make-operation-exp
		condition machine labels operations)))
	(lambda ()
	  (if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ")
				 (display (instruction-label inst))))
	  (set-contents! flag (condition-proc))
	  (advance-pc pc counter)))
      (error "Bad TEST instruction -- ASSEMBLE" inst))))
(define (test-condition test-instruction)
  (cdr (instruction-text test-instruction)))
(define (make-branch inst machine labels flag pc counter tflag)
  (let ((dest (branch-dest inst)))
    (if (label-exp? dest)
      (let ((insts
	      (lookup-label labels (label-exp-label dest))))
	(lambda ()
	  (if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ")
				 (display (instruction-label inst))))
	  (if (get-contents flag)
	    (begin (set-contents! pc insts) (set-contents! counter (+ (get-contents counter) 1)))
	    (advance-pc pc counter))))
      (error "Bad BRANCH instruction -- ASSEMBLE" inst))))
(define (branch-dest branch-instruction)
  (cadr (instruction-text branch-instruction)))

(define (make-goto inst machine labels pc counter tflag)
  (let ((dest (goto-dest inst)))
    (cond ((label-exp? dest)
	   (let ((insts
		   (lookup-label labels (label-exp-label dest))))
	     (lambda () 
	       (if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ")
				      (display (instruction-label inst))))
	       (set-contents! pc insts) (set-contents! counter (+ (get-contents counter) 1)))))
	  ((register-exp? dest)
	   (let ((reg
		   (get-register machine 
				 (register-exp-reg dest))))
	     (lambda ()
	       (if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ")
				      (display (instruction-label inst))))
	       (set-contents! pc (get-contents reg)) (set-contents! counter (+ (get-contents counter) 1)))))
	  (else (error "Bad GOTO instruction -- ASSEMbzlE" inst)))))
(define (goto-dest instruction)
  (cadr (instruction-text instruction)))
;Other instructions
(define (make-save inst machine stack pc counter tflag)
  (let ((reg (get-register machine (stack-inst-reg-name inst))))
    (lambda ()
      (if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ") (display (instruction-label inst))))
      (push stack (get-contents reg))
      (advance-pc pc counter))))
(define (make-restore inst machine stack pc counter tflag)
  (let ((reg (get-register machine (stack-inst-reg-name inst))))
    (lambda ()
      (if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ") (display (instruction-label inst))))
      (set-contents! reg (pop stack))
      (advance-pc pc counter))))
(define (stack-inst-reg-name stack-instruction)
  (cadr (instruction-text stack-instruction)))

(define (make-perform inst machine labels operations pc counter tflag)
  (let ((action (perform-action inst)))
    (if (operation-exp? action)
      (let ((action-proc
	      (make-operation-exp
		action machine labels operations)))
	(lambda ()
	  (if (= tflag 1) (begin (newline) (display (instruction-text inst)) (display " => Belongs to: ") (display (instruction-label inst))))
	  (action-proc)
	  (advance-pc pc counter)))
      (error "Bad PERFORM instruction -- ASSEMBLE" inst))))
(define (perform-action inst) (cdr (instruction-text inst)))
;Execution procedures for subexpressions
(define (make-primitive-exp exp machine labels)
  (cond ((constant-exp? exp)
	 (let ((c (constant-exp-value exp)))
	   (lambda () c)))
	((label-exp? exp)
	 (let ((insts
		 (lookup-label labels
			       (label-exp-label exp))))
	   (lambda () insts)))
	((register-exp? exp)
	 (let ((r (get-register machine
				(register-exp-reg exp))))
	   (lambda () (get-contents r))))
	(else 
	  (error "Unkown expression type -- ASSEMbzlE" exp))))
(define (register-exp? exp) (tagged-list? exp 'reg))
(define (register-exp-reg exp) (cadr exp))
(define (constant-exp? exp) (tagged-list? exp 'const))
(define (constant-exp-value exp) (cadr exp))
(define (label-exp? exp) (tagged-list? exp 'label))
(define (label-exp-label exp) (cadr exp))

(define (make-operation-exp exp machine labels operations)
  (let ((op (lookup-prim (operation-exp-op exp) operations))
	(aprocs
	  (map (lambda (e)
		 (make-primitive-exp e machine labels))
	       (operation-exp-operands exp))))
    (lambda ()
      (apply op (map (lambda (p) (p)) aprocs)))))
(define (operation-exp? exp)
  (and (pair? exp) (tagged-list? (car exp) 'op)))
(define (operation-exp-op operation-exp)
  (cadr (car operation-exp)))
(define (operation-exp-operands operation-exp)
  (cdr operation-exp))
(define (lookup-prim symbol operations)
  (let ((val (assoc symbol operations)))
    (if val
      (cadr val)
      (error "Unkown operation -- ASSEMBLE" symbol))))
;;trial
(define expt-machine
  (make-machine
    '(b n product counter)
    (list (list '- -) (list '* *) (list '= =))
    '(expt-body
       (initialize)
       (assign b (op read))
       (assign n (op read))
       (assign product (const 1))
       (assign counter (reg n))
       it-expt-loop
       (test (op =) (reg counter) (const 0))
       (branch (label loop-done))
       (assign counter (op -) (reg counter) (const 1))
       (assign product (op *) (reg b) (reg product))
       (goto (label it-expt-loop))
       loop-done
       (perform (op print) (reg product))
       (statistics)
       (goto (label expt-body))
       )))
