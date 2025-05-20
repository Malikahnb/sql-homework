DROP TABLE IF EXISTS Employees; 
CREATE TABLE Employees (
    EmployeeID INT,
    Name NVARCHAR(50),
    Department NVARCHAR(20),
    Salary INT
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);


CREATE TABLE #EmployeeTransfers (
    EmployeeID INT,
    Name NVARCHAR(50),
    Department NVARCHAR(20),
    Salary INT
);

INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT
    EmployeeID,
    Name,
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department  -- In case there's a department not in the cycle
    END AS Department,
    Salary
FROM Employees;


SELECT * FROM #EmployeeTransfers;

