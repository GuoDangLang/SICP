b.
(rule (meeting-time ?person ?day-and-time)
      (and (job ?person (?dept . ?w))
	   (or (meeting ?dept ?day-and-time)
	       (meeting the-whole-company ?day-and-time))))
;c
(and (meeting-time (Alyssa P.Hacker) (Wednesday . ?time))
     (meeting ?whatever (Wednesday . ?time)))
