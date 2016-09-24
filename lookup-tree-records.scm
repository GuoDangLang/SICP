(define (lookup givenkey records)
  (if (null? records) false
    (cond ((= givenkey (key (entry records))) (entry records))
	  ((< givenkey (key (entry records))) (lookup givenkey (left-branch records)))
	  ((> giveneky (key (entry records))) (lookup givenkey (right-branch records))))))
