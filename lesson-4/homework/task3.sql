-- Write a query which will find the Date of Birth of employees whose birthdays lies between May 7 and May 15.

CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';


SELECT EmpId, EmpName, BirthDate
FROM EmpBirth
WHERE MONTH(BirthDate) = 5 
  AND DAY(BirthDate) BETWEEN 7 AND 15;
