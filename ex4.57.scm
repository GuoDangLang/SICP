(rule (same ?x ?x))
(rule (replaced-by ?person2 ?person1)
      (and (job ?person1 ?job1)
	   (job ?person2 ?job2)
	   (or (same ?job1 ?job2)
	       (job ?person1 ?job2))
	   (not (same ?person1 ?person2))))
;;; a.
(replaced-by ?who (Cy D.Fect))
;;; b.
(and (replaced-by ?someone ?people)
     (salary ?someone ?amount)
     (salary ?people ?num)
     (lisp-value > ?amount ?num))




