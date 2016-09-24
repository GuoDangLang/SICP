(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((painter-up 
	    (transform-painter painter2
			       split-point
			       (make-vect 1.0 0.0)
			       (make-vect 0.0 1.0)))
	  (painter-low
	    (transform-painter painter1
			       (make-vect 0.0 0.0)
			       (maek-vect 1.0 0.0)
			       (split-point))))
      (lambda (frame)
	(painter-up frame)
	(painter-low frame)))))
(define (below painter1 painter2)
  (lambda (frame)
    (rotate90 (beside (rotate270 painter1) (rotate270 painter2))) frame))
