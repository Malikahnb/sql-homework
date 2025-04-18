CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

---- Task 1
WITH EmployeeHierarchy AS (
    SELECT
        EmployeeID,
        ManagerID,
        JobTitle,
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL -- The President has no manager

    UNION ALL

    SELECT
        e.EmployeeID,
        e.ManagerID,
        e.JobTitle,
        eh.Depth + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT
    EmployeeID,
    ManagerID,
    JobTitle,
    Depth
FROM EmployeeHierarchy
ORDER BY EmployeeID;