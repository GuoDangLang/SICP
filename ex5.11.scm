;1.
;replace (assign n (reg val)) and (restore val) with (restore n); then n contains fib (n - 1), val contains (n - 2),add them,get the next val. the procedure works still;
;2.
(define (make-save inst machine stack pc)
  (let ((reg (get-register machine
			   (stack-inst-reg-name inst))))
    (lambda ()
      (push stack (cons (stack-inst-reg-name inst) (get-contents reg)))
      (advance-pc pc))))`
(define (make-resore inst machine stack pc)
  (let ((reg (get-register machine (stack-inst-reg-name inst))))
    (lambda ()
      (let ((reg-value (pop stack)))
	(if (not (equal? (car reg-value) (stack-inst-reg-name inst)))
	  (error "Unmatched registernames" (stack-inst-reg-name inst))
	  (begin (set-contents! reg (cdr reg-value)) (advance-pc pc)))))))
;3.Delete the machine's stack,give every register a stack;
;see ex5.11-3.scm

