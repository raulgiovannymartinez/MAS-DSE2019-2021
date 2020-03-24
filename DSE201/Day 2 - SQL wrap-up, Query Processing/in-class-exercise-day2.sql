--Q1:
--find the students who take all classes that John Smith takes
--(do report students who take even more classes)

SELECT s.first_name, s.last_name
FROM   students s
WHERE  s.id NOT IN
     (SELECT  s_o.id
      FROM    students s_j, enrollment e_j, students s_o
      WHERE   s_j.id = e_j.student
      AND     s_j.first_name = "John" AND s_j.last_name = "Smith"
      AND     NOT EXISTS
              (SELECT 1
	       FROM   enrollment e_o
	       WHERE  e_o.student = s_o.id
	       AND    e_o.class = e_j.class))


--alternative:

SELECT s.first_name, s.last_name
FROM   students s
WHERE  s.id NOT IN
     (SELECT  s_o.id
      FROM    students s_j, enrollment e_j, students s_o
      WHERE   s_j.id = e_j.student
      AND     s_j.first_name = "John" AND s_j.last_name = "Smith"
      AND     e_j.class NOT IN
              (SELECT e_o.class
	       FROM   enrollment e_o
	       WHERE  e_o.student = s_o.id))


--But NOT the following, which would disqualify students who take
--all of John Smith's classes and more:

SELECT s.first_name, s.last_name
FROM   students s
WHERE  s.id NOT IN
     (SELECT  s_o.id
      FROM    students s_j, enrollment e_j, students s_o
      WHERE   s_j.id = e_j.student
      AND     s_j.first_name = "John" AND s_j.last_name = "Smith"
      AND     EXISTS
              (SELECT 1
	       FROM   enrollment e_o
	       WHERE  e_o.student = s_o.id
	       AND    e_o.class <> e_j.class))



--Q2:
--find the students who take ONLY (EXCLUSIVELY) classes that John Smith takes
--(do report students who take strictly fewer classes)
