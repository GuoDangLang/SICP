;;;a. because k is infinite the i,j would not increase due to this property;
(define (a-pythagorean-triples-starting-from low)
  (let ((k (an-integer-starting-from low)))
    (let ((i (an-integer-between 1 k)))
      (let ((j (an-integer-between i k)))
	(require (= (+ (* i i) (* j j)) (* k k)))
	(list i j k)))))
