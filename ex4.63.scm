(rule (grandson-of ?x ?y)
      (and (son-of ?x ?f)
	   (son-of ?f ?y)))
(rule (son-of ?x ?y)
      (or (son ?y ?x)
	  (and (son ?z ?x)
	       (wife ?z ?y))))
	  
