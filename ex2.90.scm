(define (install-poly-sparse-package)
  (define (attach-tag tag contents)
    (cons tag contents))
  (define (tag x) (attach-tag 'sparse x))
  (define (empty-termlist? x)
    (null? x))
  (define (first-term spli)
    (if (empty-termlist? spli)
      '()
      (cadr spli)))
  (define (rest-terms spli)
    (if (empty-termlist? spli)
      '()
      (cddr spli)))
  (define (make-term-sparse order coeff)
    (cons order coeff))
  (define (adjoin-term-sparselist term termlist)
    (if (=zero? (coeff term)
		termlist
		(cons term (cdr term-list)))))
  (put 'empty-termlist? 'sparse empty-termlist?)
  (put 'first-term 'sparse first-term)
  (put 'rest-terms 'sparse (lambda (term-list) (tag (rest-terms term-list))))
  (put 'make-term 'sparse make-term-sparse)
  (put 'adjoin-term 'sparse (lambda (term term-list) (tag (adjoin-term-sparselist term term-list))))
  'done)
(define (install-dense-package)
  (define (order x) (car x))
  (define (coeff x) (cdr x))
  (define (empty-termlist? x)
    (null? x))
  (define (first-term spli)
    (if (empty-termlist? spli)
      '()
      (cons (- (length spli) 1) (cadr spli))))
  (define (rest-terms spli)
    (if (empty-termlist? spli)
      '()
      (cddr spli)))
  (define (make-term-dense order coeff)
    (cons order coeff))
  (define (adjoin-term-denselist term termlist)
    (if (=zero? (coeff term))
      termlist
      (let ((o (order term)) 
	    (c (coeff term))
	    (contents (cdr termlist)))
	(define (iter-inser times contents)
	  (if (= times o)
	    (cons (add (car contents) c) (cdr termlist))
	    (cons (car contents) (iter-inser (- times 1) (cdr contents))))))
	(iter-inser (- (length contents) 1) contents)))
  (put 'empty-termlist? 'dense (lambda (x) (empty-termlist? x)))
  (put 'first-term 'dense (lambda (x) (first-term x)))
  (put 'rest-terms 'dense (lambda (x) (tag (rest-terms x))))
  (put 'make-term 'dense (lambda (x y) (make-term-dense x y)))
  (put 'adjoin-term 'dense (lambda (term termlist) (tag (adjoin-term-denselist term termlist))))
  'done)

  

