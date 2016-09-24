;;;a.In the class The professor who has a cat lectures the student;
(sentence 
  (simple-noun-phrase (article the) (noun professor)) 
  (verb-phrase 
    (verb-phrase 
      (verb-phrase 
	(verb lectures) (prep-phrase (prep to) 
				     (simple-noun-phrase (article the) (noun student)))) 
      (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))) 
    (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))
;;;b.The professor lectures to the student,in the class that has a cat in it;
(sentence 
  (simple-noun-phrase (article the) (noun professor)) 
  (verb-phrase 
    (verb-phrase (verb lectures) 
		 (prep-phrase (prep to) (simple-noun-phrase (article the) (noun student)))) 
    (prep-phrase (prep in) 
		 (noun-phrase (simple-noun-phrase (article the) (noun class)) 
			      (prep-phrase (prep with) 
					   (simple-noun-phrase (article the) (noun cat)))))))
;;;c.The professor lectures to the student that is in the class and he lectures him with the cat;
(sentence 
  (simple-noun-phrase (article the) (noun professor)) 
  (verb-phrase 
    (verb-phrase (verb lectures) 
		 (prep-phrase (prep to) 
			      (noun-phrase 
				(simple-noun-phrase (article the) (noun student)) 
				(prep-phrase (prep in) 
					     (simple-noun-phrase (article the) (noun class)))))) 
    (prep-phrase (prep with) 
		 (simple-noun-phrase (article the) (noun cat)))))
;;;d.The professor lectures to the student who is in the class and has a cat.
(sentence 
  (simple-noun-phrase (article the) (noun professor)) 
  (verb-phrase (verb lectures) 
	       (prep-phrase (prep to) 
			    (noun-phrase 
			      (noun-phrase 
				(simple-noun-phrase (article the) (noun student)) 
				(prep-phrase (prep in) 
					     (simple-noun-phrase (article the) (noun class)))) 
			      (prep-phrase (prep with) 
					   (simple-noun-phrase (article the) (noun cat)))))))
;;;e.The professor lectures to the student who is in the class that has a cat in it;
(sentence 
  (simple-noun-phrase (article the) (noun professor)) 
  (verb-phrase (verb lectures) 
	       (prep-phrase (prep to) 
			    (noun-phrase 
			      (simple-noun-phrase (article the) (noun student)) 
			      (prep-phrase (prep in) 
					   (noun-phrase 
					     (simple-noun-phrase (article the) (noun class)) 
					     (prep-phrase (prep with) 
							  (simple-noun-phrase (article the) 
									      (noun cat)))))))))
