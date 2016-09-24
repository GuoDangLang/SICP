;add a dec or inc instruction;
;(assign x (op (+ (reg a) (reg b)))) 
;it's eazy to modify the syntax procedures to acomplish this;
(define (make-execution-procedure inst labels machin pc flags stack ops)
  (cond ((eq? (car inst) 'assign) ...)
	.
	.
	.
	((eq? (car inst) 'dec)
	 (make-dec inst machine pc))))
(define (make-dec inst machine pc)
  (let ((target (get-register machine (dec-reg-name inst))))
    (if target
      (begin (set-contents! target (- (get-contents target) 1))
      (advance-pc pc))
      (error "Unbound variable"))))
(define (dec-reg-name inst)
  (cadr inst))
