(define (adj-positions positions k)
  (filterr (lambda (x) (not (= (car x) k))) positions)) 
(define (safe? k positions)
  (let ((stan (cadr (car (filterr (lambda (x) (= (car x) k)) positions)))))
    (accumulate (lambda (x y) (if (= (cadr x) stan) false
				y)) true (adj-positions positions k))))
(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list (list k new-row))))
(define empty-board
  (list (list 0 0)))
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filterr 
	(lambda (positions) (safe? k positions))
	(flatmap
	  (lambda (rest-of-queens)
	    (map (lambda (new-row)
		   (adjoin-position new-row k rest-of-queens))
		 (enumerate-interval 1 board-size)))
	  (queen-cols (- k 1))))))
  (queen-cols board-size))
