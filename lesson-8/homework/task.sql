DROP TABLE IF EXISTS Groupings;

CREATE TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
[Status]    VARCHAR(100) NOT NULL
);
INSERT INTO Groupings (StepNumber, TestCase, [Status]) 
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');

-----------------------------------------

DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');


-- 1 
WITH StatusGroups AS (
    SELECT
        StepNumber,
        TestCase,
        [Status],
        ROW_NUMBER() OVER (ORDER BY StepNumber) - 
        ROW_NUMBER() OVER (PARTITION BY [Status] ORDER BY StepNumber) AS GroupID
    FROM Groupings
)
SELECT 
    MIN(StepNumber) AS MinStepNumber,
    MAX(StepNumber) AS MaxStepNumber,
    [Status],
    COUNT(*) AS ConsecutiveCount
FROM StatusGroups
GROUP BY 
    GroupID, [Status]
ORDER BY 
    MinStepNumber;


---- 2 
WITH RecursiveYears AS (
    SELECT 1975 AS Year
    UNION ALL
    SELECT Year + 1
    FROM RecursiveYears
    WHERE Year < YEAR(GETDATE())
),
HiringYears AS (
  SELECT DISTINCT YEAR(HIRE_DATE) AS HiringYear
  FROM [dbo].[EMPLOYEES_N]
),
MissingHiringYears AS (
  SELECT
    ry.Year
  FROM RecursiveYears ry
  LEFT JOIN HiringYears hy ON ry.Year = hy.HiringYear
  WHERE hy.HiringYear IS NULL
),
YearIntervals AS (
  SELECT
    Year,
    ROW_NUMBER() OVER (ORDER BY Year) AS rn,
    Year - ROW_NUMBER() OVER (ORDER BY Year) AS diff
  FROM MissingHiringYears
),
ConsecutiveIntervals AS (
  SELECT
    MIN(Year) AS StartYear,
    MAX(Year) AS EndYear
  FROM YearIntervals
  GROUP BY diff
)
SELECT
  CASE
    WHEN StartYear = EndYear THEN CAST(StartYear AS VARCHAR(4))
    ELSE CAST(StartYear AS VARCHAR(4)) + ' - ' + CAST(EndYear AS VARCHAR(4))
  END AS Years
FROM ConsecutiveIntervals
ORDER BY StartYear;
